/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Machine;
import Model.MachineServices;
import Model.User;
import Model.UserServices;
import Security.PasswordEncryption;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
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
@WebServlet(name = "AutenticationManagement", urlPatterns = {"/AutenticationManagement",
                                                             "/AutenticationManagement/login",
                                                             "/AutenticationManagement/logout",
                                                             "/AutenticationManagement/registration"})
public class AutenticationManagement extends HttpServlet {
    
    protected void login(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, SQLException, IOException, NoSuchAlgorithmException{
        
        JSONObject Jlocation = new JSONObject();
        UserServices userService = new UserServices();
       
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        PasswordEncryption pe = new PasswordEncryption();
        String encryptedPassword = pe.cypher(password);
        
        User user = userService.getUser(email,encryptedPassword);
        
        if(user.getName()!=null){
            
            //generate session
            HttpSession session = request.getSession(true);
            session.setMaxInactiveInterval(60*15);
            session.setAttribute("currentSessionUser", user);
            
            Jlocation.put("success", true);
            Jlocation.put("message", "Login effettuato con successo");
            Jlocation.put("address", "/SmartVendingMachine/UsersManagement/personalPage"); 
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        }
        else{
        
            Jlocation.put("success", false);
            Jlocation.put("message", "Combinazione di email e password errata");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        
        
        }

    }
    
    protected void logout(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException{
        
        MachineServices machineServices = new MachineServices();
        
        HttpSession session = request.getSession(false);
        Machine machine = (Machine) session.getAttribute("currentSessionMachine");
        
        if(machine!=null){
            
            int machineId = machine.getId();
            machineServices.changeStatus(machineId,"free");
        
        }

        session.removeAttribute("currentSessionUser");
        session.removeAttribute("currentSessionMachine");
        session.invalidate();
        
        request.getRequestDispatcher("/").forward(request, response);
    }
    
    protected void registration(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, NoSuchAlgorithmException, SQLException, IOException{
    
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
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, UnsupportedEncodingException {
        
        String uri = request.getRequestURI();
        
        switch(uri){
         
            case "/SmartVendingMachine/AutenticationManagement":
        
                request.getRequestDispatcher("/View/registrationPage.jsp").forward(request, response);
                
                break;
                
            case "/SmartVendingMachine/AutenticationManagement/login":

                try {
                    login(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(AutenticationManagement.class.getName()).log(Level.SEVERE, null, ex);
                } catch (NoSuchAlgorithmException ex) {
                    Logger.getLogger(AutenticationManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            
                break;

                
            case "/SmartVendingMachine/AutenticationManagement/logout":
                
                try {
                    logout(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(AutenticationManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            
                
                break;

        }
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String uri = request.getRequestURI();
        
        switch(uri){
        
            
            case "/SmartVendingMachine/AutenticationManagement/registration":
                
                try {
                    registration(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(AutenticationManagement.class.getName()).log(Level.SEVERE, null, ex);
                } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(AutenticationManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
            
                
                break;
        
        }
    }

    

}
