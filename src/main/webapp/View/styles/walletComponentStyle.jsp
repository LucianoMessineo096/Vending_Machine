<%-- 
    Document   : walletComponentStyle
    Created on : 17 nov 2022, 17:48:20
    Author     : luciano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    
    #wallet-div{

        display:none;
        /*margin-top: 50px;*/
    }

    #wallet-info{
        
        color:white;
        background:#3F4E4F;
        border-radius: 10px 0px 0px 10px;
        padding:40px;
    }
    
    #wallet-card .col-8{
        
        border: solid;
        border-color: lightgrey;
        border-radius: 0px 10px 10px 0px;
        padding: 20px;
    }
    
    #movements{
        
        max-height: 250px;
        border-top:solid;
        border-color:lightgrey;
        
    }
    
    #movements #recharge-value{
        
        color: green;
    }
    
    #movements #purchase-value{
        
        color: red;
    }
    
    #movements #movement-type-recharge{
        
        color: green;
    }
    
    #movements #movement-type-purchase{
        
        color: red;
    }

    #coffe-svg img{

        width: 40%;

    }

    #wallet-userName #wallet-userSurname{

        color: white;


    }

</style>