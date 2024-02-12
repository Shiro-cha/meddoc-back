package meddoc.dev.genericUsage.genericService;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import meddoc.dev.genericUsage.genericModel.Role;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericRepo.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import meddoc.dev.security.service.JwtService;

import java.util.HashMap;

@Service
@RequiredArgsConstructor
public class LoginService {
    private User user;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private JwtService jwtService;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    public User getUserByEmailOrContact(String login){
        User user=userRepository.findByLogin(login)
                .orElseThrow(() -> new RuntimeException("adresse mail invalide"));
        return user;
    }
    public void isPasswordCorrect(String password){
        if(!bCryptPasswordEncoder.matches(password,getUser().getPassword())){
            throw new RuntimeException("Mot de passe  incorrect");
        }
    }
    public String getToken(){
        HashMap<String, Object> claims = new HashMap<>();
        claims.put("name",getName(getUser()));
        return jwtService.generateToken(claims,getUser());
    }
    public String getName(User user){
        if(user.getHealthpro_info()!=null) return user.getHealthpro_info().getName();
        else if(user.getPatient_info()!=null) return user.getPatient_info().getFirstname();
        else if(user.getCompany_info()!=null) return user.getCompany_info().getName();
        else return "Administateur";
    }
    public User getUserByOtp(String otp){
        String username= SecurityContextHolder.getContext().getAuthentication().getName();
        User user=userRepository.findByLoginAndDigitCode(username,otp)
                .orElseThrow(()->new RuntimeException("Email or otp incorrect"));
        return user;
    }
    public User getUser() {
        if(user==null)
            throw new RuntimeException("user is null set user first");
        return user;
    }
    public void setUser(User user) {
        this.user = user;
    }
    @Transactional
    public void addRoleToUser(Role role){
        getUser().setRole(role);
        userRepository.save(getUser());
    }
}
