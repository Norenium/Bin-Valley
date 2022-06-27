document.getElementById('show-land-id').addEventListener('click', toggleShowLandId);
set();








var idShowan = false;
function toggleShowLandId() {
      var elements = document.getElementsByClassName('mp');
      console.log(elements.length);
      for (let i = 0; i < elements.length; i++) {
            if (idShowan) {
                  elements[i].style.display = "none";

            } else {
                  elements[i].style.display = "block";
            }
      }
      if (idShowan) {
            idShowan = false;
      } else {
            idShowan = true;
      }

}

function set() {
      for (let i = 0; i < 151; i++) {
            if (i == 74) { } else {
                  //console.log('set() => pixle-' + i);
                  document.getElementById('pixle-' + i).addEventListener('mouseenter', function () {
                        document.getElementById('info-' + i).style.display = "block";
                  });

                  document.getElementById('info-' + i).addEventListener('mouseenter', function () {
                        document.getElementById('info-' + i).style.display = "block";
                        document.getElementById('pixle-' + i).classList.add("pixle-hover");
                  });

                  document.getElementById('pixle-' + i).addEventListener('mouseleave', function () {
                        document.getElementById('info-' + i).style.display = "none";
                        document.getElementById('pixle-' + i).classList.remove("pixle-hover");
                  });
            }
      }
}

function pixleMouseIn(i) {
      //document.getElementById('pixle-'+i).style.display = "block";
      console.log('mouseIn ' + i);
}

function pixleMouseOut(i) {
      //document.getElementById('pixle-'+i).style.display = "none";
      console.log('mouseout ' + i);

}