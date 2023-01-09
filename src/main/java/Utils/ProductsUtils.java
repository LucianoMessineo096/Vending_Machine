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
public class ProductsUtils {
    
    public HashMap<Refill,Integer> getProductColumnsIndex(ArrayList<Refill> refills,int productId) throws IllegalArgumentException, IllegalAccessException{
        
        //description : this function return an HashMap that contain the column index
        //              of the product for a specified refill
        
        HashMap<Refill,Integer> columnsIndex = new HashMap<>();
        
        for(Refill refill : refills){
            
            if(refill.getProd1Id()==productId){
                
                columnsIndex.put(refill, 1);
            
            }else if(refill.getProd2Id()==productId){
                
                columnsIndex.put(refill, 2);
            
            }else if(refill.getProd3Id()==productId){
                
                columnsIndex.put(refill, 3);
            
            }else if(refill.getProd4Id()==productId){
                
                columnsIndex.put(refill, 4);
            
            }else{
            
            }

        }
        
        return columnsIndex;

    }
    
}
