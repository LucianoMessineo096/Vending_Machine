<%-- 
    Document   : usersManagementComponent
    Created on : 5 nov 2022, 11:29:17
    Author     : luciano
--%>

<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="Users">
    <table class="table table-striped">
       <thead>
         <tr>
           <th scope="col">ID UTENTE</th>
           <th scope="col">NOME</th>
           <th scope="col">COGNOME</th>
           <th scope="col">EMAIL</th>
           <th scope="col">TIPO</th>
           <th scope="col">ACTIONS</th>
         </tr>
       </thead>
       <tbody>

       </tbody>
    </table>

    <div class="modal fade" id="updateUserModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered">
       <div class="modal-content">
         <div class="modal-header">
           <h1 class="modal-title fs-5" id="updateModalLabel">Modifica Utente</h1>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <div class="modal-body" id="updateUserModalBody">

         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Chiudi</button>
           <button type="button" class="btn btn-primary" id="updateUserSubmit">Salva</button>
         </div>
       </div>
     </div>
   </div>
</div>
<script>
    
    $('body').on('click','#deleteUserBtn',(e)=>{

        deleteUser(e);
    });

    $('body').on('click','#updateUserBtn',(e)=>{

        showUpdateUserPanel(e);
    });
    
    function showAllUsers(){

        clearInterface();

        const url='/SmartVendingMachine/UsersManagement/getAllUsers';

        $.get(url,(response)=>{

            $('#Users table tbody').empty();

            response.users.forEach(user=>{
                
                <% User currentUser = (User) session.getAttribute("currentSessionUser"); %>
                
                if(user.id!==<%= currentUser.getId()%>){
                    
                    let record = '<tr id='+user.id.toString()+'>'+'<td>'+user.id.toString()+'</td>'+
                                    '<td>'+user.name.toString()+'</td>'+
                                    '<td>'+user.surname.toString()+'</td>'+
                                    '<td>'+user.email.toString()+'</td>'+
                                    '<td>'+user.type.toString()+'</td>'+
                                    '<td>'+
                                        '<button id="updateUserBtn" type="button" class="btn btn-outline-success mx-1" data-bs-toggle="modal" data-bs-target="#updateUserModal">'+
                                            '<i class="bi bi-pencil"></i>'+
                                        '</button>'+
                                        '<button id="deleteUserBtn" type="button" onclick="deleteUser" class="btn btn-outline-danger mx-1">'+
                                            '<i class="bi bi-trash3-fill"></i>'+
                                        '</button>'+
                                    '</td>'+
                             '</tr>';

                    $('#Users tbody').append(record);
                    
                }
                

            });

            $('#Users').css('display','block');
        });

    }

    function updateUser(){

        const data ={

            userId: $('#updateUserModal .modal-body form').attr('id'),
            email: $('#updateUserModal .modal-body form #email-field').val(),
            name: $('#updateUserModal .modal-body form #name-field').val(),
            surname: $('#updateUserModal .modal-body form #surname-field').val(),
            type: $('#updateUserOptions option:selected').val()
        };

        const url='/SmartVendingMachine/UsersManagement/updateUser';

        $.post(url,data,(response)=>{

            if(response.success){

                showAllUsers();
            }

        });
    }

    function deleteUser(event){

        let parents = $(event.currentTarget).parents();
        let userId= parseInt(parents[1].id);

        const url='/SmartVendingMachine/UsersManagement/deleteUser';
        const data={

            userId:userId
        };

        $.post(url,data,(response)=>{

            alert(response.message);

            showAllUsers();
        });

    }

    function showUpdateUserPanel(event){

        let parents = $(event.currentTarget).parents();
        const userId= parseInt(parents[1].id);

        const url="/SmartVendingMachine/UsersManagement/getUser";
        const data={

            userId:userId
        };
        
        $.get(url,data,(response)=>{

           const email = response.email;
           const name = response.name;
           const surname = response.surname;
           const type = response.type;
           const walletBalance = response.walletBalance;

           $('#updateUserModalBody').empty();

           $('#updateUserModalBody').append(

                '<form id='+userId+'>'+
                 '<div class="mb-3">'+
                   '<label for="email" class="form-label">Email </label>'+
                   '<input id="email-field" type="email" placeholder="inserisci email" class="form-control" id="email" aria-describedby="emailHelp" value='+email+'>'+
                 '</div>'+
                 '<div class="mb-3">'+
                   '<label for="name" class="form-label">Nome</label>'+
                   '<input id="name-field" type="text" placeholder="inserisci nome" class="form-control" id="name" value='+name+'>'+
                 '</div>'+
                 '<div class="mb-3">'+
                   '<label for="surname" class="form-label">Cognome</label>'+
                   '<input id="surname-field" type="text" placeholder="inserisci cognome" class="form-control" id="surname" value='+surname+'>'+
                 '</div>'+
                 '<div class="mb-3 d-flex flex-column">'+
                    '<label for="type" class="form-label">Tipo</label>'+
                    '<select class="form-select" id="updateUserOptions" aria-label="Floating label select example">'+
                     '<option value="admin" >admin</option>'+
                     '<option value="tech">tech</option>'+
                     '<option value="user">user</option>'+
                    '</select>'+
                 '</div>'+
               '</form>'       
           );

           setOptionDropdown(type);

        });

    }

    function setOptionDropdown(type){

        let option1= $('#updateUserOptions').children()[0].innerHTML;
        let option2= $('#updateUserOptions').children()[1].innerHTML;
        let option3= $('#updateUserOptions').children()[2].innerHTML;

        const options = [option1,option2,option3];

        options.forEach((option,index)=>{

            if(option===type){

                let option = $('#updateUserOptions').children()[index];
                $(option).attr("selected","selected");
            }
        });

    }
    
</script>
