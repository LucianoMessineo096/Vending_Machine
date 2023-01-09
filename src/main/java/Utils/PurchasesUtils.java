/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import Model.Machine;
import Model.Product;
import Model.Refill;
import java.util.HashMap;

/**
 *
 * @author luciano
 */
public class PurchasesUtils {
    
    public boolean checkQuantity(Product product,Refill refill,Machine machine){
        
        boolean check=true;
        
        HashMap<Integer,Integer> machineProducts = new HashMap<Integer,Integer>();
        
        if(refill.getProd1Id()!=0){
            machineProducts.put(refill.getProd1Id(),refill.getProd1Quantity());
        }
        
        if(refill.getProd2Id()!=0){
            
            machineProducts.put(refill.getProd2Id(),refill.getProd2Quantity());
        }
        
        if(refill.getProd3Id()!=0){
            
            machineProducts.put(refill.getProd3Id(),refill.getProd3Quantity());
        }
        
        if(refill.getProd4Id()!=0){
            
            machineProducts.put(refill.getProd4Id(),refill.getProd4Quantity());
        
        }

        for(HashMap.Entry<Integer,Integer> prod : machineProducts.entrySet()){
           
            if(prod.getKey()==product.getId()){

                if(prod.getValue()==0){
                    
                    check=false;
                
                } 
            }

        }
    
        return check;
    }
    
    public void updateRefillQuantity(Product product,Refill refill){
    
        if(refill.getProd1Id()==product.getId()){
            
            refill.setProd1Quantity(refill.getProd1Quantity()-1);
        }
        
        if(refill.getProd2Id()==product.getId()){
            
            refill.setProd2Quantity(refill.getProd2Quantity()-1);
        }
        
        if(refill.getProd3Id()==product.getId()){
            
            refill.setProd3Quantity(refill.getProd3Quantity()-1);
        }
        
        if(refill.getProd4Id()==product.getId()){
            
            refill.setProd4Quantity(refill.getProd4Quantity()-1);
        }

    }
    
    public int calculateNewCapacity(Machine machine){
    
        machine.setActualCapacity(machine.getActualCapacity()-1);
        
        return machine.getActualCapacity();
        
    
    }
    
    public int getProductColumnIndex(Refill refill,Product product) throws IllegalArgumentException, IllegalAccessException{
        
        //description : this function return an HashMap that contain the column index
        //              of the product for a specified refill
        
        int columnIndex=0;
        
        if(refill.getProd1Id()==product.getId()){

            columnIndex=1;

        }else if(refill.getProd2Id()==product.getId()){

            columnIndex=2;
            
        }else if(refill.getProd3Id()==product.getId()){

            columnIndex=3;

        }else if(refill.getProd4Id()==product.getId()){

            columnIndex=4;

        }else{

        }

        return columnIndex;

    }

    public int getNewQuantity(Refill refill,Product product){
        
        int newQuantity=0;
        
        if(refill.getProd1Id()==product.getId()){
            
            newQuantity=refill.getProd1Quantity();
        }
        
        if(refill.getProd2Id()==product.getId()){
            
            newQuantity=refill.getProd2Quantity();
        }
        
        if(refill.getProd3Id()==product.getId()){
            
            newQuantity=refill.getProd3Quantity();
        }
        
        if(refill.getProd4Id()==product.getId()){
            
            newQuantity=refill.getProd4Quantity();
        }
        
        return newQuantity;
    
    }
    
}
