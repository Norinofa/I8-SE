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
	const longDesc = longDescField.value;
	const shortDesc = shortDescField.value;
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
// Example starter JavaScript for disabling form submissions if there are invalid fields
/*(() => {
	'use strict'
  
	// Fetch all the forms we want to apply custom Bootstrap validation styles to
	const forms = document.querySelectorAll('.needs-validation')
  
	// Loop over them and prevent submission
	Array.from(forms).forEach(form => {
	  form.addEventListener('submit', event => {
		if (!form.checkValidity()) {
		  event.preventDefault()
		  event.stopPropagation()
		}
  
		form.classList.add('was-validated')
	  }, false)
	})
  })()
  
*/
/*
<form>
		<label>ID:</label>
		<input type="text" id="id-field" required>
		<label>Name:</label>
		<input type="text" id="name-field" required>
		<label>Beschreibung:</label>
		<textarea id="long-desc-field" required></textarea>
		<label>Ansprechpartner:</label>
		<textarea id="short-desc-field" required></textarea>
		<br>
		<button type="button" id="reset-btn" class="btn">Loeschen</button>
		<button type="button" id="save-btn" class="btn">Speichern</button>
	</form>
 /*



const createBoxBtn = document.getElementById('create-box-btn');
const boxContainer = document.getElementById('box-container');

let boxIndex = 1;

createBoxBtn.addEventListener('click', () => {
  // Box-Element erstellen
  const infobox = document.createElement('div');
  infobox.classList.add('info');
  infobox.id = `box-${boxIndex}`;

  // Text-Elemente erstellen

    //const id = idField.value;
    const id = document.createElement('p');
    const name = document.createElement('p');
	const longDesc = document.createElement('p');
	const shortDesc = document.createElement('p');
    
    infobox.classList.add("info");
	infobox.innerHTML = `
		<h2>${id} - ${name}</h2>
		<p>${longDesc}</p>
		<p><strong>${shortDesc}</strong></p>
	`;

  /*
  const text1 = document.createElement('p');

  text1.textContent = `Box ${boxIndex} - Text 1`;
  const text2 = document.createElement('p');

  text2.textContent = `Box ${boxIndex} - Text 2`;
  const text3 = document.createElement('p');

  text3.textContent = `Box ${boxIndex} - Text 3`;
  const text4 = document.createElement('p');

  text4.textContent = `Box ${boxIndex} - Text 4`;

  // Text-Elemente zur Box hinzufügen
  infobox.appendChild(id);
  infobox.appendChild(name);
  infobox.appendChild(shortDesc);
  infobox.appendChild(longDesc);
/*



  // Box zur Container-Element hinzufügen
  boxContainer.appendChild(infobox);

  // Box-Index erhöhen
  boxIndex++;
});


*/


