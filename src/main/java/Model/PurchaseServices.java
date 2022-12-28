/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author luciano
 */
public class PurchaseServices {
    
    public boolean addPurchase(int userId,int productId,int machineId,String date,float cost) throws SQLException{
        
        boolean added= false;
        String addPurchaseQuery = "INSERT INTO purchases(userId,productId,machineId,date,cost) VALUES(?,?,?,?,?)";

        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(addPurchaseQuery);
        query.setInt(1,userId);
        query.setInt(2,productId);
        query.setInt(3,machineId);
        query.setString(4,date);
        query.setFloat(5,cost);
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
            
            added=true;
        
        }
        
        query.close();
        connection.close();
        
        return added;
    }   
    
    public ArrayList<Purchase> getPurchases(int userId) throws SQLException{
        
        ArrayList<Purchase> purchases = new ArrayList<>();
        
        String getPurchasesQuery = "SELECT * FROM purchases WHERE userId=?";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(getPurchasesQuery);
        query.setInt(1,userId);
        
        ResultSet resultSet = query.executeQuery();
        
        while(resultSet.next()){
            
            Purchase purchase = new Purchase();
            
            purchase.setId(resultSet.getInt("id"));
            purchase.setUserId(resultSet.getInt("userId"));
            purchase.setProductId(resultSet.getInt("productId"));
            purchase.setMachineId(resultSet.getInt("machineId"));
            purchase.setDate(resultSet.getNString("date"));
            purchase.setCost(resultSet.getFloat("cost"));
            
            purchases.add(purchase);
            
            
        }
        
        query.close();
        resultSet.close();
        connection.close();
        
        return purchases;
    
    }
    
}
