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
    return res.json();
  })
	const infoBox = document.createElement("div");
	infoBox.classList.add("info");
	infoBox.innerHTML = `
		<h2>${id} - ${name}</h2>
		<p>${longDesc}</p>
		<p><strong>${shortDesc}</strong></p>
	`;
	infoContainer.insertBefore(infoBox, infoContainer.firstChild);
	idField.value = "";
	nameField.value = "";
	longDescField.value = "";
	shortDescField.value = "";
});

	





   
