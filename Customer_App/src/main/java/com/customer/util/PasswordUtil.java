package com.customer.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // Generate a hash from a plaintext password
    public static String hashPassword(String plainTextPassword) {
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
    }

    // Check if the provided plaintext password matches the hashed password
    public static boolean checkPassword(String plainTextPassword, String hashedPassword) {
        return BCrypt.checkpw(plainTextPassword, hashedPassword);
    }
}
