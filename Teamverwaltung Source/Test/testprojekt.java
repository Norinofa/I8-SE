import org.junit.Assert;
import org.junit.Test;
import java.util.HashSet;
import java.util.Set;
import org.junit.After;
import org.junit.Before;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import java.sql.*;
import java.util.Random;

public class ProjectTest {

    @Test
    public void testProjectFields() {
        // Arrange
        Set<String> projectIDs = new HashSet<>();
        Project project = new Project();

        // Act
        project.setProjectID("I1");
        project.setProjectName("Test Project1");
        project.setFirma("Herr Müller");
        project.setDescription("This is a sample project.");

        // Assert
        Assert.assertTrue(projectIDs.add(project.getProjectID())); // Die erste ID sollte einzigartig sein

        // Act (erneut)
        project.setProjectID("I1"); // Versuch, dieselbe ID erneut zu setzen
        project.setProjectName("Test Project2");
        project.setFirma("Frau Meier");
        project.setDescription("This is another test project.");

        // Act (erneut)
        project.setProjectID("I3"); // Versuch, dieselbe ID erneut zu setzen
        project.setProjectName("Test Project3");
        project.setFirma("Frau Mustermann");
        project.setDescription("");

        // Assert (sollte fehlschlagen)
        Assert.assertFalse(projectIDs.add(project.getProjectID())); // Die zweite ID sollte bereits existieren und kann nicht hinzugefügt werden

        // Weitere Assertions für die anderen Felder
        Assert.assertEquals("Test Project1", project.getProjectName());
        Assert.assertEquals("Herr Müller", project.getFirma());
        Assert.assertEquals("This is a sample project.", project.getDescription());
    }
}


public class LoginPageTest {

    private WebDriver driver;
    private Connection connection;

    @Before
    public void setUp() {
        // WebDriver initialisieren (Stellen Sie sicher, dass der ChromeDriver-Treiber installiert ist und im Systempfad vorhanden ist)
        System.setProperty("webdriver.chrome.driver", "../chromedriver");
        driver = new ChromeDriver();

        // Verbindung zur Datenbank herstellen
        String url = "mysql://localhost:3306/db.sql";
        String username = "deinBenutzername";
        String password = "deinPasswort";

        try {
            connection = DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    //Test mit richtigen Login Daten

    @Test
    public void testLoginPageWithDatabaseCredentials() {
        // Query, um eine der Benutzername- und Passwortkombinationen aus der Datenbank abzurufen
        String query = "SELECT username, password FROM users LIMIT 1";

        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            // Falls ein Datensatz vorhanden ist, verwenden Sie den ersten Benutzernamen und das erste Passwort
            if (resultSet.next()) {
                String expectedUsername = resultSet.getString("username");
                String expectedPassword = resultSet.getString("password");

                // Act
                driver.get("Docker/Fronten/login.html");

                WebElement usernameInput = driver.findElement(By.id("username"));
                WebElement passwordInput = driver.findElement(By.id("password"));
                WebElement loginButton = driver.findElement(By.tagName("button"));

                usernameInput.sendKeys(expectedUsername);
                passwordInput.sendKeys(expectedPassword);
                loginButton.click();

                // Assert
                String pageTitle = driver.getTitle();
                Assert.assertEquals("Erwarteter Seitentitel", pageTitle);

            
                
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @After
    public void tearDown() {
        // Verbindung zur Datenbank schließen
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // WebDriver beenden
        driver.quit();
    }
}

//Test mit falschen Login Daten

@Test
    public void testLoginPageWithDatabaseCredentials() {
        // Query, um eine der Benutzername- und Passwortkombinationen aus der Datenbank abzurufen
        String query = "SELECT username, password FROM users LIMIT 1";

        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            // Falls ein Datensatz vorhanden ist, verwenden Sie den ersten Benutzernamen und das erste Passwort
            if (resultSet.next()) {

            String randomUsername = generateRandomString(8);
            String randomPassword = generateRandomString(10);

                // Act
                driver.get("Docker/Fronten/login.html");

                WebElement usernameInput = driver.findElement(By.id("username"));
                WebElement passwordInput = driver.findElement(By.id("password"));
                WebElement loginButton = driver.findElement(By.tagName("button"));

                usernameInput.sendKeys(randomUsername);
                passwordInput.sendKeys(randomPassword);
                loginButton.click();

                // Assert
                String pageTitle = driver.getTitle();
                Assert.assertEquals("Erwarteter Seitentitel", pageTitle);

            
                
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

            private String generateRandomString(int length) {
            String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            Random random = new Random();
            StringBuilder sb = new StringBuilder();

                for (int i = 0; i < length; i++) {
                    int index = random.nextInt(characters.length());
                    sb.append(characters.charAt(index));
                }

                return sb.toString();
            }
        }
    }

    @After
    public void tearDown() {
        // Verbindung zur Datenbank schließen
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // WebDriver beenden
        driver.quit();
    }
}