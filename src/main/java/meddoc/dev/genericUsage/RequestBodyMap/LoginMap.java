package meddoc.dev.genericUsage.RequestBodyMap;

import jakarta.validation.constraints.NotBlank;

@lombok.Data
public class LoginMap{

    @NotBlank(message = "username required")
    private String username;
    @NotBlank(message = "password required")
    private String password;
}
