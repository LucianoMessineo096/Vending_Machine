/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author luciano
 */
public class Refill {
    
    private int id;
    private int techId;
    private int machId;
    private int prod1Id;
    private int prod1Quantity;
    private int prod2Id;
    private int prod2Quantity;
    private int prod3Id;
    private int prod3Quantity;
    private int prod4Id;
    private int prod4Quantity;
    
    public Refill(){
    
    
    
    }

    public Refill(int id, int techId, int machId, int prod1Id, int prod1Quantity, int prod2Id, int prod2Quantity, int prod3Id, int prod3Quantity, int prod4Id, int prod4Quantity) {
        this.id = id;
        this.techId = techId;
        this.machId = machId;
        this.prod1Id = prod1Id;
        this.prod1Quantity = prod1Quantity;
        this.prod2Id = prod2Id;
        this.prod2Quantity = prod2Quantity;
        this.prod3Id = prod3Id;
        this.prod3Quantity = prod3Quantity;
        this.prod4Id = prod4Id;
        this.prod4Quantity = prod4Quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTechId() {
        return techId;
    }

    public void setTechId(int techId) {
        this.techId = techId;
    }

    public int getMachId() {
        return machId;
    }

    public void setMachId(int machId) {
        this.machId = machId;
    }

    public int getProd1Id() {
        return prod1Id;
    }

    public void setProd1Id(int prod1Id) {
        this.prod1Id = prod1Id;
    }

    public int getProd1Quantity() {
        return prod1Quantity;
    }

    public void setProd1Quantity(int prod1Quantity) {
        this.prod1Quantity = prod1Quantity;
    }

    public int getProd2Id() {
        return prod2Id;
    }

    public void setProd2Id(int prod2Id) {
        this.prod2Id = prod2Id;
    }

    public int getProd2Quantity() {
        return prod2Quantity;
    }

    public void setProd2Quantity(int prod2Quantity) {
        this.prod2Quantity = prod2Quantity;
    }

    public int getProd3Id() {
        return prod3Id;
    }

    public void setProd3Id(int prod3Id) {
        this.prod3Id = prod3Id;
    }

    public int getProd3Quantity() {
        return prod3Quantity;
    }

    public void setProd3Quantity(int prod3Quantity) {
        this.prod3Quantity = prod3Quantity;
    }

    public int getProd4Id() {
        return prod4Id;
    }

    public void setProd4Id(int prod4Id) {
        this.prod4Id = prod4Id;
    }

    public int getProd4Quantity() {
        return prod4Quantity;
    }

    public void setProd4Quantity(int prod4Quantity) {
        this.prod4Quantity = prod4Quantity;
    }
    
    
}
