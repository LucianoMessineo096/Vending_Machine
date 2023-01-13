/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Machine;
import Model.MachineServices;
import Model.Product;
import Model.ProductServices;
import Model.User;
import Utils.MachinesUtils;
import Utils.RequestUtils;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import static java.lang.Float.parseFloat;
import static java.lang.Integer.parseInt;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.Map;
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
@WebServlet(name = "MachinesManagement", urlPatterns = {"/MachinesManagement",
                                                        "/MachinesManagement/getAll",
                                                        "/MachinesManagement/getMachine",
                                                        "/MachinesManagement/updateMachine",
                                                        "/MachinesManagement/deleteMachine",
                                                        "/MachinesManagement/addMachine",
                                                        "/MachinesManagement/release",
                                                        "/MachinesManagement/connect"})
public class MachinesManagement extends HttpServlet {
    
    protected void connect(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException,NumberFormatException{
        
        JSONObject Jlocation = new JSONObject();
        MachineServices machineServices = new MachineServices();
        MachinesUtils utils = new MachinesUtils();
        
        request.setCharacterEncoding("UTF-8");
        /*RequestUtils ru = new RequestUtils();
        int machineId=ru.getParameters(request, "machineId");*/
        int machineId = Integer.parseInt(request.getParameter("machineId"));
        
        boolean occupied=utils.checkIfIsOccupied(machineId);
                
        if(occupied==false){
            
            machineServices.changeStatus(machineId,"occupied");
            Machine machine = machineServices.getMachine(machineId);
            
            HttpSession session = request.getSession(false);
            session.setAttribute("currentSessionMachine",machine);

            Jlocation.put("success", true);
            Jlocation.put("address", "/SmartVendingMachine/PurchasesManagement");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }
        else{
            
            Jlocation.put("success", false);
            Jlocation.put("message", "la macchinetta e' gia occupata, si prega di selezionarne una libera");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }

        
    
    }
    
    protected void getAllMachines(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException{
        
        MachinesUtils utils = new MachinesUtils();
        MachineServices machineServices = new MachineServices();
        JSONObject Jlocation = new JSONObject();

        ArrayList<Machine> machines = machineServices.getMachines();
   
        utils.checkMachinesStatus();
        
        machines= machineServices.getMachines();
        
        if(machines!=null){
            
            Jlocation.put("success", true);
            Jlocation.put("message", "macchinette ottenute");
            Jlocation.put("machines", machines); 
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);

        }else{
        
            Jlocation.put("success", false);
            Jlocation.put("message", "macchinette non ottenute");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);

        }

    }
   
    protected void getMachine(HttpServletRequest request, HttpServletResponse response) throws SQLException, UnsupportedEncodingException, IOException{
    
        MachineServices machineServices = new MachineServices();        
        JSONObject Jlocation = new JSONObject();
        
        request.setCharacterEncoding("UTF-8");
        int machineId = parseInt(request.getParameter("machineId"));
        
        Machine machine = machineServices.getMachine(machineId);
        String name = machine.getName();
        String status = machine.getStatus();
        int maxCapacity = machine.getMaxCapacity();
        int actualCapacity = machine.getActualCapacity();
        
        Jlocation.put("success", true);
        Jlocation.put("message", "macchinetta ottenuta");
        Jlocation.put("machineId", machineId); 
        Jlocation.put("name", name);
        Jlocation.put("status", status);
        Jlocation.put("maxCapacity", maxCapacity);
        Jlocation.put("actualCapacity", actualCapacity);
        String location = Jlocation.toString();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(location);
    
    }
    
    protected void updateMachine(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException{
    
        MachineServices machineServices = new MachineServices();
        JSONObject Jlocation = new JSONObject();
        
        request.setCharacterEncoding("UTF-8");
        int machineId = parseInt(request.getParameter("machineId"));
        String name = request.getParameter("name");
        String status = request.getParameter("status");
        Machine machine = machineServices.getMachine(machineId);
        boolean updated = machineServices.updateMachine(machineId, name, status);
        
        if(machine.getActualCapacity()!=0){
            
            if(updated){
        
                Jlocation.put("success", true);
                Jlocation.put("message", "macchinetta aggiornata");
                String location = Jlocation.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(location);
        
            }else{

                Jlocation.put("success", false);
                Jlocation.put("message", "macchinetta non aggiornata");
                String location = Jlocation.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(location);

            }
        
        }
        else{
        
            Jlocation.put("success", false);
            Jlocation.put("message", "la macchinetta deve prima essere ricaricata");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }

    }
    
    protected void deleteMachine(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException{
        
        MachineServices machineServices = new MachineServices();
        JSONObject Jlocation = new JSONObject();
        
        request.setCharacterEncoding("UTF-8");
        int machineId = parseInt(request.getParameter("machineId"));
               
        boolean deleted = machineServices.deleteMachine(machineId);
        
        if(deleted){
        
            Jlocation.put("success", true);
            Jlocation.put("message", "macchinetta eliminata");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        }
        else{
            
            Jlocation.put("success", false);
            Jlocation.put("message", "macchinetta non eliminata");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
 
        }

    }
    
    protected void addMachine(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException{
    
        MachineServices machineServices = new MachineServices();
        JSONObject Jlocation = new JSONObject();

        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        
        boolean added = machineServices.addMachine(name);
        
        if(added){
        
            Jlocation.put("success", true);
            Jlocation.put("message", "macchinetta aggiunta");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);

        }
        else{
            
            Jlocation.put("success", false);
            Jlocation.put("message", "macchinetta non aggiunta");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }
    }
    
    protected void release(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException{
        
        HttpSession session = request.getSession(false);
        Machine machine = (Machine) session.getAttribute("currentSessionMachine");
        MachineServices machineServices = new MachineServices();
        JSONObject Jlocation = new JSONObject();
        
        request.setCharacterEncoding("UTF-8");
        int machineId = Integer.parseInt(request.getParameter("machineId"));
        
        String status = machineServices.getStatus(machineId);
        
        if(!"disabled".equals(status)){
                        
            boolean changed = machineServices.changeStatus(machine.getId(),"free");
        
            if(changed){

                Jlocation.put("success", true);
                Jlocation.put("message", "macchinetta liberata");
                String location = Jlocation.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(location);

            }
            else{
                Jlocation.put("success", false);
                Jlocation.put("message", "macchinetta non liberata");
                String location = Jlocation.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(location);
            }
        
        }else{
            
            System.out.println("RELEASE else");
            
            machineServices.changeStatus(machine.getId(),"disabled");
        
            Jlocation.put("success", true);
            Jlocation.put("message", "macchinetta liberata");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        }
        
        session.removeAttribute("currentSessionMachine");
        
    }
    
    //-------------------------------------------------------------------------

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, UnsupportedEncodingException {
        
        String uri = request.getRequestURI();

        switch(uri){
        
            case "/SmartVendingMachine/MachinesManagement/getAll":
                
            {
                try {
                    getAllMachines(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(MachinesManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                
                break;

            case "/SmartVendingMachine/MachinesManagement/getMachine":
                
            {
                try {
                    getMachine(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(MachinesManagement.class.getName()).log(Level.SEVERE, null, ex);
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
            
            case "/SmartVendingMachine/MachinesManagement/updateMachine":
                
            {
                try {
                    updateMachine(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(MachinesManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                
                break;

            case "/SmartVendingMachine/MachinesManagement/deleteMachine":
                
            {
                try {
                    deleteMachine(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(MachinesManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                
                break;

            case "/SmartVendingMachine/MachinesManagement/addMachine":
                
            {
                try {
                    addMachine(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(MachinesManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                
                break;

            case "/SmartVendingMachine/MachinesManagement/release":
                
            {
                try {
                    release(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(MachinesManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                
                break;
            
            case "/SmartVendingMachine/MachinesManagement/connect":
                
            {
                try {
                    connect(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(MachinesManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                
                break;

        
        }
    }
    
}
