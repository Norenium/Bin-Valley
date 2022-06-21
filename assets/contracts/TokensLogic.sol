// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

contract Tokens{

    // ==================== STORAGE
        mapping(address => uint256) private _OpousMoneyBalances;
        mapping(address => uint256) private _ElectricityBalances;
        mapping(address => uint256) private _WheatBalances;
        mapping(address => uint256) private _BreadBalances;
        mapping(address => uint256) private _FlourBalances;
        mapping(address => uint256) private _MeatBalances;
        mapping(address => uint256) private _BodyFatBalances;
        mapping(address => uint256) private _BodyEnergyBalances;
        mapping(address => uint256) private _BodyHealthBalances;

        mapping(address => uint256) private PersonId;
        mapping(uint256 => address) private PersonIdToAddress;
        uint256 PersonIdNumerator = 100;
        mapping(address => string) private PersonName;



    //


    // ==================== FOODS ENERGY Consts
        // Minimum To Eat
        uint256 minMeat = 20;
        uint256 minBread = 20;
        uint256 minMeatSandwich = 100;

        uint256 meatCalFor100g = 143;
        uint256 breadCalFor100g = 265;
        uint256 meatSandwichCalFor100g = 220;

        uint256 meatFatFor100g = 2;
        uint256 breadFatFor100g = 0;
        uint256 meatSandwichFatFor100g = 1;


        // Maximum to have
        uint256 maxBodyHealth = 100;
        uint256 maxBodyFat = 5000;
        uint256 maxBodyEnergy = 700;
    //

    function start (string memory name) public {
        address sndr = tx.origin;
        require(PersonId[sndr]==0,"adress is a person");
        _OpousMoneyBalances[sndr] = 0;
        _ElectricityBalances[sndr] = 0;
        _WheatBalances[sndr] = 0;
        _BreadBalances[sndr] = 0;
        _FlourBalances[sndr] = 0;
        _MeatBalances[sndr] = 0;
        _BodyFatBalances[sndr] = 1000;
        _BodyEnergyBalances[sndr] = 700;
        _BodyHealthBalances[sndr] = 100;

        PersonIdToAddress[PersonIdNumerator] = sndr;
        PersonId[sndr] = PersonIdNumerator;
        PersonIdNumerator++;
        PersonName[sndr] = name;
    }



    // ==================== ACTIONS => EAT
        // ==================== EAT

            function eatMeat(uint256 amount) public {
                address to = tx.origin;
                require( amount >= minMeat ); // minimum maet to eat
                require(_MeatBalances[to] >= amount);
                _MeatBalances[to] -= amount;
                _BodyEnergyBalances[to] += ( amount * meatCalFor100g / 100);
                if( _BodyEnergyBalances[to] > maxBodyEnergy){
                    _BodyEnergyBalances[to] = maxBodyEnergy;
                    // TODO add fat in case ov over eating
                }
                _BodyFatBalances[to] += ( amount * meatFatFor100g / 100);
                if( _BodyFatBalances[to] > maxBodyFat){
                    _BodyFatBalances[to] = maxBodyFat;
                }
            }

            function eatBread(uint256 amount) public {
                address to = tx.origin;
                require( amount >= minBread ); // minimum maet to eat
                require(_BreadBalances[to] >= amount);
                _BreadBalances[to] -= amount;
                _BodyEnergyBalances[to] += ( amount * breadCalFor100g / 100);
                if( _BodyEnergyBalances[to] > maxBodyEnergy){
                    _BodyEnergyBalances[to] = maxBodyEnergy;
                }
                _BodyFatBalances[to] += ( amount * breadFatFor100g / 100);
                if( _BodyFatBalances[to] > maxBodyFat){
                    _BodyFatBalances[to] = maxBodyFat;
                }
            }

            function eatSandwich(uint256 amount) public {
                address to = tx.origin;
                require( amount >= minMeatSandwich ); // minimum maet to eat
                require(_BreadBalances[to] >= amount/2);
                require(_MeatBalances[to] >= amount/2);
                _BreadBalances[to] -= amount/2;
                _MeatBalances[to] -= amount/2;
                _BodyEnergyBalances[to] += ( amount * meatSandwichCalFor100g / 100);
                if( _BodyEnergyBalances[to] > maxBodyEnergy){
                    _BodyEnergyBalances[to] = maxBodyEnergy;
                }
                _BodyFatBalances[to] += ( amount * meatSandwichFatFor100g / 100);
                if( _BodyFatBalances[to] > maxBodyFat){
                    _BodyFatBalances[to] = maxBodyFat;
                }
            }
        //

        // ==================== WORK

            mapping (address => uint256 ) _numberOfHuntCamps;
            mapping (string => uint256 ) _latestHunts;
            mapping (address => string[] ) _huntCampsIds;
            uint256 huntPeriod = 180; // Increase it to 43200 Later
            uint256 huntRevenue = 1000; // Grams of Meat
            uint256 huntEnergyConsumption = 350; // Grams of Meat

            function Hunt() public {
                address to = tx.origin;
                //require( checkHuntingPrivilege(to) );  UNCOMMENT IT LATER   <<<<<<<<<<<<<=======
                require( _BodyEnergyBalances[to] >  huntEnergyConsumption); 
                //require( _latestHunts[to] < block.timestamp - huntPeriod ); // preventing frequent hunt
                string memory can = checkHuntingPrivilege(to);
                require(!compareStrings(can,""),"cant hunt");
                _latestHunts[can] = block.timestamp;
                _MeatBalances[to] += huntRevenue;
                _BodyEnergyBalances[to] -= huntEnergyConsumption;
            }

            function checkHuntingPrivilege(address to)internal view returns(string memory){
                 
                uint l = _huntCampsIds[to].length;
                require(_huntCampsIds[to].length > 0,"no camp");
                for(uint i = 0; i<l; i++){
                    if(_latestHunts[_huntCampsIds[to][i]] + huntPeriod > block.timestamp){
                        return _huntCampsIds[to][i];
                    }
                }
                return "";
            }
            
            function whenCanHunt() external view returns (uint256){
                address to = tx.origin;
                uint l = _huntCampsIds[to].length;
                require(_huntCampsIds[to].length > 0,"no camp");
                uint256[] memory times = new uint256[](l);
                for(uint i = 0; i<l; i++){
                    times[i] = _latestHunts[_huntCampsIds[to][i]] + huntPeriod;
                }
                uint min = 10000000000;
                for(uint i = 0; i<l; i++){
                    if(times[i] < min){
                        min = times[i];
                    }
                }
                return min;
            }


            function getTS() public view returns (uint256){
                return block.timestamp;
            }

        //

        //==================== BUSINESSES
            //function buyLand(string memory landId) public {
            //    return block.timestamp;
            //}
        //
    //

    // ==================== TRANSFER

        function _transferOpousMoneyBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _OpousMoneyBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _OpousMoneyBalances[from] = fromBalance - amount;
            
            _OpousMoneyBalances[to] += amount;

            emit Transfer(from, to, amount, "OpousMoney");

        }




        function _transferElectricityBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _ElectricityBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _ElectricityBalances[from] = fromBalance - amount;
            
            _ElectricityBalances[to] += amount;

            emit Transfer(from, to, amount, "Electricity");

        }




        function _transferWheatBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _WheatBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _WheatBalances[from] = fromBalance - amount;
            
            _WheatBalances[to] += amount;

            emit Transfer(from, to, amount, "Wheat");

        }




        function _transBreadBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _BreadBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _BreadBalances[from] = fromBalance - amount;
            
            _BreadBalances[to] += amount;

            emit Transfer(from, to, amount, "Bread");

        }




        function _transferFlourBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _FlourBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _FlourBalances[from] = fromBalance - amount;
            
            _FlourBalances[to] += amount;

            emit Transfer(from, to, amount, "Flour");

        }




        function _transferMeatBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _MeatBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _MeatBalances[from] = fromBalance - amount;
            
            _MeatBalances[to] += amount;

            emit Transfer(from, to, amount, "Meat");

        }




        function _transferBodyFatBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _BodyFatBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _BodyFatBalances[from] = fromBalance - amount;
            
            _BodyFatBalances[to] += amount;

            emit Transfer(from, to, amount, "BodyFat");

        }




        function _transferBodyEnergyBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _BodyEnergyBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _BodyEnergyBalances[from] = fromBalance - amount;
            
            _BodyEnergyBalances[to] += amount;

            emit Transfer(from, to, amount, "BodyEnergy");

        }




        function _transferBodyHealthBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _BodyHealthBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _BodyHealthBalances[from] = fromBalance - amount;
            
            _BodyHealthBalances[to] += amount;

            emit Transfer(from, to, amount, "BodyHealth");

        }





        event Transfer( address from, address to, uint256 amount, string token);                      

    //




    // ==================== GET BALANCES

        function OpousMoneybalanceOf(address account) public view returns(uint256) {
            return  _OpousMoneyBalances[account];
        }

        function ElectricitybalanceOf(address account) public view returns(uint256) {
            return  _ElectricityBalances[account];
        }

        function WheatbalanceOf(address account) public view returns(uint256) {
            return  _WheatBalances[account];
        }

        function BreadbalanceOf(address account) public view returns(uint256) {
            return  _BreadBalances[account];
        }

        function FlourbalanceOf(address account) public view returns(uint256) {
            return  _FlourBalances[account];
        }

        function MeatbalanceOf(address account) public view returns(uint256) {
            return  _MeatBalances[account];
        }

        function BodyFatbalanceOf(address account) public view returns(uint256) {
            return  _BodyFatBalances[account];
        }

        function BodyEnergybalanceOf(address account) public view returns(uint256) {
            return  _BodyEnergyBalances[account];
        }

        function BodyHealthbalanceOf(address account) public view returns(uint256) {
            return  _BodyHealthBalances[account];
        }


    //


    // ==================== GET MY

        function getMyOpousMoney() public view returns(uint256) {
            return  _OpousMoneyBalances[msg.sender];
        }

        function getMyElectricity() public view returns(uint256) {
            return  _ElectricityBalances[msg.sender];
        }

        function getMyWheat() public view returns(uint256) {
            return  _WheatBalances[msg.sender];
        }

        function getMyBread() public view returns(uint256) {
            return  _BreadBalances[msg.sender];
        }

        function getMyFlour() public view returns(uint256) {
            return  _FlourBalances[msg.sender];
        }

        function getMyMeat() public view returns(uint256) {
            return  _MeatBalances[msg.sender];
        }

        function getMyBodyHealth() public view returns(uint256) {
            return  _BodyHealthBalances[msg.sender];
        }

        function getMyBodyFat() public view returns(uint256) {
            return  _BodyFatBalances[msg.sender];
        }

        function getMyBodyEnergy() public view returns(uint256) {
            return  _BodyEnergyBalances[msg.sender];
        }

        function getMyInventory() public view returns(uint256[] memory) {
            uint256[] memory results = new uint256[](9);
            address to = tx.origin;
            results[0] = _OpousMoneyBalances[to];
            results[1] = _ElectricityBalances[to];
            results[2] = _WheatBalances[to];
            results[3] = _BreadBalances[to];
            results[4] = _FlourBalances[to];
            results[5] = _MeatBalances[to];
            results[6] = _BodyHealthBalances[to];
            results[7] = _BodyFatBalances[to];
            results[8] = _BodyEnergyBalances[to];
            return  results;
        }



        function getMyName() public view returns(string memory) {
            return  PersonName[tx.origin];
        }

        function getMyId() public view returns(uint256) {
            return  PersonId[tx.origin];
        }

    //

    


    // ==================== GET for ADMIN

        function getAllPersonAddresses() public view returns (address[] memory){
            require (PersonIdNumerator>100,"There are no person.");
            address[] memory allPersonIds = new address[](PersonIdNumerator-100);
            for(uint i = 100; i< PersonIdNumerator; i++ ){
                allPersonIds[i-100] = PersonIdToAddress[i];
            }
            return allPersonIds;
        }

        function getPersonIdNumerator() public view returns(uint256){
            return PersonIdNumerator;
        }
    //

    // =================== Latheral
        function compareStrings(string memory a, string memory b) public pure returns (bool) {
            return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
        }
    //


}

