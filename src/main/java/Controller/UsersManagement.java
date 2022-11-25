/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Machine;
import Model.MachineServices;
import Model.Movement;
import Model.MovementServices;
import Model.User;
import Model.UserServices;
import Security.PasswordEncryption;
import Utils.JSON;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.awt.print.Book;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import static java.lang.Float.parseFloat;
import static java.lang.Integer.parseInt;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;
import org.json.JSONObject;

/**
 *
 * @author luciano
 */
@WebServlet(name = "UsersManagement", urlPatterns = {"/UsersManagement",
                                                     "/UsersManagement/personalPage",
                                                     "/UsersManagement/add",
                                                     "/UsersManagement/getUser",
                                                     "/UsersManagement/getUpdatedUser",
                                                     "/UsersManagement/deleteUser",
                                                     "/UsersManagement/updateUser",
                                                     "/UsersManagement/updatePersonalData",
                                                     "/UsersManagement/getAllUsers",
                                                     "/UsersManagement/Wallet/getWallet",
                                                     "/UsersManagement/Wallet/getRecharges",
                                                     "/UsersManagement/Wallet/updateBalance"})
public class UsersManagement extends HttpServlet {

   //--------------Utils Functions------------------------//
    
    protected void updatePersonalData(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException, NoSuchAlgorithmException{
    
        UserServices userServices = new UserServices();
        PasswordEncryption passwordEncryption = new PasswordEncryption();
        JSONObject Jlocation = new JSONObject();

        request.setCharacterEncoding("UTF-8");
        int userId = parseInt(request.getParameter("userId"));
        String newName = request.getParameter("newName");
        String newSurname = request.getParameter("newSurname");
        String newEmail = request.getParameter("newEmail");
        String newPassword = request.getParameter("newPassword");
        
        String encryptedPassword = passwordEncryption.cypher(newPassword);

        boolean updated= userServices.updatePersonalData(userId, newName, newSurname, newEmail, encryptedPassword);

        if(updated){
         
            Jlocation.put("success", true);
            Jlocation.put("message", "dati personali aggiornati");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }else{
        
            Jlocation.put("success", false);
            Jlocation.put("message", "dati personali non aggiornati");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        
        }
    }
    
    protected void updateUser(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException{
    
        UserServices userServices = new UserServices();
        JSONObject Jlocation = new JSONObject();
        
        request.setCharacterEncoding("UTF-8");
        int userId = parseInt(request.getParameter("userId"));
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String type = request.getParameter("type");

        boolean updated = userServices.updateUser(userId, email, name, surname, type);
        
        if(updated){
        
            Jlocation.put("success", true);
            Jlocation.put("message", "utente aggiornato");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }else{
        
            Jlocation.put("success", false);
            Jlocation.put("message", "utente non aggiornato");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        
        }
        
    }
    
    protected void deleteUser(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException,NumberFormatException{
        
        try{
            
            UserServices userService = new UserServices();
            JSONObject Jlocation = new JSONObject();
            
            request.setCharacterEncoding("UTF-8");
            int userId = parseInt(request.getParameter("userId"));

            boolean deleted = userService.deleteUser(userId);

            if(deleted){


                Jlocation.put("success", true);
                Jlocation.put("message", "utente eliminato");
                String location = Jlocation.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(location);

            }else{

                Jlocation.put("success", false);
                Jlocation.put("message", "utente non eliminato");
                String location = Jlocation.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(location);

            }

        }catch(NumberFormatException e){
            
            System.err.println(e);
        
        }
        
        
        
    }
    
    protected void updateBalance(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException{
        
        UserServices userServices = new UserServices();
        MovementServices movementServices = new MovementServices();
        JSONObject Jlocation = new JSONObject();
        
        request.setCharacterEncoding("UTF-8");
        int userId = parseInt(request.getParameter("userId"));
        float rechargeValue = parseFloat(request.getParameter("rechargeValue"));
        User user = userServices.getUser(userId);
        float walletBalance = user.getWalletBalance();
        
        float newBalance = walletBalance + rechargeValue;
        
        boolean updated = userServices.updateWallet(userId,newBalance);
        
        if(updated){
            
            //get the date and time 
            LocalDateTime date = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
            String formattedDate = date.format(formatter);
            
            movementServices.addMovement(userId, rechargeValue, formattedDate,"recharge");

            Jlocation.put("success", true);
            Jlocation.put("message", "saldo wallet aggiornato");
            Jlocation.put("walletBalance", newBalance); 
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }
        else{
        
            Jlocation.put("success", false);
            Jlocation.put("message", "saldo wallet non aggiornato");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        
        }
    
    }
    
    protected void getWallet(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException{
        
        UserServices userServices = new UserServices();
        JSONObject Jlocation = new JSONObject();

        request.setCharacterEncoding("UTF-8");
        int userId = parseInt(request.getParameter("userId"));
        
        User user = userServices.getUser(userId);
        float walletBalance= user.getWalletBalance();
        
        Jlocation.put("success", true);
        Jlocation.put("message", "saldo wallet ottenuto");
        Jlocation.put("walletBalance", walletBalance); 
        String location = Jlocation.toString();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(location);
        
        
    }
    
    protected void getUser(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException{
    
        UserServices userServices = new UserServices();
        JSONObject Jlocation = new JSONObject();
        
        request.setCharacterEncoding("UTF-8");
        int userId = parseInt(request.getParameter("userId"));
        
        User user = userServices.getUser(userId);
        String email = user.getEmail();
        String password = user.getPassword();
        String name = user.getName();
        String surname = user.getSurname();
        String type = user.getType();
        float walletBalance = user.getWalletBalance();
        
        Jlocation.put("success", true);
        Jlocation.put("message", "Utente ottenuto");
        Jlocation.put("userId", userId); 
        Jlocation.put("email", email);
        Jlocation.put("password", password);
        Jlocation.put("name", name);
        Jlocation.put("surname", surname);
        Jlocation.put("type", type);
        Jlocation.put("walletBalance", walletBalance);
        String location = Jlocation.toString();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(location);
    }
    
    protected void getUpdatedUser(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException{
        
        UserServices userServices = new UserServices();
        JSONObject Jlocation = new JSONObject();
        
        request.setCharacterEncoding("UTF-8");
        int userId = parseInt(request.getParameter("userId"));

        User user = userServices.getUser(userId);
        
        HttpSession session = request.getSession(false);
        session.removeAttribute("currentSessionUser");
        session.setAttribute("currentSessionUser",user);

        Jlocation.put("success", true);
        Jlocation.put("message", "Utente ottenuto");
        String location = Jlocation.toString();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(location);
    
    }
    
    protected void getAllUsers(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException{
        
        UserServices userService = new UserServices();
        JSONObject Jlocation = new JSONObject();
        
        ArrayList<User> users = userService.getUsers();
        
        Jlocation.put("success", true);
        Jlocation.put("message", "Utenti ottenuti");
        Jlocation.put("users", users); 
        String location = Jlocation.toString();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(location);
    
    }
    
    protected void addNewUser(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException, NoSuchAlgorithmException{
    
        JSONObject Jlocation = new JSONObject();
        UserServices userServices = new UserServices();
        PasswordEncryption passwordEncryption = new PasswordEncryption();
        
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");

        boolean userExist = userServices.checkIfUserAlreadyExists(email);
        
        if(!userExist){

            String encryptedPassword = passwordEncryption.cypher(password);
        
            boolean inserted = userServices.addUser(email, encryptedPassword, name, surname);
        
            if(inserted){

                User user = userServices.getUser(email, password);

                Jlocation.put("success", true);
                Jlocation.put("address", "/SmartVendingMachine/"); 
                Jlocation.put("message", "utente registrato correttamente");
                Jlocation.put("user", user);
                String location = Jlocation.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(location);
            }
            else{

                Jlocation.put("success", false);
                Jlocation.put("message", "errore durante la registrazione");
                String location = Jlocation.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(location);


            }

        }
        else{
            
            Jlocation.put("success", false);
            Jlocation.put("message", "attenzione l'email inserita risulta associata ad un altro account,inserire una nuova mail");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
            
        }

    }
   
    protected void getMovements(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException{
            
        JSONObject Jlocation = new JSONObject();
        MovementServices movementServices = new MovementServices();
        
        request.setCharacterEncoding("UTF-8");
        int userId = parseInt(request.getParameter("userId"));
        
        ArrayList<Movement> movements = movementServices.getMovements(userId);
        
        if(movements!=null){
        
            Jlocation.put("success", true);
            Jlocation.put("message", "movimenti ottenuti");
            Jlocation.put("movements", movements); 
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }
        else{
        
            Jlocation.put("success", false);
            Jlocation.put("message", "movimenti non ottenuti");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }
        
    }
    
    //--------------Main Functions------------------------//
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, UnsupportedEncodingException {
        
        String uri = request.getRequestURI();
        
        switch(uri){
            
            case "/SmartVendingMachine/UsersManagement":
                
                
                request.getRequestDispatcher("index.jsp").forward(request, response);
                break;
            
            case "/SmartVendingMachine/UsersManagement/registration":
                
                request.getRequestDispatcher("/View/registrationPage.jsp").forward(request, response);
                
                break;
            
            case "/SmartVendingMachine/UsersManagement/personalPage":
                
                try{
                    
                    MachineServices machineServices = new MachineServices();
        
                    HttpSession session = request.getSession(false);
                    Machine machine = (Machine) session.getAttribute("currentSessionMachine");

                    if(machine!=null){

                        int machineId = machine.getId();
                        machineServices.changeStatus(machineId,"free");
                        session.removeAttribute("currentSessionMachine");

                    }

                    request.getRequestDispatcher("/View/personalPage.jsp").forward(request, response);

                }catch(SQLException e){
                    
                }
                
                
                break;
  
            case "/SmartVendingMachine/UsersManagement/getUser":
                
            {
                try {
                    getUser(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(UsersManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                break;
                
            case "/SmartVendingMachine/UsersManagement/getUpdatedUser":
                
            {
                try {
                    getUpdatedUser(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(UsersManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                
                break;

                
            case "/SmartVendingMachine/UsersManagement/getAllUsers":
                
            {
                try {
                    getAllUsers(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(UsersManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                
                break;


            case "/SmartVendingMachine/UsersManagement/Wallet/getWallet":
                
            {
                try {
                    getWallet(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(UsersManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                break;

            case "/SmartVendingMachine/UsersManagement/Wallet/getRecharges":
                
            {
                try {
                    getMovements(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(UsersManagement.class.getName()).log(Level.SEVERE, null, ex);
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
        
            case "/SmartVendingMachine/UsersManagement/add":
                
            {
                try {
                    addNewUser(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(UsersManagement.class.getName()).log(Level.SEVERE, null, ex);
                } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(UsersManagement.class.getName()).log(Level.SEVERE, null, ex);
            }
            }
                
                break;
                
            case "/SmartVendingMachine/UsersManagement/Wallet/updateBalance":
                
            {
            try {
                updateBalance(request,response);
            } catch (SQLException ex) {
                Logger.getLogger(UsersManagement.class.getName()).log(Level.SEVERE, null, ex);
            }
            }
                break;

            case "/SmartVendingMachine/UsersManagement/deleteUser":
                
            {
                try {
                    deleteUser(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(UsersManagement.class.getName()).log(Level.SEVERE, null, ex);
                }catch(NumberFormatException ne){
                    Logger.getLogger(UsersManagement.class.getName()).log(Level.SEVERE, null, ne);
                }
               
            }
                
                break;
            
            case "/SmartVendingMachine/UsersManagement/updateUser":
                
            {
                try {
                    updateUser(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(UsersManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                
                break;

            case "/SmartVendingMachine/UsersManagement/updatePersonalData":
                
            {
                try {
                    updatePersonalData(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(UsersManagement.class.getName()).log(Level.SEVERE, null, ex);
                } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(UsersManagement.class.getName()).log(Level.SEVERE, null, ex);
            }
            }
                
                break;

        }
    }

    

}
