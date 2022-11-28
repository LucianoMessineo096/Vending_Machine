/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Machine;
import Model.MachineServices;
import Model.MovementServices;
import Model.Product;
import Model.ProductServices;
import Model.Purchase;
import Model.PurchaseServices;
import Model.Refill;
import Model.RefillServices;
import Model.User;
import Model.UserServices;
import Utils.JSON;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import static java.lang.Integer.parseInt;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

/**
 *
 * @author luciano
 */
@WebServlet(name = "PurchasesManagement", urlPatterns = {"/PurchasesManagement",
                                                         "/PurchasesManagement/doPurchase",
                                                         "/PurchasesManagement/getAllPurchases"})
public class PurchasesManagement extends HttpServlet {
    
    
    //--------Utils---------------------------//
    
    protected boolean checkQuantity(Product product,Refill refill,Machine machine){
        
        boolean check=true;
        
        HashMap<Integer,Integer> machineProducts = new HashMap<Integer,Integer>();
        
        if(refill.getProd1Id()!=0){
            machineProducts.put(refill.getProd1Id(),refill.getProd1Quantity());
        }
        
        if(refill.getProd2Id()!=0){
            
            machineProducts.put(refill.getProd2Id(),refill.getProd2Quantity());
        }
        
        if(refill.getProd3Id()!=0){
            
            machineProducts.put(refill.getProd3Id(),refill.getProd3Quantity());
        }
        
        if(refill.getProd4Id()!=0){
            
            machineProducts.put(refill.getProd4Id(),refill.getProd4Quantity());
        
        }

        for(HashMap.Entry<Integer,Integer> prod : machineProducts.entrySet()){
           
            if(prod.getKey()==product.getId()){

                if(prod.getValue()==0){
                    
                    check=false;
                
                } 
            }

        }
    
        return check;
    }
    
    protected HashMap<Integer,Integer> updateQuantity(Product product,Refill refill,Machine machine){
    
        int updatedQuantity;
        
        HashMap<Integer,Integer> machineProducts = new HashMap<Integer,Integer>();
        
        if(refill.getProd1Id()!=0){
            machineProducts.put(refill.getProd1Id(),refill.getProd1Quantity());
        }
        
        if(refill.getProd2Id()!=0){
            
            machineProducts.put(refill.getProd2Id(),refill.getProd2Quantity());
        }
        
        if(refill.getProd3Id()!=0){
            
            machineProducts.put(refill.getProd3Id(),refill.getProd3Quantity());
        }
        
        if(refill.getProd4Id()!=0){
            
            machineProducts.put(refill.getProd4Id(),refill.getProd4Quantity());
        
        }
          
        for(HashMap.Entry<Integer,Integer> prod : machineProducts.entrySet()){
                       
            if(prod.getKey()==product.getId()){

                updatedQuantity = prod.getValue() - 1;
                prod.setValue(updatedQuantity);
            }

        }

        return machineProducts;

    }
    
    protected int calculateNewCapacity(HashMap<Integer,Integer> machineProducts){
    
        int newActualCapacity=0;
        
        for(HashMap.Entry<Integer,Integer> prod : machineProducts.entrySet()){
           
            newActualCapacity+=prod.getValue();

        }
        
        return newActualCapacity;
        
    
    }
    
    protected void doPurchase(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, IOException, SQLException{
    
        PurchaseServices purchaseService = new PurchaseServices();
        ProductServices productService = new ProductServices();
        UserServices userService = new UserServices();
        MovementServices movementServices = new MovementServices();
        MachineServices machineServices = new MachineServices();
        RefillServices refillServices = new RefillServices();
        JSONObject Jlocation = new JSONObject();
        
        request.setCharacterEncoding("UTF-8");
        int productId = parseInt(request.getParameter("productId"));
        int userId = parseInt(request.getParameter("userId"));
        int machineId = parseInt(request.getParameter("machineId"));
        
        Product product = productService.getProduct(productId);
        User user = userService.getUser(userId);
        Machine machine = machineServices.getMachine(machineId);
        Refill refill = refillServices.getRefill(machineId);
        
        boolean checkQuantity = checkQuantity(product,refill,machine);
                
        if(checkQuantity){
        
            float price = product.getPrice();
            float balance = user.getWalletBalance();

            if(price<balance){

                float newBalance= balance-price;
                boolean updatedBalance = userService.updateBalance(userId, newBalance);

                if(updatedBalance){

                    //get the date and time 
                    LocalDateTime date = LocalDateTime.now();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
                    String formattedDate = date.format(formatter);

                    purchaseService.addPurchase(userId,productId,machineId,formattedDate,price);
                    movementServices.addMovement(userId, price, formattedDate, "purchase");

                    HashMap<Integer,Integer> machineProducts = updateQuantity(product,refill,machine);
                    boolean updated=refillServices.updateRefill(machineId,machineProducts);
                    
                    int newActualCapacity = calculateNewCapacity(machineProducts);
                    machineServices.updateMachine(machineId, newActualCapacity);

                    Jlocation.put("success", true);
                    Jlocation.put("address", "/SmartVendingMachine/UsersManagement/personalPage");
                    Jlocation.put("message", "Acquisto effettuato");
                    String location = Jlocation.toString();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                }
                else{

                    Jlocation.put("success", false);
                    Jlocation.put("message", "Errore durante l'aggiornamento del saldo,si prega di riprovare");
                    String location = Jlocation.toString();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                }

            }else{

                //no purchase

                Jlocation.put("success", false);
                Jlocation.put("message", "Saldo wallet non sufficente, ricarica!!");
                String location = Jlocation.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(location);


            }
        
        }
        else{
        
            Jlocation.put("success", false);
            Jlocation.put("message", "attenzione la quantita di prodotto selezionato non e' sufficente!!");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);

        }

    }
    
    protected void getAllPurchases(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException{
        
        PurchaseServices purchaseService = new PurchaseServices();
        ProductServices productServices = new ProductServices();
        JSONObject Jlocation = new JSONObject();
        
        request.setCharacterEncoding("UTF-8");
        int userId = parseInt(request.getParameter("userId"));
        
        ArrayList<Purchase> purchases = purchaseService.getPurchases(userId);
        ArrayList<Product> products = new ArrayList<>();
        
        for(Purchase purchase : purchases){
           
            Product product = productServices.getProduct(purchase.getProductId());
            
            products.add(product);

        }
        
        Jlocation.put("success", true);
        Jlocation.put("purchases", purchases);
        Jlocation.put("products", products);
        Jlocation.put("message", "Acquisti ottenuti");
        String location = Jlocation.toString();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(location);
    
    }
    

    //-------------Main-------------//

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, UnsupportedEncodingException {
        
        String uri = request.getRequestURI();
        
        switch(uri){
        
            case "/SmartVendingMachine/PurchasesManagement":
                
                request.getRequestDispatcher("/View/purchasePage.jsp").forward(request, response);

                break;
                
            case "/SmartVendingMachine/PurchasesManagement/getAllPurchases":
                
            {
                try {
                    getAllPurchases(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(PurchasesManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                
                break;

        
        
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, UnsupportedEncodingException {
        
        String uri=  request.getRequestURI();
        
        switch(uri){
        
            case "/SmartVendingMachine/PurchasesManagement/doPurchase":
                
            {
                try {
                    doPurchase(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(PurchasesManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                
                break;

        
        
        
        }
    }


}
