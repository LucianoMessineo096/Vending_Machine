/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import Model.Refill;
import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author luciano
 */
public class RefillsUtils {
    
    public ArrayList<Integer> updateQuantity(Refill refill,Integer[] insertedQuantities){
       
       HashMap<String,Integer> quantities = new HashMap<String,Integer>();
       ArrayList<Integer> newQuantities=new ArrayList<>();
       
       int count=0;
       
       quantities.put("prod1Quantity", refill.getProd1Quantity());
       quantities.put("prod2Quantity", refill.getProd2Quantity());
       quantities.put("prod3Quantity", refill.getProd3Quantity());
       quantities.put("prod4Quantity", refill.getProd4Quantity());
       
       for(HashMap.Entry<String,Integer> quantity : quantities.entrySet()){
                      
           int actualQuantity = quantity.getValue();
           int insertedQuantity = insertedQuantities[count];  
           int toAdd=Math.abs(insertedQuantity-actualQuantity);
           
           if(toAdd==0){
              newQuantities.add(actualQuantity); 
           }
           else{
               
               int newQuantity=actualQuantity+toAdd;
               newQuantities.add(newQuantity);
           
           }
           
           count++;
           
       }
       
       return newQuantities;

    }
    
}
