package meddoc.dev.genericUsage.genericController;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.RoleService;
import meddoc.dev.genericUsage.RequestBodyMap.LoginMap;
import meddoc.dev.genericUsage.genericService.LoginService;
import meddoc.dev.module.prosante.constant.RoleName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class LoginController {
    @Autowired
    private LoginService loginService;
    @Autowired
    private RoleService roleService;
    @PostMapping("/login")
    public ResponseEntity<String> login(
          @Valid @RequestBody LoginMap loginBody
    ) {
        String login=loginBody.getUsername();
        String password=loginBody.getPassword();
        try {
            User user=loginService.getUserByEmailOrContact(login);
            loginService.setUser(user);
            loginService.isPasswordCorrect(password);
            return ResponseEntity.ok(loginService.getToken());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
    @PostMapping("/validateOtp")
    public ResponseEntity<String> handleAccountValidation(
            @RequestBody String code
    ) {
        try {
           User user =loginService.getUserByOtp(code);
           loginService.setUser(user);
           loginService.addRoleToUser(roleService.getRoleByName(RoleName.PATIENT));
           return ResponseEntity.ok(loginService.getToken());
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

}
