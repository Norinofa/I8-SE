# Notizen

## TODO

- [ ] logfile nach docker/logs legen
- [ ] ? file/folder permissions für lokale Verzeichnisse in den Docker Containern
- [ ] Passwörter und relevantes als Umgebungsvariable übergeben und nicht direkt im Code speichern bzw. per Git verteilen
  - https://subscription.packtpub.com/book/web-development/9781788837682/1/ch01lvl1sec06/creating-a-docker-project-file-structure
- [ ] Datenverzeichnisse für Datenbank etc. besser organisieren (data) bzw. backups
- [ ] Reset-Funktion: Setzt die Datenbank komplett zurück, so dass nur noch der Dozent-Login+Passwort (Primärschlüssel wieder bei 1 beginnend) vorhanden ist und alle Tabellen mit Studenten-/Umfrage-/Themendaten wieder leer sind (inkl. Primärschlüssel wieder bei 1 beginnend)
- [ ] Projekt-ID als extra Feld für Projekte erfassen und davon entsprechend auslesen für Namensbildung (E1: Thema...)
- [ ] Oberfläche erneuern, Label Begriffe (einzahl, mehrzahl, männlich, weiblich, ...)


## Fragen

- Warum auf Englisch und nicht Deutsch? (teamverwaltung/settings.py)

  ```
  LANGUAGE_CODE = 'en-us'

  TIME_ZONE = 'UTC'
  ```

## Serverzertifikate Quelle/Verwendung

Quelldateien:

- docker/ssl
  - htw_iteamse_server_with_ca.crt
  - htw_iteamse_server.key
  - htw_ldap_ca.crt

Docker Volumes:

- docker-compose.yml
  ```
  services:
    proxy:
      volumes:
        - ./docker/ssl/:/etc/nginx/ssl/:ro
    web:
      volumes:
        - ./docker/ssl/:/var/www/ssl/:ro
  ```

Verwendung:

- docker/django/gunicorn.py
  ```
  10 keyfile = '/var/www/ssl/htw_iteamse_server.key'
  11 certfile = '/var/www/ssl/htw_iteamse_server_with_ca.crt'
  ```

- docker/nginx/nginx.conf
  ```
  51 ssl_certificate ssl/htw_iteamse_server_with_ca.crt;
	52 ssl_certificate_key ssl/htw_iteamse_server.key;
  ```

- src/teamverwaltung/teamverwaltung/settings.py
  ```
  152 LDAP_CA_FILE_PATH = "/var/www/ssl/htw_ldap_ca.crt"
  ```

## LDAP CA vs Serverzertifikat HTTPS

Prinzipiell hat die benötigte LDAP-CA nichts mit dem Serverzertifikat für HTTPS zu tun. Dies sind zwei getrennte Dinge.

Das Serverzertifikat (HTTPS) benötigt für eine erfolgreiche Prüfung die zugehörigen CAs (Certificate Authorities), also die Kette nach oben der ausstellenden Stelle vom DFN-Verein, damit das Zertifikat erfolgreich geprüft werden kann. Diese ist bei ihnen zusätzlich mit in das Serverzertifikat (HTTPS) aufgenommen worden.

Das Zertifikat des LDAP Server des Rechenzentrums ist ebenfalls vom DFN-Verein über die HTW ausgestellt worden.

Django als LDAP-Client benötigt für SSL/TLS die Kette der ausstellenden Stelle, um das Serverzertifikat des LDAP Servers prüfen zu können. Genau diese Kette gibt man bei „LDAP_CA_FILE_PATH“ an.

Dadurch, dass das Webserverzertifikat (HTTPS) diese Kette vom DFN enthält, können sie es auch für „LDAP_CA_FILE_PATH“ verwenden. Dabei wird das Webserverzertifikat ignoriert, aber die zusätzlich enthaltene Kette vom DFN genommen.

Das geht also nur in dem speziellen Fall, wenn der LDAP und der Webserver beide Zertifikate von der gleichen ausgestellten Stelle bekommen. Andernfalls bräuchte LDAP_CA_FILE_PATH eine Datei mir der zum LDAP Server passenden Kette.

Das hatte mich erst verwundert, warum das bei ihnen mit dem eher unüblichen gleichen Zertifikat geht. Aber vielleicht war es ihnen auch nicht so klar. ;)
