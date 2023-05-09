function login() {
    // Benutzername und Passwort überprüfen
    var username = document.getElementById("username").value;
    var password = document.getElementById("password").value;
    if (username === "Admin" && password === "1") {
      // Benutzer erfolgreich angemeldet
      // Weiterleitung zur anderen Seite
      window.location.href = "../Projektverwaltung/Projektverwaltung.html";
    } else {

      if (username === "Benutzer" && password === "1") {
        // Benutzer erfolgreich angemeldet
        // Weiterleitung zur anderen Seite
        window.location.href = "../Studentenansicht/Studentenansicht.html";
      } else {
        // Fehlermeldung anzeigen
        alert("Benutzername oder Passwort ungültig!");
      }
    } 
}