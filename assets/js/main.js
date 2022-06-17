document.getElementById('connect-wallet-btn').addEventListener("click",ConnctWallet);
document.getElementById('health-title').addEventListener("click",CH);

function ConnctWallet(){
      console.log('connect-wallet-btn clicked.')
      document.getElementById('connect-wallet-div').style.display = "none";
}


function CH(){
      console.log('CH clicked.')
      document.getElementById("health-bar").ariaValueNow = 50;
      document.getElementById("health-bar").style.width = '50%';
}