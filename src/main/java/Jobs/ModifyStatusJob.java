/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Jobs;

import Model.Machine;
import Model.MachineServices;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 *
 * @author luciano
 */
public class ModifyStatusJob implements Job {
    
    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException{
        
        /*
            this job is executed every 1 min to check status for every machine
            
            when a user close the browser without passing to logout then the status remain pending in occupied
        
            how to resolve: if status=occupied for plus 10 minutes then machine is available again
            
        */
        
        System.out.println("MODIFY-STATUS-JOB-STARTED");
        
        try{
            
            boolean changed=false;
            boolean setted=false;
            
            MachineServices machineServices = new MachineServices();
            ArrayList<Machine> occupiedMachines = machineServices.getMachinesByStatus("occupied");
            
            if(occupiedMachines!=null){
                
                for(Machine machine : occupiedMachines){
                
                    String occupiedSince = machine.getOccupiedSince();
                    occupiedSince=occupiedSince.replaceAll("-",":");
                    occupiedSince=occupiedSince.replaceAll(" ",":");

                    String[] a = occupiedSince.split("\\:");
                    int storedHour =Integer.parseInt(a[3]);
                    int storedMinutes = Integer.parseInt(a[4]);
                                        
                    LocalDateTime now = LocalDateTime.now();
                    int currentHour = now.getHour();
                    int currentMinutes = now.getMinute();

                    if ((storedHour==currentHour && Math.abs(storedMinutes-currentMinutes) > 10) || (storedHour!=currentHour)) {

                        changed=machineServices.changeStatus(machine.getId(), "free");
                        setted=machineServices.setToNullOccupiedSince(machine.getId());
                    }
                    
                    if(changed && setted){
                        System.out.println("La macchinetta: "+machine.getId()+" con stato occupied e' stata sbloccata, in quanto pending in tale stato");
                    }

                }
            
            }else{
                System.out.println("nessuna macchinetta occupata");
            }
            
  
        }catch(SQLException se){
            se.printStackTrace();
        }
         
    }
    
}
