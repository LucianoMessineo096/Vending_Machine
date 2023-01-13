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
    
    public void checkMachinesStatus() throws SQLException{
    
        /*
            this method is called to check status for every machine
            
            when a user close the browser without passing to logout then the status remain pending in occupied
        
            how to resolve: if status=occupied for plus 10 minutes then machine is available again
            
        */
        
        MachineServices machineServices = new MachineServices();
        ArrayList<Machine> occupiedMachines = machineServices.getMachinesByStatus("occupied");
        
        for(Machine machine : occupiedMachines){

            String occupiedSince = machine.getOccupiedSince();
            
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDateTime targetTime = LocalDateTime.parse(occupiedSince, formatter);
            
            LocalDateTime currentTime = LocalDateTime.now();
            long minutesBetween = ChronoUnit.MINUTES.between(currentTime, targetTime);

            if (minutesBetween > 2) {
                
                machineServices.changeStatus(machine.getId(), "free");
                machineServices.setToNullOccupiedSince(machine.getId());
            }
               
        }
    
    }
    
}
