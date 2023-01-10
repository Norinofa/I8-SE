const elementDraggedEvent = new Event("elementDragged");

const dragElementPrefix = "dragElement";
const dropZonePrefix = "topic";

class DragElement {
    constructor(elementID, originID, textHTML){
        this.elementID = dragElementPrefix + elementID; // full id of html element
        this.originID = dropZonePrefix + originID; // full id of the box that contains the element
        this.textHTML = textHTML; // text of html element
        this.short_elementID = elementID.toString().replace(dragElementPrefix, ""); // just id number of the html element
        this.short_originID = originID.toString().replace(dropZonePrefix, ""); // just id number of the box thats contains the element

        this.createHTMLElement();
        this.handleDropzones();
    }

    createHTMLElement(){
        $("#" + this.originID).append("<div id='" + this.elementID + "' class='teammember' topic='" + this.short_originID + "'>" + this.textHTML + "</div>"); // create html element
        $("#" + this.elementID).draggable({ // make element draggable
            revert: "invalid"
        });
    }


    getElementID(){
        return this.elementID;
    }

    changeCurrentID(newID){
        this.currentID = newID;
    }

    handleDropzones(){
        $(".dropzone").droppable({ // make dropzones droppable for specific element
            tolerance: "intersect",
            over: function(event, ui){ // hover effect on dropzone
                if(ui.draggable.attr("topic") != $(this).attr("id").replace("topic", "")){ // show hover effect on all dropzones except the origin one
                    $(this).addClass("dropzone_over");
                }
            },
            out: function(event, ui){ // remove hover effect from dropzone
                $(this).removeClass("dropzone_over");
            },
            accept: function(ui){
                var topicID = $(ui).attr("topic");
                var dropzoneID = $(this).attr("id").replace("topic", "");
                if(topicID == dropzoneID){ // if the element was dragged but not moved to another box, it shouldn't append at the end of the but the same position as it was before
                    return false;
                }
                return true;
            },
            drop: function(event, ui){
                var id = $(ui.draggable).attr("id");
                if(this.elementID == id){ // if this element is dropped in dropzones
                    return; // cancel if not
                }
                
                var name = $(ui.draggable).html(); // text of the element
                var receiver = $(this).attr("id"); // id of the dropzone

                
                $(ui.draggable).remove(); // remove element from origin
                $("#" + receiver).append("<div id='" + id + "' class='teammember' topic='" + receiver.replace(dropZonePrefix, "") + "'>" + name + "</div>"); // add element to dropzone
                $("div #" + id).draggable({
                    revert: "invalid"
                });

                $(this).removeClass("dropzone_over");

                document.dispatchEvent(elementDraggedEvent);
            }
        });
    }

    getCurrentLocation(){
        return $("#" + this.elementID).attr("topic");
    }

    didElementMoved(){ // check if drag element switched topic
        if(this.getCurrentLocation() == this.short_originID){
            return false;
        } else {
            return true;
        }
    }
}

class DragElementManager {
    constructor(warningID, countID, saveID){
        this.dragElements = [];
        this.warningID = warningID; // warning icon id
        this.countID = countID; // count of moved drag elements id
        this.saveID = saveID; // save icon/button id
        this.isSaved = false;


        document.addEventListener("elementDragged", () => {
            var changes = 0;
            for(var i in this.dragElements){
                if(this.dragElements[i].didElementMoved()){
                    changes++;
                }
            }

            $("#" + this.countID).html(changes);
            if(changes > 0){
                $("#" + this.warningID).css("visibility", "visible");
                $("#" + this.saveID).css("visibility", "visible");
            } else {
                $("#"+ this.warningID).css("visibility", "hidden");
                $("#"+ this.saveID).css("visibility", "hidden");
            }
        });

        
    }

    getIsSaved(){
        return this.isSaved;
    }

    setIsSaved(isSaved){
        this.isSaved = isSaved;
    }

    checkForChanges(){
        for(var i in this.dragElements){
            if(this.dragElements[i].didElementMoved())
                return true;
        }

        return false;
    }

    addDragElement(elementID, originID, textHTML, snum){
        this.dragElements.push(new DragElement(elementID, originID, textHTML));    
        $("#" + dragElementPrefix + elementID).click(function(){
            openModalStudent(snum);
        })
    }

    sendChanges(){
        if(!this.checkForChanges()){
            alert("Es wurden keine Änderungen vorgenommen!");
            return;
        }

        var changes = {};

        for(var i in this.dragElements){
            if(this.dragElements[i].didElementMoved()){
                var currentID = this.dragElements[i].getCurrentLocation();
                var elementID = this.dragElements[i].short_elementID;
                changes[elementID] = currentID;
            }
        }

        $.ajax({
            url: "teamerstellung_changes",
            type: "POST",
            data: {
                changes: JSON.stringify(changes),
                csrfmiddlewaretoken: getCookie('csrftoken')
            },
            beforeSend: function(){
                this.isSaved = true;
            },
            success: function(response){
                if(response.success){
                    const parser = new URL(window.location);
                    parser.searchParams.set("noti_saved", "1");
                    window.location = parser.href;
                }
            }
        });
    }
}

var dragElementManager = new DragElementManager("changesWarning", "changesCount", "changesSave");


function changesSave_Click(){
    if(confirm("Sollen die Änderungen gespeichert werden?"))
        dragElementManager.sendChanges();
}