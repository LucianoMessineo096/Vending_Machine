/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author luciano
 */
public class Product {
    
    private int id;
    private String name;
    private float price;
    private String typology;
    
    public Product(){
    
    }

    public Product(int id, String name, float price, String typology) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.typology = typology;
    }
    
    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the price
     */
    public float getPrice() {
        return price;
    }

    /**
     * @param price the price to set
     */
    public void setPrice(float price) {
        this.price = price;
    }

    /**
     * @return the typology
     */
    public String getTypology() {
        return typology;
    }

    /**
     * @param typology the typology to set
     */
    public void setTypology(String typology) {
        this.typology = typology;
    }
    
    
    
    
    
}
