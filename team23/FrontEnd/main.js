
// get a reference to the container element
let container = document.getElementById("projects");
let ids =[]
fetch('http://localhost:8080/Project/getall', {
  method: 'Get',
  headers : {
    "Content-Type" : "application/json"
  }
})
.then(response => response.json()).then(data => {
  // handle the response from the server
  for (const project of data) {
    // create the div element with the class "content-container"
    container.innerHTML += '<div class="bezeichnung drop"><span>' + project.name + '</span></div>' +
    '<div class="cell-full">' +
    '<input type="radio" name="topic' + project.id + '" data-rating="1">' +
    '<input type="radio" name="topic' + project.id + '" data-rating="2">' +
    '<input type="radio" name="topic' + project.id + '" data-rating="3" checked>' +
    '<input type="radio" name="topic' + project.id + '" data-rating="4">' +
    '<input type="radio" name="topic' + project.id + '" data-rating="5">' +
    '</div>';

    ids.push(project.id)
    
    }
})
.catch(error => {
  console.log(error)
});


let Rolecontainer = document.getElementById("roles");
let Roleids =[]
fetch('http://localhost:8080/roles/getall', {
  method: 'Get',
  headers : {
    "Content-Type" : "application/json"
  }
})
.then(response => response.json()).then(data => {

  console.log(data)
  // handle the response from the server
  for (const role of data) {
    // create the div element with the class "content-container"
    Rolecontainer.innerHTML += '<div class="bezeichnung drop"><span>' + role.role + '</span></div>' +
    '<div class="cell-full">' +
    '<input type="radio" name="role' + role.id + '" data-rating="1">' +
    '<input type="radio" name="role' + role.id + '" data-rating="2">' +
    '<input type="radio" name="role' + role.id + '" data-rating="3" checked>' +
    '<input type="radio" name="role' + role.id + '" data-rating="4">' +
    '<input type="radio" name="role' + role.id + '" data-rating="5">' +
    '</div>';

    Roleids.push(role.id)
    
    }
})
.catch(error => {
  console.log(error)
});





let skillcontainer = document.getElementById("Skills");
let skillids =[]
fetch('http://localhost:8080/skills/getall', {
  method: 'Get',
  headers : {
    "Content-Type" : "application/json"
  }
})
.then(response => response.json()).then(data => {

  console.log(data)
  // handle the response from the server
  for (const skill of data) {
    // create the div element with the class "content-container"
    skillcontainer.innerHTML += '<div id="special-bez" class="bezeichnung special-bez">' +
    '<span>' + skill.skill+'</span></div>' + 
    ' <div class="cell"><input type="radio" name="skill' + skill.id + '" data-rating="4"></div>' +
    ' <div class="cell"><input type="radio" name="skill' + skill.id + '" data-rating="3"></div>' +
    ' <div class="cell"><input type="radio" name="skill' + skill.id + '" data-rating="2"></div>' +
    ' <div class="cell"><input type="radio" name="skill' + skill.id + '" data-rating="1"></div>' ;

   

    skillids.push(skill.id)
    
    }
})
.catch(error => {
  console.log(error)
});












let savebtn = document.getElementById("sendQuestionnaire");
savebtn.addEventListener("click" , saveanswers);

function saveanswers() {
  console.log(ids.length)
 let uid = parseInt(sessionStorage.getItem("userid"));
  let rolesdata = []
let senddata = []
let skilldata = []

  for( let i of ids )  
{
    let rating;
    const radios = document.querySelectorAll('input[type="radio"][name="topic'+ i +'"]');
    for (const radio of radios) {
      if (radio.checked) {
        rating = parseInt(radio.dataset.rating);
        break;
      }
    }
    let obj ={
      score : rating ,
        projectid : i ,
        userid : uid  
    }
    senddata.push(obj)
    console.log(obj)
}
    fetch('http://localhost:8080/Answers/Project/save', {
  method: 'Post',
  headers : {
    "Content-Type" : "application/json"
  } ,body: JSON.stringify(senddata)
}).then(res =>res.text())
.then(data => console.log("data saved"))



for( let i of Roleids )  
{
    let rating;
    const radiosa = document.querySelectorAll('input[type="radio"][name="role'+ i +'"]');
    for (const radio of radiosa) {
      if (radio.checked) {
        rating = parseInt(radio.dataset.rating);
        break;
      }
    }
    let obj ={
      score : rating ,
        projectid : i ,
        userid : uid    
    }
    rolesdata.push(obj)
    console.log(obj)
}
    fetch('http://localhost:8080/Answers/Role/save', {
  method: 'Post',
  headers : {
    "Content-Type" : "application/json"
  } ,body: JSON.stringify(rolesdata)
}).then(res =>res.text())
.then(data => console.log("data saved"))




for( let i of skillids )  
{
    let rating;
    const radiosa = document.querySelectorAll('input[type="radio"][name="skill'+ i +'"]');
    for (const radio of radiosa) {
      if (radio.checked) {
        rating = parseInt(radio.dataset.rating);
        break;
      }
    }
    let obj ={
      score : rating ,
      skillid : i ,
        userid : uid  
    }
    skilldata.push(obj)
    console.log(obj)
}
    fetch('http://localhost:8080/Answers/Skill/save', {
  method: 'Post',
  headers : {
    "Content-Type" : "application/json"
  } ,body: JSON.stringify(skilldata)
}).then(res =>res.text())
.then(data => console.log("data saved"))





}


document.getElementById("username").innerHTML  = sessionStorage.getItem("username");

// loop through your list of projects and create the necessary HTML elements






// loop through your list of projects and create the necessary HTML elements

