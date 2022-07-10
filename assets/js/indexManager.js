StartContract();

function ConnctWallet() {
      StartContract();
}

var allLandsId = new Array();
var myLandsId;
var myLands = new Array();
var allLandsType = new Array();


var sellLandsId, sellLandsPrice;
var sellLandArray = new Array();

function startPageManager() {
      console.log('page Manager has been called');
      getMyName().then(res => {
            console.log('My name: ' + res)
            document.getElementById('connect-wallet-div').style.display = "none";
            if (res === '') {
                  console.log('No name');
                  document.getElementById('start-div').style.display = "block";
            } else {
                  document.getElementById('boards-container').style.display = "block";
                  document.getElementById('my-name').innerHTML = res;

            }
      })



      getMyInventory().then(res => {

            console.info(res);
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
            var energyPercentage = Math.floor(res[8] / 10);
            document.getElementById('energy-bar').style.width = energyPercentage + "%";
            document.getElementById('energy-percentage').innerHTML = energyPercentage + "%";
            document.getElementById('energy-cal').innerHTML = Math.floor(res[8]) + " Cal";
      })

      // get all lnads and get all land types and get my lands and set my lands on the page
      getAllLandIds().then(res => {
            allLandsId = res;
            getAllLandTypes().then(res2 => {


                  //#region set landtypes to string names

                  for (let i = 0; i < res2.length; i++) {


                        switch (parseInt(BigInt((res2[i]).toString()))) {
                              case 0:


                                    allLandsType[i] = "Forest"
                                    // console.log('#My Land number ' + i + '  case 0:  type: ' + allLandsType[i]);

                                    break;

                              case 2:
                                    allLandsType[i] = "Mountain"
                                    break;

                              case 3:
                                    allLandsType[i] = "Agral"
                                    break;

                              case 4:
                                    allLandsType[i] = "Urban"
                                    break;

                              default:
                                    break;
                        }
                  }
                  //#endregion

                  getMyLands().then(res3 => {
                        myLandsId = res3;
                        console.log('res3: ' + res3)
                        console.log('myLandsId: ' + myLandsId)

                        if (myLandsId.length > 0) {
                              myLandsId.forEach(element => {
                                    for (let i = 0; i < allLandsId.length; i++) {
                                          if (element == allLandsId[i]) {

                                                //console.log('set myLands types: ' +BigInt(allLandsType[i]._hex))
                                                //myLands.push({ landId: allLands[i], landType: parseInt(BigInt((allLandsType[i]._hex).toString())) });
                                                myLands.push({ landId: allLandsId[i], landType: allLandsType[i] });

                                          }


                                    }

                              });

                              setMyLands();
                              getAndSetSellLandData();
                              //getWhenCanHunt();
                        } else {
                              document.getElementById('no-lands').style.display = "block";
                              document.getElementById('loading-lands').style.display = "none";

                        }
                  })
            })
      })


}

function getAndSetSellLandData() {
      getSellLandsPrices().then(res => {
            sellLandsPrice = res;
            document.getElementById('loading-sell-lands').style.display = "none";

            if (sellLandsPrice.length == 0) {
                  document.getElementById('no-sell-lands').style.display = "block";
            } else {


                  getSellLandsId().then(res2 => {
                        sellLandsId = res2;
                        console.log('*****************')
                        console.info(allLandsId);
                        console.info(sellLandsId);
                        for (let i = 0; i < allLandsId.length; i++) {

                              for (let j = 0; j < sellLandsPrice.length; j++) {

                                    if (allLandsId[i] == sellLandsId[j]) {
                                          var row = document.getElementById('sell-list');

                                          var n = Math.floor(Math.random() * 10);
                                          var el = '<div class="land-for-sale" id="' + allLandsId[i] + '-sale"> <div class=" row col-12"> <img src="assets/images/Avatars/Avatar (' + n + ').svg" alt="profile thumnail" class="col-1 lfs-img"> <p class="col-3">Land Id: ' +
                                                allLandsId[i] + '</p> <p class="col-3">Seller: Darth Vader</p> <p class="col-4">Price: ' + sellLandsPrice[i] + ' OP <span class="' + allLandsType[i] + '">' + allLandsType[i] + '</span> </p> <div class="col-1"> <button type="button" class="btn btn-sm btn-primary float-end " onclick="buyLand(\''
                                                + allLandsId[i] + '\',' + sellLandsPrice[i] + ')"> Buy </button> </div></div> </div>';

                                          row.innerHTML += el;

                                          sellLandArray.push({ landId: allLandsId[i], landType: allLandsType[i], price: parseInt(sellLandsId[j]) })
                                    }
                              }

                        }

                  })
            }
      })
}




function setMyLands() {
      var myLandsDiv = document.getElementById('my-lands');
      document.getElementById('loading-lands').style.display = "none";
      for (let i = 0; i < myLands.length; i++) {


            myLandsDiv.innerHTML += '<div class="my-land-row d-flex justify-content-between">' +
                  '<span>LandId: ' + myLands[i].landId + '</span>' +
                  '         <span> LandType: <span class="' + myLands[i].landType + '">' + myLands[i].landType + '</span></span>      </div>';
      }

}