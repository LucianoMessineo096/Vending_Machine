<%-- 
    Document   : personalPage.jsp
    Created on : 1 nov 2022, 20:56:11
    Author     : luciano
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Enumeration"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="Controller.UsersManagement"%>
<%@page language="java" 
        contentType="text/html" 
        pageEncoding="UTF-8"
        import=" Model.User"
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="/SmartVendingMachine/View/img/favicon-16x16.png" type="image/icon type">
        <title>SmartVendingMachine</title>
        
        <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
        
        <jsp:include page="/View/styles/personalPageStyle.jsp"></jsp:include>
        <jsp:include page="/View/styles/walletComponentStyle.jsp"></jsp:include>  
        
    </head>
    <body>
        <jsp:include page="/View/components/navbar2.jsp"></jsp:include>
        
        <section id="mainSection" class="row">
            
            <div id="sideNav" class="col-2">
                
                <div class="d-flex flex-column"></div>
                
            </div>

            <div class="col-10">
                
                <%  User currentUser = (User)session.getAttribute("currentSessionUser"); %>
                <div id="subTitle" class="d-flex flex-row justify-content-between">
                    <h3>Benvenuto/a <%= currentUser.getName().toUpperCase() +" "+ currentUser.getSurname().toUpperCase() %></h3>
                    <div class="spinner-border text-success my-2" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
                
                <jsp:include page="/View/components/personalDataComponent.jsp"></jsp:include>
    
                <div id="machineConnectionSection"> 
                    
                    <div id="machineConnectionBody" class="d-flex flex-row col-12"></div>
                    
                </div>
   
                <jsp:include page="/View/components/walletManagementComponent.jsp"></jsp:include>
                        
                <jsp:include page="/View/components/purchasesComponent.jsp"></jsp:include>    
                
                <jsp:include page="/View/components/productsManagementComponent.jsp"></jsp:include>
                        
                <jsp:include page="/View/components/usersManagementComponent.jsp"></jsp:include>
                
                <jsp:include page="/View/components/machineManagementComponent.jsp"></jsp:include>
                
            </div>
                        
        </section>
                
    </body>
    <script>

        $(document).ready(()=>{
            
            //-------------------Users management----------------------------//
            
            if('<%= currentUser.getType() %>' === 'admin'){
                                
                showAdminInterface();
                
            }
            
            if('<%= currentUser.getType() %>' === 'user'){
                
                showUserInterface();
                
            }
            
            if('<%= currentUser.getType() %>' === 'tech'){
                
                showTechInterface();
                
            }

            //---------PERSONAL INFO VIEW -----------//

            $("#personalData").click(()=>{

                showPersonalInfo();

            });

            //--------WALLET VIEW --------//

            $('#wallet').click(()=>{
            
                showWallet();

            });

            //--------Purchase-----------//

            $('#purchase').click(()=>{
                
                showMachinesCard();
                
            });
            
            $('body').on('click','#machineConnectionBtn',(e)=>{
                
                const url="/SmartVendingMachine/MachinesManagement/connect";
                
                let parents = $(e.currentTarget).parents();
                let machineId= parseInt(parents[3].id);
                const data = {machineId: machineId};

                $.post(url,data,(response)=>{
                                        
                    window.location=response.address;
                });

            });
            
            //---------Purchase History ----------//

            $('#purchasesMade').click(()=>{
            
                showPurchases();

            });
            
            //-------------------Users Management(admin)---------------------//
            
            $('#usersManagement').click(()=>{
                
                showAllUsers();
                
            });
            
            $('#updateUserSubmit').click(()=>{
                
                updateUser();
            });
            
            //-------------------Products Management(admin/tech)------------------//
            
            $('#productsManagement').click(()=>{
                
                showAllProducts();
                
            });
            
            //------------------Machine Management(admin)------------------------//
        
            $('body').on('click','#machinesManagement',(e)=>{

                showAllMachines();

            });

        });
        
        //##################FUNCTIONS#########################################//

        //-------------USER DATA
        
        function showPersonalInfo(){

        clearInterface();

        const data={

            userId:<%= currentUser.getId()%>

        };

        $.get('/SmartVendingMachine/UsersManagement/getUser',data,(response)=>{

            if(response.success){

                $('#personal-data').css('display','block');

            }
        });
    }
        
        //------------------PURCHASE

        function showMachinesCard(){
            
            $('.spinner-border').css('display','block');
            clearInterface();
            
            const url="/SmartVendingMachine/MachinesManagement/getAll";
            
            $.get(url,(response)=>{
                                
                if(response.success){
                                        
                    $('#machineConnectionBody').empty();
                   
                    response.machines.forEach(machine=>{
                                                
                        if(machine.status==='active' || machine.status==='free'){
                            
                            let card = '<div id='+machine.id.toString()+' class="card text-center col-4 m-3" style="max-width: 540px;">'+
                                            '<div class="row g-0">'+
                                               '<div class="col-md-4 my-5 px-1">'+
                                                 '<img src="/SmartVendingMachine/View/img/machine.png" class="img-fluid rounded-start" alt="...">'+
                                               '</div>'+
                                               '<div class="col-md-8 my-4">'+
                                                 '<div class="card-body">'+
                                                   '<p class="card-text">'+'<b> MACCHINETTA: '+machine.name+'</b>'+'</p>'+
                                                   '<button id="machineConnectionBtn" class="btn btn-primary">Connettiti</button>'+
                                                 '</div>'+
                                               '</div>'+
                                             '</div>'+
                                         '</div>';

                            $('#machineConnectionBody').append(card);
                            
                        }

                   });
                   
                   $('#machineConnectionSection').css('display','block');
                   $('.spinner-border').css('display','none');
                } 
            });
           
        }

        //---------------UTILS
        
        function showAdminInterface(){
        
            $('#sideNav div').empty();
        
            let buttons = '<button type="button" id="personalData" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 py-1 m-0 my-1" src="/SmartVendingMachine/View/img/wallet.png">'+
                                '<p class="col-10 p-0 m-0 my-1 ">DATI PERSONALI</p>'+
                            '</button>'+
                            '<button type="button" id="wallet" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 m-0 my-1" src="/SmartVendingMachine/View/img/wallet.png">'+ 
                                '<p class="col-10 p-0 m-0 my-1">WALLET</p>'+
                            '</button>'+
                            '<button type="button" id="purchase" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 py-1 m-0 my-1" src="/SmartVendingMachine/View/img/shopping-cart.png">'+ 
                                '<p class="col-10 p-0 m-0 my-1">ACQUISTO</p>'+
                            '</button>'+
                            '<button type="button" id="purchasesMade" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 py-1 m-0 my-1" src="/SmartVendingMachine/View/img/choices.png">'+ 
                                '<p class="col-10 p-0 m-0 my-1">ACQUISTI EFFETTUATI</p>'+
                            '</button>'+
                            '<button type="button" id="usersManagement" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 py-1 m-0 my-1" src="/SmartVendingMachine/View/img/profile.png">'+
                                '<p class="col-10 p-0 m-0 my-1">GESTIONE UTENTI</p>'+
                            '</button>'+
                            '<button type="button" id="machinesManagement" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 py-1 m-0 my-1"src="/SmartVendingMachine/View/img/favicon-16x16.png">'+ 
                                '<p class="col-10 p-0 m-0 my-1">GESTIONE MACCHINETTE</p>'+
                            '</button>'+
                            '<button type="button" id="productsManagement" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 py-1 m-0 my-1" src="/SmartVendingMachine/View/img/boxes.png">'+ 
                                '<p class="col-10 p-0 m-0 my-1">GESTIONE PRODOTTI</p>'+
                            '</button>';
        
            $('#sideNav div').append(buttons);

        }
        
        function showUserInterface(){
            
            $('#sideNav div').empty();
        
            let buttons = '<button type="button" id="personalData" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 py-1 m-0 my-1" src="/SmartVendingMachine/View/img/wallet.png">'+
                                '<p class="col-10 p-0 m-0 my-1 ">DATI PERSONALI</p>'+
                            '</button>'+
                            '<button type="button" id="wallet" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 m-0 my-1" src="/SmartVendingMachine/View/img/wallet.png">'+ 
                                '<p class="col-10 p-0 m-0 my-1">WALLET</p>'+
                            '</button>'+
                            '<button type="button" id="purchase" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 py-1 m-0 my-1" src="/SmartVendingMachine/View/img/shopping-cart.png">'+ 
                                '<p class="col-10 p-0 m-0 my-1">ACQUISTO</p>'+
                            '</button>'+
                            '<button type="button" id="purchasesMade" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 py-1 m-0 my-1" src="/SmartVendingMachine/View/img/choices.png">'+ 
                                '<p class="col-10 p-0 m-0 my-1">ACQUISTI EFFETTUATI</p>'+
                            '</button>';
                            
            $('#sideNav div').append(buttons);

        }
        
        function showTechInterface(){
            
            $('#sideNav div').empty();
        
            let buttons = '<button type="button" id="personalData" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 py-1 m-0 my-1" src="/SmartVendingMachine/View/img/wallet.png">'+
                                '<p class="col-10 p-0 m-0 my-1 ">DATI PERSONALI</p>'+
                            '</button>'+
                            '<button type="button" id="wallet" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 m-0 my-1" src="/SmartVendingMachine/View/img/wallet.png">'+ 
                                '<p class="col-10 p-0 m-0 my-1">WALLET</p>'+
                            '</button>'+
                            '<button type="button" id="purchase" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 py-1 m-0 my-1" src="/SmartVendingMachine/View/img/shopping-cart.png">'+ 
                                '<p class="col-10 p-0 m-0 my-1">ACQUISTO</p>'+
                            '</button>'+
                            '<button type="button" id="purchasesMade" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 py-1 m-0 my-1" src="/SmartVendingMachine/View/img/choices.png">'+ 
                                '<p class="col-10 p-0 m-0 my-1">ACQUISTI EFFETTUATI</p>'+
                            '</button>'+
                            '<button type="button" id="machinesManagement" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 py-1 m-0 my-1"src="/SmartVendingMachine/View/img/favicon-16x16.png">'+ 
                                '<p class="col-10 p-0 m-0 my-1">GESTIONE MACCHINETTE</p>'+
                            '</button>'+
                            '<button type="button" id="productsManagement" class="btn btn-sm col-12 my-3 d-flex flex-row">'+
                                '<img class="col-2 p-0 py-1 m-0 my-1" src="/SmartVendingMachine/View/img/boxes.png">'+ 
                                '<p class="col-10 p-0 m-0 my-1">GESTIONE PRODOTTI</p>'+
                            '</button>';
        
            $('#sideNav div').append(buttons);

        }
        
        function clearInterface(){
            
            $('#wallet-div').css('display','none');
            $('#personal-data').css('display','none');
            $('#purchases').css('display','none');
            $('#Users').css('display','none');
            $('#Products').css('display','none');
            $('#machine-mngmt').css('display','none');
            $('#machineConnectionSection').css('display','none');
        }
        
        function checkIfInputFieldIsBlank(data){
            
            let formData = Object.values(data);
            
            return formData.includes('');
        }

    </script>
</html>

