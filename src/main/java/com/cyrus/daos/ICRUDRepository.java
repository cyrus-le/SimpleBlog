/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.daos;

import java.io.Serializable;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author Cyrus
 * @param <K>
 * @param <V>
 */
public interface ICRUDRepository<K,V> extends Serializable{
    public boolean insert(K k) throws SQLException, NamingException;
    public boolean delete(K k) throws SQLException, NamingException;
    public K get(V v) throws SQLException, NamingException;
    public boolean update(K k ,V v) throws SQLException, NamingException;
}
