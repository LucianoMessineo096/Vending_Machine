<%-- 
    Document   : navbar3.jsp
    Created on : 26 ott 2022, 15:42:40
    Author     : luciano
--%>

<%@page import="Model.Machine"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    .navbar{
        
        margin: 0px;
        padding: 0px;
    }

    .nav-link,.nav-link active{

        color:white;
    }
    .container-fluid{

        /*background-color: #3F4E4F;*/
        background-color: rgb(50 50 50);
        margin:0px;
        padding:0px;
    }
</style>
<nav class="navbar navbar-expand-lg bg-light">
    <div class="container-fluid">
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a id="profile" class="nav-link" aria-current="page" >Profilo</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" aria-current="page" href="/SmartVendingMachine/AutenticationManagement/logout">Logout</a>
          </li>
        </ul>
      </div>
    </div>
    
    <!-- href="/SmartVendingMachine/UsersManagement/personalPage" -->
</nav>
<script>
    
    $(document).ready(()=>{
        
        $(document).on('click','#profile',(e)=>{
            
            e.preventDefault();
            
            <%  Machine currentMachine = (Machine)session.getAttribute("currentSessionMachine"); %>
            
            const url='/SmartVendingMachine/MachinesManagement/release';
            const data = {machineId:'<%= currentMachine.getId()%>'};
            
            $.post(url,data,(response)=>{
                
                window.location='/SmartVendingMachine/UsersManagement/personalPage';
            });
            
        });
        
    });
    
</script>
