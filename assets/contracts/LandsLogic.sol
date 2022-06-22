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


    address LSaddress;
    ILandsStorage LS;

    function getLandsStorageAddress() public view returns (address){
        return LSaddress;
    }

    function setLandsStorageAddress(address adr) public{
        LSaddress = adr;
        LS = ILandsStorage(adr);
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
                    _mint(tx.origin, landIds[i],landTypes[i]);
                    setLandType(landIds[i],landTypes[i]);
                }
            }


            string[]  adLands;
            string[]  allLandsTemp;
            uint256[]  allLandsTypeTemp;
            //Mint a land
            function _mint(address to, string memory landId, uint256 landType) internal virtual {
                require(to != address(0), "ERC721: mint to the zero address");
                require(!_landExists(landId), "ERC721: token already minted");

                uint256 n = LS.getNumberOfLands(to);
                LS.setNumberOfLands(to,n+1);

                uint256 na = LS.getNumberOfAllLands();
                LS.setNumberOfAllLands(na+1);

                LS.setlandOwner(landId,to);

                delete adLands;
                adLands = LS.getAddressLands(to);
                adLands.push(landId);
                LS.setAddressLands(to, adLands);

                delete allLandsTemp;
                allLandsTemp = LS.getAllLands();
                allLandsTemp.push(landId);
                LS.setAllLands(allLandsTemp);

                delete allLandsTypeTemp;
                allLandsTypeTemp = LS.getAllLandsTypes();
                allLandsTypeTemp.push(landType);
                LS.setAllLandsTypes(allLandsTypeTemp);

                LS.setLandHasBuilding(landId, false);
                emit Transfer(address(0), to, landId);

            }

            // if a land ID exist
            function _landExists(string memory landId) internal view virtual returns (bool) {
                return LS.getlandOwner(landId) != address(0);
            }    
        //


        // ========== PERMITS
            function _mintPermit(address to, string memory permitId, uint256 permitType, uint256 landType) internal virtual {
                require(to != address(0), "ERC721: mint to the zero address");
                require(!_permitExists(permitId), "ERC721: token already minted");

                LS.setPermitType(permitId, permitType);
                LS.setPermitsLandType(permitId, landType);

                
                uint256 n = LS.getNumberOfPermits(to);
                LS.setNumberOfPermits(to,n+1);


                uint256 na = LS.getNumberOfAllPermits();
                LS.setNumberOfAllPermits(na+1);

                LS.setPermitOwner(permitId, to);
 
                delete adLands;
                adLands = LS.getAddressPermits(to);
                adLands.push(permitId);
                LS.setAddressPermits(to, adLands);

                
                delete allLandsTemp;
                allLandsTemp = LS.getAllPermits();
                allLandsTemp.push(permitId);
                LS.setAllPermits(allLandsTemp);

                delete allLandsTypeTemp;
                allLandsTypeTemp = LS.getAllPermitsTypes();
                allLandsTypeTemp.push(permitType);
                LS.setAllPermitsTypes(allLandsTypeTemp);

                LS.setPermitUsed(permitId, false);

                emit TransferPermit(address(0), to, permitId);

            }

            // if a permit ID exist
            function _permitExists(string memory permitId) internal view virtual returns (bool) {
                return LS.getPermitOwner(permitId) != address(0);
            }   

            event TransferPermit( address from, address to, string permitId);                      

        //

        // ========== BUILDING
            function _buildBuilding(address to, string memory permitId, string memory landId) external virtual {
                
                require(to != address(0), "Build to the zero address");
                require(_permitExists(permitId), "Permit not exist");

                require(LS.getlandOwner(landId) == to, "Land is not yours");
                require(LS.getPermitOwner(permitId) == to, "Permit is not yours");
                require(!LS.getPermitUsed(permitId), "Permit has been used before");

                require(!LS.getLandHasBuilding(landId), "Land has a building");
                require(LS.getPermitsLandType(permitId) == LS.getLandType(landId),"types not same");

                LS.setPermitUsed(permitId, true);
                LS.setLandHasBuilding(landId, true);

                string memory buildingId = append(landId,permitId);

                                
                uint256 n = LS.getNumberOfBuildings(to);
                LS.setNumberOfBuildings(to,n+1);

                uint256 na = LS.getNumberOfAllBuildings();
                LS.setNumberOfAllBuildings(na+1);
 
                LS.setBuildingOwner(buildingId, to);
  
  
                delete adLands;
                adLands = LS.getAddressBuildings(to);
                adLands.push(buildingId);
                LS.setAddressBuildings(to, adLands);

                
                delete allLandsTemp;
                allLandsTemp = LS.getAllBuildings();
                allLandsTemp.push(buildingId);
                LS.setAllBuildings(allLandsTemp);


                delete allLandsTypeTemp;
                allLandsTypeTemp = LS.getAllBuildingsTypes();
                uint bt = LS.getPermitType(permitId);
                allLandsTypeTemp.push(bt);
                LS.setAllBuildingsTypes(allLandsTypeTemp);
                LS.setBuildingType(buildingId, bt);


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
    
    //


    //  ==================== TRANSFER

        function transferLand ( address from, address to, string memory landId) private {

            require(to != address(0), "Send to the zero address");
            require(_landExists(landId), "Not existed");
            //require(msg.sender == from, "Not your own land");
            require( LS.getNumberOfLands(from) > 0, "Not any land existed");

            removeLand(from, landId);

            uint256 n = LS.getNumberOfLands(to);
            LS.setNumberOfLands(to,n+1);
            LS.setlandOwner(landId, to);

            delete adLands;
            adLands = LS.getAddressLands(to);
            adLands.push(landId);
            LS.setAddressLands(to, adLands);

            emit Transfer(address(0), to, landId);

        }

        function removeLand( address from, string memory landId) internal { // problem here?
            uint256 number = LS.getNumberOfLands(from);
            require(number>1 , "#2 has not any land");
            string[] memory temp = LS.getAddressLands(from);
            string[] memory newArray = new string[](number-1);
            if(number == 1){
                LS.setAddressLands(from,newArray);
            }else{
                uint counter =0;
                for(uint i=0; i < number; i++){
                    if( compareStrings( temp[i], landId ) ){
                        
                    }else{
                        newArray[counter]=(landId);
                        counter++;
                    }
                }
               LS.setAddressLands(from,newArray);
            }
            
           LS.setNumberOfLands(from,number-1);
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
                require( LS.getlandOwner(landId) == tx.origin,"Not yours");
                
                delete adLands;
                adLands = LS.getLandsToSellId();
                adLands.push(landId);
                LS.setLandsToSellId( adLands );

                delete allLandsTypeTemp;
                allLandsTypeTemp = LS.getLandsToSellPrice();
                allLandsTypeTemp.push(price);
                LS.setLandsToSellPrice(allLandsTypeTemp);

            }



            function removeMyLandFromSellList (string memory landId) public {
                require( LS.getlandOwner(landId) == tx.origin,"Not yours");
                removeLandFromSellList(landId);
            }

            function removeLandFromSellList (string memory landId) private  {
              
                //   remove the id
                string[] memory temp = LS.getLandsToSellId();
                uint counter = 0;
                uint index = 0;

                delete adLands;
                adLands = new string[](temp.length-1);

                for(uint i=0; i < temp.length; i++){
                        if( compareStrings( temp[i], landId ) ){
                            index = i;
                        }else{
                            adLands[counter]=temp[i];     
                            counter++;
                        }
                }

                LS.setLandsToSellId(adLands);


                //   remove the price
                uint256[] memory tempPrices = LS.getLandsToSellPrice();
                counter = 0;

                delete allLandsTypeTemp;
                allLandsTypeTemp = new uint256[](tempPrices.length-1);

                for(uint i=0; i < tempPrices.length; i++){
                        if( index == i ){
                            
                        }else{
                            allLandsTypeTemp[counter]=tempPrices[i];     
                            counter++;
                        }
                }

                LS.setLandsToSellPrice(tempPrices);
            }

            

            function getLandPrice (string memory landId) private returns(uint256) {
              
                //   Finding the id index
                string[] memory temp = LS.getLandsToSellId();
                uint counter = 0;
                uint index = 0;
                uint256 result = 0;

                delete adLands;
                adLands = new string[](temp.length-1);

                for(uint i=0; i < temp.length; i++){
                        if( compareStrings( temp[i], landId ) ){
                            index = i;
                        }else{
                            adLands[counter]=temp[i];     
                            counter++;
                        }
                }

                
                //finding id price
                uint256[] memory tempPrices = LS.getLandsToSellPrice();
                counter = 0;

                delete allLandsTypeTemp;
                allLandsTypeTemp = new uint256[](tempPrices.length-1);

                for(uint i=0; i < tempPrices.length; i++){
                        if( index == i ){
                            result = tempPrices[i];
                        }else{
                            allLandsTypeTemp[counter]=tempPrices[i];     
                            counter++;
                        }
                }

                return result;
            }

            function getSellLandListPrice() public view returns(uint256[] memory ){
                return LS.getLandsToSellPrice();
            }

            function getSellLandListId() public view returns(string[] memory ){
                return LS.getLandsToSellId();
            }

            function buyLand(string memory landId, uint256 buyPrice) public {
                uint256 price = getLandPrice(landId);
                require(price>0); // listed ad sell
                require(price == buyPrice); // check correctness
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



interface ILandsStorage{

    // ========== Lands

        function getlandOwner(string calldata landId) external view returns(address);

        function setlandOwner(string calldata landId, address adr) external;

        function getNumberOfLands(address adr) external view returns(uint256);

        function setNumberOfLands(address adr, uint256 number) external;

        function getAddressLands(address adr) external view returns(string[] memory);

        function setAddressLands(address adr, string[] calldata lands) external ;

        function getLandType(string calldata landId) external view returns(uint256);

        function setLandType(string calldata landId, uint256 landType) external;

        function getLandHasBuilding(string calldata landId) external view returns(bool);
        
        function setLandHasBuilding(string calldata landId, bool state) external;

        function getLandsBuilding(string calldata landId) external view returns(string memory);

        function setLandsBuilding(string calldata landId, string memory building) external;

        function getAllLands() external view returns(string[] memory);

        function setAllLands(string[] memory lands) external;
        
        function getAllLandsTypes() external view returns(uint256[] memory);

        function setAllLandsTypes(uint256[] memory landsTypes) external ;

        function getNumberOfAllLands() external view returns(uint256);

        function setNumberOfAllLands(uint256 number) external;

        function getLandsToSellId() external view returns(string[] memory);

        function setLandsToSellId(string[] memory lands) external;

        function getLandsToSellPrice() external view returns(uint256[] memory);

        function setLandsToSellPrice(uint256[] memory lands) external;

    //


    // ========== Permits

        function getPermitOwner(string calldata PermitId) external view returns(address);

        function setPermitOwner(string calldata PermitId, address adr) external;
        
        function getPermitType(string calldata PermitId) external view returns(uint256);

        function setPermitType(string calldata PermitId, uint256 permitType) external ;

        function getPermitsLandType(string calldata PermitId) external view returns(uint256);

        function setPermitsLandType(string calldata PermitId, uint256 landType) external ;

        function getNumberOfPermits(address adr) external view returns(uint256);

        function setNumberOfPermits(address adr, uint256 number) external;

        function getAddressPermits(address adr) external view returns(string[] memory);

        function setAddressPermits(address adr, string[] calldata Permits) external ;

        function getPermitUsed(string calldata landId) external view returns(bool);

        function setPermitUsed(string calldata landId, bool state) external;

        function getAllPermits() external view returns(string[] memory);

        function setAllPermits(string[] memory Permits) external ;

        function getAllPermitsTypes() external view returns(uint256[] memory);

        function setAllPermitsTypes(uint256[] memory PermitsTypes) external;

        function getNumberOfAllPermits() external view returns(uint256);

        function setNumberOfAllPermits(uint256 number) external;

        function getPermitsToSellId() external view returns(string[] memory);

        function setPermitsToSellId(string[] memory Permits) external;

        function getPermitsToSellPrice() external view returns(string[] memory);

        function setPermitsToSellPrice(string[] memory Permits) external;
    //

    // ========== Buildings

        function getAllBuildings() external view returns(string[] memory);

        function setAllBuildings(string[] memory Buildings) external;

        function getAllBuildingsTypes() external view returns(uint256[] memory);

        function setAllBuildingsTypes(uint256[] memory BuildingsTypes) external;

        function getNumberOfAllBuildings() external view returns(uint256);

        function setNumberOfAllBuildings(uint256 number) external;

        function getBuildingOwner(string calldata BuildingId) external view returns(address);

        function setBuildingOwner(string calldata BuildingId, address adr) external;

        function getAddressBuildings(address adr) external view returns(string[] memory);

        function setAddressBuildings(address adr, string[] memory Buildings) external;

        function getNumberOfBuildings(address adr) external view returns(uint256);

        function setNumberOfBuildings(address adr, uint256 number) external;      

        function getBuildingType(string calldata BuildingId) external view returns(uint256);

        function setBuildingType(string calldata BuildingId, uint256 BuildingType) external;

    //
}