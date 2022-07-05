
//#region  WALLET FUNCTIONS CONTRACT INIT




async function StartContract() {

      console.log('Start Contract');
      // Step 1: get connect to metamask
      checkForMetamask().then(step1 => {
            if (step1) {

                  // step 2: init contract
                  tryInitContract().then(step2 => {
                        return Promise.resolve(true);
                  }).catch(() => { return Promise.resolve(false); });
            }
      })
}



var provider;
var signer;
var hasMetamask = false;
async function checkForMetamask() {

      if (window.ethereum === undefined) {
            sendAlert('You need to install MetaMask Extention.')
            return Promise.resolve(false);
      } else {
            hasMetamask = true;
            provider = new ethers.providers.Web3Provider(window.ethereum, "any");
            await provider.send("eth_requestAccounts", []).then(() => {
                  signer = provider.getSigner();
            });
            //console.log('step 1 done.')
            return Promise.resolve(true);
      }
}

function sendAlert(msg) {
      setTimeout(() => {
            window.alert(msg);
      }, 1000)
}



var myContract;
var isContractInit = false;

function tryInitContract() {
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
