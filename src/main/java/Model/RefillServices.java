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
import java.util.HashMap;

/**
 *
 * @author luciano
 */
public class RefillServices {
    
    public boolean checkIfMachineHasBeenRefilled(int machineId) throws SQLException{
        
        boolean check=false;
        
        String statement = "SELECT * FROM refills WHERE machId=?";
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setInt(1, machineId);
        
        ResultSet resultSet = query.executeQuery();

        if(resultSet.next()){
            
            check=true;
        
        }
        return check;

    }
    
    public ArrayList<Refill> getAllRefills() throws SQLException{
    
        ArrayList<Refill> refills = new ArrayList<>();
        Refill refill = new Refill();
        String statement = "SELECT * FROM refills";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        ResultSet resultSet = query.executeQuery();
        
        if(resultSet.next()){
            
            refill.setId(resultSet.getInt("id"));
            refill.setMachId(resultSet.getInt("machId"));
            refill.setTechId(resultSet.getInt("techId"));
            refill.setProd1Id(resultSet.getInt("prod1Id"));
            refill.setProd1Quantity(resultSet.getInt("prod1Quantity"));
            refill.setProd2Id(resultSet.getInt("prod2Id"));
            refill.setProd2Quantity(resultSet.getInt("prod2Quantity"));
            refill.setProd3Id(resultSet.getInt("prod3Id"));
            refill.setProd3Quantity(resultSet.getInt("prod3Quantity"));
            refill.setProd4Id(resultSet.getInt("prod4Id"));
            refill.setProd4Quantity(resultSet.getInt("prod4Quantity"));
            
            refills.add(refill);
        }
        
        return refills;
    
    }
    
    public Refill getRefill(int machineId) throws SQLException{
    
        Refill refill = new Refill();
        String statement = "SELECT * FROM refills WHERE machId=?";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setInt(1,machineId);
        
        ResultSet resultSet = query.executeQuery();
        
        if(resultSet.next()){
            
            refill.setId(resultSet.getInt("id"));
            refill.setMachId(resultSet.getInt("machId"));
            refill.setTechId(resultSet.getInt("techId"));
            refill.setProd1Id(resultSet.getInt("prod1Id"));
            refill.setProd1Quantity(resultSet.getInt("prod1Quantity"));
            refill.setProd2Id(resultSet.getInt("prod2Id"));
            refill.setProd2Quantity(resultSet.getInt("prod2Quantity"));
            refill.setProd3Id(resultSet.getInt("prod3Id"));
            refill.setProd3Quantity(resultSet.getInt("prod3Quantity"));
            refill.setProd4Id(resultSet.getInt("prod4Id"));
            refill.setProd4Quantity(resultSet.getInt("prod4Quantity"));
        }
        
        return refill;
    }
    
    public boolean addRefill(int machineId,int techId,
                                           int prod1Id,int prod1Quantity,
                                           int prod2Id,int prod2Quantity,
                                           int prod3Id,int prod3Quantity,
                                           int prod4Id,int prod4Quantity) throws SQLException
    {
    
        boolean inserted = false;
        String statement = "INSERT INTO refills(techId,machId,"
                                                + "prod1Id,prod1Quantity,"
                                                + "prod2Id,prod2Quantity,"
                                                + "prod3Id,prod3Quantity,"
                                                + "prod4Id,prod4Quantity)"
                                                + "VALUES(?,?,?,?,?,?,?,?,?,?)";
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setInt(1, techId);
        query.setInt(2, machineId);
        query.setInt(3, prod1Id);
        query.setInt(4, prod1Quantity);
        query.setInt(5, prod2Id);
        query.setInt(6, prod2Quantity);
        query.setInt(7, prod3Id);
        query.setInt(8, prod3Quantity);
        query.setInt(9, prod4Id);
        query.setInt(10, prod4Quantity);
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
            
            inserted=true;
        
        }
        return inserted;
    
    }
    
    public boolean updateRefill(int machineId,int techId,
                                           int prod1Id,int prod1Quantity,
                                           int prod2Id,int prod2Quantity,
                                           int prod3Id,int prod3Quantity,
                                           int prod4Id,int prod4Quantity) throws SQLException
    {
    
        boolean updated = false;
        String statement = "UPDATE refills SET techId=?,prod1Id=?,prod1Quantity=?,prod2Id=?,prod2Quantity=?,prod3Id=?,prod3Quantity=?,prod4Id=?,prod4Quantity=? WHERE machId=?";
                
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setInt(1, techId);
        query.setInt(2, prod1Id);
        query.setInt(3, prod1Quantity);
        query.setInt(4, prod2Id);
        query.setInt(5, prod2Quantity);
        query.setInt(6, prod3Id);
        query.setInt(7, prod3Quantity);
        query.setInt(8, prod4Id);
        query.setInt(9, prod4Quantity);
        query.setInt(10, machineId);
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
            
            updated=true;
        
        }
        return updated;
    
    }
    
    public boolean updateRefill(int colIndex , int productId) throws SQLException{
        
        boolean updated = false;
        String statement= "UPDATE refills SET prod"+colIndex+"Quantity=? WHERE prod"+colIndex+"Id=?";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setInt(1, 0);
        query.setInt(2, productId);
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
            
            updated=true;
        
        }
        
        return updated;
    
    }
    
    public boolean updateRefill(int machineId,HashMap<Integer,Integer> machineProducts) throws SQLException
    {
    
        boolean updated = false;
        int count=1;
        //String statement = "UPDATE refills SET prod1Id=?,prod1Quantity=?,
        //prod2Id=?,prod2Quantity=?,prod3Id=?,prod3Quantity=?,prod4Id=?,prod4Quantity=? WHERE machId=?";
        
        String statement= "UPDATE refills SET ";
        
        for(HashMap.Entry<Integer,Integer> prod : machineProducts.entrySet()){
            
            if(count==1){
                
                statement+= "prod"+count+"Id=?,prod"+count+"Quantity=?";
                
            }
            
            if(count==machineProducts.size()){
                
                statement+= ",prod"+count+"Id=?,prod"+count+"Quantity=?";
            
            }
            
            if(count>1 && count<machineProducts.size()){
                
                statement+= ",prod"+count+"Id=?,prod"+count+"Quantity=?";
            
            }
            
            count++;
        }
        
        statement+=" WHERE machId=?";
        
        count=1;
                
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        
        for(HashMap.Entry<Integer,Integer> prod : machineProducts.entrySet()){
            query.setInt(count,prod.getKey());
            count++;
            query.setInt(count,prod.getValue());
            count++;
        }
        
        query.setInt(count, machineId);
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
            
            updated=true;
        
        }
        return updated;
    
    }
    
    
    
    
}
