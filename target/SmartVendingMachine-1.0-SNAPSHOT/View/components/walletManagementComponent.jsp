<%-- 
    Document   : walletManagementComponent
    Created on : 5 nov 2022, 11:26:14
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
<div id="wallet-div">
    
    <%  User currentUser = (User)session.getAttribute("currentSessionUser"); %>
                     
    <div id="wallet-card" class="row p-1 m-2">
        <div class="col-4" id="wallet-info">
            <p>MY WALLET</p>
            <p id="wallet-userName" class="m-1"><b>NOME:</b> <%=currentUser.getName().toUpperCase() %></p>
            <p id="wallet-userSurname" class="m-1"><b>COGNOME:</b> <%=currentUser.getSurname().toUpperCase() %></p>
            <p class="m-1">SALDO: €<b id="walletBalance"></b></p>    
        </div>
        <div class="col-8">
            <div class="d-flex flex-row justify-content-between col-11">
                <label class="my-3"><b>Lista Movimenti</b></label>
                <button class="btn btn-success m-2" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">Effettua ricarica</button>   
            </div>
            <div id="movements" class="overflow-auto"></div>
        </div>

    </div>
    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
      <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasRightLabel">Ricarica Wallet</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
      <div class="offcanvas-body">
          <input 
              type="number" 
              min="1"
              max="100"
              class="form-control my-2" 
              id="recharge-value" 
              aria-describedby="rechargeHelp" 
              placeholder="inserisci valore"
          >
          <button id="recharge-button" class="btn btn-success my-2">Ricarica</button>
      </div>
    </div>
                    
                    
    <!-- *****************************************test*********************************************** -->
    
    
</div>
<script>
    
    $('.offcanvas .offcanvas-body #recharge-button').click(()=>{
            
        doWalletRecharge();

    });
    
    function isFloat(rechargeValue){
        
        rechargeValue=rechargeValue.toString();
        
        if(rechargeValue.includes('.') || rechargeValue.includes(',')){
            
            return false;
        }
        else{
            
            return true;
        }
        
    }
    
    function _validation(){
        
        $(".offcanvas .offcanvas-body #recharge-value").removeClass('is-invalid');
                
        let validation=true;
        
        let rechargeValue = parseInt($('.offcanvas .offcanvas-body #recharge-value').val());
        
        console.log(typeof rechargeValue +"_"+ rechargeValue)
        
        if(rechargeValue<0 || rechargeValue>100){
            
            $(".offcanvas .offcanvas-body #recharge-value").addClass('is-invalid');
            
            validation=false;
             
        }
        
        /*if(isFloat(rechargeValue)){
           
           alert('il valore della ricarica deve essere intero');
           $(".offcanvas .offcanvas-body #recharge-value").addClass('is-invalid');
           validation=false;
            
        }*/
        
        if(rechargeValue=== undefined || rechargeValue===null || rechargeValue===''){
            
            $(".offcanvas .offcanvas-body #recharge-value").addClass('is-invalid');
            
            validation=false;
        }
                
        return validation;
        
    }
    
    function doWalletRecharge(){

        let rechargeValue = $('.offcanvas .offcanvas-body #recharge-value').val();
        
        let validation = _validation();
        
        if(validation){
            
            const url ='/SmartVendingMachine/UsersManagement/Wallet/updateBalance';
            const data = {

                userId: parseInt('<%= currentUser.getId() %>'),
                rechargeValue: parseInt(rechargeValue)
            };

            $.post(url,data,(response)=>{

               alert(response.message);
               showWallet();
            });
            
        }

    }
    
    function showWallet(){

        clearInterface();

        const data={

            userId: parseInt('<%= currentUser.getId() %>')
        };

        const url = '/SmartVendingMachine/UsersManagement/Wallet/getWallet';
        
        $.get(url,data,(response)=>{

            if(response.success){

                $('#wallet-div').css('display','block');
                $('#walletBalance').text(response.walletBalance.toString());

                showMovements(parseInt('<%= currentUser.getId() %>'));
            }

        });

    }
    
    function showMovements(userId){

        const url = "/SmartVendingMachine/UsersManagement/Wallet/getRecharges";

        const data={

            userId:userId
        };

        $.get(url,data,(response)=>{

            $('#movements').empty();

            var movementCard;

            response.movements.forEach(movement=>{

                if(movement.type==='recharge'){

                    movementCard = '<div class="card my-2 col-11">'+
                                            '<div class="card-body row">'+
                                              '<p class="col-4" id="movement-type-recharge"><b>Ricarica</b></p>'+
                                              '<p class="col-4 d-flex justify-content-center">'+movement.date+'</p>'+
                                              '<p class="col-4 d-flex justify-content-end" id="recharge-value">$'+movement.value+'</p>'+
                                            '</div>'+
                                        '</div>';

                }
                else{

                    movementCard = '<div class="card my-2 col-11">'+
                                            '<div class="card-body d-flex flex-row justify-content-between">'+
                                              '<p class="col-4" id="movement-type-purchase"><b>Acquisto</b></p>'+
                                              '<p class="col-4 d-flex justify-content-center">'+movement.date+'</p>'+
                                              '<p class="col-4 d-flex justify-content-end" id="purchase-value">$'+movement.value+'</p>'+
                                            '</div>'+
                                        '</div>';


                }

                $('#movements').append(movementCard);

            });

        });

    }

</script>
