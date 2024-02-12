package meddoc.dev.genericUsage.RequestBodyMap;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import meddoc.dev.genericUsage.genericModel.HasId;
import meddoc.dev.genericUsage.genericModel.User;

@Data
public class SignUpMap<L extends HasId>{
//    @NotNull(message = "profile required")
    L profile;
//    @NotBlank(message = "user not found !")
    User user;
//    @NotBlank(message = "confirmPassword required")
    String confirmPassword;
}
