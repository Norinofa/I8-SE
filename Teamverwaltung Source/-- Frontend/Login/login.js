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

      sessionStorage.setItem("username", data.username);
      sessionStorage.setItem("userid", data.id);
      if(data.role = "student") {
      window.location.href = "../Studentenansicht.html";
      } else {
        alert("this is proffersor");

      }


    })
    .catch(err => console.log(err));
}


