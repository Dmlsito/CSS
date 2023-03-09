const form = document.querySelector(".container-form__form");
const userName = document.getElementById("user-name");
const userEmail = document.getElementById("user-email");
const alertName = document.querySelector(".alert-name");
const alertEmail = document.querySelector(".alert-email");
const alertSuccess = document.querySelector(".alert-success");
//Validations
var regUserName =  /^([A-Za-zÁÉÍÓÚñáéíóúÑ]{0}?[A-Za-zÁÉÍÓÚñáéíóúÑ\']+[\s])+([A-Za-zÁÉÍÓÚñáéíóúÑ]{0}?[A-Za-zÁÉÍÓÚñáéíóúÑ\'])+[\s]?([A-Za-zÁÉÍÓÚñáéíóúÑ]{0}?[A-Za-zÁÉÍÓÚñáéíóúÑ\'])?$/;
const regUserEmail =  /^\w+([.-_+]?\w+)*@\w+([.-]?\w+)*(\.\w{2,10})+$/;

const errors = [];

const showErrors = (errors) => {
 
  errors.forEach((error) => {
    error.type.textContent = error.msg;
  })
}
const cleanErrorsName = (errors) => {
       errors.forEach(error => {
        if(error.type === alertName){
            error.msg = "";
        }
       })
}
const cleanErrorsEmail = (errors) => {
    errors.forEach(error => {
        if(error.type === alertEmail){
            error.msg = "";
        }
    })
}
const checkForm = (errors) => {
    let check;
    errors.forEach( error => {
        if(error.msg === "")
        check = true;
        else
        check = false;
    })

    return check;   

}
form.addEventListener("submit", (e) => {

    if(!regUserName.test(userName.value) || !userName.value.trim()){
        console.log("Formato de nombre incorrecto");
        //Add the error
        errors.push({
            type: alertName,
            msg: "Formato no valido en el campo nombre, solo letras"
        })
    }else{
        cleanErrorsName(errors)
    }
    
    if(!regUserEmail.test(userEmail.value) || !userEmail.value.trim()){
        console.log("Formato de email incorrecto");
        errors.push({
            type: alertEmail, 
            msg: "Formato de correo electronico no valido"
        })
    }else{
        cleanErrorsEmail(errors);
    }
     
    if(errors.length !== 0){
        showErrors(errors);
        e.preventDefault();
        //With the stop 
        return
    }
    
    console.log("Formato valido");
})


