function generieren() {
    var min = parseInt(document.getElementById("min").value);
    var max = parseInt(document.getElementById("max").value);
    var size = min + max;
    window.location.href = "Teamverwaltung.html?size=" + size;
}