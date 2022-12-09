/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import org.json.JSONObject;

/**
 *
 * @author luciano
 */
public class JSON {
    
    private HttpServletRequest request;

    public JSON() {
        
    }
    
    public HttpServletRequest getRequest() {
        return request;
    }

    public void setRequest(HttpServletRequest request) {
        this.request = request;
    }

    public JSONObject convertToJSON(HttpServletRequest request) throws IOException{
    
        StringBuilder buffer = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;

        while((line = reader.readLine()) != null) {
                buffer.append(line);
        }

        String data = buffer.toString();
        JSONObject jsonReq = new JSONObject(data);
        
        return jsonReq;
    
    }
    
    
    
    
}
