/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Security;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author luciano
 */
public class PasswordEncryption {
    
    String password;
    
    public PasswordEncryption(){
        
        
    }
    
    public String getPassword(){
        
        return this.password;
    }
    
    public void setPassword(String password){
        
        this.password=password;
    }
    
    public String cypher(String password) throws NoSuchAlgorithmException, UnsupportedEncodingException{
        
        return toHex(getSHA(password));
    
    }
    
    public static String toHex(byte[] hash){
        
        //convert hash into digest
        BigInteger digest = new BigInteger(1,hash);
        
        //convert digest into hex value
        StringBuilder hexString = new StringBuilder(digest.toString(16));
        
        //padding
        while(hexString.length()<32){
            
            hexString.insert(0,"0");
        }
        
        return hexString.toString();
    
    }
    
    public static byte[] getSHA(String password) throws NoSuchAlgorithmException, UnsupportedEncodingException{
    
    
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        
        byte[] hash = md.digest(password.getBytes("UTF-8"));
        
        return hash;
    }
    
    
    
}
