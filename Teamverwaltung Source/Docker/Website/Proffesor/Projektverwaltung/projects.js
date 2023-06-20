function getPojectList() {
    fetch("http://localhost:8080/Project/getall")
    .then(response => response.json())
    .then(data => {
        const projectsList = data;
        const tbody = document.querySelector("#data tbody");
        tbody.innerHTML = "";

        projectsList.forEach(project => {
            const row = document.createElement("tr");

            const nameCell = document.createElement("td");
            nameCell.textContent = project.proid;

            const descriptionCell = document.createElement("td");
            descriptionCell.textContent = project.name;

            const proidCell = document.createElement("td");
            proidCell.textContent = project.firma;

            const firmaCell = document.createElement("td");
            firmaCell.textContent = project.description;

            const actionCell = document.createElement("td");
            const deleteButton = document.createElement("button");
            deleteButton.textContent = "löschen";
            deleteButton.addEventListener("click", () => deleteUser(project.id));
            const updatebtn = document.createElement("button");
            updatebtn.textContent = "bearbeiten";
            updatebtn.addEventListener("click", () => updateform(project.id));
            actionCell.appendChild(updatebtn);
            actionCell.appendChild(deleteButton);

            row.appendChild(nameCell);
            row.appendChild(descriptionCell);
            row.appendChild(proidCell);
            row.appendChild(firmaCell);
            row.appendChild(actionCell);

            tbody.appendChild(row);
        });
    })
    .catch(error => {
        alert("An error occurred. Please try again.");
        console.error(error);
    });
}



function deleteUser(projcet) {
    fetch(`http://localhost:8080/Project/delete/${projcet}`, {
        method: "DELETE"
    })
    .then(response => response.json())
    .then(data => {
        console.log("error")
        if (data.success) {
            getPojectList();
                } else {
            alert("this is deleted.");
        }
    })
    .catch(error => {
        alert("An error occurred. Please try again.");
        console.error(error);
    });
}
// Get the initial list of users
getPojectList();

function updateform(x) {
    let updateforms = document.getElementById("update");
    updateforms.style.display = "block";
let idfield = document.getElementById("id-field");
let idname = document.getElementById("name-field");
let idfirma = document.getElementById("short-desc-field");
let iddes = document.getElementById("long-desc-field");
let idproj = document.getElementById("idproj-field");

    fetch(`http://localhost:8080/Project/getbyid/` + x, {
        method: "GET"
    })
    .then(response => response.json())
    .then(data => {
        idproj.value = data.id;
        idfield.value = data.proid ;
        idname.value = data.name;
        idfirma.value = data.firma;
        iddes.value = data.description;
    })
    .catch(error => {
        alert("An error occurred. Please try again.");
        console.error(error);
    });

}

function hideupdate() {
    let updateforms = document.getElementById("update");
    updateforms.style.display = "none";
}
function editporject() {
    let idfield = document.getElementById("id-field").value;
    let idname = document.getElementById("name-field").value;
    let idfirma = document.getElementById("short-desc-field").value;
    let iddes = document.getElementById("long-desc-field").value;
    let idproj = document.getElementById("idproj-field").value;
    console.log(idproj)
    let porjobj ={
        name: idname,
        description: iddes,
        proid: idfield,
        firma: idfirma
    }
    fetch(`http://localhost:8080/Project/edit/` + idproj, {
        method: "PUT" ,headers: {
            "Content-Type": "application/json"
          },  body: JSON.stringify(porjobj)
    })
    .then(response => response.text())
    .then(data => {
       alert("Porject updated");
       let updateforms = document.getElementById("update");
       updateforms.style.display = "none";

       getPojectList();
    })
    .catch(error => {
        alert("An error occurred. Please try again.");
        console.error(error);
      

    });


}