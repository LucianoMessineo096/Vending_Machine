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
public class MovementServices {
    
    public boolean addMovement(int userId,float value,String date,String type) throws SQLException{
    
        boolean inserted = false;
        String statement = "INSERT INTO movements(userId,value,date,type) VALUES(?,?,?,?)";
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setInt(1, userId);
        query.setFloat(2, value);
        query.setString(3, date);
        query.setString(4, type);
                
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
            
            inserted=true;
        
        }
        return inserted;

    }
    
    public ArrayList<Movement> getMovements(int userId) throws SQLException{
    
        ArrayList<Movement> movements = new ArrayList<>();
    
        String statement = "SELECT * FROM movements WHERE userId=?";

            DataSourceFactory dataSource = new DataSourceFactory();
            Connection connection = dataSource.getConnection();

            PreparedStatement query = connection.prepareStatement(statement);
            query.setInt(1, userId);

            ResultSet resultSet = query.executeQuery();

            while(resultSet.next()){

                Movement movement = new Movement();

                movement.setId(resultSet.getInt("id"));
                movement.setUserId(resultSet.getInt("userId"));
                movement.setValue(resultSet.getFloat("value"));
                movement.setDate(resultSet.getNString("date"));
                movement.setType(resultSet.getNString("type"));
                
                movements.add(movement);

            }

        return movements;

    }
    
    
    
}
