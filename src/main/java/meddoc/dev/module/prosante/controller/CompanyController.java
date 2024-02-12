package meddoc.dev.module.prosante.controller;

import jakarta.transaction.Transactional;
import meddoc.dev.genericUsage.RequestBodyMap.SignUpMap;
import meddoc.dev.genericUsage.genericController.CrudEntityController;
import meddoc.dev.genericUsage.genericModel.Role;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.genericUsage.genericService.RoleService;
import meddoc.dev.genericUsage.genericService.SignUpService;
import meddoc.dev.genericUsage.genericService.UserService;
import meddoc.dev.module.prosante.constant.RoleName;
import meddoc.dev.module.prosante.model.Company;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.prosante.service.CompanyService;
import meddoc.dev.module.prosante.service.HealthProService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/company")
public class CompanyController extends CrudEntityController<Company,Integer> {
    @Autowired
    UserService userService;
    @Autowired
    SignUpService signUpService;
    @Autowired
    RoleService roleService;
    @Autowired
    HealthProService healthProService;
    @GetMapping("/healthPros")
    public ResponseEntity<List<HealthPro>> getHealthProList(){
        User companyManager = userService.getCurrentLoggedInUser();
        List<HealthPro> healthProList = getCompanyService().getLhealthPro(companyManager.getCompany_info());
        return ResponseEntity.ok(healthProList);
    }
    @GetMapping("/healthPro/{id}")
    public ResponseEntity<HealthPro> getHealthPro(@PathVariable int id){
        User companyManager = userService.getCurrentLoggedInUser();
        HealthPro healthPro = healthProService.getHealthProByCompanyAndId(companyManager.getCompany_info().getId(),id);
        return ResponseEntity.ok(healthPro);
    }
    @GetMapping("/{id}")
    public ResponseEntity<Company> getCompany(@PathVariable int id){
        Company company= getCompanyService().findById(id);
        return ResponseEntity.ok(company);
    }
    @PutMapping("desactivate/{id}")
    @PreAuthorize("hasRole('secretary')")
    public ResponseEntity<String> desactivateAccount(@PathVariable int healthProId){
        User user=userService.getCurrentLoggedInUser();
        HealthPro healthPro = healthProService.getHealthProByCompanyAndId(user.getCompany_info().getId(),healthProId);
        getCompanyService().desactivateAccount(healthPro);
        return ResponseEntity.ok("Success");
    }
    @PutMapping("activate/{id}")
    @PreAuthorize("hasRole('secretary')")
    public ResponseEntity<String> ativateAccount(@PathVariable int healthProId){
        User user=userService.getCurrentLoggedInUser();
        HealthPro healthPro = healthProService.getHealthProByCompanyAndId(user.getCompany_info().getId(),healthProId);
        getCompanyService().isEnoughHeatltPro(user.getCompany_info());
        Role role=roleService.getRoleByName(RoleName.HEALTHPRO);
        getCompanyService().activateAccount(healthPro,role);
        return ResponseEntity.ok("Success");
    }
    @Transactional
    @PostMapping("/addHealthPro")
    public ResponseEntity<String> addHealthPro(@RequestBody SignUpMap<HealthPro> signUpMap){
        User companyManager = userService.getCurrentLoggedInUser();
        getCompanyService().isEnoughHeatltPro(companyManager.getCompany_info());
        String confirmPassword = signUpMap.getConfirmPassword();
        HealthPro hPro = signUpMap.getProfile();
        User hUser = signUpMap.getUser();
        hUser.setRole(roleService.getRoleByName(RoleName.HEALTHPRO));
        hPro.setCompany(companyManager.getCompany_info());
        try{
            healthProService.save(hPro);
            signUpService.saveUser(hUser,confirmPassword);
            return ResponseEntity.ok("success");
        }catch (RuntimeException e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @Override
    @Autowired
    @Qualifier("companyService")
    public void setService(GenericService<Company,Integer> service) {
        this.service = service;
    }
    public CompanyService getCompanyService(){
        return (CompanyService)this.service;
    }
    
}
