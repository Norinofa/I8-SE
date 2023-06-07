document.addEventListener('click', e => {
    const isDropdownButton = e.target.matches("[data-dropdown-button]")
    if (!isDropdownButton && e.target.closest('[data-dropdown]') != null) return

    let currentDropdown
    if (isDropdownButton) {
        currentDropdown = e.target.closest('[data-dropdown]')
        currentDropdown.classList.toggle('active')
    }

    document.querySelectorAll("[data-dropdown].active").forEach(dropdown => {
        if (dropdown === currentDropdown) return
        dropdown.classList.remove('active')
    })
})


// für fragebogen
var holder1 = document.getElementById('firstholder');
var holder2 = document.getElementById('secondholder');
var holder3 = document.getElementById('thirdholder');
var choice2 = document.getElementById('choice2');
var choice3 = document.getElementById('choice3');
var choice4 = document.getElementById('choice4');


function openholder1() {
    holder1.classList.toggle('active');
    choice2.style.borderRadius = '0 30px 30px 30px'
}
function openholder2() {
    holder2.classList.toggle('active');
    choice3.style.borderRadius = '0 30px 30px 30px'
}
function openholder3() {
    holder3.classList.toggle('active');
    choice4.style.borderRadius = '0 30px 30px 30px'
}

// für sticky navbar
window.addEventListener('scroll', function(){
    var scroll = this.document.querySelector('.fa-arrow-up');
    var nav = this.document.querySelector('.sticky-nav');
    scroll.classList.toggle("active", this.window.scrollY > 500)
    nav.classList.toggle("active", this.window.scrollY > 500)
})

// für dropdown
function show(anything) {
    document.querySelector('.textBox').value = anything;
}

let dropdown = document.querySelector('.dropdown');
dropdown.onclick = function(){
    dropdown.classList.toggle('active');
}

// für import
var importCsv = document.querySelector('.file-upload');
var imoortButton = document.getElementById('test');
var full = document.querySelector('.fullscreen');

function openImport() {
  importCsv.style.display = 'flex';
}


// test
window.addEventListener('click', function(e){

	if (test.contains(e.target) || importCsv.contains(e.target)){
  	// alert("Clicked in Box");
    full.style.display = 'block';
    importCsv.style.display = 'flex';
  } else{
  	// alert("Clicked outside Box");
    importCsv.style.display = 'none';
    full.style.display = 'none';
  }
})


// für section controll
const themenswitch = document.getElementById('themenswitch');
var startThemenansicht = document.getElementById('startThemenansicht');
const fragebogenswitch = document.getElementById('fragebogenswitch');
var startFragebogen = document.getElementById('startFragebogen');
const teamsswitch = document.getElementById('teamsswitch');
var startTeams = document.getElementById('startTeams');

themenswitch.addEventListener('change', function() {
  if (this.checked) {
    console.log("Checkbox is checked.." + this.id);
    startThemenansicht.style.display = 'none';
  } else {
    console.log("Checkbox is not checked..");
    startThemenansicht.style.display = 'flex';
  }
});

fragebogenswitch.addEventListener('change', function() {
  if (this.checked) {
    console.log("Checkbox is checked.." + this.id);
    startFragebogen.style.display = 'none';
  } else {
    console.log("Checkbox is not checked..");
    startFragebogen.style.display = 'flex';
  }
});

teamsswitch.addEventListener('change', function() {
  if (this.checked) {
    console.log("Checkbox is checked..");
    startTeams.style.display = 'none';
  } else {
    console.log("Checkbox is not checked..");
    startTeams.style.display = 'flex';
  }
});