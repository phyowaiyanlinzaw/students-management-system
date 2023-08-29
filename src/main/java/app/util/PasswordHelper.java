package app.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordHelper {
    public static String hashPassword(String userInputPassword){
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        return passwordEncoder.encode(userInputPassword);
    }

    public static boolean checkPassword(String userInputPassword, String hashedPassword){
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        return passwordEncoder.matches(userInputPassword, hashedPassword);
    }
}
