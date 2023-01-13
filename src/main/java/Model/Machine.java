/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author luciano
 */
public class Machine {
    
    private int id;
    private String name;
    private String status;
    private int maxCapacity;
    private int actualCapacity;
    private String occupiedSince;
    
    public Machine(){
    
    
    }

    public Machine(int id, String name, String status, int maxCapacity, int actualCapacity,String occupiedSince) {
        this.id = id;
        this.name = name;
        this.status = status;
        this.maxCapacity = maxCapacity;
        this.actualCapacity = actualCapacity;
        this.occupiedSince=occupiedSince;
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
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * @return the maxCapacity
     */
    public int getMaxCapacity() {
        return maxCapacity;
    }

    /**
     * @param maxCapacity the maxCapacity to set
     */
    public void setMaxCapacity(int maxCapacity) {
        this.maxCapacity = maxCapacity;
    }

    /**
     * @return the actualCapacity
     */
    public int getActualCapacity() {
        return actualCapacity;
    }

    /**
     * @param actualCapacity the actualCapacity to set
     */
    public void setActualCapacity(int actualCapacity) {
        this.actualCapacity = actualCapacity;
    }

    public String getOccupiedSince() {
        return occupiedSince;
    }

    public void setOccupiedSince(String occupiedSince) {
        this.occupiedSince = occupiedSince;
    }
    
}
