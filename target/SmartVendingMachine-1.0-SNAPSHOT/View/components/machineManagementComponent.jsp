<%-- 
    Document   : machineManagementComponent
    Created on : 9 nov 2022, 21:57:54
    Author     : luciano
--%>

<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="machine-mngmt">
    
    <div class="d-flex flex-row m-0 p-0 justify-content-between">
        <button type="button" class="btn btn-success my-3" data-bs-toggle="modal" data-bs-target="#addMachineModal">Inserisci Macchinetta</button>
        <div id="actions" class="d-flex flex-row m-0 p-0 justify-content-between"></div>
    </div>
    
    <table class="table table-striped">
       <thead>
         <tr>
           <th scope="col">ID MACCHINETTA</th>
           <th scope="col">NOME</th>
           <th scope="col">STATO</th>
           <th scope="col">CAPACITA MAX</th>
           <th scope="col">CAPACITA ATTUALE</th>
           <th scope="col">ACTIONS</th>
           <th scope="col"> </th>
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
                       <select class="form-select" id="dropdown-id-list1" aria-label="Default select example" onblur="checkIfprodIdIsRepeated(this)">
                        <option value="0">Open this select menu</option>
                       </select>
                   </div>
                   <div class="mb-3 col-6">
                     <label for="InputName" class="form-label">QUANTITA PRODOTTO 1</label>
                     <input type="number" min="1" max="5" onblur="checkQuantity(this)" class="form-control" id="product1quantity-field" aria-describedby="product1quantityHelp" >
                   </div>
                </div>
                <div class="row">
                    <div class="mb-3 col-6">
                        <label for="InputName" class="form-label">ID PRODOTTO 2</label>
                        <select class="form-select" id="dropdown-id-list2" aria-label="Default select example" onblur="checkIfprodIdIsRepeated(this)">
                        <option value="0">Open this select menu</option>
                       </select>
                    </div>
                    <div class="mb-3 col-6">
                      <label for="InputName" class="form-label">QUANTITA PRODOTTO 2</label>
                      <input type="number" min="1" max="5" onblur="checkQuantity(this)" class="form-control" id="product2quantity-field" aria-describedby="product2quantityHelp" >
                    </div>
                </div>
                <div class="row">
                    <div class="mb-3 col-6">
                        <label for="InputName" class="form-label">ID PRODOTTO 3</label>
                        <select class="form-select" id="dropdown-id-list3" aria-label="Default select example" onblur="checkIfprodIdIsRepeated(this)">
                        <option value="0">Open this select menu</option>
                       </select>
                    </div>
                    <div class="mb-3 col-6">
                        <label for="InputName" class="form-label">QUANTITA PRODOTTO 3</label>
                        <input type="number" min="1" max="5" onblur="checkQuantity(this)" class="form-control" id="product3quantity-field" aria-describedby="product3quantityHelp" >
                    </div>
                </div>
                <div class="row">
                    <div class="mb-3 col-6">
                        <label for="InputName" class="form-label">ID PRODOTTO 4</label>
                        <select class="form-select" id="dropdown-id-list4" aria-label="Default select example" onblur="checkIfprodIdIsRepeated(this)">
                        <option value="0">Open this select menu</option>
                       </select>
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
           <h1 class="modal-title fs-5" id="updateMachineTitle">Modifica Macchinetta</h1>
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
        
        InsertProductsInSelect();
        getRefillStatus(e);
        
    });

    $('#addRefillSubmit').click((e)=>{

        let parents = $(e.currentTarget).parents();
        let machineId = $(parents[1]).attr('machineId');

        addRefill(machineId);
    });
    
    $('#updateMachineModal').on('hidden.bs.modal', function () {
        
        $('#updateMachineTitle .badge').remove(); 
        showAllMachines();
        
    });
    
    $('#addRefillModal').on('hidden.bs.modal', function () {
        
        $('#refillModalLabel .badge').remove(); 
        showAllMachines();
        
    });
    
    $('#addRefillModal').on('hidden.bs.modal', function () {
        
        $('#productId1-field').removeClass('is-invalid');
        $('#product1quantity-field').removeClass('is-invalid');
        $('#productId2-field').removeClass('is-invalid');
        $('#product2quantity-field').removeClass('is-invalid');
        $('#productId3-field').removeClass('is-invalid');
        $('#product3quantity-field').removeClass('is-invalid');
        $('#productId4-field').removeClass('is-invalid');
        $('#product4quantity-field').removeClass('is-invalid');
        
    });
    
    //-------------------------------------------------------------------------
    
    function addRefillValidation(data){
                        
        $('#dropdown-id-list1').removeClass('is-invalid');
        $('#product1quantity-field').removeClass('is-invalid');
        $('#dropdown-id-list2').removeClass('is-invalid');
        $('#product2quantity-field').removeClass('is-invalid');
        $('#dropdown-id-list3').removeClass('is-invalid');
        $('#product3quantity-field').removeClass('is-invalid');
        $('#dropdown-id-list4').removeClass('is-invalid');
        $('#product4quantity-field').removeClass('is-invalid');
        
        let validation=true;

        if(data.prod1Id===''){

            $("#dropdown-id-list1").addClass('is-invalid');

            validation=false;
        }
        
        if(data.prod1Quantity===''){

            $("#product1quantity-field").addClass('is-invalid');

            validation=false;
        }
        
        data.prod1Quantity>=1 && data.prod1Quantity<=5 ? validation=true : vaidation=false;
        
        if(data.prod2Id===''){

            $("#dropdown-id-list2").addClass('is-invalid');

            validation=false;
        }
        
        if(data.prod2Quantity===''){

            $("#product2quantity-field").addClass('is-invalid');

            validation=false;
        }
        
        data.prod2Quantity>=1 && data.prod2Quantity<=5 ? validation=true : vaidation=false;
        
        if(data.prod3Id===''){

            $("#dropdown-id-list3").addClass('is-invalid');

            validation=false;
        }
        
        if(data.prod3Quantity===''){

            $("#product3quantity-field").addClass('is-invalid');

            validation=false;
        }
        
        data.prod3Quantity>=1 && data.prod3Quantity<=5 ? validation=true : vaidation=false;
        
        if(data.prod4Id===''){

            $("#dropdown-id-list4").addClass('is-invalid');

            validation=false;
        }
        
        if(data.prod4Quantity===''){

            $("#product4quantity-field").addClass('is-invalid');

            validation=false;
        }
        
        data.prod4Quantity>=1 && data.prod4Quantity<=5 ? validation=true : vaidation=false;
        
        return validation;
    }
    
    function getRefillStatus(e){
        
        let parents = $(e.currentTarget).parents();
        let machineId= parseInt(parents[1].id);

        $('#addRefillModal .modal-content').attr("machineId",machineId);
        
        const url='/SmartVendingMachine/RefillsManagement/getRefill';
        const data={machineId:machineId};

        $.get(url,data,(response)=>{
            
            if(response.success){
                
                $("#dropdown-id-list1 option[value="+response.prod1Id.toString()+"]").attr('selected', 'selected');
                response.prod1Id===0 ? $('#product1quantity-field').val('') : $('#product1quantity-field').val(response.prod1Quantity);
                $("#dropdown-id-list2 option[value="+response.prod2Id.toString()+"]").attr('selected', 'selected');
                response.prod2Id===0 ? $('#product2quantity-field').val('') : $('#product2quantity-field').val(response.prod2Quantity);
                $("#dropdown-id-list3 option[value="+response.prod3Id.toString()+"]").attr('selected', 'selected');
                response.prod3Id===0 ? $('#product3quantity-field').val('') : $('#product3quantity-field').val(response.prod3Quantity);
                $("#dropdown-id-list4 option[value="+response.prod4Id.toString()+"]").attr('selected', 'selected');
                response.prod4Id===0 ? $('#product4quantity-field').val('') : $('#product4quantity-field').val(response.prod4Quantity);
               
            }
        });
    }
    
    function InsertProductsInSelect(){
        
        const url="/SmartVendingMachine/ProductsManagement/getAll";
        
        $.get({url:url,async:false},(response)=>{
                                    
            let dropdown = $('#machine-mngmt .form-select');
            dropdown.empty();
            let optionDefault="<option value="+0+">Open this select menu</option>";
            dropdown.append(optionDefault);
            
            response.products.forEach((product)=>{
                
                let prodOption = product.id.toString()+": "+product.name.toString();                     
                let option = "<option value="+product.id+" id="+product.id+">"+prodOption+"</option>";
                
                dropdown.append(option);
                
            });
            
        });
 
    }
    
    function addRefill(machineId){
         
        <% User currentUser = (User)session.getAttribute("currentSessionUser"); %>
        
        const url="/SmartVendingMachine/RefillsManagement/addRefill";
        const data={

            machineId: machineId,
            techId:'<%= currentUser.getId()%>',
            prod1Id:$("#dropdown-id-list1 option:selected")[0].id,
            prod1Quantity:$('#product1quantity-field').val(),
            prod2Id:$("#dropdown-id-list2 option:selected")[0].id,
            prod2Quantity:$('#product2quantity-field').val(),
            prod3Id:$("#dropdown-id-list3 option:selected")[0].id,
            prod3Quantity:$('#product3quantity-field').val(),
            prod4Id:$("#dropdown-id-list4 option:selected")[0].id,
            prod4Quantity:$('#product4quantity-field').val()

        };
                                
        if(addRefillValidation(data)){

            $.post(url,data,(response)=>{
                
                $('#refillModalLabel .badge').remove();
                let success ='<span class="badge rounded-pill text-bg-success mx-2">Rifornita</span>';
                let error ='<span class="badge rounded-pill text-bg-danger mx-2">capacità max raggiunta</span>';
                
                response.success===true ? $('#refillModalLabel').append(success) : $('#refillModalLabel').append(error);
                
            });

        }

    }
    
    function showAllMachines(){
        
        $('.spinner-border').css('display','block');
        clearInterface();

        const url="/SmartVendingMachine/MachinesManagement/getAll";
        
        $.get(url,(response)=>{
            
            if(response.success){
                
                let totalMachines=0;
                let totalMachinesActive=0;
                let totalMachinesDisabled=0;

                $('#machine-mngmt tbody').empty();

                response.machines.forEach(machine=>{
                    
                    console.log(machine)
                    
                    machine.status==='free' || machine.status==='active' ? totalMachinesActive++ : totalMachinesDisabled++;
                    totalMachines++;

                    let message= machine.actualCapacity===0 ? '<span class="badge rounded-pill text-bg-danger">Da rifornire</span>' : "";

                    let updateBtnEnabled = '<button id="updateMachineBtn" type="button" class="btn btn-outline-success mx-1" data-bs-toggle="modal" data-bs-target="#updateMachineModal">'+
                                                '<i class="bi bi-pencil"></i>'+
                                            '</button>';
                    let updateBtnDisabled = '<button id="updateMachineBtn" type="button" class="btn btn-outline-success mx-1" data-bs-toggle="modal" data-bs-target="#updateMachineModal" disabled>'+
                                                '<i class="bi bi-pencil"></i>'+
                                            '</button>';
                                    
                    let status = machine.status==='disabled'? '<span class="badge text-bg-danger">'+machine.status+'</span>' : ( machine.status==='occupied'? '<span class="badge text-bg-warning">'+machine.status+'</span>' : '<span class="badge text-bg-success">'+machine.status+'</span>' );              
                    let updateBtn = machine.actualCapacity===0 ? updateBtnDisabled : updateBtnEnabled;                
                    
                    let record = '<tr id='+machine.id.toString()+'>'+'<td>'+machine.id.toString()+'</td>'+
                                 '<td>'+machine.name.toString()+'</td>'+
                                 '<td>'+status+'</td>'+
                                 '<td>'+machine.maxCapacity.toString()+'</td>'+
                                 '<td>'+machine.actualCapacity.toString()+'</td>'+
                                 '<td>'+
                                     '<button id="refillMachineBtn" type="button" class="btn btn-outline-warning mx-1" data-bs-toggle="modal" data-bs-target="#addRefillModal">'+
                                         '<i class="bi bi-fuel-pump"></i>'+
                                     '</button>'+
                                     updateBtn
                                     +
                                     '<button id="deleteMachineBtn" type="button" onclick="deleteMachine" class="btn btn-outline-danger mx-1">'+
                                         '<i class="bi bi-trash3-fill"></i>'+
                                     '</button>'+
                                 '</td>'+
                                 '<td>'+message+'</td>'+
                          '</tr>';

                    $('#machine-mngmt tbody').append(record);

               });
               
               $('#machine-mngmt #actions .badge').remove();
               let infoBadge='<span class="badge rounded-pill text-bg-info my-4 mx-2">Macchinette totali: '+totalMachines+'</span>';
               let infoBadge2='<span class="badge rounded-pill text-bg-success my-4 mx-2">Macchinette attive: '+totalMachinesActive+'</span>';
               let infoBadge3='<span class="badge rounded-pill text-bg-danger my-4 mx-2">Macchinette disattive: '+totalMachinesDisabled+'</span>';
               $('#machine-mngmt #actions').append(infoBadge,infoBadge2,infoBadge3);
               $('#machine-mngmt').css('display','block');
               $('.spinner-border').css('display','none');
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
                 
                $('#updateMachineTitle .badge').remove();                
                $('#updateMachineTitle').append('<span class="badge rounded-pill text-bg-success mx-2">'+response.message+'</span>'); 

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

            showAllMachines();
        });

    }
        
    function addMachine(){

        const name = $('#addMachineModal .modal-body #name-field').val();
        const url='/SmartVendingMachine/MachinesManagement/addMachine';
        const data={name:name};
        
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
            
            
            $(domElmnt).val('');

        }

    }
    
    function checkIfprodIdIsRepeated(option){
                        
        var isRepeated=false;
        var count=0;
        var productId=option.selectedIndex;
                
        $("#addRefillModal form ").find(':input').each(function(index){
                        
            if(index%2===0 && productId!==0){
                
                productId===this.selectedIndex ? count++ : count;
                
            }
                            
        });
        
        isRepeated = count>1 ? true : false;
        
        if(isRepeated){
            
            alert('non possono esservi prodotti ripetuti');
            
            $(option).val('0');
            
        }
        
    }
     
</script>

