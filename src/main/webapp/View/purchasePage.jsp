<%-- 
    Document   : purchasePage
    Created on : 2 nov 2022, 19:18:38
    Author     : luciano
--%>

<%@page import="Model.Machine"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Enumeration"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="Controller.*"%>
<%@page language="java" 
        contentType="text/html" 
        import="Model.User"
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
        <jsp:include page="/View/styles/purchasePageStyle.jsp"></jsp:include>
        <link rel="icon" href="/SmartVendingMachine/View/img/favicon-16x16.png" type="image/icon type">
        <title>SmartVendingMachine</title>
    </head>
    <body>
        
        <jsp:include page="/View/components/navbar3.jsp"></jsp:include>
        <span class="badge rounded-pill text-bg-info m-2 position-absolute top-0 end-0">Saldo Attuale: €<b id="balanceInfo"></b></span>
        <section id="products" class="row d-flex flex-row justify-content-center">
            
        </section>
        
        <div class="modal fade" id="purchaseModal" tabindex="-1" aria-labelledby="updateMachineLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="purchaseModalMessage"></h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
            </div>
          </div>
        </div>
        
    </body>
    <script>
                
        $(document).ready(()=>{
            
            getMachineProducts();
            
            //-------Purchase
            
            $('body').on('click','#Purchase-btn',(e)=>{
                
                
                let card= $(event.target).parents()[3];
                let id=$(card).attr('id');
                Purchase(id);
                
            });

        });
        
        //--------------------------------------------------------------------
        
        function setQuantity(quantities,product){
            
            let quantity=0;
            
            if(product.id==quantities.prod1Id){
                
                quantity=quantities.prod1Quantity;

            }else if(product.id==quantities.prod2Id){
                                
                quantity=quantities.prod2Quantity;
 
            }else if(product.id==quantities.prod3Id){
                                
                quantity=quantities.prod3Quantity;
                
            }else{
                                
                quantity=quantities.prod4Quantity;
 
            }
            
            return quantity;
            
        }
        
        function setProductImg(typology){
                        
            let cardImg;
            let imgCoffe = '<img src="View/img/coffee-cup.png" class="img-fluid rounded-start" alt="...">';
            let imgWater = '<img src="View/img/water.png" class="img-fluid rounded-start" alt="...">';
            let imgDrink = '<img src="View/img/coke.png" class="img-fluid rounded-start" alt="...">';
            let imgSnack = '<img src="View/img/snack.png" class="img-fluid rounded-start" alt="...">';
            
            if(typology==='coffe'){
                        
                cardImg = imgCoffe;

            }else if(typology==='water'){

                cardImg = imgWater;

            }else if(typology==='drink'){

                cardImg = imgDrink;

            }else{

                cardImg = imgSnack;
            }
            
            return cardImg;
            
        }
        
        function getWalletBalance(){
            
            const url='/SmartVendingMachine/UsersManagement/Wallet/getWallet';
            <% User currentSessionUser = (User)session.getAttribute("currentSessionUser"); %>
            const data={userId:<%= currentSessionUser.getId() %>};
                
            $.get(url,data,(response)=>{
                                
                $('#balanceInfo').text(response.walletBalance);
            });
                
        }

        function getMachineProducts(){
            
            getWalletBalance();
            
            const url ='/SmartVendingMachine/ProductsManagement/getMachineProducts';
            <% Machine currentMachine = (Machine)session.getAttribute("currentSessionMachine"); %>
            const data={machineId:<%= currentMachine.getId() %>};
            
            $.get(url,data,(response)=>{
                
                $('#products').empty();
                
                response.products.forEach((product)=>{
                                        
                    if(product.id!==0){
                        
                        let cardImg = setProductImg(product.typology);
                        let quantity = setQuantity(response.quantities,product);
                        let quantityMessage= quantity===0 ? '<p class="badge rounded-pill text-bg-danger col-8">Non disponibile</p>' : '<p class="badge rounded-pill text-bg-success col-8">Disponibilità: '+quantity.toString()+'</p>';
                        let purchaseBtn = quantity===0 ? '<button id="Purchase-btn" class="btn btn-primary col-12" data-bs-toggle="modal" data-bs-target="#purchaseModal" disabled>Acquista</button>' : '<button id="Purchase-btn" class="btn btn-primary col-12" data-bs-toggle="modal" data-bs-target="#purchaseModal">Acquista</button>';

                        let card= '<div id='+product.id.toString()+' class="card text-center col-5 m-3" style="max-width: 540px;">'+
                                   '<div class="row g-0">'+
                                      '<div class="col-md-4 my-5">'+cardImg+'</div>'+
                                      '<div class="col-md-8 my-4">'+
                                        '<div class="card-body">'+
                                          '<p class="card-text col-12">'+'<b>'+product.name+'</b>'+'</p>'+
                                          '<p class="card-text col-12">Prezzo: € '+product.price+'</p>'+
                                           quantityMessage+
                                           purchaseBtn+
                                        '</div>'+
                                      '</div>'+
                                    '</div>'+
                                '</div>';

                        $('#products').append(card);

                        quantity=0;
                        
                    }
                    
               });
               
            });
 
        }

        function Purchase(id){
            
            <%  User currentUser = (User)session.getAttribute("currentSessionUser"); %>
                
            const data={
                
                productId:id,
                userId:<%=currentUser.getId() %>,
                machineId:<%=currentMachine.getId() %>
            };
                        
            const url='/SmartVendingMachine/PurchasesManagement/doPurchase';
            
            $.post(url,data,(response)=>{
                
                $('#purchaseModalMessage').text(response.message)
                                
                getMachineProducts();

            });
                    
        }
        
    </script>
</html>

