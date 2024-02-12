package meddoc.dev.genericUsage.RequestBodyMap;

import jakarta.validation.constraints.NotEmpty;
import lombok.Data;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Data
public class ChangePasswordMap {
    @NotEmpty(message = "Confirm password is required")
     String confirmPassword;
    @NotEmpty(message = "New password is required")
    String newPassword;

}
