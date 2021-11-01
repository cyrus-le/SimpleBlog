/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cyrus.utils;

/**
 *
 * @author Cyrus
 */
public class CalculatingPagingUtil {

    public static int totalPageNum(int numberRecords, int objectPerPage) {
        int totalPageNum = numberRecords / objectPerPage;
        if (numberRecords % objectPerPage!= 0) {
            totalPageNum++;
        }
        return totalPageNum;
    }
}
