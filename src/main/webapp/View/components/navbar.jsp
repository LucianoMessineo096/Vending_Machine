<%-- 
    Document   : navbar
    Created on : 26 ott 2022, 14:45:52
    Author     : luciano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    .navbar{
        border-bottom: groove;
        margin: 0px;
        padding: 0px;
    }

    .nav-link,.nav-link active{

        color:white;
    }
    .container-fluid{

        /*background-color: #3F4E4F;*/
        background-color: #084c61;
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
            <a class="nav-link" aria-current="page" href="/SmartVendingMachine">SmartVendingMachine</a>
          </li>
          <li class="nav-item">
            <a id="registration" class="nav-link" href="/SmartVendingMachine/AutenticationManagement">Registrazione</a>
          </li>
        </ul>
      </div>
    </div>
</nav>
