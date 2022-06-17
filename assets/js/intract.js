StartContract();
document.getElementById('contract-address').innerHTML = contractAddress;

//#region variables




//#endregion

//#region Page Functions
//#region Send Data to contract

// document.getElementById('chip-in').addEventListener('click', function () {

//       if (TicketPrice == 0) {
//             if (IsBucketReady != true) {
//                   window.alert('There is no running lottery bucket now.')
//             } else {
//                   window.alert('Ticket Price is not defined correctly.\n Please refresh the page and' +
//                         ' try again.')
//             }
//       } else {
//             var val = ethers.utils.parseEther(TicketPrice.toString());
//             console.log('sending value (10^18): ' + val);
//             myContract.chipIn({ value: val });
//       }

// })


//#endregion 



//#region FETCH contract data methods

function setPageData() {

myContract.getMyBodyEnergy().then(res=>{
      console.log('Energy: '+res)
      console.info(res);
}
);


};



//#endregion

function normalize(inp) {
      return inp / Math.pow(10, 18);
}








//#region Wallet  Functions


//#region         step 0: Start

async function StartContract() {
      console.log('Start Contract');
      // Step 1: get connect to metamask
      checkForMetamask().then(step1 => {
            if (step1) {
                  // step 2: init contract
                  tryInitContract().then(step2 => {

                        setPageData();

                        return Promise.resolve(true);
                  })
            }
      })
}



//#endregion


//#region         step 1: check for metamask
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
            console.log('step 1 done.')
            return Promise.resolve(true);
      }
}

function sendAlert(msg) {
      setTimeout(() => {
            window.alert(msg);
      }, 1000)
}

//#endregion 


//#region         step 2: init Contract

var myContract;
var isContractInit = false;

function tryInitContract() {
      try {
            myContract = new ethers.Contract(contractAddress, ABI, signer);
            isContractInit = true;
            console.log('step 2 - contract init done.');
            return Promise.resolve(true);
      } catch (error) {
            return Promise.resolve(false);
      }
}

 //#endregion




//#endregion