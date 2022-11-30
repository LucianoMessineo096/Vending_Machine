<%-- 
    Document   : purchasesComponent
    Created on : 5 nov 2022, 11:24:24
    Author     : luciano
--%>

<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="purchases">
    <table class="table table-striped overflow-auto">
       <thead>
         <tr>
           <th scope="col">ID ACQUISTO</th>
           <th scope="col">PRODOTTO</th>
           <th scope="col">DATA</th>
           <th scope="col">COSTO</th>
         </tr>
       </thead>
       <tbody>

       </tbody>
    </table>

</div>
<script>
    
    function showPurchases(){
        
        $('.spinner-border').css('display','block');
        
        clearInterface();

        <%  User currentUser = (User)session.getAttribute("currentSessionUser"); %>

        const url="/SmartVendingMachine/PurchasesManagement/getAllPurchases";
        const data = {

            userId: parseInt('<%= currentUser.getId() %>')

        };
        
        $.get(url,data,(response)=>{
            
           $('#purchases tbody').empty();

           response.purchases.forEach((purchase,index)=>{

               $('#purchases tbody').append(

                  '<tr>'+'<td>'+purchase.id.toString()+'</td>'+
                         '<td>'+response.products[index].name+'</td>'+
                         '<td>'+purchase.date.toString()+'</td>'+
                         '<td>€'+purchase.cost.toString()+'</td>'+
                  '</tr>'

                );
           });

           $('#purchases').css('display','block');
           $('.spinner-border').css('display','none');
        });
    }
</script>

