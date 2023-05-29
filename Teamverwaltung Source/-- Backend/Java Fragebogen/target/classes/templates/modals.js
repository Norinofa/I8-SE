function getCookie(name) {
    var cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        var cookies = document.cookie.split(';');
        for (var i = 0; i < cookies.length; i++) {
            var cookie = jQuery.trim(cookies[i]);
            // Does this cookie string begin with the name we want?
            if (cookie.substring(0, name.length + 1) === (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}

function openModalEdit(pk){
    var modalEdit = $("#modal-bearbeitung");
    modalEdit.css("display", "flex");
    hideModalEditUI();

    $.ajax({
        url: "",
        type: "GET",
        data: {
            topickey: pk
        },
        success: function(response){
            $("#modalEditHeadline").html("Bearbeitung: " + response.name);
            $("#modalEditName").val(response.name);
            $("#modalEditDescription").val(response.description);
            $("#modalEditResponsible").val(response.responsible);
            $("#modalEditPDF").val(response.pdf);

            showModalEditUI();
        }
    });

    $("#modalEditClose").click(function(){
        modalEdit.css("display", "none");

        hideModalEditUI();

        $("#modalEditClose").unbind();
        $("#modalEditSave").unbind();
        $("#modalEditDelete").unbind();
    });

    $("#modalEditSave").click(function(){
        $.ajax({
            url: "",
            type: "POST",
            data: {
                topickey: pk,
                name: $("#modalEditName").val(),
                description: $("#modalEditDescription").val(),
                responsible: $("#modalEditResponsible").val(),
                pdf: $("#modalEditPDF").val(),
                csrfmiddlewaretoken: getCookie('csrftoken')
            },
            success: function(response){
                if(response.success){
                    const parser = new URL(window.location);
                    parser.searchParams.set("noti_updated", "1");
                    window.location = parser.href;
                }
            }
        });

        $("#modalEditClose").unbind();
        $("#modalEditSave").unbind();
        $("#modalEditDelete").unbind();
    });

    $("#modalEditDelete").click(function(){
        var confirmation = confirm("Soll das Thema wirklich gelöscht werden?");

        if(confirmation){
            $.ajax({
                url: "",
                type: "DELETE",
                headers: { "X-CSRFToken": getCookie('csrftoken') },
                data: {
                    topickey: pk,
                },
                success: function(response){
                    if(response.success){
                        const parser = new URL(window.location);
                        parser.searchParams.set("noti_deleted", "1");
                        window.location = parser.href;
                    }
                }
            });
        }

        $("#modalEditClose").unbind();
        $("#modalEditSave").unbind();
        $("#modalEditDelete").unbind();
    });
}

function showModalEditUI(){
    $("#modalEditName").css("visibility", "visible");
    $("#modalEditNameLabel").css("visibility", "visible");
    $("#modalEditDescription").css("visibility", "visible");
    $("#modalEditDescriptionLabel").css("visibility", "visible");
    $("#modalEditResponsible").css("visibility", "visible");
    $("#modalEditResponsibleLabel").css("visibility", "visible");
    $("#modalEditPDF").css("visibility", "visible");
    $("#modalEditPDFLabel").css("visibility", "visible");
    $("#modalEditSave").css("visibility", "visible");
    $("#modalEditDelete").css("visibility", "visible");

    $("#load_spinner").css("visibility", "hidden");
}

function hideModalEditUI(){
    $("#modalEditHeadline").html("Bearbeitung:");
    $("#modalEditName").css("visibility", "hidden");
    $("#modalEditNameLabel").css("visibility", "hidden");
    $("#modalEditDescription").css("visibility", "hidden");
    $("#modalEditDescriptionLabel").css("visibility", "hidden");
    $("#modalEditResponsible").css("visibility", "hidden");
    $("#modalEditResponsibleLabel").css("visibility", "hidden");
    $("#modalEditPDF").css("visibility", "hidden");
    $("#modalEditPDFLabel").css("visibility", "hidden");
    $("#modalEditSave").css("visibility", "hidden");
    $("#modalEditDelete").css("visibility", "hidden");

    $("#load_spinner").css("visibility", "visible");
}

function openModalNew(){
    $("#modalNewName").val("");
    $("#modalNewDescription").val("");
    $("#modalNewResponsible").val("");
    $("#modalNewPDF").val("");

    $("#modal-neu").css("display", "block");

    $("#modalNewClose").click(function(){
        $("#modal-neu").css("display", "none");

        $("#modalNewClose").unbind();
        $("#modalNewSave").unbind();
    });

    $("#modalNewSave").click(function(){
        var name = $("#modalNewName").val();
        var description = $("#modalNewDescription").val();
        var responsible = $("#modalNewResponsible").val();
        var pdf = $("#modalNewPDF").val();

        if(!name || !description || !responsible || !pdf)
        {
            alert("Bitte fülle alle Felder aus!");
            return;
        }

        $.ajax({
            url: "",
            type: "PUT",
            headers: { "X-CSRFToken": getCookie("csrftoken") },
            data: {
                name: name,
                description: description,
                responsible: responsible,
                pdf: pdf
            },
            success: function(response){
                if(response.success){
                    const parser = new URL(window.location);
                    parser.searchParams.set("noti_created", "1");
                    window.location = parser.href;
                }
            }
        });

        $("#modalNewClose").unbind();
        $("#modalNewSave").unbind();
    });
}