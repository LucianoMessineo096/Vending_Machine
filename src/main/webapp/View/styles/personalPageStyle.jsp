<%-- 
    Document   : personalPageStyle
    Created on : 26 ott 2022, 15:18:47
    Author     : luciano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<style>
    
    @import url("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css");
            
    html,body {
     height: 100%;
     width: 100%;
     position: relative;
    }

    #mainSection{

        height: 90vh;
        width: 100%;
        margin: 0px;
    }

    #sideNav{
        
        box-shadow: 10px 0 5px -2px #888;
        /*border-right: solid;*/
        height: 100%;
    }

    #sideNav div{

        width: 100%;
    }

    
    
    #purchases{
        
        display:none;
        padding:10px;
        overflow: auto;
        height: 82vh;
    }
    
    #purchases thead th{
        
        position: relative;
        top:0;
        z-index: 1;  
    }
    
    h3{

        margin-top: 11px;
    }

    #purchase-div{

        display:none;
    }
    
    #Users{
        
        display:none;
        padding:10px;
        overflow: auto;
        height: 82vh;
    }
    
    #Products{
        
        display:none;
        padding:10px;

    }
    
    .col-10 h3{
        
        border-bottom: solid;
        border-color: gainsboro;
    }
    
    #machineConnectionSection{
        
        display: none;
        
    }
    /*--------------------MACHINE------------------------------------------*/
    
    #machine-mngmt{
        
        display:none;
        padding:10px;
    }
    
    /*-----------------SIDENAV BTNS---------------------------------------*/
    #sideNav button{
        
        background-color: tan;
        color:white;
        
    }
    
    /*--------------------BTN-IMGS---------------------------------*/
    
    #sideNav img{
        
        width:16px;
    }
    
    /*--------------------------PERSONAL-DATA------------------------*/
    #personal-data{

        display: none;

    }
    
    #personal-data .card-body p{
        
        color:#084c61;
    }
    
    #personal-data .card{
        
        max-width: 330px;
    }
    #Avatar{
        width:100px;
        height: 100px;
        border-radius: 50%;
    }
    
</style>