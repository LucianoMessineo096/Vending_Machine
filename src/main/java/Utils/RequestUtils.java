/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Enumeration;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author luciano
 */
public class RequestUtils {
    
    public void print(HttpServletRequest request) throws IOException{
        
        System.out.println("URL: " + request.getRequestURL());
        System.out.println("Method: " + request.getMethod());
        System.out.println("Headers: ");
        Enumeration<String> headerNames = request.getHeaderNames();
        while (headerNames.hasMoreElements()) {
            String headerName = headerNames.nextElement();
            System.out.println(headerName + ": " + request.getHeader(headerName));
        }
        System.out.println("Body: ");
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            System.out.println(line);
        }
    }
     
}
