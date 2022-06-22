// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

//  TODO:
//  1- add modifiers to avoide any chanes except for the lands logic
//  

contract Lands{
    
    // TYPES CODE CONVENTION 
        /*
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
        //}
        
    //





    // ==================== STORAGE ====================

        // ================ Lands

            // LandId is a string unique identifier like: AS21 which also is coordinates

            // Mapping from LandId to owner address
            mapping(string => address) private _landsOwners;

            // Mapping owner address to number of lands an address  owns
            mapping(address => uint256) private _numberOfLands;

            // Mapping owner address to landIds
            mapping(address => string[]) private _addressLands;

            // Mapping from landId to lnadType eg: 0 = Forest
            mapping(string => uint256) private _landType;
            
            // Mapping from LandId to has building - true if a building has been build on the land
            mapping(string => bool) private _landHasBuilding;
            
            // Mapping from LandId to its building
            mapping(string => string) private _landsBuilding;

            // All lnadIds eg:[AS21,AS22,AW32,...]
            string[] allLands;

            // Types of the All all lands in the same order eg: [0,1,4,...] - each index of the array
            // indicates the type pf the same index landId in the allLands array;
            uint256[] allLandsTypes;

            // number of all minted lands
            uint256 numberOfAllLands;

            // landIds listed to sell
            string[] landsToSellId;

            // prices for the lands which are listed to sell. in the same order of the landsToSellId
            uint256[] landsToSellPrice;
        //

        // ================ Permits

            // permitId is a string unique identifier like: HC01 which also indicates the type and number
            // (eg: HC is a hunting camp and 01 in numerator)
            // permitIds will be given by admin in minting time

            // Mapping from permitId to owner address
            mapping(string => address) private _permitsOwners;
                        
            // Mapping from permitId to its use state
            mapping(string => bool) private _permitUsed;

            // Mapping owner address to number of permits
            mapping(address => uint256) private _numberOfPermits;

            // Mapping permitId to permitType
            mapping(string => uint256) private _permitType;

            // Mapping permitId to landType - Defines the permit is allows to build the builing in what land type
            mapping(string => uint256) private _permitsLandType;

            // Mapping owner address to its all permits by permitId
            mapping(address => string[]) private _addressPermits;

            // All permits eg:[HC01, HC02, GR01, ...] - permitIds will be given by admin in minting time
            string[] allPermits;
            
            // Types of the all permits in the same order eg: [0,1,4,...] - each index of the array
            // indicates the type pf the same index permitsId in the allPermits array;
            uint256[] allPermitsTypes;

            // number of all minted permits
            uint256 numberOfAllPermits;
            
            // permitIds listed to sell
            string[] permitsToSellId;

            // prices for the permits which are listed to sell. in the same order of the permitsToSellId
            string[] permitsToSellPrice;
        //
        
        // ================ Buildings

            // buildingId is a string unique identifier like: AS21-HC01 which is a combination of the lnadId
            // and the permitId. (eg: AS21-HC01 is a hunting camp which builded on the AS21)

            // All buildings (by id)
            string[] allBuildings;

            // All buildings (by type) in the same order of the allBuildings;
            uint256[] allBuildingsTypes;

            // number of all Buildings
            uint256 numberOfAllBuildings;

            
            // Mapping from buildingId to owner address
            mapping(string => address) private _buildingOwner;

            // Mapping owner address to buildings by id
            mapping(address => string[]) private _addressBuildings;
            
            // Mapping owner address to number of buildings
            mapping(address => uint256) private _numberOfBuildings;

            // Mapping buildingId to buildingType
            mapping(string => uint256) private _buildingType;

        //



    //


    // ==================== METHODS ====================

        // ========== Lands

            function getlandOwner(string calldata landId) public view returns(address){
                return _landsOwners[landId];
            }

            function setlandOwner(string calldata landId, address adr) public {
                _landsOwners[landId] = adr;
            }

            function getNumberOfLands(address adr) public view returns(uint256){
                return _numberOfLands[adr];
            }

            function setNumberOfLands(address adr, uint256 number) public {
                _numberOfLands[adr] = number;
            }

            function getAddressLands(address adr) public view returns(string[] memory){
                return _addressLands[adr];
            }

            function setAddressLands(address adr, string[] memory lands) public {
                _addressLands[adr] = lands;
            }

            function getLandType(string calldata landId) public view returns(uint256){
                return _landType[landId];
            }

            function setLandType(string calldata landId, uint256 landType) public {
                _landType[landId] = landType;
            }

            function getLandHasBuilding(string calldata landId) public view returns(bool){
                return _landHasBuilding[landId];
            }

            function setLandHasBuilding(string calldata landId, bool state) public {
                _landHasBuilding[landId] = state;
            }

            function getLandsBuilding(string calldata landId) public view returns(string memory){
                return _landsBuilding[landId];
            }

            function setLandsBuilding(string calldata landId, string memory building) public {
                _landsBuilding[landId] = building;
            }

            function getAllLands() public view returns(string[] memory){
                return allLands;
            }

            function setAllLands(string[] memory lands) public {
                delete allLands;
                allLands = new string[](lands.length);
                allLands = lands;
            }

            function getAllLandsTypes() public view returns(uint256[] memory){
                return allLandsTypes;
            }

            function setAllLandsTypes(uint256[] memory landsTypes) public {
                delete allLands;
                allLandsTypes = new uint256[](landsTypes.length);
                allLandsTypes = landsTypes;
            }

            function getNumberOfAllLands() public view returns(uint256){
                return numberOfAllLands;
            }

            function setNumberOfAllLands(uint256 number) public {
                numberOfAllLands = number;
            }

            function getLandsToSellId() public view returns(string[] memory){
                return landsToSellId;
            }

            function setLandsToSellId(string[] memory lands) public {
                delete landsToSellId;
                landsToSellId = new string[](lands.length);
                landsToSellId = lands;
            }

            function getLandsToSellPrice() public view returns(uint256[] memory){
                return landsToSellPrice;
            }

            function setLandsToSellPrice(uint256[] memory lands) public {
                delete landsToSellPrice;
                landsToSellPrice = new uint256[](lands.length);
                landsToSellPrice = lands;
            }
  

        //


        // ========== Permits

            function getPermitOwner(string calldata PermitId) public view returns(address){
                return _permitsOwners[PermitId];
            }

            function setPermitOwner(string calldata PermitId, address adr) public {
                _permitsOwners[PermitId] = adr;
            }

            function getPermitType(string calldata PermitId) public view returns(uint256){
                return _permitType[PermitId];
            }

            function setPermitType(string calldata PermitId, uint256 permitType) public {
                _permitType[PermitId] = permitType;
            }

            function getPermitsLandType(string calldata PermitId) public view returns(uint256){
                return _permitsLandType[PermitId];
            }

            function setPermitsLandType(string calldata PermitId, uint256 landType) public {
                _permitsLandType[PermitId] = landType;
            }

            function getPermitUsed(string calldata landId) public view returns(bool){
                return _permitUsed[landId];
            }

            function setPermitUsed(string calldata landId, bool state) public {
                _permitUsed[landId] = state;
            }

            function getNumberOfPermits(address adr) public view returns(uint256){
                return _numberOfPermits[adr];
            }

            function setNumberOfPermits(address adr, uint256 number) public {
                _numberOfPermits[adr] = number;
            }

            function getAddressPermits(address adr) public view returns(string[] memory){
                return _addressPermits[adr];
            }

            function setAddressPermits(address adr, string[] memory Permits) public {
                _addressPermits[adr] = Permits;
            }

            function getAllPermits() public view returns(string[] memory){
                return allPermits;
            }

            function setAllPermits(string[] memory Permits) public {
                delete allPermits;
                allPermits = new string[](Permits.length);
                allPermits = Permits;
            }

            function getAllPermitsTypes() public view returns(uint256[] memory){
                return allPermitsTypes;
            }

            function setAllPermitsTypes(uint256[] memory PermitsTypes) public {
                delete allPermits;
                allPermitsTypes = new uint256[](PermitsTypes.length);
                allPermitsTypes = PermitsTypes;
            }     

            function getNumberOfAllPermits() public view returns(uint256){
                return numberOfAllPermits;
            }

            function setNumberOfAllPermits(uint256 number) public {
                numberOfAllPermits = number;
            }    

            function getPermitsToSellId() public view returns(string[] memory){
                return permitsToSellId;
            }

            function setPermitsToSellId(string[] memory Permits) public {
                delete permitsToSellId;
                permitsToSellId = new string[](Permits.length);
                permitsToSellId = Permits;
            }  

            function getPermitsToSellPrice() public view returns(string[] memory){
                return permitsToSellPrice;
            }

            function setPermitsToSellPrice(string[] memory Permits) public {
                delete permitsToSellPrice;
                permitsToSellPrice = new string[](Permits.length);
                permitsToSellPrice = Permits;
            } 
            
        //


         // ========== Buildings

            function getAllBuildings() public view returns(string[] memory){
                return allBuildings;
            }

            function setAllBuildings(string[] memory Buildings) public {
                delete allBuildings;
                allBuildings = new string[](Buildings.length);
                allBuildings = Buildings;
            }

            function getAllBuildingsTypes() public view returns(uint256[] memory){
                return allBuildingsTypes;
            }

            function setAllBuildingsTypes(uint256[] memory BuildingsTypes) public {
                delete allBuildings;
                allBuildingsTypes = new uint256[](BuildingsTypes.length);
                allBuildingsTypes = BuildingsTypes;
            }     

            function getNumberOfAllBuildings() public view returns(uint256){
                return numberOfAllBuildings;
            }

            function setNumberOfAllBuildings(uint256 number) public {
                numberOfAllBuildings = number;
            }    

            function getBuildingOwner(string calldata BuildingId) public view returns(address){
                return _buildingOwner[BuildingId];
            }

            function setBuildingOwner(string calldata BuildingId, address adr) public {
                _buildingOwner[BuildingId] = adr;
            }

            function getAddressBuildings(address adr) public view returns(string[] memory){
                return _addressBuildings[adr];
            }

            function setAddressBuildings(address adr, string[] memory Buildings) public {
                _addressBuildings[adr] = Buildings;
            }

            function getNumberOfBuildings(address adr) public view returns(uint256){
                return _numberOfBuildings[adr];
            }

            function setNumberOfBuildings(address adr, uint256 number) public {
                _numberOfBuildings[adr] = number;
            }
            
            function getBuildingType(string calldata BuildingId) public view returns(uint256){
                return _buildingType[BuildingId];
            }

            function setBuildingType(string calldata BuildingId, uint256 BuildingType) public {
                _buildingType[BuildingId] = BuildingType;
            }

        //
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


