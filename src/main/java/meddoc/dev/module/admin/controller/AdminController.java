package meddoc.dev.module.admin.controller;

import meddoc.dev.genericUsage.genericController.CrudEntityController;
import meddoc.dev.genericUsage.genericModel.Role;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.genericUsage.genericService.RoleService;
import meddoc.dev.genericUsage.genericService.UserService;
import meddoc.dev.module.prosante.Dto.ProfilHproDto;
import meddoc.dev.module.prosante.Dto.ProfilPatientDto;
import meddoc.dev.module.prosante.constant.RoleName;
import meddoc.dev.module.prosante.model.Company;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.prosante.model.V_pointage_healthpro;
import meddoc.dev.module.prosante.model.V_pointage_patient;
import meddoc.dev.module.search.service.CompanySearchService;
import meddoc.dev.module.search.service.ElasticService;
import meddoc.dev.module.search.service.HealthProSearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/admin")
@PreAuthorize("hasRole('admin')")
public class AdminController extends CrudEntityController<User,Integer>{
    @Autowired
    RoleService roleService;
    @Autowired
    ElasticService elasticService;
    @Autowired
    CompanySearchService companySearchService;
    @Autowired
    HealthProSearchService healthProSearchService;
    @GetMapping("/unacUsers")
    public ResponseEntity<HashMap<String,List<?>>> getUnactivatedUsers(){
        return  ResponseEntity.ok(getUserService().getUnactivatedUsers());
    }
    @PutMapping("/activateUser/{user_id}")
    public ResponseEntity<String> activateUser(@PathVariable("user_id") int user_id) throws IOException {
        User user = getUserService().findById(user_id);
        Role role=roleService.getCorrespondingRole(user);
        getUserService().activateUser(user,role);
        addToElastic(user);
        return ResponseEntity.ok("user account activated");
    }
    @PutMapping("/deactivateUser/{user_id}")
    public ResponseEntity<String> deactivateUser(@PathVariable("user_id") int user_id) throws IOException {
        User user = getUserService().findById(user_id);
        Role role=roleService.getCorrespondingRole(user);
        getUserService().deactivateUser(user);
        removeFromElastic(user,role);
        return ResponseEntity.ok("user account deactivated");
    }
    @GetMapping("/healthPro/{id}")
    public ResponseEntity<HealthPro> getHealthProById(@PathVariable int id){
        User user = getUserService().findById(id);
        HealthPro healthPro = user.getHealthpro_info();
        return ResponseEntity.ok(healthPro);
    }
    @GetMapping("/company/{id}")
    public ResponseEntity<Company> getCompanyById(@PathVariable int id){
        User user = getUserService().findById(id);
        Company company= user.getCompany_info();
        return ResponseEntity.ok(company);
    }
    @GetMapping("/healthProUsers")
    public ResponseEntity<Page<?>> getHealthProUser(@RequestParam(required = false) String keyword,
                                                    @RequestParam(required = false,defaultValue = "0") double feed_back,
                                                    @RequestParam(required = false,defaultValue = "0") double cancel,
                                                    @RequestParam(required = false,defaultValue = "3") int roleSum,
                                                    Pageable pageable){
        Page<V_pointage_healthpro> page = getUserService().getHealthProUsers(keyword,feed_back,cancel,roleSum,pageable);
        Page<ProfilHproDto> pageHpro=page.map(pg->new ProfilHproDto(pg));
        return  ResponseEntity.ok(pageHpro);
    }
    @GetMapping("/patientUsers")
    public ResponseEntity<Page<?>> getPatientUser(@RequestParam(required = false) String keyword,
                                                  @RequestParam(required = false,defaultValue = "0") double missed,
                                                  @RequestParam(required = false,defaultValue = "0") double cancel,
                                                  @RequestParam(required = false,defaultValue = "3") int roleSum,
                                                  Pageable pageable){

        Page<V_pointage_patient> page = getUserService().getPatientUsers(keyword,missed,cancel,roleSum,pageable);
        Page<ProfilPatientDto> pagePatient=page.map(pg->new ProfilPatientDto(pg));
        return  ResponseEntity.ok(pagePatient);
    }

    private void addToElastic(User user) throws IOException {
        if(user.getRole().getName().compareToIgnoreCase(RoleName.HEALTHPRO.name())==0) {
            healthProSearchService.saveHealthPro(user);
        }
        else if(user.getRole().getName().compareToIgnoreCase(RoleName.SECRETARY.name())==0) {
            companySearchService.saveCompany(user);
        }
    }
    private void removeFromElastic(User user,Role role) throws IOException {
        if(role.getName().compareToIgnoreCase(RoleName.HEALTHPRO.name())==0 )
            healthProSearchService.deleteHealthPro(user);
        else if(role.getName().compareToIgnoreCase(RoleName.SECRETARY.name())==0)
            companySearchService.deleteCompany(user);
    }

    @Autowired
    @Override
    public void setService(GenericService<User, Integer> service) {
        this.service = service;
    }

    public UserService getUserService(){
        return (UserService) this.service;
    }
}
