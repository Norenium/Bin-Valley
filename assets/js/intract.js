StartContract();
//document.getElementById('contract-address').innerHTML = contractAddress;
console.log('window.location: ' + window.location);
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
      myContract.getMyInventory().then(res => {
            console.log('6 res: ' + res[8]);

            //Flour
            var opousMoneyPersentage = Math.floor(res[0]);
            document.getElementById('op-val').innerHTML = opousMoneyPersentage;

            //Flour
            var electricityPersentage = Math.floor(res[1]);
            document.getElementById('mw-val').innerHTML = electricityPersentage;

            //Flour
            var WheatPersentage = Math.floor(res[2]);
            document.getElementById('wh-val').innerHTML = WheatPersentage;

            //Flour
            var BreadPersentage = Math.floor(res[3]);
            document.getElementById('br-val').innerHTML = BreadPersentage;

            //Flour
            var healthPersentage = Math.floor(res[4]);
            document.getElementById('fl-val').innerHTML = healthPersentage;

            //Meat
            var healthPersentage = Math.floor(res[5]);
            document.getElementById('mt-val').innerHTML = healthPersentage;

            //Health
            var healthPersentage = Math.floor(res[6]);
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
            document.getElementById('energy-cal').innerHTML = Math.floor(res[8]) + " Cal";
      }
      );
};
var pricesArray;
let landIdArray;
function setLandData() {
      console.log('setLandData Started');
      myLandContract.getSellLandList().then(res => {

            console.log('setLandData 2 ');

            pricesArray = res;
            myLandContract.getSellLandIds().then(ret => {
                  console.log('setLandData 3 ');

                  landIdArray = ret;
                  var row = document.getElementById('sell-list');

                  for (let i = 0; i < ret.length; i++) {

                        console.log('sell land list item ' + i + ' id :' + landIdArray[i]
                              + '  price: ' + pricesArray[i]);


                        var el = '<div class="land-for-sale"> <div class=" row col-12"> <img src="assets/images/Avatars/Avatar (2).svg" alt="profile thumnail" class="col-1 lfs-img"> <p class="col-3">Land Id: ' +
                              landIdArray[i] + '</p> <p class="col-4">Seller: Darth Vader</p> <p class="col-3">Price: ' + pricesArray[i] + ' OP</p> <button type="button" class="btn btn-primary float-end col-1" onclick="buyLand(\''
                              + landIdArray[i] + '\')"> Buy </button> </div> </div>';

                        row.innerHTML += el;
                  }
            }
            );
      }
      );
};



//#endregion

function normalize(inp) {
      return inp / Math.pow(10, 18);
}

function buyLand(landId) {
      console.log('Call for buy land id: ' + landId);
      myLandContract.buyLand(landId).then(res =>
            console.info(res));
}

function listLand() {
      var landId = document.getElementById('sell-landId').value;
      var price = document.getElementById('sell-price').value;
      console.log('Call for sell land -  id: ' + landId + '   price: ' + price);
      myLandContract.listLandToSell(landId,price).then(res =>
          console.info(res));
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

                        if (window.location == 'http://127.0.0.1:8080/') {
                              setPageData();
                        }
                        return Promise.resolve(true);
                  })
                  tryInitContract2().then(step2 => {
                        if (window.location == 'http://127.0.0.1:8080/') {

                              setLandData();
                        }
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



var myLandContract;
var isLandContractInit = false;

function tryInitContract2() {
      try {
            myLandContract = new ethers.Contract(landContractAddress, landABI, signer);
            isLandContractInit = true;
            console.log('step 2 - contract init done.');
            return Promise.resolve(true);
      } catch (error) {
            return Promise.resolve(false);
      }
}

 //#endregion




//#endregion