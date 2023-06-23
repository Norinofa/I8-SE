
//Datei für Backup auswählen
function openFile() {
    var input = document.createElement('input');
    input.type = 'file';
    input.accept = '.xlsx';
    input.accept = '.csv';
    input.click();
    
    input.addEventListener('change', () => {
      const selectedFile = input.files[0];
      readCSV(selectedFile); // Call readCSV function with the selected file

    });
}


//Popup fürs Seite zurücksetzen
function openPopup() {
	var popupOverlay = document.getElementById("popup-overlay");
	var popup = document.getElementById("popup");
	popupOverlay.style.display = "block";
	popup.style.display = "block";
}

function closePopup() {
	var popupOverlay = document.getElementById("popup-overlay");
	var popup = document.getElementById("popup");
	popupOverlay.style.display = "none";
	popup.style.display = "none";
}








function readCSV(file) {
  const reader = new FileReader();
  reader.onload = function(event) {
    const contents = event.target.result;
    const lines = contents.split('\n');

    // Extract header row
    const headerRow = lines[0].split(';');
    const thead = document.querySelector('#csvTable thead');
    thead.innerHTML = '';
    const headerRowHTML = document.createElement('tr');
    for (let i = 0; i < headerRow.length; i++) {
      const th = document.createElement('th');
      th.textContent = headerRow[i];
      headerRowHTML.appendChild(th);
    }
    thead.appendChild(headerRowHTML);

    // Remove existing table rows
    const tbody = document.querySelector('#csvTable tbody');
    tbody.innerHTML = '';
//

let users = [];


    // Create new table rows
    for (let i = 1; i < lines.length; i++) { // Start from index 1 to skip the header row
      const cells = lines[i].split(';');
      if (cells.length === 5) {
        let fisrnameval , lastnameval , emailval ,studenval ;
        const row = document.createElement('tr');
        for (let j = 0; j < cells.length; j++) {
          const cell = document.createElement('td');
          if(j==1)
          {
            fisrnameval = cells[j];
          }
          if(j==2)
          {
            lastnameval = cells[j];
          }
          if(j==3)
          {
            emailval = cells[j];
          }
          if(j==4)
          {
            studenval = cells[j];
          }
          cell.textContent = cells[j];
          row.appendChild(cell);
        }

        let user = {
         
          firstname :fisrnameval,
          lastname : lastnameval ,
          email : emailval ,
          studiengruppe : studenval
        }
       
        users.push(user);
        saveccsv(user);

        tbody.appendChild(row);
      }
    }
    console.log(users);
  };
  reader.readAsText(file);
}




//ZIP Download 

function downloadAll() {
    // Namen der Dateien, die im ZIP-Archiv enthalten sein sollen
    const filenames = ["../index.html"];
  
    // ZIP-Datei erzeugen
    const zip = new JSZip();
    const folder = zip.folder("I8_Backup");
  
    // Für jede Datei in der filenames-Liste eine neue Datei im ZIP-Archiv erstellen
    for (let i = 0; i < filenames.length; i++) {
      const filename = filenames[i];
      const fileContent = null; // Inhalt der Datei
      folder.file(filename, fileContent, { binary: true });
    }
  
    // ZIP-Datei als Blob erzeugen und als Download bereitstellen
    zip.generateAsync({ type: "blob" }).then(function (blob) {
      const link = document.createElement("a");
      link.href = window.URL.createObjectURL(blob);
      link.download = "I8_Backup.zip";
      link.click();
    });
  }

function saveccsv(data) {
  fetch("http://localhost:8080/student/save",{
    method: "post",
    headers: {
      "Content-Type": "application/json"
    } 
    ,body:JSON.stringify(data)
    }
    )
  .catch(err=>console.log(err))
}


  function cleardata() {
    fetch("http://localhost:8080/Answers/Project/deleteall",{
      method: "Get",
      headers: {
        "Content-Type": "application/json"
      }
      })
    .then(response => response.json())
    .catch(err=>console.log(err))

    fetch("http://localhost:8080/Answers/Skill/deleteall",{
      method: "Get",
      headers: {
        "Content-Type": "application/json"
      }
      })
    .then(response => response.json())
    .catch(err=>console.log(err))


    fetch("http://localhost:8080/Answers/Role/deleteall",{
      method: "Get",
      headers: {
        "Content-Type": "application/json"
      }
      })
    .then(response => response.json())
    .catch(err=>console.log(err))


    fetch("http://localhost:8080/Project/deleteall",{
      method: "Delete",
      headers: {
        "Content-Type": "application/json"
      }
      })
    .then(response => response.json())
    .catch(err=>console.log(err))

    fetch("http://localhost:8080/Users/getallstudent",{
      method: "Get",
      headers: {
        "Content-Type": "application/json"
      }
      })
    .then(response => response.json())
    .catch(err=>console.log(err))

   alert("Seite wird zurückgesetzt!")
  }