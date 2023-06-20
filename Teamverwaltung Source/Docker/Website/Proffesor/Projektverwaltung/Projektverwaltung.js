const idField = document.getElementById("id-field");
const nameField = document.getElementById("name-field");
const longDescField = document.getElementById("long-desc-field");
const shortDescField = document.getElementById("short-desc-field");
const resetBtn = document.getElementById("reset-btn");
const saveBtn = document.getElementById("save-btn");
const infoContainer = document.getElementById("info-container");

resetBtn.addEventListener("click", function() {
	idField.value = "";
	nameField.value = "";
	longDescField.value = "";
	shortDescField.value = "";
});

saveBtn.addEventListener("click", function() {
	const id = idField.value;
	const name = nameField.value;
	const nameval = nameField.value;

	const longDesc = longDescField.value;
	const shortDesc = shortDescField.value;
	checisidexsit();
	let isvialded = validateForm();

	if (isvialded) {
	let projdata = {
		name :  nameval   ,
		description :  longDesc  ,
		proid :  id    ,
		firma :  shortDesc 
	}
	fetch("http://localhost:8080/Project/save", {
    method: "post",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(projdata)
  })
  .then(res => {
    if (!res.ok) {
      alert("password and username is wrong");
      throw new Error(res.statusText);
    }
	 location.href = "./Projects.html"

    return res.json();
  })
}
});


function validateForm() {
	// Reset error messages
	
	
	document.getElementById("errorid").textContent = "";
	document.getElementById("errorname").textContent = "";
	document.getElementById("errorfirma").textContent = "";
	document.getElementById("errordes").textContent = "";
  
	// Get field values
	var id = document.getElementById("id-field").value;
	var name = document.getElementById("name-field").value;
	var firma = document.getElementById("short-desc-field").value;
	var beschreibung = document.getElementById("long-desc-field").value;
  
  
	
	
	var isValid = true; // Flag to track form validity

	// Check if ID field is empty
	if (id.trim() === "" ) {
	  document.getElementById("errorid").textContent = "Please enter an ID";
	  isValid = false;
	}
  
	// Check if Projektname field is empty
	if (name.trim() === "") {
	  document.getElementById("errorname").textContent = "Please enter a Projektname";
	  isValid = false;
	}
  
	// Check if Firma/Ansprechpartner field is empty
	if (firma.trim() === "") {
	  document.getElementById("errorfirma").textContent = "Please enter a Firma/Ansprechpartner";
	  isValid = false;
	}
  
	// Check if Beschreibung field is empty
	if (beschreibung.trim() === "") {
	  document.getElementById("errordes").textContent = "Please enter a Beschreibung";
	  isValid = false;
	}
  
	return isValid;
  }

	
function checisidexsit(){
	const id = idField.value;
	document.getElementById("isexsit").textContent = "";
	document.getElementById("save-btn").disabled = false ;
	let isexsit = false;
	fetch("http://localhost:8080/Project/getprojid/" + id, {
		method: "Get",
		headers: {
		  "Content-Type": "application/json"
		}
	  })
	  .then(res =>res.json())
	  .then(data => {
		isexsit = data;
		if(isexsit) {
			document.getElementById("isexsit").textContent = "Diese ID wurde schon vergeben. Bitte nutzen Sie eine neue ID.";
			document.getElementById("save-btn").disabled = true ;
		}
		console.log(data)
	  })

}

let idcheck = document.getElementById("id-field");
idcheck.addEventListener("change" , checisidexsit) ;





   
