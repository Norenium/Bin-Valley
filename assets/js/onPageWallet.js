
//#region  WALLET FUNCTIONS CONTRACT INIT
function isOdd(num) { return num % 2; }


function StartContract() {
      //console.log('StartContract');
      return new Promise(() => {

            checkForMetamask().then(step1 => {
                  if (step1) {
                        //console.log('checkForMetamask=>then');

                        // step 2: init contract
                        tryInitContract().then(step2 => {
                              //console.log('tryInitContract => .then')
                              startPageManager();
                              return Promise.resolve(step2);

                        }).catch(() => { return Promise.resolve(false); });
                  }
            })
      })
}



var provider;
var signer;
var hasMetamask = false;
async function checkForMetamask() {

      //console.log('checkForMetamask');
      //return new Promise(async function () {
      if (window.ethereum === undefined) {
            sendAlert('You need to install MetaMask Extention.')
            console.log('ERROR: You need to install MetaMask Extention.')
            return Promise.resolve(false);
            //return false;
      } else {
            hasMetamask = true;
            provider = new ethers.providers.Web3Provider(window.ethereum, "any");
            await provider.send("eth_requestAccounts", []).then(() => {
                  signer = provider.getSigner();
                  return Promise.resolve(true);

            });
            return Promise.resolve(true);

      }
      ///});
}

function sendAlert(msg) {
      setTimeout(() => {
            window.alert(msg);
      }, 1000)
}



var myContract;
var isContractInit = false;

function tryInitContract() {
      //console.log('tryInitContract');
      /*
      return Promise.resolve(function () {
            myContract = new ethers.Contract(contractAddress, ABI, signer);
            isContractInit = true;
            console.log('tryInitContract done.');
            return true;
      });*/

      try {
            myContract = new ethers.Contract(contractAddress, ABI, signer);
            isContractInit = true;
            //console.log('step 2 - contract init done.');
            return Promise.resolve(true);
      } catch (error) {
            return Promise.resolve(false);
      }

}

//#endregion 







//#region ======================== GLOBAL CALL CONTRACT METHODS ========================
function getMyName() {
      return new Promise(function (resolve) {
            resolve(myContract.bravoCall(31, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res[0];
            }));
      })
}


function getMyInventory() {
      return new Promise(function (resolve) {
            resolve(myContract.charlieCall(31, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }));
      })
}

function getAllLandIds() {
      return new Promise(function (resolve) {
            resolve(myContract.bravoCall(11, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }));
      })
}

function getAllLandTypes() {
      return new Promise(function (resolve) {
            resolve(myContract.charlieCall(11, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }));
      })
}

function getMyLands() {
      return new Promise(function (resolve) {
            resolve(myContract.bravoCall(12, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }));
      })
}



function getSellLandsPrices() {
      return new Promise(function (resolve) {
            resolve(
                  myContract.charlieCall(12, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                        return res;
                  }));
      })
}

function getSellLandsId() {
      return new Promise(function (resolve) {
            resolve(myContract.bravoCall(13, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }));
      })
}






function getMyBuildings() {
      return new Promise(function (resolve) {
            resolve(myContract.bravoCall(16, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }));
      })
}



function getAllBuildings() {
      return new Promise(function (resolve) {
            resolve(myContract.bravoCall(17, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }));
      })
}


// returns a uint256  number of seconds from 1970 to the block latest hunt happend.
function getWhenCanHunt() {
      //console.log('call for when can hunt');
      return new Promise(function (resolve, revoke) {
            try {
                  console.log('TRY TRY Hunting privilage')

                  resolve(myContract.charlieCall(32, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                        //console.log('res for when can hunt: ' + res);
                        return res;
                  }));
            } catch (error) {
                  revoke(function () { return false });
                  console.log('have not Hunting privilage')

            }

      })
}



//#endregion
