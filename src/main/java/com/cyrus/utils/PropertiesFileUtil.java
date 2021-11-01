/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cyrus.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import javax.servlet.ServletContext;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
public class PropertiesFileUtil {

    public static Properties getProperties(ServletContext context, String fileRelativePath) {
        InputStream input = context.getResourceAsStream(fileRelativePath);
        Properties prop = null;
        try {
            prop = new Properties();
            prop.load(input);
        } catch (IOException ex) {
            Logger.getLogger(PropertiesFileUtil.class.getName()).log(Level.ERROR, null, ex);
        }
        return prop;
    }
}
