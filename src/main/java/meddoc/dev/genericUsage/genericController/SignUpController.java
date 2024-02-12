package meddoc.dev.genericUsage.genericController;

import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import meddoc.dev.genericUsage.genericModel.OtpValidation;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.OtpService;
import meddoc.dev.genericUsage.genericService.SignUpService;
import meddoc.dev.mailer.model.Mail;
import meddoc.dev.mailer.service.MailerService;
import meddoc.dev.genericUsage.RequestBodyMap.SignUpMap;
import meddoc.dev.module.patient.model.Patient;
import meddoc.dev.module.patient.service.PatientService;
import meddoc.dev.module.prosante.model.Company;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.prosante.service.AgendaService;
import meddoc.dev.module.prosante.service.CompanyService;
import meddoc.dev.module.prosante.service.HealthProService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/signup")
public class SignUpController {
    @Autowired
    SignUpService signUpService;
    @Autowired
    private MailerService mailerService;
    @Autowired
    private OtpService otpService;
    @Autowired
    private PatientService patientService;
    @Autowired
    private CompanyService companyService;
    @Autowired
    private HealthProService healthProService;
    @PostMapping("/patient")
    @Transactional
    public ResponseEntity<String> SignUpPatient(
            @Valid @RequestBody SignUpMap<Patient> signUpModel
    ) {
        User user=signUpModel.getUser();
        String confirmPassword = signUpModel.getConfirmPassword();
        Patient patient = signUpModel.getProfile();
        try{
            patientService.save(patient);
            user.setPatient_info(patient);
            signUpService.saveUser(user,confirmPassword);
            OtpValidation otpValidation=otpService.generateOtpValidation(user);
            Mail activationMail=signUpService.
                    buildActivationMail(otpValidation);
            otpService.save(otpValidation);
            sendMailAsync(activationMail);
            return ResponseEntity.ok(signUpService.getToken(patient.getName()));
        }catch (RuntimeException e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
    @PostMapping("/healthPro")
    @Transactional
    public ResponseEntity<?> SignUpHealthPro(
            @Valid @RequestBody SignUpMap<HealthPro> signUpModel
    ) {
        User user=signUpModel.getUser();
        String confirmPassword = signUpModel.getConfirmPassword();
        HealthPro hpro = signUpModel.getProfile();
        try{
            healthProService.save(hpro);
            user.setHealthpro_info(hpro);
            signUpService.saveUser(user,confirmPassword);
            return ResponseEntity.ok("success");
        }catch (RuntimeException e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
    @PostMapping("/company")
    @Transactional
    public ResponseEntity<String> SignUpCompany(
            @Valid @RequestBody SignUpMap<Company> signUpModel
    ) {
        User user=signUpModel.getUser();
        String confirmPassword = signUpModel.getConfirmPassword();
        Company company = signUpModel.getProfile();
        try{
            companyService.save(company);
            user.setCompany_info(company);
            signUpService.saveUser(user,confirmPassword);
            return ResponseEntity.ok("success");
        }catch (RuntimeException e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    private void sendMailAsync(Mail mail){
        Thread thread= new Thread(() -> mailerService.sendMail(mail));
        thread.start();
    }
}
