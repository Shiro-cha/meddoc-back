package meddoc.dev.security.service;

import java.sql.Timestamp;
import java.util.Random;
public class CodeValidationGenerator {
    public static final int DURATION = 600000; // 10 minutes
    public static String generateCode() {
        StringBuilder code = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 6; i++) {
            int digit = random.nextInt(10); // Génère un chiffre aléatoire entre 0 et 9
            code.append(digit);
        }
        return code.toString();
    }

    public static Timestamp generateExpiresAt() {
        long currentTime = System.currentTimeMillis();
        long expirationTime = currentTime + DURATION;
        return new Timestamp(expirationTime);
    }
    public static Timestamp generateCreatedAt() {
        long currentTime = System.currentTimeMillis();
        return new Timestamp(currentTime);
    }
}
