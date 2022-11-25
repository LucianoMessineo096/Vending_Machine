/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author luciano
 */
public class DataSourceFactory {
    
    private String database_name="smartvendingmachinedb";
    private String username="root";
    private String password="root";
    private String url="jdbc:mysql://localhost:3306/"+database_name;
    
    Connection connection;
    
    public Connection getConnection(){
        
        try{
            
            Class.forName("com.mysql.jdbc.Driver");
            connection = (Connection) DriverManager.getConnection(this.url,this.username,this.password);
            //JOptionPane.showInputDialog("connesso");
        }catch(SQLException sqlex){
            
            System.err.println(sqlex);
            //JOptionPane.showInputDialog("errore");
        }catch(ClassNotFoundException ex){
            
            System.err.println(ex);
            //JOptionPane.showInputDialog("errore");
        }
        
        return connection;
    }
    
}
