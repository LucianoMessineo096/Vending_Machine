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
        
        <section id="products" class="row d-flex flex-row justify-content-center">
            
        </section>
        
        
    </body>
    <script>
                
        $(document).ready(()=>{
            
            //variables
            var products=[];

            const url ='/SmartVendingMachine/ProductsManagement/getMachineProducts';
            <% Machine currentMachine = (Machine)session.getAttribute("currentSessionMachine"); %>
            const data={machineId:<%= currentMachine.getId() %>};
            
            $.get(url,data,(response)=>{
                             
                response.products.forEach(product=>{
                    
                    products.push(product);

                    let id = product.id;
                    let tipologia = product.typology;
                    let nome = product.name;
                    let prezzo = product.price;
                    let card;

                    if(tipologia==='coffe'){

                        card= '<div id='+id.toString()+' class="card text-center col-3 m-3" style="max-width: 540px;">'+
                              '<div class="row g-0">'+
                                 '<div class="col-md-4 my-5">'+
                                   '<img src="View/img/coffee-cup.png" class="img-fluid rounded-start" alt="...">'+
                                 '</div>'+
                                 '<div class="col-md-8 my-4">'+
                                   '<div class="card-body">'+
                                     '<p class="card-text">'+'<b>'+nome+'</b>'+'</p>'+
                                     '<p class="card-text">Prezzo: '+prezzo+'€</p>'+
                                     '<button class="btn btn-primary">Acquista</button>'+
                                   '</div>'+
                                 '</div>'+
                               '</div>'+
                           '</div>';        

                    }else if(tipologia==='water'){

                         card= '<div id='+id.toString()+' class="card text-center col-3 m-3" style="max-width: 540px;">'+
                               '<div class="row g-0">'+
                                  '<div class="col-md-4 my-5">'+
                                    '<img src="View/img/water.png" class="img-fluid rounded-start" alt="...">'+
                                  '</div>'+
                                  '<div class="col-md-8 my-4">'+
                                    '<div class="card-body">'+
                                      '<p class="card-text">'+'<b>'+nome+'</b>'+'</p>'+
                                      '<p class="card-text">Prezzo: '+prezzo+'€</p>'+
                                      '<button class="btn btn-primary">Acquista</button>'+
                                    '</div>'+
                                  '</div>'+
                                '</div>'+
                            '</div>';

                    }else if(tipologia==='drink'){
 
                         card= '<div id='+id.toString()+' class="card text-center col-3 m-3" style="max-width: 540px;">'+
                               '<div class="row g-0">'+
                                  '<div class="col-md-4 my-5">'+
                                    '<img src="View/img/coke.png" class="img-fluid rounded-start" alt="...">'+
                                  '</div>'+
                                  '<div class="col-md-8 my-4">'+
                                    '<div class="card-body">'+
                                      '<p class="card-text">'+'<b>'+nome+'</b>'+'</p>'+
                                      '<p class="card-text">Prezzo: '+prezzo+'€</p>'+
                                      '<button class="btn btn-primary">Acquista</button>'+
                                    '</div>'+
                                  '</div>'+
                                '</div>'+
                            '</div>';

                    }else if(tipologia==='snack'){
                        
                        card= '<div id='+id.toString()+' class="card text-center col-3 m-3" style="max-width: 540px;">'+
                               '<div class="row g-0">'+
                                  '<div class="col-md-4 my-5">'+
                                    '<img src="View/img/snack.png" class="img-fluid rounded-start" alt="...">'+
                                  '</div>'+
                                  '<div class="col-md-8 my-4">'+
                                    '<div class="card-body">'+
                                      '<p class="card-text">'+'<b>'+nome+'</b>'+'</p>'+
                                      '<p class="card-text">Prezzo: '+prezzo+'€</p>'+
                                      '<button class="btn btn-primary">Acquista</button>'+
                                    '</div>'+
                                  '</div>'+
                                '</div>'+
                            '</div>';

                    }

                    $('#products').append(card);
               });
               
               //-------Purchase
            
                $('.btn').click((event)=>{
                    
                    let card= $(event.target).parents()[3];
                    let id=$(card).attr('id');
                    Purchase(id);
                });
            });
        });
        
        //------Utils Functions

        function Purchase(id){
            
            <%  User currentUser = (User)session.getAttribute("currentSessionUser"); %>
                
            const data={
                
                productId:id,
                userId:<%=currentUser.getId() %>,
                machineId:<%=currentMachine.getId() %>
            };
                        
            const url='/SmartVendingMachine/PurchasesManagement/doPurchase';
            
            $.post(url,data,(response)=>{
                
          
                alert(response.message);
 
            });
                    
        }
        
    </script>
</html>

