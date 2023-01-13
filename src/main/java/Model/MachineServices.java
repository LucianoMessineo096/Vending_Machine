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
public class MachineServices {
    
    public boolean setToNullOccupiedSince(int machineId) throws SQLException{
        
        boolean setted=false;
        
        String statement = "UPDATE machines SET occupiedSince=null WHERE id=?";
         
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();

        PreparedStatement query = connection.prepareStatement(statement);
        query.setInt(1,machineId);

        int rowCount = query.executeUpdate();

        if(rowCount!=0){

            setted=true;

        }

        query.close();
        connection.close();
        
        return setted;
    
    }
    
    public boolean changeStatus(int machineId,String status) throws SQLException{
        
        boolean changed=false;
        
        if(status=="occupied"){
            
            String statement = "UPDATE machines SET status=?, occupiedSince=NOW() WHERE id=?";
         
            DataSourceFactory dataSource = new DataSourceFactory();
            Connection connection = dataSource.getConnection();

            PreparedStatement query = connection.prepareStatement(statement);
            query.setString(1,status);
            query.setInt(2,machineId);

            int rowCount = query.executeUpdate();

            if(rowCount!=0){

                changed=true;

            }
            
            query.close();
            connection.close();

            
        
        }else{
            
            String statement = "UPDATE machines SET status=?, occupiedSince=DEFAULT WHERE id=?";
         
            DataSourceFactory dataSource = new DataSourceFactory();
            Connection connection = dataSource.getConnection();

            PreparedStatement query = connection.prepareStatement(statement);
            query.setString(1,status);
            query.setInt(2,machineId);

            int rowCount = query.executeUpdate();

            if(rowCount!=0){

                changed=true;

            }
            
            query.close();
            connection.close();
        
        
        
        
        }
        
        return changed;

    }
    
    public ArrayList<Machine> getMachinesByStatus(String status) throws SQLException{
    
        ArrayList<Machine> machines = new ArrayList<>();
        
        String statement = "SELECT * FROM machines WHERE status=?";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setString(1,status);
        
        ResultSet resultSet = query.executeQuery();
        
        while(resultSet.next()){
            
            Machine machine = new Machine();
            
            machine.setId(resultSet.getInt("id"));
            machine.setName(resultSet.getNString("name"));
            machine.setStatus(resultSet.getNString("status"));
            machine.setName(resultSet.getNString("name"));
            machine.setMaxCapacity(resultSet.getInt("maxcapacity"));
            machine.setActualCapacity(resultSet.getInt("actualcapacity"));
            
            if(resultSet.getDate("occupiedSince")!=null){
                
                machine.setOccupiedSince(resultSet.getDate("occupiedSince").toString()+" "+resultSet.getTime("occupiedSince").toString());
            }
            
            
            machines.add(machine);

        }
        
        query.close();
        resultSet.close();
        connection.close();
        
        return machines;
    }
    
    public ArrayList<Machine> getMachines() throws SQLException{
    
        ArrayList<Machine> machines = new ArrayList<>();
        
        String statement = "SELECT * FROM machines";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        
        ResultSet resultSet = query.executeQuery();
        
        while(resultSet.next()){
            
            Machine machine = new Machine();
            
            machine.setId(resultSet.getInt("id"));
            machine.setName(resultSet.getNString("name"));
            machine.setStatus(resultSet.getNString("status"));
            machine.setName(resultSet.getNString("name"));
            machine.setMaxCapacity(resultSet.getInt("maxcapacity"));
            machine.setActualCapacity(resultSet.getInt("actualcapacity"));
            
            if(resultSet.getDate("occupiedSince")!=null){
                
                machine.setOccupiedSince(resultSet.getDate("occupiedSince").toString()+" "+resultSet.getTime("occupiedSince").toString());
            }
            
            
            machines.add(machine);

        }
        
        query.close();
        resultSet.close();
        connection.close();
        
        return machines;
    }
    
    public String getStatus(int machineId) throws SQLException{
    
        String status;
        Machine machine = new Machine();
        String statement = "SELECT * FROM machines WHERE id=?";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setInt(1,machineId);
        
        ResultSet resultSet = query.executeQuery();
        
        if(resultSet.next()){
        
            machine.setStatus(resultSet.getNString("status"));
        }
        
        status=machine.getStatus();
        
        query.close();
        resultSet.close();
        connection.close();
        
        return status;
    
    
    }
    
    public Machine getMachine(int machineId) throws SQLException{
    
        Machine machine = new Machine();
        String statement = "SELECT * FROM machines WHERE id=?";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setInt(1,machineId);
        
        ResultSet resultSet = query.executeQuery();
        
        if(resultSet.next()){
        
            machine.setId(resultSet.getInt("id"));
            machine.setName(resultSet.getNString("name"));
            machine.setStatus(resultSet.getNString("status"));
            machine.setMaxCapacity(resultSet.getInt("maxcapacity"));
            machine.setActualCapacity(resultSet.getInt("actualcapacity"));
        
        }
        
        query.close();
        resultSet.close();
        connection.close();
        
        return machine;
    
    
    }

    public boolean deleteMachine(int productId) throws SQLException{
        
        boolean deleted=false;
        String statement = "DELETE FROM machines WHERE id=?";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setInt(1,productId);
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
        
            deleted=true;
        }
        
        query.close();
        connection.close();
        
        return deleted;
    
    }

    public boolean addMachine(String name) throws SQLException{
        
        boolean added = false;
        String statement="INSERT INTO machines(name) VALUES(?)";
        
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setString(1,name);
       
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
        
            added=true;
        }
        
        query.close();
        connection.close();
        
        return added;
    }

    public boolean updateMachine(int machineId,String name,String status) throws SQLException{
    
        boolean updated=false;
        String statement = "UPDATE machines SET name=?, status=? WHERE id=?";
         
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setString(1,name);
        query.setString(2,status);
        query.setInt(3,machineId);
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
            
            updated=true;
        
        }
        
        query.close();
        connection.close();
        
        return updated;

    }
    
    public boolean updateMachine(int machineId,int newActualCapacity) throws SQLException{
    
        boolean updated=false;
        String statement = "UPDATE machines SET actualCapacity=? WHERE id=?";
         
        DataSourceFactory dataSource = new DataSourceFactory();
        Connection connection = dataSource.getConnection();
        
        PreparedStatement query = connection.prepareStatement(statement);
        query.setInt(1,newActualCapacity);
        query.setInt(2,machineId);
        
        int rowCount = query.executeUpdate();
        
        if(rowCount!=0){
            
            updated=true;
        
        }
        
        query.close();
        connection.close();
        
        return updated;

    }
}
