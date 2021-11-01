package com.cyrus.utils;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.Serializable;
import java.security.SecureRandom;
import java.util.UUID;

/**
 *
 * @author Cyrus
 */
public final class SecureUUIDUtil implements Serializable {

	private static final String NUMBER_DICTIONARY = "0123456789";
	private static final String WORD_DICTIONARY = "abcdef";
	private static final String FINAL_DICTIONARY = NUMBER_DICTIONARY
		+ WORD_DICTIONARY;

	public static final String getSecureUUID() {
		final StringBuilder sb = new StringBuilder();
		final SecureRandom rand = new SecureRandom();
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		for (int i = 0; i < 10; i++) {
			sb.append(FINAL_DICTIONARY
				.charAt(rand.nextInt(FINAL_DICTIONARY.length())));
		}
		uuid += sb.toString();
		return uuid;
	}
}
