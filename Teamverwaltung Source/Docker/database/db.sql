DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `role` (`role`) VALUES ('Test');
INSERT INTO `role` (`role`) VALUES ('Implementierung');
INSERT INTO `role` (`role`) VALUES ('Entwurf');
INSERT INTO `role` (`role`) VALUES ('Analyse');
INSERT INTO `role` (`role`) VALUES ('Teamleiter');



DROP TABLE IF EXISTS `skill`;

CREATE TABLE `skill` (
  `id` int NOT NULL AUTO_INCREMENT,
  `skill` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `skill` (`skill`) VALUES ('Objektorientierte Konzepte (Klassen, Vererbung, usw.)');
INSERT INTO `skill` (`skill`) VALUES (' Web-Technologien (HTML, CSS, HTTP, REST) ');
INSERT INTO `skill` (`skill`) VALUES ('Objektorientierte Programmiersprachen, z.B. Java, C#, C++');
INSERT INTO `skill` (`skill`) VALUES ('Skriptsprachen, z.B. Python, Ruby, PHP, JavaScript');
INSERT INTO `skill` (`skill`) VALUES ('Web-Frameworks, z.B. Spring, ASP.NET, Django, Node.js');
INSERT INTO `skill` (`skill`) VALUES ('Datenbanken, z.B. MySQL, MS SQL Server, MongoDB');
INSERT INTO `skill` (`skill`) VALUES ('Modellierungssprachen, z.B. EPK, BPMN, UML ');
INSERT INTO `skill` (`skill`) VALUES (' Gestaltung von Benutzeroberflächen (UI-Design) ');
INSERT INTO `skill` (`skill`) VALUES (' Projekt-, Risiko-, Qualitätsmanagement, Personalführung ');
INSERT INTO `skill` (`skill`) VALUES (' Softwareentwicklung in Projektarbeit ');
INSERT INTO `skill` (`skill`) VALUES (' Softwareentwicklung in Einzelarbeit ');
INSERT INTO `skill` (`skill`) VALUES (' Versionsverwaltung mit Git ');



DROP TABLE IF EXISTS `project`;

CREATE TABLE `project` (
  `id` int NOT NULL AUTO_INCREMENT,
  `proid` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `firma` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `teams`;

CREATE TABLE `teams` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `projectid` int NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`projectid`) REFERENCES `project`(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `issanswerd` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `users` (`username`, `password`, `firstname`, `lastname`, `role`, `issanswerd`) VALUES ("Nuha", "123", "Nuha", "Adnan", "student", "NO");
INSERT INTO `users` (`username`, `password`, `firstname`, `lastname`, `role`, `issanswerd`) VALUES ("Nuha2", "123", "Nuha", "Adnan", "student", "NO");
INSERT INTO `users` (`username`, `password`, `firstname`, `lastname`, `role`, `issanswerd`) VALUES ("Nuha3", "123", "Nuha", "Adnan", "student", "NO");
INSERT INTO `users` (`username`, `password`, `firstname`, `lastname`, `role`, `issanswerd`) VALUES ("Nuha4", "123", "Nuha", "Adnan", "student", "NO");
INSERT INTO `users` (`username`, `password`, `firstname`, `lastname`, `role`, `issanswerd`) VALUES ("Nuha5", "123", "Nuha", "Adnan", "student", "NO");
INSERT INTO `users` (`username`, `password`, `firstname`, `lastname`, `role`, `issanswerd`) VALUES ("Nuha6", "123", "Nuha", "Adnan", "student", "NO");
INSERT INTO `users` (`username`, `password`, `firstname`, `lastname`, `role`, `issanswerd`) VALUES ("Nuha7", "123", "Nuha", "Adnan", "student", "NO");
INSERT INTO `users` (`username`, `password`, `firstname`, `lastname`, `role`, `issanswerd`) VALUES ("Nuha8", "123", "Nuha", "Adnan", "student", "NO");
INSERT INTO `users` (`username`, `password`, `firstname`, `lastname`, `role`, `issanswerd`) VALUES ("Nuha9", "123", "Nuha", "Adnan", "student", "NO");
INSERT INTO `users` (`username`, `password`, `firstname`, `lastname`, `role`, `issanswerd`) VALUES ("Nuha10", "123", "Nuha", "Adnan", "student", "NO");
INSERT INTO `users` (`username`, `password`, `firstname`, `lastname`, `role`, `issanswerd`) VALUES ("dozent", "123", "Nuha", "Adnan", "dozent", "NO");


DROP TABLE IF EXISTS `teammember`;

CREATE TABLE `teammember` (
  `id` int NOT NULL AUTO_INCREMENT,
  `teamid` int NOT NULL,
  `projectid` int NOT NULL,
  `userid` int NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`teamid`) REFERENCES `teams`(`id`) ,
 FOREIGN KEY (`projectid`) REFERENCES `project`(`id`) ,
  FOREIGN KEY (`userid`) REFERENCES `users`(`id`) 
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `projectquestion`;

CREATE TABLE `projectquestion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `score` int NOT NULL,
  `projectid` int NOT NULL,
  `userid` int NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`projectid`) REFERENCES `project`(`id`),
   FOREIGN KEY (`userid`) REFERENCES `users`(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `rolequestion`;

CREATE TABLE `rolequestion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `score` int NOT NULL,
  `roleid` int NOT NULL,
  `userid` int NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`roleid`) REFERENCES `role`(`id`),
   FOREIGN KEY (`userid`) REFERENCES `users`(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `skillanswer`;

CREATE TABLE `skillanswer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `score` int NOT NULL,
  `skillid` int NOT NULL,
  `userid` int NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`skillid`) REFERENCES `skill`(`id`),
   FOREIGN KEY (`userid`) REFERENCES `users`(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
