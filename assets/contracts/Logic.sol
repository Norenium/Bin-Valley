    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0; 

contract Logic { 

        //-----  Administrative variables 
        bool isInitialized = false;
        address  _secretaryAddress;
        address  _proxyAddress;
        address  _landsAddress; 
        address  _tokensAddress; 

  


        // ==========================    ADMINISTRATIVE FUNCTIONS     ==========================


            function setSecretary(address adr) public secretary {
                _secretaryAddress = adr;
            }

            function getSecretary() public view secretary returns(address) {
                return _secretaryAddress;
            }


            function setProxyAddress(address adr) public secretary {
                _proxyAddress = adr;
            }

            function getProxyAddress() public view secretary returns(address) {
                return _proxyAddress;
            }


            function setLandsAddress(address adr) public secretary {
                _landsAddress = adr;
                lands = Lands( _landsAddress);
            }

            function getLandsAddress() public view secretary returns(address) {
                return _landsAddress;
            }

            

            function setTokensAddress(address adr) public secretary {
                _tokensAddress = adr;
                tokens = Tokens( _tokensAddress);
            }

            function getTokensAddress() public view secretary returns(address) {
                return _tokensAddress;
            }

            function getSelfdAddress() public view  returns(address) {
                return address(this);
            }


            function initializer() external { 
                _secretaryAddress = TrO();
                isInitialized = true;
            }



            // =====   MODIFIERS

                modifier proxy {
                    require(msg.sender == _proxyAddress);
                    _;
                }

                modifier secretary {
                    bool check = false;
                    if(msg.sender == _secretaryAddress){
                        check = true;
                    }else{
                        if( tx.origin == _secretaryAddress){
                                check = true;
                        }
                    }
                    require(check);
                    _;
                }
            //


        //



    // ==========================    ALPHA FUNCTIONS     ==========================


        function Alpha(uint c, address[] memory _addressData,string[] memory _stringData, uint256[] memory _uint256Data) external view returns (address[] memory){

            // ==========================  Lands Functions
            
                if(c == 11 ){
                    address[] memory x0 = new address[](1);
                    x0 [0] = lands.getLandOwner(_stringData[0]);
                    return x0;
                }            
            //

            // ==========================  Tokens Functions
                /*if(c == 31 ){
                    return tokens.getAllPersonAddresses();
                }  */
            //

            address[] memory x  = new address[](0);
            return x;
        }

    //

    // ==========================    BRAVO FUNCTIONS     ==========================


        function Bravo(uint c, address[] memory _addressData,string[] memory _stringData, uint256[] memory _uint256Data) external view returns (string[] memory){

            // ==========================  Lands Functions

                if(c == 11){
                    return lands.getAllLands();
                }  
                
                if(c == 12){
                    return lands.getSellLandIds();
                }                
            // 

            // ==========================  Tokens Functions

                if(c == 31){
                    string[] memory res = new string[](1);
                    res[0] = tokens.getMyName();
                    return res;
                }                
            //   

            return new string[](0);
        }

    //

    // ==========================    CHARLIE FUNCTIONS     ==========================

        function Charlie(uint c, address[] memory _addressData,string[] memory _stringData, uint256[] memory _uint256Data) external view returns (uint256[] memory){

                // ==========================  Lands Functions

                if(c == 11){
                    return lands.getAllLandTypes();
                }     
                
                if(c == 12){
                    return lands.getSellLandListPrice();
                }                
            // 

            // ==========================  Tokens Functions

                if(c == 31){
                    return tokens.getMyInventory();
                }    

                if(c == 32){
                    uint256[] memory x  = new uint256[](1);
                    x[0] = tokens.whenCanHunt();
                    return x;
                }  
                
                if(c == 33){
                    uint256[] memory x  = new uint256[](1);
                    x[0] = tokens.getMyId();
                    return x;
                }                   

            //   

            return new uint256[](0);
        }

        Lands lands;
        Tokens tokens;
    //
    
    // ==========================    DELTA FUNCTIONS     ==========================

        function Delta(uint c, address[] memory _addressData,string[] memory _stringData, uint256[] memory _uint256Data) external {
            
            // ==========================  Lands Functions

                if(c == 11){
                    lands.listLandToSell(_stringData[0],_uint256Data[0]);
                }  
                
                if(c == 12){
                    lands.removeMyLandFromSellList(_stringData[0]);
                }      
                                
                if(c == 13){
                    lands.buyLand(_stringData[0]);
                }              
            // 

            // ==========================  Tokens Functions

                if(c == 31){
                    tokens.start(_stringData[0]);
                }      

                if(c == 32){
                    tokens.eatMeat(_uint256Data[0]);
                }        

                if(c == 33){
                    tokens.eatBread(_uint256Data[0]);
                }        

                if(c == 34){
                    tokens.eatSandwich(_uint256Data[0]);
                }

                if(c == 35){
                    tokens.Hunt();
                }

                if(c == 34){
                    tokens.Hunt();
                }

                if(c == 34){
                    tokens.Hunt();
                }



            //   

        }
    //



    // ==========================    LATERAL FUNCTIONS     ==========================
    
        /// Converting string to Uint256 Code example:
        function stringToUint(string memory s) internal pure returns (uint256, bool) {
            bool hasError = false;
            bytes memory b = bytes(s);
            uint256 result = 0;
            uint256 oldResult = 0;
            for (uint i = 0; i < b.length; i++) { // c = b[i] was not needed
                if (uint256(bytes32(b[i])) >= 48 && uint256(bytes32(b[i])) <= 57) {
                    // store old value so we can check for overflows
                    oldResult = result;
                    result = result * 10 + (uint256(bytes32(b[i])) - 48); // bytes and int are not compatible with the operator -.
                    // prevent overflows
                    if(oldResult > result ) {
                        // we can only get here if the result overflowed and is smaller than last stored value
                        hasError = true;
                    }
                } else {
                    hasError = true;
                }
            }
            return (result, hasError); 
        } 

        /// Chechk Equality of two strings
        function stringsEquals(string memory s1, string memory s2) private pure returns (bool) {
            bytes memory b1 = bytes(s1);
            bytes memory b2 = bytes(s2);
            uint256 l1 = b1.length;
            if (l1 != b2.length) return false;
            for (uint256 i=0; i<l1; i++) {
                if (b1[i] != b2[i]) return false;
            }
            return true;
        }

            /* another convert method
            function stringToUint(string s) constant returns (uint result) {
                bytes memory b = bytes(s);
                uint i;
                result = 0;
                for (i = 0; i < b.length; i++) {
                    uint c = uint(b[i]);
                    if (c >= 48 && c <= 57) {
                        result = result * 10 + (c - 48);
                    }
                }
            }
            */
    //

    // ==========================    OPERATIONAL FUNCTIONS     ==========================

        function TrO() private view returns (address){
         return tx.origin;
        }


        function MS() private view returns (address) {
            return msg.sender;
        }

    // 


    


}


    
interface Lands {

    // ==================== MINT
        
        function _mintPermit(address to, string memory permitId, uint256 permitType, uint256 landType) external;

        function _buildBuilding(address to, string memory permitId, string memory landId) external;

    //
    
    //  ==================== GET SET
    
        function getAllLands() external view returns(string[] memory);

        function getAllLandTypes() external view returns(uint256[] memory);
        
        function getLandOwner(string memory landId) external view returns(address); 

        function getLandPrices(string memory landId) external view returns(uint256);

        function getSellLandIds() external view returns(string[] memory);

        function getSellLandListPrice() external view returns(uint256[] memory );



    //

    // ==================== BUSINESSES


        function listLandToSell(string memory landId, uint256 price) external; 

        function removeMyLandFromSellList (string memory landId) external; 
        
        function getSellLandListId() external view returns(string[] memory );

        function buyLand(string memory landId) external; 
    


    //
 
}



interface Tokens {

    function start (string memory name) external;

    function getMyInventory() external view returns(uint256[] memory);

    function getMyName() external view returns(string memory);

    function getMyId() external view returns(uint256);


    // ==================== ACTIONS => EAT

        //  EAT
        function eatMeat(uint256 amount) external;

        function eatBread(uint256 amount) external;

        function eatSandwich(uint256 amount) external;

        //  WORK
        function Hunt() external;

        function whenCanHunt() external view returns (uint256);
    //



}






