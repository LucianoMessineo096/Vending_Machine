/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import com.password4j.Hash;
import com.password4j.Password;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.swing.JOptionPane;

/**
 *
 * @author luciano
 */
public class UserServices {
    
    public User getUser(int userId) throws SQLException{
    
        User user = new User();
        String statement = "SELECT * FROM users WHERE id=?";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setInt(1,userId);
        
        ResultSet resultSet = query.executeQuery();
        
        if(resultSet.next()){
            
            user.setId(resultSet.getInt("id"));
            user.setEmail(resultSet.getNString("email"));
            user.setPassword(resultSet.getNString("password"));
            user.setName(resultSet.getNString("name"));
            user.setSurname(resultSet.getNString("surname"));
            user.setType(resultSet.getNString("type"));
            user.setWalletBalance(resultSet.getFloat("walletBalance"));
        }
        
        query.close();
        resultSet.close();
        connection.close();
        
        return user;
    
    }
    
    public boolean checkIfUserAlreadyExists(String email) throws SQLException, NoSuchAlgorithmException{
    
        boolean exists=false;
        
        String statement = "SELECT * FROM users WHERE email=?";
 
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setString(1,email);
        
        ResultSet resultSet = query.executeQuery();
        
        if(resultSet.next()){
            
            exists=true;
        }
        
        query.close();
        resultSet.close();
        connection.close();
        
        return exists;
    
    }
    
    public User getUser(String email,String password) throws SQLException, NoSuchAlgorithmException{
    
        User user = new User();
        String statement = "SELECT * FROM users WHERE email=? and password=?";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setString(1,email);
        query.setString(2,password);
        
        ResultSet resultSet = query.executeQuery();
        
        if(resultSet.next()){
            
            user.setId(resultSet.getInt("id"));
            user.setEmail(resultSet.getNString("email"));
            user.setPassword(resultSet.getNString("password"));
            user.setName(resultSet.getNString("name"));
            user.setSurname(resultSet.getNString("surname"));
            user.setType(resultSet.getNString("type"));
            user.setWalletBalance(resultSet.getFloat("walletBalance"));
        }
        
        query.close();
        resultSet.close();
        connection.close();
        
        return user;
    
    }
    
    public boolean addUser(String email,String password,String name,String surname) throws SQLException, NoSuchAlgorithmException {
                
        boolean inserted = false;
        String statement = "INSERT INTO users(email,password,name,surname) VALUES(?,?,?,?)";
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        //password encryption
        //String cypherPass = CypherFunction(password).toString();
        

        PreparedStatement query = connection.prepareStatement(statement);
        query.setString(1, email);
        query.setString(2, password);
        query.setString(3, name);
        query.setString(4, surname);
        
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
            
            inserted=true;
        
        }
        
        query.close();
        connection.close();
        
        return inserted;
    }
    
    public boolean deleteUser(int userId) throws SQLException{
    
        boolean deleted=false;
        
        String statement = "DELETE FROM users WHERE id=?";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setInt(1,userId);
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
        
            deleted=true;
        }
        
        query.close();
        connection.close();
        
        return deleted;
    }
    
    public boolean updateUser(int userId,String email,String name,String surname,String type) throws SQLException{
        
        boolean updated=false;
        
        String statement ="UPDATE users SET email=? , name=?, surname=?, type=? WHERE id=?";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setString(1,email);
        query.setString(2,name);
        query.setString(3,surname);
        query.setString(4,type);
        query.setInt(5,userId);
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
            
            updated=true;
        
        }
        
        query.close();
        connection.close();
        
        return updated;
    
    }
    
    public boolean updatePersonalData(int userId,String name,String surname,String email,String password) throws SQLException{
        
        boolean updated=false;
        
        String statement ="UPDATE users SET name=? , surname=?, email=?, password=? WHERE id=?";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setString(1,name);
        query.setString(2,surname);
        query.setString(3,email);
        query.setString(4,password);
        query.setInt(5,userId);
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
            
            updated=true;
        
        }
        
        query.close();
        connection.close();
        
        return updated;
        
    }
            
    public boolean updateWallet(int userId,float recharge) throws SQLException{
    
        boolean updated=false;
        String statement = "UPDATE users SET walletBalance=? WHERE id=?";
         
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setFloat(1,recharge);
        query.setInt(2,userId);
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
            
            updated=true;
        
        }
        
        query.close();
        connection.close();
        
        return updated;
    }
    
    public boolean updateBalance(int userId, float newBalance) throws SQLException{
        
        boolean updated=false;
        String statement = "UPDATE users SET walletBalance=? WHERE id=?";
         
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setFloat(1,newBalance);
        query.setInt(2,userId);
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
            
            updated=true;
        
        }
        
        query.close();
        connection.close();
        
        return updated;
    
    
    }
    
    public ArrayList<User> getUsers() throws SQLException{
        
        ArrayList<User> users = new ArrayList<>();
        
        String statement = "SELECT * FROM users";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        
        ResultSet resultSet = query.executeQuery();
        
        while(resultSet.next()){
            
            User user= new User();
            
            user.setId(resultSet.getInt("id"));
            user.setEmail(resultSet.getNString("email"));
            user.setPassword(resultSet.getNString("password"));
            user.setName(resultSet.getNString("name"));
            user.setSurname(resultSet.getNString("surname"));
            user.setType(resultSet.getNString("type"));
            user.setWalletBalance(resultSet.getFloat("walletBalance"));
            
            users.add(user);

        }
        
        query.close();
        resultSet.close();
        connection.close();
        
        return users;
    
    }
 
}
