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

        <section id="mainSection" class="row">

            <div class='col-1'>
                <jsp:include page="/View/components/sideNavComponent.jsp"></jsp:include>
            </div>
            
            <div class="col-11">
                
                <%  User currentUser = (User)session.getAttribute("currentSessionUser"); %>
                <div id="subTitle" class="d-flex flex-row justify-content-between">
                    <h3>Benvenuto/a <%= currentUser.getName().toUpperCase() +" "+ currentUser.getSurname().toUpperCase() %></h3>
                    <div class="spinner-border text-success my-2" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
                    
                <jsp:include page="/View/components/personalDataComponent.jsp"></jsp:include>
    
                <div id="machineConnectionSection"> 
                    
                    <div id="machineConnectionBody" class="row d-flex flex-row justify-content-center"></div>

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
            
            '<%= currentUser.getType() %>' === 'admin' ? showAdminInterface() : '';
            
            '<%= currentUser.getType() %>' === 'user' ? showUserInterface() : '';
            
            '<%= currentUser.getType() %>' === 'tech' ? showTechInterface() : '';

            //---------PERSONAL INFO VIEW -----------//

            $("#personalData").click((e)=>{
                
                e.preventDefault();
                showPersonalInfo();

            });

            //--------WALLET VIEW --------//

            $('#wallet').click((e)=>{
                
                e.preventDefault();
                showWallet();

            });

            //--------Purchase-----------//

            $('#purchase').click((e)=>{
                
                e.preventDefault();
                showMachinesCard();
                
            });
            
            $('body').on('click','#machineConnectionBtn',(e)=>{
                
                $('#connectionMessage').remove();
                
                const url="/SmartVendingMachine/MachinesManagement/connect";
                
                let parents = $(e.currentTarget).parents();
                let machineId= parents[3].id;
                const data = {machineId: machineId};

                $.post(url,data,(response)=>{
                    
                    const alert='<div id="connectionMessage" class="alert alert-danger position-fixed bottom-0 end-0 m-2" role="alert">'+response.message+'</div>';
                    
                    response.success===true ? window.location=response.address : $('body').append(alert);

                });
                
                setTimeout(()=>{$('#connectionMessage').remove();}, 3000);

            });
            
            //---------Purchase History ----------//

            $('#purchasesMade').click((e)=>{
                
                e.preventDefault();
                showPurchases();

            });
            
            //-------------------Users Management(admin)---------------------//
            
            $('#usersManagement').click((e)=>{
                
                e.preventDefault();
                showAllUsers();
                
            });
            
            $('#updateUserSubmit').click(()=>{
                
                updateUser();
            });
            
            //-------------------Products Management(admin/tech)------------------//
            
            $('#productsManagement').click((e)=>{
                
                e.preventDefault();
                showAllProducts();
                
            });
            
            //------------------Machine Management(admin)------------------------//
        
            $('body').on('click','#machinesManagement',(e)=>{
                
                e.preventDefault();
                showAllMachines();

            });

        });
        
        //##################FUNCTIONS#########################################//

        //-------------USER DATA
        
        function showPersonalInfo(){

            clearInterface();

            const data={userId:<%= currentUser.getId()%>};

            $.get('/SmartVendingMachine/UsersManagement/getUser',data,(response)=>{

                if(response.success){

                    $('#personal-data').css('display','block');

                }
            });
        }
        
        //------------------PURCHASE
        
        function checkMachinesAvailability(machines){
        
            var machineAvailable=0;
                    
            machines.forEach((machine,index)=>{
                 
                (machine.status!=='disabled' && machine.status!=='occupied') ? machineAvailable++ : machineAvailable;


            });
            
            return check = machineAvailable>0 ? true : false;
        
        }

        function showMachinesCard(){
            
            $('.spinner-border').css('display','block');
            clearInterface();
            
            const url="/SmartVendingMachine/MachinesManagement/getAll";
            
            $.get(url,(response)=>{
                                
                if(response.success){
                    
                    let checkAvailability= checkMachinesAvailability(response.machines);
                                        
                    if(checkAvailability){
                        
                        $('#machineConnectionBody').empty();
                   
                        response.machines.forEach(machine=>{

                            if(machine.status==='active' || machine.status==='free'){

                                let card = '<div id='+machine.id.toString()+' class="card text-center col-3 m-3" style="max-width: 540px;">'+
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
                    else{
                    
                        $('#machineConnectionBody').empty();
                        $('#machineConnectionBody').append('<div class="alert alert-warning my-3" role="alert">Nessuna macchinetta al momento disponibile!</div>');
                        $('#machineConnectionSection').css('display','block');
                        $('.spinner-border').css('display','none');
                    }
 
                }
                
            });
           
        }

        //---------------UTILS
        
        function showAdminInterface(){
            
            $('#personalData').show();
            $('#wallet').show();
            $('#purchase').show();
            $('#purchasesMade').show();
            $('#usersManagement').show();
            $('#machinesManagement').show();
            $('#productsManagement').show();
        }
        
        function showTechInterface(){
            
            $('#personalData').show();
            $('#wallet').show();
            $('#purchase').show();
            $('#purchasesMade').show();
            $('#usersManagement').hide();
            $('#machinesManagement').show();
            $('#productsManagement').show();
        }
        
        function showUserInterface(){
            
            $('#personalData').show();
            $('#wallet').show();
            $('#purchase').show();
            $('#purchasesMade').show();
            $('#usersManagement').hide();
            $('#machinesManagement').hide();
            $('#productsManagement').hide();
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

