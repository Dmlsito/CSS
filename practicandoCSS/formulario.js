const form = document.querySelector(".container-form__form");
const userName = document.getElementById("user-name");
const userEmail = document.getElementById("user-email");
const alertName = document.querySelector(".alert-name");
const alertEmail = document.querySelector(".alert-email");
const alertSuccess = document.querySelector(".alert-success");
//Validations
var regUserName =  /^([A-Za-zÁÉÍÓÚñáéíóúÑ]{0}?[A-Za-zÁÉÍÓÚñáéíóúÑ\']+[\s])+([A-Za-zÁÉÍÓÚñáéíóúÑ]{0}?[A-Za-zÁÉÍÓÚñáéíóúÑ\'])+[\s]?([A-Za-zÁÉÍÓÚñáéíóúÑ]{0}?[A-Za-zÁÉÍÓÚñáéíóúÑ\'])?$/;
const regUserEmail =  /^\w+([.-_+]?\w+)*@\w+([.-]?\w+)*(\.\w{2,10})+$/;

const showErrors = (errors) => {
 
  errors.forEach((error) => {
    error.type.textContent = error.msg;
  })
}

form.addEventListener("submit", (e) => {

    const errors = [];

    if(!regUserName.test(userName.value) || !userName.value.trim()){
        alertName.style.display = "block"
        console.log("Formato de nombre incorrecto");
        //Add the error
        errors.push({
            type: alertName,
            msg: "Formato no valido en el campo nombre, solo letras"
        })
    }else{
        alertName.style.display = "none";
    }
    
    if(!regUserEmail.test(userEmail.value) || !userEmail.value.trim()){
        alertEmail.style.display = "block"
        console.log("Formato de email incorrecto");
        errors.push({
            type: alertEmail, 
            msg: "Formato de correo electronico no valido"
        })
    }else{
       alertEmail.style.display = "none";
    }
     
    if(errors.length !== 0){
        showErrors(errors);
        e.preventDefault();
        console.log("Formato no valido")
        //With the stop we stop the form
        return
    }
})


