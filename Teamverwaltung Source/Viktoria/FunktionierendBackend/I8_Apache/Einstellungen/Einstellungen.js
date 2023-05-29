
//Datei für Backup auswählen
function openFile() {
    var input = document.createElement('input');
    input.type = 'file';
    input.accept = '.xlsx';
    input.click();
    
    input.addEventListener('change', () => {
      const selectedFile = input.files[0];
      alert(`Die ausgewählte Datei ist: ${selectedFile.name}`);
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