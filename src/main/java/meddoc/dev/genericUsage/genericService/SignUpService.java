package meddoc.dev.genericUsage.genericService;


import lombok.RequiredArgsConstructor;
import meddoc.dev.genericUsage.genericModel.OtpValidation;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericRepo.UserRepository;
import meddoc.dev.mailer.model.Mail;
import meddoc.dev.security.service.JwtService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
@RequiredArgsConstructor
public class SignUpService {
    private User user;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private JwtService jwtService;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    public void saveUser(User user,String confirmPassword){
        setUser(user);
        isSameAsUserPassword(confirmPassword);
        encryptUserPassword();
        saveUser();
    }
    public void isSameAsUserPassword(String confirmPassword){
        if(getUser().getPassword().compareTo(confirmPassword)!=0){
            throw new RuntimeException("Le mot de passe et la confirmation ne sont pas identiques");
        }
    }
    public void encryptUserPassword(){
        String encryptedPass=bCryptPasswordEncoder.encode(getUser().getPassword());
        getUser().setPassword(encryptedPass);
    }
    public void saveUser(){
        try{
            userRepository.save(getUser());
        }catch (DataIntegrityViolationException e) {
            throw new RuntimeException("Le mail ou le numero deja utilise");
        }
    }
    public String getToken(String name){
        HashMap<String,Object> claims=new HashMap<>();
        claims.put("name",name);
        String token= jwtService.generateToken(claims,getUser());
        return token;
    }
    public Mail buildActivationMail(OtpValidation otp){
        String body="<div style=\"font-family: Helvetica,Arial,sans-serif;min-width:1000px;overflow:auto;line-height:2\">\n" +
                "  <div style=\"margin:50px auto;width:70%;padding:20px 0\">\n" +
                "    <div style=\"border-bottom:1px solid #eee\">\n" +
                "      <a href=\"\" style=\"font-size:1.4em;color: #00466a;text-decoration:none;font-weight:600\">MEDDoC</a>\n" +
                "    </div>\n" +
                "    <p style=\"font-size:1.1em\">Bonjour ,</p>\n" +
                "    <p> Voici le code  OTP pour completer votre inscription sur MEDDoC. OTP est valide pour une duree de 5 minutes</p>\n" +
                "    <h2 style=\"background: #00466a;margin: 0 auto;width: max-content;padding: 0 10px;color: #fff;border-radius: 4px;\">"+otp.getDigit_code()+"</h2>\n" +
                "    <p style=\"font-size:0.9em;\">Regards,<br />MEDDoC</p>\n" +
                "    <hr style=\"border:none;border-top:1px solid #eee\" />\n" +
                "    <div style=\"float:right;padding:8px 0;color:#aaa;font-size:0.8em;line-height:1;font-weight:300\">\n" +
                "      <p>MEDDoC/p>\n" +
                "      <p>Antananarivo</p>\n" +
                "    </div>\n" +
                "  </div>\n" +
                "</div>";
        Mail mail=new Mail();
        mail.setBody(body);
        mail.setTo(getUser().getEmail());
        mail.setSubject("confirmation de votre compte MEDDOC ");
        return mail;
    }
    public User getUser(){
        if(user==null)
            throw new RuntimeException("user is null set user first");
        return user;
    }
    public void setUser(User user) {
        this.user = user;
    }
}
