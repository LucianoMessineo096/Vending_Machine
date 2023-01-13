/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import Model.Machine;
import Model.MachineServices;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;

/**
 *
 * @author luciano
 */
public class MachinesUtils {
    
    public boolean checkIfIsOccupied(int machineId) throws SQLException{
        
        MachineServices machineServices = new MachineServices();
        String status=machineServices.getStatus(machineId);
                
        if(status.matches("occupied")){
            
            return true;
        }
        else{
            return false;
        }
            
    }
    
    public void checkMachinesCapacity(ArrayList<Machine> machines) throws SQLException{
    
        //looping through machines and check if machine capacity is eq 0
        //if eq 0 then set status=disabled 
        
        MachineServices machineServices = new MachineServices();
        
        for(Machine machine : machines){
            
            if(machine.getActualCapacity()==0){
            
                machineServices.changeStatus(machine.getId(),"disabled");
            }
            
        }
    
    }
    
    public void checkMachineCapacity(Machine machine) throws SQLException{
    
        //check if machine capacity is eq 0
        //if eq 0 then set status=disabled 
        
        MachineServices machineServices = new MachineServices();
          
        if(machine.getActualCapacity()==0){

            machineServices.changeStatus(machine.getId(),"disabled");
        }
            
    }
    
}
