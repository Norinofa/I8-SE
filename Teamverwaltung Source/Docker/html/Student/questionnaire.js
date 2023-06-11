$("#sendQuestionnaire").bind("click", sendQuestionnaire_Click);


function sendQuestionnaire_Click(){
    var topicRating = {};
    var roleRating = {};
    var skillRating = {};

    try{

        // check topic
        topicsToCheck.forEach(function(element){
            var selectedRating = document.querySelector("input[name='topic" + element + "']:checked").dataset.rating;
            if(selectedRating != null)
                topicRating[element] = selectedRating;
        });

        roleRating["Test"] = document.querySelector("input[name='roleTest']:checked").dataset.rating;
        roleRating["Implementierung"] = document.querySelector("input[name='roleImplementation']:checked").dataset.rating;
        roleRating["Entwurf"] = document.querySelector("input[name='roleDesign']:checked").dataset.rating;
        roleRating["Analyse"] = document.querySelector("input[name='roleAnalytic']:checked").dataset.rating;
        roleRating["Teamleiter"] = document.querySelector("input[name='roleLeader']:checked").dataset.rating;

        skills = ["oop", "web", "ooplang", "scriot", "webframeworks", "db", "modelling", "db", "management",
                    "teamwork", "developer", "git", "test"];

        skills.forEach(function(item, index, array){
            try{
                skillRating[item] = document.querySelector("input[name='skill" + item + "']:checked").dataset.rating;
            }catch(ex){}
        })



        $.ajax({
            url: "fragebogen/send",
            type: "POST",
            data: {
                ratingTopics: JSON.stringify(topicRating),
                ratingRoles: JSON.stringify(roleRating),
                ratingSkills: JSON.stringify(skillRating),
                csrfmiddlewaretoken: getCookie('csrftoken')
            },
            success: function(response){
                if(response.success == 1)
                    location.reload();
                else
                    alert("Fehler beim Speichern des Fragebogens! Möglicherweise sind sie nicht berechtigt.");
            },
        });
    }
    catch(ex){
        if(ex instanceof TypeError)
            alert("Fehler! Bitte fülle alle Felder aus.");
        else
            alert("Fehler beim Absenden des Fragebogen");
    }
}

function openModalStudent(pk) {
    $.ajax({
        url: "fragebogen/details",
        type: "GET",
        data: {
            s_num: pk
        },
        success: function(response){
            var projects = JSON.parse(response.poll_projects);
            var roles = JSON.parse(response.poll_roles);
            var skills = JSON.parse(response.poll_skills);

            $("#quesProjects").html("");
            $("#quesRoles").html("");
            $("#quesSkills").html("");

            $("#quesStudent").html(response.name + " (" + pk + ")");

            for(var key in projects){
                var tr = document.createElement("tr");

                var td1 = document.createElement("td");
                var td2 = document.createElement("td");

                for(var i = 0; i < parseInt(projects[key]); i++){
                    var star = document.createElement("i");
                    star.setAttribute("class", "fa-solid fa-star");

                    td1.appendChild(star);
                }

                var span = document.createElement("span");
                span.innerHTML = key;
                td2.appendChild(span);

                tr.appendChild(td1);
                tr.appendChild(td2);

                document.getElementById("quesProjects").appendChild(tr);
            }

            for(var key in roles){
                var tr = document.createElement("tr");

                var td1 = document.createElement("td");
                var td2 = document.createElement("td");

                for(var i = 0; i < parseInt(roles[key]); i++){
                    var star = document.createElement("i");
                    star.setAttribute("class", "fa-solid fa-star");

                    td1.appendChild(star);
                }

                var span = document.createElement("span");
                span.innerHTML = key;
                td2.appendChild(span);

                tr.appendChild(td1);
                tr.appendChild(td2);

                document.getElementById("quesRoles").appendChild(tr);
            }

            for(var key in skills){
                var tr = document.createElement("tr");

                var td1 = document.createElement("td");
                var td2 = document.createElement("td");

                for(var i = 0; i < parseInt(skills[key]); i++){
                    var star = document.createElement("i");
                    star.setAttribute("class", "fa-solid fa-star");

                    td1.appendChild(star);
                }

                var span = document.createElement("span");
                span.innerHTML = key;
                td2.appendChild(span);

                tr.appendChild(td1);
                tr.appendChild(td2);

                document.getElementById("quesSkills").appendChild(tr);
            }

            $("#frag-indepth").css("display", "flex");
        }
    });
}

function closeModalStudent(){
    $("#frag-indepth").css("display", "none");
}