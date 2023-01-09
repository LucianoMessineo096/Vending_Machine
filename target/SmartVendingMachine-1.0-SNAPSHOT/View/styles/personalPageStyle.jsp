<%-- 
    Document   : personalPageStyle
    Created on : 26 ott 2022, 15:18:47
    Author     : luciano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

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

    }
    
    #Products{
        
        display:none;
        padding:10px;

    }
    
    /*#purchases thead th{
        
        position: relative;
        top:0;
        z-index: 1;  
    }*/
    
    #subTitle{
        
        border-bottom: solid;
        border-color: gainsboro;
    }
    
    #machineConnectionSection{
        
        display: none;
        
    }
    
    .spinner-border{
        
        display:none;
    }
    
    button:disabled {
        cursor: not-allowed;
        pointer-events: all !important;
    }
    
    /*-------------------TABLES----------------------------------------------*/
    
    tbody {
        display:block;
        height:450px;
        overflow:auto;
        scrollbar-width: thin;          /* "auto" or "thin" */
        scrollbar-color: #198754 white;   /* scroll thumb and track */ 
    }
    thead, tbody tr {
        display:table;
        width:100%;
        table-layout:fixed;
    }
    
    tbody td{
        
        word-break: break-all;
    }
    
    thead {
        width: calc( 100% - 1em )
    }
    
    table {
        width:400px;
    }
    
    tbody::-webkit-scrollbar {
        width: 12px;               /* width of the entire scrollbar */
    }

    tbody::-webkit-scrollbar-track {
      background: white;        /* color of the tracking area */
    }

    tbody::-webkit-scrollbar-thumb {
      background-color: #198754;    /* color of the scroll thumb */
      border-radius: 20px;       /* roundness of the scroll thumb */
      border: 3px solid white;  /* creates padding around scroll thumb */
    }

    /*--------------------MACHINE------------------------------------------*/
    
    #machine-mngmt{
        
        display:none;
        padding:10px;
        overflow: auto;
        height: 82vh;

    }
    
    #machineConnectionBody{
        
        max-height: 600px;
        overflow-y: scroll;
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