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

      // myContract.getMyBodyEnergy().then(res => {
      //       console.log('Energy res: ' + res)
      //       var per = Math.floor(res / 7);
      //       console.log('Energy per: ' + per)
      //       document.getElementById('energy-bar').style.width = per + "%";
      //       document.getElementById('energy-percentage').innerHTML = per + "%";
      //       document.getElementById('energy-cal').innerHTML = res + " Cal";
      // }
      // );

      // myContract.getMyBodyFat().then(res => {
      //       console.log('Fat res: ' + res)
      //       var per = Math.floor(res / 50);
      //       console.log('Fat per: ' + per)
      //       document.getElementById('fat-bar').style.width = per + "%";
      //       document.getElementById('fat-percentage').innerHTML = per + "%";
      //       document.getElementById('fat-cal').innerHTML = res + " Cal";
      // }
      // );

      // myContract.getMyBodyHealth().then(res => {
      //       console.log('Health res: ' + res)
      //       var per = Math.floor(res );
      //       console.log('Health per: ' + per)
      //       document.getElementById('health-bar').style.width = per + "%";
      //       document.getElementById('health-percentage').innerHTML = per + "%";
      // }
      // );


      myContract.getMyInventory().then(res => {
            console.log('6 res: ' + res[8]);

            //Flour
            var opousMoneyPersentage = Math.floor(res[0] );
            document.getElementById('op-val').innerHTML = opousMoneyPersentage ;

            //Flour
            var electricityPersentage = Math.floor(res[1] );
            document.getElementById('mw-val').innerHTML = electricityPersentage ;

            //Flour
            var WheatPersentage = Math.floor(res[2] );
            document.getElementById('wh-val').innerHTML = WheatPersentage ;

            //Flour
            var BreadPersentage = Math.floor(res[3] );
            document.getElementById('br-val').innerHTML = BreadPersentage ;

            //Flour
            var healthPersentage = Math.floor(res[4] );
            document.getElementById('fl-val').innerHTML = healthPersentage ;

            //Meat
            var healthPersentage = Math.floor(res[5] );
            document.getElementById('mt-val').innerHTML = healthPersentage ;

            //Health
            var healthPersentage = Math.floor(res[6] );
            document.getElementById('health-bar').style.width = healthPersentage + "%";
            document.getElementById('health-percentage').innerHTML = healthPersentage + "%";

            // Fat
            var fatPercentage = Math.floor(res[7] / 50);
            document.getElementById('fat-bar').style.width = fatPercentage + "%";
            document.getElementById('fat-percentage').innerHTML = fatPercentage + "%";
            document.getElementById('fat-cal').innerHTML = Math.floor(res[7]) + " Cal";


            // Energy
            var energyPercentage = Math.floor(res[8] / 7);
            document.getElementById('energy-bar').style.width = energyPercentage + "%";
            document.getElementById('energy-percentage').innerHTML = energyPercentage + "%";
            document.getElementById('energy-cal').innerHTML =  Math.floor(res[8]) + " Cal";
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