let ISAnswred = sessionStorage.getItem("ISAnswred");
let uuids = sessionStorage.getItem("userid")


// get a reference to the container element
let container = document.getElementById("projects");
let ids = []
fetch('http://localhost:8080/Project/getall', {
  method: 'Get',
  headers: {
    "Content-Type": "application/json"
  }
})
  .then(response => response.json()).then(data => {
    // handle the response from the server
    for (const project of data) {
      let socre;
      let inputsss = "";
      function getProjectScore(pid, uid, callback) {
        let ans = {
          "userid": parseInt(uid),
          "subid": parseInt(pid)
        };
        fetch('http://localhost:8080/Answers/Project/get', {
          method: 'POST',
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify(ans)
        })
          .then(response => response.text())
          .then(data => {
            socre = data;
            callback(data); // Invoke the callback function with the result
          })
          .catch(error => {
            console.error(error);
            callback(null); // Invoke the callback function with null if there's an error
          });
      }

      getProjectScore(project.id, uuids, result => {
        socre = result;
        // Assign the result to socre globally
        for (i = 1; i < 6; i++) {
          if (i == socre) {
            inputsss += '<input type="radio" name="topic' + project.id + '" data-rating="' + i + '" checked>';
          } else {
            inputsss += '<input type="radio" name="topic' + project.id + '" data-rating="' + i + '">';
          }
        }
        container.innerHTML += '<div class="bezeichnung drop"><span>' + project.name + '</span></div>' +
        '<div class="cell-full">' +
        inputsss +
        '</div>';
        ids.push(project.id)
      });
     
    }
  })
  .catch(error => {
    console.log(error)
  });
/////// end projefctsa

let Rolecontainer = document.getElementById("roles");
let Roleids = []
fetch('http://localhost:8080/roles/getall', {
  method: 'Get',
  headers: {
    "Content-Type": "application/json"
  }
})
  .then(response => response.json()).then(data => {

    // handle the response from the server
    for (const role of data) {
      let socre2;
      let inputsss2 = "";

      function getRoleScore(pid, uid, callback) {
        let ans = {
          "userid": parseInt(uid),
          "subid": parseInt(pid)
        };
        fetch('http://localhost:8080/Answers/Role/get', {
          method: 'POST',
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify(ans)
        })
          .then(response => response.text())
          .then(data => {
            socre2 = data;
            callback(data); // Invoke the callback function with the result
          })
          .catch(error => {
            console.error(error);
            callback(null); // Invoke the callback function with null if there's an error
          });
      }

      getRoleScore(role.id, uuids, result => {
        socre2 = result; // Assign the result to socre globally
        for (i = 1; i < 6; i++) {
          if (i == socre2) {
            inputsss2 += '<input type="radio" name="role' + role.id + '" data-rating="' + i + '" checked>';
          } else {
            inputsss2 += '<input type="radio" name="role' + role.id + '" data-rating="' + i + '">';
          }
        }
        Rolecontainer.innerHTML += '<div class="bezeichnung drop"><span>' + role.role + '</span></div>' +
        '<div class="cell-full">' +
          inputsss2 +
          '</div>';

      Roleids.push(role.id)
      });

  
  }
})
.catch(error => {
  console.log(error)
});




 
let skillcontainer = document.getElementById("Skills");
let skillids = []
fetch('http://localhost:8080/skills/getall', {
  method: 'Get',
  headers: {
    "Content-Type": "application/json"
  }
})
  .then(response => response.json()).then(data => {

 
    // handle the response from the server
    for (const skill of data) {


  let socre3;
      let inputsss3 = "";

      function getSkillScore(pid, uid, callback) {
        let ans = {
          "userid": parseInt(uid),
          "subid": parseInt(pid)
        };
        fetch('http://localhost:8080/Answers/Skill/gets', {
          method: 'POST',
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify(ans)
        })
          .then(response => response.text())
          .then(data => {
            socre3 = data;
            callback(data); // Invoke the callback function with the result
          })
          .catch(error => {
            console.error(error);
            callback(null); // Invoke the callback function with null if there's an error
          });
      }

      getSkillScore(skill.id, uuids, result => {
        socre3 = result; // Assign the result to socre globally
        for (i = 1; i < 5; i++) {
          if (i == socre3) {
            inputsss3 += ' <div class="cell"><input type="radio" name="skill' + skill.id + '" data-rating="' + i + '" checked ></div>' ;

          } else {
            inputsss3 += 
            ' <div class="cell"><input type="radio" name="skill' + skill.id + '" data-rating="' + i + '"></div>' ;

          }
        }
        skillcontainer.innerHTML += '<div id="special-bez" class="bezeichnung special-bez">' +
        '<span>' + skill.skill + '</span></div>' +    inputsss3 ;
       
         
          skillids.push(skill.id)
      });

  
  }
})
.catch(error => {
  console.log(error)
});

     

  




let savebtn = document.getElementById("sendQuestionnaire");
savebtn.addEventListener("click", saveanswers);

function saveanswers() {
  console.log(ids.length)
  let uid = parseInt(sessionStorage.getItem("userid"));
  removeanswers();

  let rolesdata = []
  let senddata = []
  let skilldata = []

  for (let i of ids) {
    let rating;
    const radios = document.querySelectorAll('input[type="radio"][name="topic' + i + '"]');
    for (const radio of radios) {
      if (radio.checked) {
        rating = parseInt(radio.dataset.rating);
        break;
      }
    }
    let obj = {
      score: rating,
      projectid: i,
      userid: uid
    }
    senddata.push(obj)
  
  }
  fetch('http://localhost:8080/Answers/Project/save', {
    method: 'Post',
    headers: {
      "Content-Type": "application/json"
    }, body: JSON.stringify(senddata)
  }).then(res => res.text())
    .then(data => console.log("data saved"))



  for (let i of Roleids) {
    let rating;
    const radiosa = document.querySelectorAll('input[type="radio"][name="role' + i + '"]');
    for (const radio of radiosa) {
      if (radio.checked) {
        rating = parseInt(radio.dataset.rating);
        break;
      }
    }
    let obj = {
      score: rating,
      projectid: i,
      userid: uid
    }
    rolesdata.push(obj)
    console.log(obj)
  }
  fetch('http://localhost:8080/Answers/Role/save', {
    method: 'Post',
    headers: {
      "Content-Type": "application/json"
    }, body: JSON.stringify(rolesdata)
  }).then(res => res.text())
    .then(data => console.log("data saved"))




  for (let i of skillids) {
    let rating;
    const radiosa = document.querySelectorAll('input[type="radio"][name="skill' + i + '"]');
    for (const radio of radiosa) {
      if (radio.checked) {
        rating = parseInt(radio.dataset.rating);
        break;
      }
    }
    let obj = {
      score: rating,
      skillid: i,
      userid: uid
    }
    skilldata.push(obj)
    console.log(obj)
  }
  fetch('http://localhost:8080/Answers/Skill/save', {
    method: 'Post',
    headers: {
      "Content-Type": "application/json"
    }, body: JSON.stringify(skilldata)
  }).then(res => res.text())
    .then(data => console.log("data saved"))



alert("Your Ansers Saved")

}


document.getElementById("username").innerHTML = sessionStorage.getItem("username");

// loop through your list of projects and create the necessary HTML elements



function removeanswers() {
  fetch('http://localhost:8080/Answers/Project/delall/' + uuids, {
    method: 'DELETE',
    headers: {
      "Content-Type": "application/json"
    }
  }).then(res => res.text())
    .then(data => console.log("data saved"))

    fetch('http://localhost:8080/Answers/Role/delall/' + uuids, {
      method: 'DELETE',
      headers: {
        "Content-Type": "application/json"
      }
    }).then(res => res.text())
      .then(data => console.log("data saved"))

    fetch('http://localhost:8080/Answers/Skill/delall/' + uuids, {
    method: 'DELETE',
    headers: {
      "Content-Type": "application/json"
    }
  }).then(res => res.text())
    .then(data => console.log("data saved"))

}


// loop through your list of projects and create the necessary HTML elements

