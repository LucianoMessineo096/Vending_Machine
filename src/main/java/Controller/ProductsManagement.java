/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Machine;
import Model.MachineServices;
import Model.Product;
import Model.ProductServices;
import Model.Refill;
import Model.RefillServices;
import Utils.ProductsUtils;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import static java.lang.Float.parseFloat;
import static java.lang.Integer.parseInt;
import java.lang.reflect.Field;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

/**
 *
 * @author luciano
 */
@WebServlet(name = "ProductsManagement", urlPatterns = {"/ProductsManagement",
                                                        "/ProductsManagement/getProduct",
                                                        "/ProductsManagement/getMachineProducts",
                                                        "/ProductsManagement/getAll",
                                                        "/ProductsManagement/addProduct",
                                                        "/ProductsManagement/deleteProduct",
                                                        "/ProductsManagement/updateProduct"})
public class ProductsManagement extends HttpServlet {
    
    protected void getMachineProducts(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException{
        
        RefillServices refillServices = new RefillServices();
        ProductServices productServices = new ProductServices();
        ArrayList<Product> products = new ArrayList<>();
        JSONObject Jlocation = new JSONObject();
        
        request.setCharacterEncoding("UTF-8");
        int machineId = parseInt(request.getParameter("machineId"));
        
        Refill refill = refillServices.getRefill(machineId);
        Product prod1 = productServices.getProduct(refill.getProd1Id());
        Product prod2 = productServices.getProduct(refill.getProd2Id());
        Product prod3 = productServices.getProduct(refill.getProd3Id());
        Product prod4 = productServices.getProduct(refill.getProd4Id());
        
        products.add(prod1);
        products.add(prod2);
        products.add(prod3);
        products.add(prod4);
        
        if(products!=null){
            
            HashMap<String,Integer> prodQuantity = new HashMap<>();
            prodQuantity.put("prod1Id", refill.getProd1Id());
            prodQuantity.put("prod1Quantity", refill.getProd1Quantity());
            prodQuantity.put("prod2Id", refill.getProd2Id());
            prodQuantity.put("prod2Quantity", refill.getProd2Quantity());
            prodQuantity.put("prod3Id", refill.getProd3Id());
            prodQuantity.put("prod3Quantity", refill.getProd3Quantity());
            prodQuantity.put("prod4Id", refill.getProd4Id());
            prodQuantity.put("prod4Quantity", refill.getProd4Quantity());

            Jlocation.put("success", true);
            Jlocation.put("products", products);
            Jlocation.put("quantities", prodQuantity);
            Jlocation.put("message", "prodotti ottenuti");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }
        else{
            
            Jlocation.put("success", false);
            Jlocation.put("message", "prodotti non ottenuti");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }
        
    
    }
    
    protected void getProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException,UnsupportedEncodingException, IOException{
        
        try{
            
            ProductServices productServices = new ProductServices();        
            JSONObject Jlocation = new JSONObject();

            request.setCharacterEncoding("UTF-8");
            int productId = Integer.parseInt(request.getParameter("productId"));

            Product product = productServices.getProduct(productId);

            if(product.getId()!=0 && product!=null){

                String name = product.getName();
                float price = product.getPrice();
                String typology = product.getTypology();

                Jlocation.put("success", true);
                Jlocation.put("message", "Prodotto ottenuto");
                Jlocation.put("productId", product.getId()); 
                Jlocation.put("name", name);
                Jlocation.put("price", price);
                Jlocation.put("typology", typology);
                String location = Jlocation.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(location);

            }
            else{

                Jlocation.put("success", false);
                Jlocation.put("message", "Prodotto non ottenuto");
                String location = Jlocation.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(location);

            }

        }catch(NumberFormatException e){
            
            System.err.println(e);
        
        }

    }
    
    protected void getAllProducts(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException{
    
        ProductServices productServices = new ProductServices();
        JSONObject Jlocation = new JSONObject();
        
        ArrayList<Product> products = productServices.getAllProducts();
        
        if(products!=null){
            
            Jlocation.put("success", true);
            Jlocation.put("products", products);
            Jlocation.put("message", "prodotti ottenuti");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }
        else{
        
            Jlocation.put("success", false);
            Jlocation.put("message", "prodotti non ottenuti");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }
        
    
    }
    
    protected void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException, IllegalArgumentException, IllegalAccessException{
        
        ProductsUtils utils = new ProductsUtils();
        ProductServices productServices = new ProductServices();
        RefillServices refillServices = new RefillServices();
        MachineServices machineServices = new MachineServices();
        JSONObject Jlocation = new JSONObject();

        request.setCharacterEncoding("UTF-8");
        int productId = parseInt(request.getParameter("productId"));
        
        ArrayList<Refill> refills = refillServices.getAllRefills();
        
        if(refills!=null){
            
            HashMap<Refill,Integer> columnsIndex = utils.getProductColumnsIndex(refills, productId);
        
            for(HashMap.Entry<Refill,Integer> refill : columnsIndex.entrySet()){

                //set 0 the specified product quantity
                refillServices.updateRefill(refill.getValue(),productId);

                //update machine capacity
                Refill machineRefill = refillServices.getRefill(refill.getKey().getMachId());

                int newActualCapacity = machineRefill.getProd1Quantity()+machineRefill.getProd2Quantity()+machineRefill.getProd3Quantity()+machineRefill.getProd4Quantity();

                machineServices.updateMachine(refill.getKey().getMachId(), newActualCapacity);

            }

            boolean deleted = productServices.deleteProduct(productId);

            if(deleted){

                Jlocation.put("success", true);
                Jlocation.put("message", "prodotto eliminato");
                String location = Jlocation.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(location);
            }
            else{

                Jlocation.put("success", false);
                Jlocation.put("message", "prodotto non eliminato");
                String location = Jlocation.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(location);

            }
        
        }else{
        
            Jlocation.put("success", false);
            Jlocation.put("message", "errore durante la fase di eliminazione del prodotto; Refill non presente");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }
        

    }
    
    protected void addProduct(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException{
    
        ProductServices productServices = new ProductServices();
        JSONObject Jlocation = new JSONObject();

        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        Float price = parseFloat(request.getParameter("price"));
        String typology = request.getParameter("typology");
        
        boolean added = productServices.addProduct(name, price, typology);
        
        if(added){
        
            Jlocation.put("success", true);
            Jlocation.put("message", "prodotto aggiunto");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);

        }
        else{
            
            Jlocation.put("success", false);
            Jlocation.put("message", "prodotto non aggiunto");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }
    }
    
    protected void updateProduct(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException{
    
        ProductServices productServices = new ProductServices();
        JSONObject Jlocation = new JSONObject();
        
        request.setCharacterEncoding("UTF-8");
        int productId = parseInt(request.getParameter("productId"));
        String name = request.getParameter("name");
        float price = parseFloat(request.getParameter("price"));
        String typology = request.getParameter("typology");
        
        boolean updated = productServices.updateProduct(productId, name, price, typology);
        
        if(updated){
        
            Jlocation.put("success", true);
            Jlocation.put("message", "prodotto aggiornato");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }else{
        
            Jlocation.put("success", false);
            Jlocation.put("message", "prodotto non aggiornato");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        
        }
    }
    
    //-------------------------------------------------------------------------

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, UnsupportedEncodingException {
        
        String uri = request.getRequestURI();
        
        switch(uri){
        
               
            case "/SmartVendingMachine/ProductsManagement/getAll":
                
            {
                try {
                    getAllProducts(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(ProductsManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                     
            case "/SmartVendingMachine/ProductsManagement/getProduct":
                
            {
                try {
                    getProduct(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(ProductsManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                
                break;
                
            case "/SmartVendingMachine/ProductsManagement/getMachineProducts":
                
            {
                try {
                    getMachineProducts(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(ProductsManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                
                break;


        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, UnsupportedEncodingException {
        
        String uri = request.getRequestURI();
        
        switch(uri){
        
            case "/SmartVendingMachine/ProductsManagement/deleteProduct":
                
                
            {
                try {
                    deleteProduct(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(ProductsManagement.class.getName()).log(Level.SEVERE, null, ex);
                } catch (IllegalArgumentException ex) {
                    Logger.getLogger(ProductsManagement.class.getName()).log(Level.SEVERE, null, ex);
                } catch (IllegalAccessException ex) {
                    Logger.getLogger(ProductsManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                break;

            case "/SmartVendingMachine/ProductsManagement/addProduct":
                
            {
                try {
                    addProduct(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(ProductsManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                
                break;
            
            case "/SmartVendingMachine/ProductsManagement/updateProduct":
                
            {
                try {
                    updateProduct(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(ProductsManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                break;

        }
    }

}
