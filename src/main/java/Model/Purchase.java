/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author luciano
 */
public class Purchase {
    
    private int id;
    private int userId;
    private int productId;
    private int machineId;
    private String date;
    private float cost;
    
    public Purchase(){
    
    }

    public Purchase(int id, int userId, int productId,int machineId, String date, float cost) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.machineId= machineId;
        this.date = date;
        this.cost = cost;
    }
    
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public float getCost() {
        return cost;
    }

    public void setCost(float cost) {
        this.cost = cost;
    }

    public int getMachineId() {
        return machineId;
    }

    public void setMachineId(int machineId) {
        this.machineId = machineId;
    }
    
    
    
}
