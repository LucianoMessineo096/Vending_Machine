<%-- 
    Document   : productsManagementComponent
    Created on : 5 nov 2022, 11:19:19
    Author     : luciano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="Products">
    <button type="button" class="btn btn-success my-3" data-bs-toggle="modal" data-bs-target="#addProductModal">Inserisci Prodotto</button>
    <table class="table table-striped">
       <thead>
         <tr>
           <th scope="col">ID PRODOTTO</th>
           <th scope="col">DESCRIZIONE</th>
           <th scope="col">PREZZO</th>
           <th scope="col">TIPOLOGIA</th>
           <th scope="col">ACTIONS</th>
         </tr>
       </thead>
       <tbody>

       </tbody>
    </table>

    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered">
       <div class="modal-content">
         <div class="modal-header">
           <h1 class="modal-title fs-5" id="addModalLabel">Aggiungi Prodotto</h1>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <div class="modal-body">
             <form>
                <div class="mb-3">
                  <label for="InputDescription" class="form-label">Descrizione</label>
                  <input type="text" class="form-control" id="description-field" aria-describedby="DescrHelp">
                </div>
                <div class="mb-3">
                  <label for="InputPrice" class="form-label">Prezzo</label>
                  <input type="number" class="form-control" id="price-field">
                </div>
                <div class="mb-3">
                  <label for="InputTypology" class="form-label">Tipologia</label>
                  <select class="form-select" id="addProductOptions" aria-label="Floating label select example">
                   <option value="coffe" >coffe</option>
                   <option value="snack">snack</option>
                   <option value="drink">drink</option>
                   <option value="water">water</option>
                  </select>
                </div>
              </form>
         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Chiudi</button>
           <button type="button" class="btn btn-primary" id="addProductSubmit">Salva</button>
         </div>
       </div>
     </div>
    </div>

    <div class="modal fade" id="updateProductModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered">
       <div class="modal-content">
         <div class="modal-header">
           <h1 class="modal-title fs-5" id="updateProductModal">Modifica Prodotto</h1>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <div class="modal-body" id="updateProductModalBody">

         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Chiudi</button>
           <button type="button" class="btn btn-primary" id="updateProductSubmit">Salva</button>
         </div>
       </div>
     </div>
   </div>

</div>
<script>
    
    $('body').on('click','#deleteProductBtn',(e)=>{

        deleteProduct(e);
    });

    $('body').on('click','#updateProductBtn',(e)=>{

        showUpdateProductPanel(e);
    });

    $('#addProductSubmit').click(()=>{

        addProduct();
    });

    $('#updateProductSubmit').click(()=>{

        updateProduct();
    });
    
    function showAllProducts(){
            
        clearInterface();

        const url='/SmartVendingMachine/ProductsManagement/getAll';

        $.get(url,(response)=>{

            if(response.success){

                $('#Products tbody').empty();

                response.products.forEach(product=>{

                console.log(product)

                let record = '<tr id='+product.id.toString()+'>'+'<td>'+product.id.toString()+'</td>'+
                                    '<td>'+product.name.toString()+'</td>'+
                                    '<td>€'+product.price.toString()+'</td>'+
                                    '<td>'+product.typology.toString()+'</td>'+
                                    '<td>'+
                                        '<button id="updateProductBtn" type="button" class="btn btn-outline-success mx-1" data-bs-toggle="modal" data-bs-target="#updateProductModal">'+
                                            '<i class="bi bi-pencil"></i>'+
                                        '</button>'+
                                        '<button id="deleteProductBtn" type="button" onclick="deleteProduct" class="btn btn-outline-danger mx-1">'+
                                            '<i class="bi bi-trash3-fill"></i>'+
                                        '</button>'+
                                    '</td>'+
                             '</tr>';

                $('#Products tbody').append(record);

                });

                $('#Products').css('display','block');
            }

        });
    }
        
    function showUpdateProductPanel(event){

        let parents = $(event.currentTarget).parents();
        const productId= parseInt(parents[1].id);

        const url="/SmartVendingMachine/ProductsManagement/getProduct";
        const data={

            productId:productId
        };
        
        $.get(url,data,(response)=>{

            const productId = response.productId;
            const name = response.name;
            const price = response.price;
            const typology = response.typology;

            $('#updateProductModalBody').empty();

            $('#updateProductModalBody').append(

                '<form id='+productId+'>'+
                 '<div class="mb-3">'+
                   '<label for="description" class="form-label">Descrizione</label>'+
                   '<input id="description-field" type="text" placeholder="inserisci descrizione" class="form-control" aria-describedby="descriptionHelp" value='+name+'>'+
                 '</div>'+
                 '<div class="mb-3">'+
                   '<label for="price" class="form-label">Prezzo</label>'+
                   '<input id="price-field" type="text" placeholder="inserisci prezzo" class="form-control" value='+price+'>'+
                 '</div>'+
                 '<div class="mb-3 d-flex flex-column">'+
                    '<label for="typology" class="form-label">Tipologia</label>'+
                    '<select class="form-select" id="updateProductOptions" aria-label="Floating label select example">'+
                     '<option value="coffe" >caffè</option>'+
                     '<option value="snack">snack</option>'+
                     '<option value="drink">drink</option>'+
                     '<option value="water">acqua</option>'+
                    '</select>'+
                 '</div>'+
               '</form>'       
            );

            setOptionDropdownProducts(typology);

        });

    }

    function setOptionDropdownProducts(typology){

        let option1= $('#updateProductOptions').children()[0].innerHTML;
        let option2= $('#updateProductOptions').children()[1].innerHTML;
        let option3= $('#updateProductOptions').children()[2].innerHTML;

        const options = [option1,option2,option3];

        options.forEach((option,index)=>{

            if(option===typology){

                let option = $('#updateProductOptions').children()[index];
                $(option).attr("selected","selected");
            }
        });

    }

    function updateProduct(){

        const data ={

            productId: $('#updateProductModalBody form').attr('id'),
            name: $('#updateProductModal .modal-body form #description-field').val(),
            price: $('#updateProductModal .modal-body form #price-field').val(),
            typology: $('#updateProductOptions option:selected').val()
        };

        const url='/SmartVendingMachine/ProductsManagement/updateProduct';
        
        $.post(url,data,(response)=>{

            if(response.success){

                showAllProducts();
            }

        });

    }

    function deleteProduct(event){

        let parents = $(event.currentTarget).parents();
        let productId= parseInt(parents[1].id);

        const url='/SmartVendingMachine/ProductsManagement/deleteProduct';
        const data={

            productId:productId
        };
        
        $.post(url,data,(response)=>{

            alert(response.message);
            
            showAllProducts();
        });

    }

    function addProduct(){

        const name = $('#addProductModal .modal-body #description-field').val();
        const price = $('#addProductModal .modal-body #price-field').val();
        const typology = $('#addProductOptions option:selected').val();

        const url='/SmartVendingMachine/ProductsManagement/addProduct';

        const data={

            name:name,
            price:price,
            typology:typology

        };

        $.post(url,data,(response)=>{

            if(response.success){

                showAllProducts();

                $('#addProductModal .modal-body #description-field').val('');
                $('#addProductModal .modal-body #price-field').val('');

            }

        });

    }
        
</script>

