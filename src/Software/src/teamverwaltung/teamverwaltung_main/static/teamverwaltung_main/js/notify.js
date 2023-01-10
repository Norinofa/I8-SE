let x;
let toast = document.getElementById("toast");
let successHeader = document.getElementById("notifySuccessHead");
let successBody = document.getElementById("notifySuccessBody");

function showToast(header, body){
    clearTimeout(x);
    successHeader.innerHTML = header;
    successBody.innerHTML = body;

    toast.style.transform = "translateX(0)";
    x = setTimeout(()=>{
        toast.style.transform = "translateX(400px)"
    }, 4000);
}
function closeToast(){
    toast.style.transform = "translateX(400px)";
}