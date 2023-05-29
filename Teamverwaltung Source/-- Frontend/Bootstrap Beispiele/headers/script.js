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


/* JavaScript-Code für Dropdown-Menü */
document.addEventListener('DOMContentLoaded', function() {
    var dropdowns = document.querySelectorAll('.dropdown');
    for (var i = 0; i < dropdowns.length; i++) {
        dropdowns[i].addEventListener('mouseover', function() {
            this.querySelector('.dropdown-content').style.display = 'block';
        });
        dropdowns[i].addEventListener('mouseout', function() {
            this.querySelector('.dropdown-content').style.display = 'none';
        });
    }
});



function openFile() {
    var input = document.createElement('input');
    input.type = 'file';
    input.accept = '.xlsx';
    input.onchange = function(event) { 
        var selectedFile = event.target.files[0];
        document.getElementById('filename').innerHTML = 'Ausgewählte Datei: ' + selectedFile.name;
    };
    input.click();
}


// Die Dateien, die in die Zip-Datei aufgenommen werden sollen
const files = [
    { name: "Datei1.txt"  },
    { name: "Datei2.txt" },
  ];
  
  // Zip-Datei erstellen und herunterladen
  function downloadZip() {
    // Neue JSZip-Instanz erstellen
    const zip = new JSZip();
    
    // Dateien zur Zip-Datei hinzufügen
    files.forEach(file => {
      zip.file(file.name, file.content);
    });
    
    // Zip-Datei generieren und herunterladen
    zip.generateAsync({ type: "blob" }).then(content => {
      // Download-Link erstellen
      const downloadLink = document.createElement("a");
      downloadLink.href = URL.createObjectURL(content);
      downloadLink.download = "meine-datei.zip";
      
      // Download-Link klicken, um die Zip-Datei herunterzuladen
      downloadLink.click();
    });
  }
  
  // Click-Event-Listener hinzufügen
  document.getElementById("download-btn").addEventListener("click", downloadZip);