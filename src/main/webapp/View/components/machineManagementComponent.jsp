<%-- 
    Document   : machineManagementComponent
    Created on : 9 nov 2022, 21:57:54
    Author     : luciano
--%>

<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="machine-mngmt">
    
    <button type="button" class="btn btn-success my-3"data-bs-toggle="modal" data-bs-target="#addMachineModal">Inserisci Macchinetta</button>
    <table class="table table-striped">
       <thead>
         <tr>
           <th scope="col">ID MACCHINETTA</th>
           <th scope="col">NOME</th>
           <th scope="col">STATO</th>
           <th scope="col">CAPACITA MAX</th>
           <th scope="col">CAPACITA ATTUALE</th>
           <th scope="col">ACTIONS</th>
         </tr>
       </thead>
       <tbody>

       </tbody>
    </table>
    
    <div class="modal fade" id="addRefillModal" tabindex="-1" aria-labelledby="refillModalLabel" aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered">
       <div class="modal-content">
         <div class="modal-header">
           <h1 class="modal-title fs-5" id="refillModalLabel">Rifonisci Macchinetta</h1>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <div class="modal-body">
            <form>
                <div class="row">
                   <div class="mb-3 col-6">
                       <label for="InputName" class="form-label">ID PRODOTTO 1</label>
                       <input type="number" class="form-control" onblur="checkProdId(this)" id="productId1-field" aria-describedby="productId1Help" >
                   </div>
                   <div class="mb-3 col-6">
                     <label for="InputName" class="form-label">QUANTITA PRODOTTO 1</label>
                     <input type="number" min="1" max="5" onblur="checkQuantity(this)" class="form-control" id="product1quantity-field" aria-describedby="product1quantityHelp" >
                   </div>
                </div>
                <div class="row">
                    <div class="mb-3 col-6">
                        <label for="InputName" class="form-label">ID PRODOTTO 2</label>
                        <input type="number" class="form-control" onblur="checkProdId(this)" id="productId2-field" aria-describedby="productId2Help" >
                    </div>
                    <div class="mb-3 col-6">
                      <label for="InputName" class="form-label">QUANTITA PRODOTTO 2</label>
                      <input type="number" min="1" max="5" onblur="checkQuantity(this)" class="form-control" id="product2quantity-field" aria-describedby="product2quantityHelp" >
                    </div>
                </div>
                <div class="row">
                    <div class="mb-3 col-6">
                        <label for="InputName" class="form-label">ID PRODOTTO 3</label>
                        <input type="number" class="form-control" onblur="checkProdId(this)" id="productId3-field" aria-describedby="productId3Help" >
                    </div>
                    <div class="mb-3 col-6">
                        <label for="InputName" class="form-label">QUANTITA PRODOTTO 3</label>
                        <input type="number" min="1" max="5" onblur="checkQuantity(this)" class="form-control" id="product3quantity-field" aria-describedby="product3quantityHelp" >
                    </div>
                </div>
                <div class="row">
                    <div class="mb-3 col-6">
                        <label for="InputName" class="form-label">ID PRODOTTO 4</label>
                        <input type="number" class="form-control" onblur="checkProdId(this)" id="productId4-field" aria-describedby="productId4Help" >
                    </div>
                    <div class="mb-3 col-6">
                        <label for="InputName" class="form-label">QUANTITA PRODOTTO 4</label>
                        <input type="number" min="1" max="5" onblur="checkQuantity(this)" class="form-control" id="product4quantity-field" aria-describedby="product4quantityHelp" >
                    </div>
                </div>
            </form>
         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Chiudi</button>
           <button type="button" class="btn btn-primary" id="addRefillSubmit">Salva</button>
         </div>
       </div>
     </div>
    </div>

    <div class="modal fade" id="addMachineModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered">
       <div class="modal-content">
         <div class="modal-header">
           <h1 class="modal-title fs-5" id="addModalLabel">Aggiungi Macchinetta</h1>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <div class="modal-body">
             <form>
                <div class="mb-3">
                  <label for="InputName" class="form-label">NOME</label>
                  <input type="text" class="form-control" id="name-field" aria-describedby="NameHelp">
                </div>
              </form>
         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Chiudi</button>
           <button type="button" class="btn btn-primary" id="addMachineSubmit">Salva</button>
         </div>
       </div>
     </div>
    </div>

    <div class="modal fade" id="updateMachineModal" tabindex="-1" aria-labelledby="updateMachineLabel" aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered">
       <div class="modal-content">
         <div class="modal-header">
           <h1 class="modal-title fs-5" id="updateMachineModal">Modifica Macchinetta</h1>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <div class="modal-body" id="updateMachineModalBody">

         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Chiudi</button>
           <button type="button" class="btn btn-primary" id="updateMachineSubmit">Salva</button>
         </div>
       </div>
     </div>
   </div>
    
</div>
<script>
    
    $('body').on('click','#deleteMachineBtn',(e)=>{

        deleteMachine(e);
    });

    $('body').on('click','#updateMachineBtn',(e)=>{

        showUpdateMachinePanel(e);
    });

    $('#addMachineSubmit').click(()=>{

        addMachine();
    });

    $('#updateMachineSubmit').click(()=>{

        updateMachine();
    });

    $('body').on('click','.btn-outline-warning',(e)=>{

        let parents = $(e.currentTarget).parents();
        let machineId= parseInt(parents[1].id);

        $('#addRefillModal .modal-content').attr("machineId",machineId);
        
        const url='/SmartVendingMachine/RefillsManagement/getRefill';
        const data={machineId:machineId};

        $.get(url,data,(response)=>{
            
            if(response.success){

                response.prod1Id===0 ? $('#productId1-field').val('') : $('#productId1-field').val(response.prod1Id);
                response.prod1Id===0 ? $('#product1quantity-field').val('') : $('#product1quantity-field').val(response.prod1Quantity);
                response.prod2Id===0 ? $('#productId2-field').val('') : $('#productId2-field').val(response.prod2Id);
                response.prod2Id===0 ? $('#product2quantity-field').val('') : $('#product2quantity-field').val(response.prod2Quantity);
                response.prod3Id===0 ? $('#productId3-field').val('') : $('#productId3-field').val(response.prod3Id);
                response.prod3Id===0 ? $('#product3quantity-field').val('') : $('#product3quantity-field').val(response.prod3Quantity);
                response.prod4Id===0 ? $('#productId4-field').val('') : $('#productId4-field').val(response.prod4Id);
                response.prod4Id===0 ? $('#product4quantity-field').val('') : $('#product4quantity-field').val(response.prod4Quantity);
            }
            
            
        });
    });

    $('#addRefillSubmit').click((e)=>{

        let parents = $(e.currentTarget).parents();
        let machineId = $(parents[1]).attr('machineId');

        addRefill(machineId);
    });
    
     function addRefill(machineId){
         
        <% User currentUser = (User)session.getAttribute("currentSessionUser"); %>
            
        const data={

            machineId: machineId,
            techId:'<%= currentUser.getId()%>',
            prod1Id:$('#productId1-field').val(),
            prod1Quantity:$('#product1quantity-field').val(),
            prod2Id:$('#productId2-field').val(),
            prod2Quantity:$('#product2quantity-field').val(),
            prod3Id:$('#productId3-field').val(),
            prod3Quantity:$('#product3quantity-field').val(),
            prod4Id:$('#productId4-field').val(),
            prod4Quantity:$('#product4quantity-field').val()

        };

        if(!checkIfInputFieldIsBlank(data)){

            const url="/SmartVendingMachine/RefillsManagement/addRefill";

            $.post(url,data,(response)=>{


                if(response.success===true){

                    showAllMachines();
                }
            });

        }else{

            alert('compilare tutti i campi obbligatori');
        }

    }
    
    function showAllMachines(){
            
        clearInterface();

        const url="/SmartVendingMachine/MachinesManagement/getAll";
        
        $.get(url,(response)=>{

            if(response.success){

                $('#machine-mngmt tbody').empty();

                response.machines.forEach(machine=>{

                    let record = '<tr id='+machine.id.toString()+'>'+'<td>'+machine.id.toString()+'</td>'+
                                 '<td>'+machine.name.toString()+'</td>'+
                                 '<td>'+machine.status.toString()+'</td>'+
                                 '<td>'+machine.maxCapacity.toString()+'</td>'+
                                 '<td>'+machine.actualCapacity.toString()+'</td>'+
                                 '<td>'+
                                     '<button id="refillMachineBtn" type="button" class="btn btn-outline-warning mx-1"data-bs-toggle="modal" data-bs-target="#addRefillModal">'+
                                         '<i class="bi bi-fuel-pump"></i>'+
                                     '</button>'+
                                     '<button id="updateMachineBtn" type="button" class="btn btn-outline-success mx-1" data-bs-toggle="modal" data-bs-target="#updateMachineModal">'+
                                         '<i class="bi bi-pencil"></i>'+
                                     '</button>'+
                                     '<button id="deleteMachineBtn" type="button" onclick="deleteMachine" class="btn btn-outline-danger mx-1">'+
                                         '<i class="bi bi-trash3-fill"></i>'+
                                     '</button>'+
                                 '</td>'+
                          '</tr>';

                    $('#machine-mngmt tbody').append(record);

               });

               $('#machine-mngmt').css('display','block');

            } 
        });

    }
        
    function showUpdateMachinePanel(event){

        let parents = $(event.currentTarget).parents();
        const machineId= parseInt(parents[1].id);

        const url="/SmartVendingMachine/MachinesManagement/getMachine";
        const data={

            machineId:machineId
        };

        $.get(url,data,(response)=>{

            const machineId = response.machineId;
            const name = response.name;
            const status = response.status;
            const maxCapacity = response.maxCapacity;
            const actualCapacity = response.actualCapacity;

            $('#updateMachineModalBody').empty();

            $('#updateMachineModalBody').append(

                '<form id='+machineId+'>'+
                 '<div class="mb-3">'+
                   '<label for="name" class="form-label">NOME</label>'+
                   '<input id="name-field" type="text" placeholder="inserisci nome" class="form-control" aria-describedby="nameHelp" value='+name+'>'+
                 '</div>'+
                 '<div class="mb-3 d-flex flex-column">'+
                    '<label for="status" class="form-label">STATO</label>'+
                    '<select class="form-select" id="updateMachineOptions" aria-label="Floating label select example">'+
                     '<option value="disabled" >Disabilitato</option>'+
                     '<option value="active">Attivo</option>'+
                    '</select>'+
                 '</div>'+
               '</form>'       
            );

            setOptionDropdownMachine(status);

        });

    }
        
    function setOptionDropdownMachine(status){

        let option1= $('#updateMachineOptions').children()[0].innerHTML;
        let option2= $('#updateMachineOptions').children()[1].innerHTML;

        const options = [option1,option2];

        options.forEach((option,index)=>{

            if(option===status){

                let option = $('#updateMachineOptions').children()[index];
                $(option).attr("selected","selected");
            }
        });

    }
        
    function updateMachine(){

        const data ={

            machineId: $('#updateMachineModalBody form').attr('id'),
            name: $('#updateMachineModal .modal-body form #name-field').val(),
            status: $('#updateMachineOptions option:selected').val()
        };

        const url='/SmartVendingMachine/MachinesManagement/updateMachine';
        
       $.post(url,data,(response)=>{

            if(response.success){

                showAllMachines();
            }

        });

    }
        
    function deleteMachine(event){

        let parents = $(event.currentTarget).parents();
        let machineId= parseInt(parents[1].id);

        const url='/SmartVendingMachine/MachinesManagement/deleteMachine';
        const data={

            machineId:machineId
        };
        
        $.post(url,data,(response)=>{

            alert(response.message);

            showAllMachines();
        });

    }
        
    function addMachine(){

        const name = $('#addMachineModal .modal-body #name-field').val();

        const url='/SmartVendingMachine/MachinesManagement/addMachine';

        const data={

            name:name

        };
        
        $.post(url,data,(response)=>{

            if(response.success){

                showAllMachines();

                $('#addMachineModal .modal-body #name-field').val('');

            }

        });

    }
        
    function checkQuantity(domElmnt){

        let quantity = $(domElmnt).val();

        if(quantity<1 || quantity>5){

            $(domElmnt).val(1);

        }

    }
    
    function prodIdIsRepeated(productId){
        
        var isRepeated=false;
        var count=0;
        
        $("#addRefillModal form ").find(':input').each(function(index){
            
            if(index%2==0){
                
                productId==$(this).val() ? count++ : count;                
                
            }
                            
        });
        
        return isRepeated = count>1 ? true : false;
        
    }
        
    function checkProdId(domElmnt){

        let productId = $(domElmnt).val();
        
        console.log(prodIdIsRepeated(productId));
        
        if(!prodIdIsRepeated(productId)){
            
            if(productId!==''){

                const url="/SmartVendingMachine/ProductsManagement/getProduct";
                const data={productId:productId};
                
                $.get(url,data,(response)=>{

                    if(response.success===false){

                        alert('il prodotto: '+productId+' non esiste!');

                        $(domElmnt).val('');
                    }
                });

            }
            
        }
        else{
            
            alert('il prodotto '+productId+' non puo essere inserito piu di una volta');
            
        }

    }
    
</script>

