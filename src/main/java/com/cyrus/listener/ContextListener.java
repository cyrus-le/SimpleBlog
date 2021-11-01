/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/ServletListener.java to edit this template
 */
package com.cyrus.listener;

import com.cyrus.utils.PropertiesFileUtil;
import java.io.File;
import java.util.Properties;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.apache.log4j.PropertyConfigurator;

/**
 * Web application lifecycle listener.
 *
 * @author Cyrus
 */
public class ContextListener implements ServletContextListener {

    @Override

    public void contextInitialized(ServletContextEvent sce) {
        //config log4j
        ServletContext context = sce.getServletContext();
        String log4jLocation = context.getInitParameter("log4j-config-location");
        String fullPath = context.getRealPath("") + File.separator + log4jLocation;

        System.setProperty("PATH", context.getRealPath("")); //dùng đường dẫn động trong log4j.property

        PropertyConfigurator.configure(fullPath);
        //config sitemap
        String siteMapLocation = context.getInitParameter("SITEMAP_PROPERTIES_FILE_LOCATION");
        Properties siteMapProp = PropertiesFileUtil.getProperties(context, siteMapLocation);
        context.setAttribute("SITE_MAP", siteMapProp);

        //config authentication
        String authenticationLocation = context.getInitParameter("AUTHENTICATION_PROPERTIES_FILE_LOCATION");
        Properties authenticationProp = PropertiesFileUtil.getProperties(context, authenticationLocation);
        context.setAttribute("AUTHENTICATION_LIST", authenticationProp);

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
