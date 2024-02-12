package meddoc.dev.genericUsage.statistique;

import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.UserService;
import meddoc.dev.module.prosante.model.Company;
import meddoc.dev.module.prosante.model.HealthPro;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/stat")
public class StatController {
    @Autowired
    StatService statservice;
    @Autowired
    UserService userService;
    @GetMapping("/patient")
    @PreAuthorize("hasRole('patient')")
    public ResponseEntity<AppointmentStat> getPatientStat(@RequestParam(required = false,defaultValue = "0") int month, @RequestParam(required = false,defaultValue = "0") int year){
        User user=userService.getCurrentLoggedInUser();
        return ResponseEntity.ok(statservice.getPatientOrHealthProStat(user.getId(),0,month,year));
    }
    @GetMapping("/healthPro")
    @PreAuthorize("hasRole('healthpro')")
    public ResponseEntity<AppointmentStat> getHealthProStat(@RequestParam(required = false,defaultValue = "0") int month,@RequestParam(required = false,defaultValue = "0") int year){
        HealthPro hpro=userService.getCurrentLoggedInUser().getHealthpro_info();
        return ResponseEntity.ok(statservice.getPatientOrHealthProStat(0, hpro.getId(),month,year));
    }
    @GetMapping("/company")
    @PreAuthorize("hasRole('manager')")
    public ResponseEntity<AppointmentStat> getCompany(@RequestParam(required = false,defaultValue = "0") int month,@RequestParam(required = false,defaultValue = "0") int year){
        Company company=userService.getCurrentLoggedInUser().getCompany_info();
        return ResponseEntity.ok(statservice.getCompanyStat(company.getId(),month,year));
    }
}
