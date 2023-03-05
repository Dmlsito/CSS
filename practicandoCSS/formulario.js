const form = document.querySelector(".container-form__form");
const userName = document.getElementById("user-name");
const userEmail = document.getElementById("user-email");

//Validations
var regUserName =  /^([A-Za-zÁÉÍÓÚñáéíóúÑ]{0}?[A-Za-zÁÉÍÓÚñáéíóúÑ\']+[\s])+([A-Za-zÁÉÍÓÚñáéíóúÑ]{0}?[A-Za-zÁÉÍÓÚñáéíóúÑ\'])+[\s]?([A-Za-zÁÉÍÓÚñáéíóúÑ]{0}?[A-Za-zÁÉÍÓÚñáéíóúÑ\'])?$/;
const regUserEmail =  /^\w+([.-_+]?\w+)*@\w+([.-]?\w+)*(\.\w{2,10})+$/;


form.addEventListener("submit", (e) => {
    
    if(!regUserName.test(userName.value)){
        console.log("Formato de nombre incorrecto");
        return
    }

    if(!regUserEmail.test(userEmail.value)){
        console.log("Formato de email incorrecto");
        return;
    }
    console.log("Formato valido")
})


