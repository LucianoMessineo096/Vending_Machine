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
public class ProductServices {
    
    public Product getProduct(int productId) throws SQLException{
    
        Product product = new Product();
        String statement = "SELECT * FROM products WHERE id=?";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setInt(1,productId);
        
        ResultSet resultSet = query.executeQuery();
        
        if(resultSet.next()){
        
            product.setId(resultSet.getInt("id"));
            product.setName(resultSet.getNString("name"));
            product.setPrice(resultSet.getFloat("price"));
            product.setTypology(resultSet.getNString("typology"));
        
        }
        
        
        return product;
    
    
    }
    
    public ArrayList<Product> getAllProducts() throws SQLException{
    
        ArrayList<Product> products = new ArrayList<>();
        
        String statement = "SELECT * FROM products";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        
        ResultSet resultSet = query.executeQuery();
        
        while(resultSet.next()){
            
            Product product= new Product();
            
            product.setId(resultSet.getInt("id"));
            product.setName(resultSet.getNString("name"));
            product.setPrice(resultSet.getFloat("price"));
            product.setTypology(resultSet.getNString("typology"));
            
            
            products.add(product);
            
            
        }
        
        
        return products;
    
    }
    
    public boolean deleteProduct(int productId) throws SQLException{
        
        boolean deleted=false;
        String statement = "DELETE FROM products WHERE id=?";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setInt(1,productId);
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
        
            deleted=true;
        }
        
        
        return deleted;
    
    }
    
    public boolean addProduct(String name,float price,String typology) throws SQLException{
        
        boolean added = false;
        String statement="INSERT INTO products(name,price,typology) VALUES(?,?,?)";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setString(1,name);
        query.setFloat(2,price);
        query.setString(3,typology);
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
        
            added=true;
        }
    
    
        return added;
    }
    
    public boolean updateProduct(int productId,String name,float price,String typology) throws SQLException{
    
        boolean updated=false;
        String statement = "UPDATE products SET name=?, price=?, typology=?  WHERE id=?";
         
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setString(1,name);
        query.setFloat(2,price);
        query.setString(3,typology);
        query.setInt(4,productId);
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
            
            updated=true;
        
        }
        
        return updated;

    }
}
