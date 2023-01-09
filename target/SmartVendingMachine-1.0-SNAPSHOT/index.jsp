<%-- 
    Document   : index.jsp
    Created on : 1 nov 2022, 20:28:08
    Author     : luciano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="/SmartVendingMachine/View/img/favicon-16x16.png" type="image/icon type">
        <title>SmartVendingMachine</title>
          
        <!-- bootstrap and jquery -->
        <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
        
        <jsp:include page="/View/styles/indexStyles.jsp"></jsp:include>
        
    </head>
    <body>

        <jsp:include page="/View/components/navbar.jsp"></jsp:include>

        <div id="main-section">
            <div class="card" style="width: 18rem;">
              <div class="card-body">
                <h6 class="card-title mb-2">Accedi</h6>
                <form id="form">
                    <label for="email" class="form-label">Email</label>
                    <div class="mb-3 input-group has-validation">
                        <input id="email" type="email" class="form-control" aria-describedby="inputGroupPrepend" required>
                        <div class="invalid-feedback">
                          Si prega di inserire una mail.
                        </div>                     
                    </div>
                    <label for="password" class="form-label">Password</label>
                    <div class="mb-3 input-group has-validation">
                        <input id="password" type="password" class="form-control" aria-describedby="inputGroupPrepend" required>
                        <div class="invalid-feedback">
                          Si prega di inserire una password.
                        </div>                     
                    </div>
                    <button type="submit" class="btn btn-light">Submit</button>
                </form>
              </div>
            </div>
        </div>

    </body>
</html>
<script type="text/javascript" src="jsgrid.min.js"></script>
<script>
        
    function login(){

        $("#form").submit(function(event) {

            event.preventDefault();

            let validation= _validate();

            if(validation){

                const url='/SmartVendingMachine/AutenticationManagement/login';
                const data = {
                    email: $("#email").val(),
                    password: $("#password").val()
                };

                $.get(url,data,(response)=>{

                    let address = response.address;
                    let message = response.message;
                    let success  =response.success;

                    $('.alert').remove();

                    if(success){

                        const alert = '<div class="alert alert-success col-3 position-fixed top-0 end-0 m-5 p-3" style="z-index: 11" role="alert">'+message+'</div>';

                        $('#main-section').append(alert);

                        window.location=address;

                    }
                    else{

                        const alert = '<div class="alert alert-danger col-3 position-fixed top-0 end-0 m-5 p-3" style="z-index: 11" role="alert">'+message+'</div>';

                        $('#main-section').append(alert);
                    }

                });

            }
            else{

                const alert = '<div class="alert alert-danger col-3 position-fixed top-0 end-0 m-5 p-3" style="z-index: 11" role="alert">la combinazione di email e password non e corretta</div>';

                $('#main-section').append(alert);

            }

        });
    }

    function _validate(){

        let validation=true;

        //Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
        let passRegex=/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

        let emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/g;

        if($("#email").val().match(emailRegex)===null){

            validation=false;
        }

        if($("#password").val().match(passRegex)===null){

            validation=false;
        }

        return validation;

    }


    $(document).ready(()=>{

        login();
        
        history.replaceState(null, null, location.href);
        
    });


</script>

