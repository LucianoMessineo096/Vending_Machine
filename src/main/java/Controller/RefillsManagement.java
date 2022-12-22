/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Machine;
import Model.MachineServices;
import Model.Refill;
import Model.RefillServices;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import static java.lang.Integer.parseInt;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
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
@WebServlet(name = "RefillsManagement", urlPatterns = {"/RefillsManagement","/RefillsManagement/addRefill","/RefillsManagement/getRefill"})
public class RefillsManagement extends HttpServlet {
    
    /*************************************************************************/
    protected void getRefill(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException{
        
        RefillServices refillServices = new RefillServices();
        JSONObject Jlocation = new JSONObject();
        
        request.setCharacterEncoding("UTF-8");
        int machineId = parseInt(request.getParameter("machineId"));
        
        Refill refill = refillServices.getRefill(machineId);
        
        if(refill!=null){
            
            Jlocation.put("success", true);
            Jlocation.put("message", "rifornimento ottenuto");
            Jlocation.put("prod1Id", refill.getProd1Id());
            Jlocation.put("prod1Quantity", refill.getProd1Quantity());
            Jlocation.put("prod2Id", refill.getProd2Id());
            Jlocation.put("prod2Quantity", refill.getProd2Quantity());
            Jlocation.put("prod3Id", refill.getProd3Id());
            Jlocation.put("prod3Quantity", refill.getProd3Quantity());
            Jlocation.put("prod4Id", refill.getProd4Id());
            Jlocation.put("prod4Quantity", refill.getProd4Quantity());
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }
        else{
            
            Jlocation.put("success", false);
            Jlocation.put("message", "rifornimento non ottenuto");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }
    
    }
    
    protected ArrayList<Integer> updateQuantity(Refill refill,Integer[] insertedQuantities){
        
       HashMap<String,Integer> quantities = new HashMap<String,Integer>();
       ArrayList<Integer> newQuantities=new ArrayList<>();
       
       int count=0;
       
       quantities.put("prod1Quantity", refill.getProd1Quantity());
       quantities.put("prod2Quantity", refill.getProd2Quantity());
       quantities.put("prod3Quantity", refill.getProd3Quantity());
       quantities.put("prod4Quantity", refill.getProd4Quantity());
       
       for(HashMap.Entry<String,Integer> quantity : quantities.entrySet()){
           
           int actualQuantity = quantity.getValue();
           int insertedQuantity = insertedQuantities[count];
       
           if(actualQuantity<insertedQuantity){
               
               int toAdd= insertedQuantity - actualQuantity;
               int newQuantity = actualQuantity + toAdd;
               newQuantities.add(newQuantity);
           
           }
           else if(actualQuantity>insertedQuantity){
               int toAdd= actualQuantity - insertedQuantity;
               int newQuantity = actualQuantity + toAdd;
               newQuantities.add(newQuantity);
           }
           else{
           
               newQuantities.add(insertedQuantity);
           }
           
       }
       
       return newQuantities;

    }
   
    protected void addRefill(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException{
    
        RefillServices refillServices = new RefillServices();
        MachineServices machineServices = new MachineServices();
        JSONObject Jlocation = new JSONObject();
        
        request.setCharacterEncoding("UTF-8");
        int machineId = parseInt(request.getParameter("machineId"));
        int techId = parseInt(request.getParameter("techId"));
        int prod1Id = parseInt(request.getParameter("prod1Id"));
        int prod1Quantity = parseInt(request.getParameter("prod1Quantity"));
        int prod2Id = parseInt(request.getParameter("prod2Id"));
        int prod2Quantity = parseInt(request.getParameter("prod2Quantity"));
        int prod3Id = parseInt(request.getParameter("prod3Id"));
        int prod3Quantity = parseInt(request.getParameter("prod3Quantity"));
        int prod4Id = parseInt(request.getParameter("prod4Id"));
        int prod4Quantity = parseInt(request.getParameter("prod4Quantity"));
        
        Integer[] insertedQuantities={prod1Quantity,prod2Quantity,prod3Quantity,prod4Quantity};
        
        Machine machine = machineServices.getMachine(machineId);
        int maxCapacity = machine.getMaxCapacity();
        int actualCapacity = machine.getActualCapacity();
        
        if(actualCapacity<maxCapacity){
            
            Refill refill = refillServices.getRefill(machineId);
            boolean machineHasBeenRefilled = refillServices.checkIfMachineHasBeenRefilled(machineId);
            
            if(machineHasBeenRefilled){
            
                ArrayList<Integer> newQuantities = updateQuantity(refill,insertedQuantities);
            
                prod1Quantity = newQuantities.get(0);
                prod2Quantity = newQuantities.get(1);    
                prod3Quantity = newQuantities.get(2);
                prod4Quantity = newQuantities.get(3);
                
                boolean updated = refillServices.updateRefill(machineId, 
                                                            techId, 
                                                            prod1Id, prod1Quantity, 
                                                            prod2Id, prod2Quantity, 
                                                            prod3Id, prod3Quantity, 
                                                            prod4Id, prod4Quantity);
                
                int newActualCapacity = prod1Quantity + prod2Quantity + prod3Quantity + prod4Quantity;
                boolean actualQuantityUpdated = machineServices.updateMachine(machineId,newActualCapacity);
                
                if(updated && actualQuantityUpdated){
                
                    Jlocation.put("success", true);
                    Jlocation.put("message", "rifornimento effettuato");
                    String location = Jlocation.toString();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);


                }
                else{

                    Jlocation.put("success", false);
                    Jlocation.put("message", "rifornimento non effettuato");
                    String location = Jlocation.toString();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);

                }
           
            }
            else{
                
                boolean refilled = refillServices.addRefill(machineId, 
                                                     techId, 
                                                     prod1Id, prod1Quantity, 
                                                     prod2Id, prod2Quantity, 
                                                     prod3Id, prod3Quantity, 
                                                     prod4Id, prod4Quantity);
                
                int newActualCapacity = prod1Quantity + prod2Quantity + prod3Quantity + prod4Quantity;
                boolean actualQuantityUpdated = machineServices.updateMachine(machineId,newActualCapacity);
                
                
                if(refilled && actualQuantityUpdated){
                
                    Jlocation.put("success", true);
                    Jlocation.put("message", "rifornimento effettuato");
                    String location = Jlocation.toString();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);


                }
                else{

                    Jlocation.put("success", false);
                    Jlocation.put("message", "rifornimento non effettuato");
                    String location = Jlocation.toString();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);

                }
            
            }
            
        }else{
        
            Jlocation.put("success", false);
            Jlocation.put("message", "attenzione la macchinetta ha raggiunto la capacità massima, non è possibile inserire altri prodotti");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }
        

    }

    /*************************************************************************/

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, UnsupportedEncodingException {
        
        String uri = request.getRequestURI();
        
        switch(uri){
        
            case "/SmartVendingMachine/RefillsManagement/getRefill":
                
            {
                try {
                    getRefill(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(RefillsManagement.class.getName()).log(Level.SEVERE, null, ex);
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
        
            case "/SmartVendingMachine/RefillsManagement/addRefill":
                
            {
                try {
                    addRefill(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(RefillsManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                
                break;

        
        
        }
    }


}
