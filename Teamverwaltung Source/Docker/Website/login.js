function login() {
  var usernameval = document.getElementById("username").value;
  var passwordval = document.getElementById("password").value;

  let user = {
    username: usernameval,
    password: passwordval
  };

  

  fetch("http://localhost:8080/Users/login", {
    method: "post",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(user)
  })
  .then(res => {
    if (!res.ok) {
      alert("password and username is wrong");
      throw new Error(res.statusText);
    }
    return res.json();
  })

    .then(data => {
      console.log(data);
console.log(data.username);
console.log(data.id);
console.log(data.role);
      sessionStorage.setItem("username", data.username);
      sessionStorage.setItem("userid", data.id);
      sessionStorage.setItem("ISAnswred", data.ISAnswred);
      if(data.role == "student") {
      window.location.href = "./Student/Studentenansicht.html";
      } else {
        alert("this is proffersor");
        window.location.href = "./Proffesor/Teamverwaltung/Teams_generieren.html";
      }


    })
    .catch(err => console.log(err));
}


