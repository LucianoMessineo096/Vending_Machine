<%-- 
    Document   : registrationPage.
    Created on : 1 nov 2022, 20:26:14
    Author     : luciano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
        <link rel="icon" href="/SmartVendingMachine/View/img/favicon-16x16.png" type="image/icon type">
        <title>SmartVendingMachine</title>
        
    </head>
    
    
    <body>
          
        <jsp:include page="/View/components/navbar.jsp"></jsp:include>

        <section class="row d-flex justify-content-center">
            
           <form id="form" class="col-6">
            <div class="row my-4">
                <label class="col-3">Registrazione</label>
                            
            </div>
            
            <div class="mb-3">
              <label for="email" class="form-label">Email</label>
              <input type="email" class="form-control" id="email" aria-describedby="emailHelp">
            </div>
            <div class="mb-3">
              <label for="password" class="form-label">Password</label>
              <input type="password" class="form-control" id="password">
            </div>
            <div class="mb-3">
              <label for="name" class="form-label">Nome</label>
              <input type="text" class="form-control" id="name">
            </div>
              <div class="mb-3">
              <label for="surname" class="form-label">Cognome</label>
              <input type="text" class="form-control" id="surname">
            </div>
            <button id="btn-submit" type="submit" class="btn btn-primary">Submit</button>
          </form>

        </section>
 
    </body>
        
    <script>

        function _validate(){
            
            $("#email").removeClass('is-invalid');
            $("#password").removeClass('is-invalid');
            $("#name").removeClass('is-invalid');
            $("#surname").removeClass('is-invalid');
                        
            let validation=true;
            
            //Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
            let passRegex=/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            let emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/g;
            let textRegex = /^[a-zA-Z ]+$/;
            
            if($("#email").val().match(emailRegex)===null){
                
                $("#email").addClass('is-invalid');
                
                validation=false;
            }
            
            if($("#password").val().match(passRegex)===null){
                
                $("#password").addClass('is-invalid');
                
                validation=false;
            }
            
            if($("#name").val().match(textRegex)===null){
                
                $("#name").addClass('is-invalid');
                
                validation=false;
            }
            
            if($("#surname").val().match(textRegex)===null){
                
                $("#surname").addClass('is-invalid');
                
                validation=false;
            }
                        
            return validation;
            
        }

        function sendData(){
        
            $("#form").submit(function(event) {
				
                event.preventDefault();

                let validation = _validate();

                if(validation){

                    var data = {
                        email:$('#email').val(),
                        password:$("#password").val(),
                        name: $("#name").val(),
                        surname: $("#surname").val()

                    };

                    var url = '/SmartVendingMachine/AutenticationManagement/registration';

                    $.post(url,data,(response)=> {
                        
                        if(response.success){
                            
                            let message = response.message;
                            
                            const alert = '<div class="alert alert-success col-3 position-fixed top-0 end-0 m-5 p-3" style="z-index: 11" role="alert">'+message+'</div>';
                                                       
                            $('.row').append(alert);
                            
                            window.location=response.address;
                        }
                        else{
                            
                            let message = response.message;
                            
                            const alert = '<div class="alert alert-danger col-3 position-fixed top-0 end-0 m-5 p-3" style="z-index: 11" role="alert">'+message+'</div>';
                                                       
                            $('.row').append(alert);  

                        }
    
                    });

                }
                
            });
        }
        
        $(document).ready(()=> {sendData();} );
        
    </script>
</html>
