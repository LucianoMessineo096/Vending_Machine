<%-- 
    Document   : personalDataComponent
    Created on : 14 nov 2022, 00:18:49
    Author     : luciano
--%>

<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="personal-data" class="my-5 mx-3">
    <div class="card">
        <div class="d-flex flex-row">
            <img class="m-2" src="/SmartVendingMachine/View/img/user.png" id="Avatar">
            <div class="m-4">
                <button id="updateUsrBtn" type="button" class="btn btn-outline-success mx-1" data-bs-toggle="modal" data-bs-target="#updateUsrModal">
                    <i class="bi bi-pencil"></i>
                </button>
                <button id="deletePersonalDataBtn" type="button" class="btn btn-outline-danger mx-1" data-bs-toggle="modal" data-bs-target="#deleteUsrModal">
                    <i class="bi bi-trash3-fill"></i>
                </button>
            </div>

        </div>
        
        <%  User currentUser = (User)session.getAttribute("currentSessionUser"); %>

        <div class="card-body">
            <p id="id"><b>ID</b>: <%=currentUser.getId() %></p>
            <p id="name"><b>NOME</b>: <%=currentUser.getName() %></p>
            <p id="surname"><b>COGNOME</b>: <%=currentUser.getSurname() %></p>
            <p id="email"><b>EMAIL</b>: <%=currentUser.getEmail() %></p>
        </div>
    </div>

    <div class="modal fade" id="updateUsrModal" tabindex="-1" aria-labelledby="updateUsrModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="exampleModalLabel">Modifica Utente</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input id="newName" class="form-control my-2" type="text" placeholder="inserisci nuovo nome">
                <input id="newSurname" class="form-control my-2" type="text" placeholder="inserisci nuovo cognome">
                <input id="newEmail" class="form-control my-2" type="text" placeholder="inserisci nuova email">
                <input id="newPassword" class="form-control my-2" type="text" placeholder="inserisci nuova password">
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
              <button id="updateUsrSubmit" type="button" class="btn btn-primary">Save</button>
            </div>
          </div>
        </div>
    </div>
        
    <div class="modal fade" id="deleteUsrModal" tabindex="-1" aria-labelledby="deleteUsrModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="exampleModalLabel">Cancellazione Utente</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Sei sicuro/a di voler eliminare il tuo account?</p>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
              <button id="deleteUsrBtn" type="button" class="btn btn-primary">Save</button>
            </div>
          </div>
        </div>
    </div>

</div>
<script>
    
    $(document).ready(()=>{
            
        $('#updateUsrSubmit').click(()=>{

            updateAccount();
        });
        
        $('body').on('click','#deleteUsrBtn',()=>{

            deleteAccount();
        });
        
        $(document).on('show.bs.modal','#updateUsrModal', function () {
            
            $("#newName").val('<%=currentUser.getName()%>');
            $("#newSurname").val('<%=currentUser.getSurname()%>');
            $("#newEmail").val('<%=currentUser.getEmail()%>');
            
        })

    });
    
    //-------------------------------------------------------------------------
    
    function _validate(){
            
        $("#newEmail").removeClass('is-invalid');
        $("#newPassword").removeClass('is-invalid');
        $("#newName").removeClass('is-invalid');
        $("#newSurname").removeClass('is-invalid');

        let validation=true;

        //Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
        let passRegex=/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
        let emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/g;
        let textRegex = /^[a-zA-Z]+$/;

        if($("#newEmail").val().match(emailRegex)===null){

            $("#newEmail").addClass('is-invalid');

            validation=false;
        }

        if($("#newPassword").val().match(passRegex)===null){

            $("#newPassword").addClass('is-invalid');

            validation=false;
        }

        if($("#newName").val().match(textRegex)===null){

            $("#newName").addClass('is-invalid');

            validation=false;
        }

        if($("#newSurname").val().match(textRegex)===null){

            $("#newSurname").addClass('is-invalid');

            validation=false;
        }

        return validation;

    }
    
    function updateAccount(){
    
        let validation = _validate();
        
        if(validation){
            
            const data={

                userId: '<%= currentUser.getId() %>',
                newName:$('#newName').val(),
                newSurname:$('#newSurname').val(),
                newEmail:$('#newEmail').val(),
                newPassword:$('#newPassword').val()

            };

            const url='/SmartVendingMachine/UsersManagement/updatePersonalData';

            $.post(url,data,(response)=>{

                if(response.success){
                    
                    getUpdatedUser();
                }

            });

        }
 
    }
    
    function getUpdatedUser(){
        
        const url = '/SmartVendingMachine/UsersManagement/getUpdatedUser';
        const data = {userId:'<%= currentUser.getId()%>'};

        $.get(url,data,(response)=>{

            if(response.success){
                window.location='/SmartVendingMachine/UsersManagement/personalPage';
                <% currentUser = (User)request.getSession(false).getAttribute("currentSessionUser"); %>

            }

        });
    
    }
        
    function deleteAccount(){

        const url='/SmartVendingMachine/UsersManagement/deleteUser';
        const data={

            userId:<%= currentUser.getId() %>
        };
        
        
        $.post(url,data,(response)=>{
            
            if(response.success){
                
                const url_logout = "/SmartVendingMachine/AutenticationManagement/logout";
                
                $.get(url,(response)=>{
                    
                    window.location="/SmartVendingMachine"
                })
            }
        })
        
    }

</script>
