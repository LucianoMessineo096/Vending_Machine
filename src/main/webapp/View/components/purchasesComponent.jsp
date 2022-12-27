<%-- 
    Document   : purchasesComponent
    Created on : 5 nov 2022, 11:24:24
    Author     : luciano
--%>

<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="purchases">
    
    <div class="d-flex flex-row m-0 p-0 justify-content-between">
        <p></p>
        <div id='actions' class="d-flex flex-row m-0 p-0 justify-content-between"></div>
    </div>
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
            
           let numPurchases=0;
           let totalCost=0;
           
           $('#purchases tbody').empty();

           response.purchases.forEach((purchase,index)=>{
               
               numPurchases++;
               totalCost+=parseFloat(purchase.cost);
               
               let description = response.products[index].name==='undefined' ? response.products[index].name : 'N/A';
               
               let record = '<tr>'+'<td>'+purchase.id.toString()+'</td>'+
                                '<td>'+description+'</td>'+
                                '<td>'+purchase.date.toString()+'</td>'+
                                '<td>€'+purchase.cost.toString()+'</td>'+
                            '</tr>';

               $('#purchases tbody').append(record);
           });
           
           $('#purchases #actions .badge').remove();
           $('#purchases .badge').remove();
           let infoBadge='<span class="badge rounded-pill text-bg-info my-4 mx-2">Acquisti effettuati: '+numPurchases+'</span>';
           let costBadge='<span class="badge rounded-pill text-bg-warning my-4 mx-2">Totale speso: '+totalCost+'</span>';
           $('#purchases #actions').append(infoBadge,costBadge);
           $('#purchases').css('display','block');
           $('.spinner-border').css('display','none');
        });
    }
</script>

