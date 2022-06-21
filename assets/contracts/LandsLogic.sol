// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

contract Lands{
        string[]  lands = ["AS21","AT20","AT21","AT22","AT24","AU23","AU24","AW20","AW21","AW22","AX21","AX22","AS22","AS23","AS24","AS26","AT23","AN27","AN29","AN31"];
        uint8[]  types = [4,4,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,0,0,0];

    function initializer() public {  //#=> replace public with internal or ... &&  add secretary origin

        batchMint(lands , 20,types );
        listLandToSell("AS21",100);
        listLandToSell("AT20",200);
        listLandToSell("AU23",330);
        listLandToSell("AW20",400);


    }






    // ==================== STORAGE 


        struct Land{
            string landID;
            //address owner; // maybe shuld be added later.
            LandType landType;
            //uint256 allocationTimeStamp;
        }

        enum LandType{
            Forest,             // 0
            Empty,              // 1
            Mountain,           // 2
            Agricultural,       // 3
            Urban,              // 4
            Coast               // 5
        }


        enum BuildingType{
            HuntingCamp,    // 0 HC 22
            WheatFarm,      // 1 WF 33
            Grinder,        // 2 GD 44
            Bakeshop,       // 3 BS 55
            WindMill,       // 4 WM 66
            House           // 5 HS 77
            // ===== All types
                /*
                ForestHuntingCamp,      // 10
                MountainHuntingCamp,    // 11
                WheatFarm,              // 20
                TomatoCroft,            // 21            
                LettuceCroft,           // 22        
                Residental,             // 40
                Commercial,             // 50
                Industrial              // 60
                */
            //
        }



        // Mapping from token ID to owner address
        mapping(string => address) private _owners;

        // Mapping owner address to token count
        mapping(address => uint256) private _balances;

        // Mapping owner address to lands
        mapping(address => string[]) private _addressLands;

        // Mapping from token ID to owner address
        mapping(string => uint256) private _landType;

        
        // Mapping from token ID to has building
        mapping(string => bool) private _landHasBuilding;

        string[] allLands;
        uint256[] allLandsTypes;

        uint256 numberOfAllLands;


        // ================ Permits
            uint256 numberOfAllPermits;
            string[] allPermits;
            uint256[] allPermitsTypes;
            
            // Mapping from token ID to owner address
            mapping(string => address) private _permitOwners;
                        
            // Mapping from token ID to used
            mapping(string => bool) private _permitUsed;

            // Mapping owner address to token count
            mapping(address => uint256) private _permitBalances;

            // Mapping owner address to token count
            mapping(string => uint256) private _permitsType;

            // Mapping owner address to lands - Defines the permit is alowing to build the builing in  what land type
            mapping(string => uint256) private _permitsLandType;

            // Mapping owner address to lands
            mapping(address => string[]) private _addressPermits;
        //
        
        // ================ Buildings
            uint256 numberOfAllBuildings;
            string[] allBuildings;
            uint256[] allBuildingsTypes;
            
            // Mapping from token ID to owner address
            mapping(string => address) private _buildingOwners;

            // Mapping owner address to token count
            mapping(address => uint256) private _buildingBalances;

            // Mapping owner address to lands
            mapping(address => string[]) private _addressBuildings;
        //



    //

    //  ==================== GET SET
    

        function getMyLands() public view returns (string[] memory){
            return _addressLands[Tro()];
        }
        
        function getMyPermits() public view returns (string[] memory){
            return _addressPermits[Tro()];
        }
        
        function getMyBuildings() public view returns (string[] memory){
            return _addressBuildings[Tro()];
        }
        
        function setLandType (string memory landId, uint256 landtype) private {
            _landType[landId] = landtype;
        }

        /*
        function getLandType (string memory landId) public view returns(LandType){
            return _landType[landId];
        }*/


        function getAllLands() public view returns(string[] memory){
            return allLands;
        }

        function getAllLandTypes() public view returns(uint256[] memory){
            return allLandsTypes;
        }
        
        function getLandOwner(string memory landId) public view returns(address){
            return _owners[landId];
        } 

        function getLandPrices(string memory landId) public view returns(uint256){
            return _landSellPrices[landId];
        }

        function getNumberOfSellList() public view returns(uint256){
            return numberOfSellList;
        }

        function getSellLandIds() public view returns(string[] memory){
            return sellLandIds;
        }


    //

    //  ==================== MINT
        
        // ========== LAND
            function batchMint( string[] memory landIds, uint count, uint8[] memory landTypes) public {
                for(uint i = 0; i < count; i++){
                    _mint(msg.sender, landIds[i],landTypes[i]);
                    setLandType(landIds[i],landTypes[i]);
                }
            }

            //Mint a land
            function _mint(address to, string memory landId, uint8 landType) internal virtual {
                require(to != address(0), "ERC721: mint to the zero address");
                require(!_landExists(landId), "ERC721: token already minted");


                _balances[to] += 1;
                numberOfAllLands++;
                _owners[landId] = to;
                _addressLands[to].push(landId);
                allLands.push(landId);
                allLandsTypes.push(landType);
                _landHasBuilding[landId] = false;
                emit Transfer(address(0), to, landId);

            }

            // if a land ID exist
            function _landExists(string memory landId) internal view virtual returns (bool) {
                return _owners[landId] != address(0);
            }    
        //

        // ========== BUILDING
            function _buildBuilding(address to, string memory permitId, string memory landId) external virtual {
                require(to != address(0), "Build to the zero address");
                require(_permitExists(permitId), "Permit not exist");
                require(_owners[landId] == to, "Land is not yours");
                require(!_permitUsed[permitId], "Permit has been used before");
                require(!_landHasBuilding[landId], "Land has a building");
                require(_permitsLandType[permitId]==_landType[landId],"types not same");
                _permitUsed[permitId] = true;
                _landHasBuilding[landId] = true;
                string memory buildingId = append(landId,permitId);
                _buildingBalances[to] += 1;
                numberOfAllBuildings++;
                _buildingOwners[buildingId] = to;
                _addressBuildings[to].push(buildingId);
                allBuildings.push(buildingId);
                allBuildingsTypes.push(_permitsType[permitId]);
                emit TransferBuilding(address(0), to, buildingId);

            }

            // if a permit ID exist
            function _buildingExists(string memory landId) internal view virtual returns (bool) {
                return _owners[landId] != address(0);
            }   

            event TransferBuilding( address from, address to, string buildingId);                      

            function append(string memory a, string memory b) internal pure returns (string memory) {
                return string(abi.encodePacked( a, "-", b));
            }
        //
    
        // ========== PERMITS
            function _mintPermit(address to, string memory permitId, uint256 buildingType , uint256 landType) internal virtual {
                require(to != address(0), "ERC721: mint to the zero address");
                require(!_permitExists(permitId), "ERC721: token already minted");


                _permitsLandType[permitId] = landType;
                _permitBalances[to] += 1;
                numberOfAllPermits++;
                _permitOwners[permitId] = to;
                _addressPermits[to].push(permitId);
                allPermits.push(permitId);
                allPermitsTypes.push(buildingType);
                _permitUsed[permitId] = false;
                emit TransferPermit(address(0), to, permitId);

            }

            // if a permit ID exist
            function _permitExists(string memory permitId) internal view virtual returns (bool) {
                return _permitOwners[permitId] != address(0);
            }   

            event TransferPermit( address from, address to, string permitId);                      

        //
    //


    //  ==================== TRANSFER

        function transferLand ( address from, address to, string memory landId) private {
            require(to != address(0), "Send to the zero address");
            require(_landExists(landId), "Not existed");
            //require(msg.sender == from, "Not your own land");
            require( _balances[from]>0, "Not any land existed");

            removeLand(from, landId);

            _balances[to] += 1;
            _owners[landId] = to;
            _addressLands[to].push(landId);

            emit Transfer(address(0), to, landId);

        }

        function removeLand( address from, string memory landId) internal { // problem here?
            string[] memory temp = _addressLands[from];
            uint256 number = _balances[from];
            string[] memory newArray = new string[](number-1);
            if(number == 1){
                _addressLands[from] = newArray;
            }else{
                uint counter =0;
                for(uint i=0; i < number; i++){
                        if( compareStrings( temp[i], landId ) ){
                            newArray[counter]=(landId);
                            counter++;
                        }
                }
                _addressLands[from] = newArray;//???
            }
            
            _balances[from]--;
        }

        function compareStrings(string memory a, string memory b) public pure returns (bool) {
            return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
        }

        event Transfer( address from, address to, string landId);                      
    //

    // ==================== BUSINESSES 

        // ===== LANDS

            // Mapping from token ID to owner address
            mapping(string => uint256) private _landSellPrices;
            uint256 numberOfSellList;
            string[] sellLandIds;


            function listLandToSell(string memory landId, uint256 price) public {
                require(_owners[landId] == tx.origin,"Not yours");
                _landSellPrices[landId] = price;
                sellLandIds.push(landId);
                numberOfSellList++;
            }



            function removeMyLandFromSellList (string memory landId) public {
                require(_owners[landId] == tx.origin,"Not yours");
                removeLandFromSellList(landId);
            }

            function removeLandFromSellList (string memory landId) private  {
                _landSellPrices[landId] = 0;
                
                string[] memory temp = sellLandIds;
                uint counter = 0;
                //string[] memory newArray = new string[](numberOfSellList-1);
                //sellLandIds.length = 0;
                delete sellLandIds;
                sellLandIds = new string[](numberOfSellList-1);
                for(uint i=0; i < numberOfSellList; i++){
                        if( compareStrings( temp[i], landId ) ){
                            
                        }else{
                            sellLandIds[counter]=temp[i];     
                            counter++;
                            //sellLandIds.push(temp[i]);     

                        }
                }
                //sellLandIds = newArray;
                numberOfSellList--;
            }

            struct LandSellTicket{
                string landId;
                uint256 price;
            }

            function getSellLandList() public view returns(uint256[] memory ){

                uint256[] memory results = new uint256[](numberOfSellList);

                for(uint i=0; i < numberOfSellList; i++){
                    string memory id = sellLandIds[i];
                    results[i]= _landSellPrices[id];
                }
                return results;
            }

            function buyLand(string memory landId) public {
                uint256 price = _landSellPrices[landId];
                require(price>0); // listed ad sell
                //require(_balance > price)  // check for enught balance

                // Transfer the fee

                address to = tx.origin;
                transferLand(_owners[landId],to,landId);
                removeLandFromSellList(landId);

            }
        //

        // ===== Permits
    //

    // ==================== LATHERAL 
        function Tro() private view returns (address){
            return tx.origin;
        }
    //
}