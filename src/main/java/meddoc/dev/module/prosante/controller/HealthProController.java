package meddoc.dev.module.prosante.controller;

import jakarta.validation.constraints.NotNull;
import meddoc.dev.genericUsage.genericModel.Role;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.genericUsage.genericController.CrudEntityController;
import meddoc.dev.genericUsage.genericService.UserService;
import meddoc.dev.module.patient.Dto.PatientDto;
import meddoc.dev.module.prosante.Dto.ProfilHproDto;
import meddoc.dev.module.prosante.RequestMap.ProfilMap;
import meddoc.dev.module.prosante.constant.EventType;
import meddoc.dev.module.prosante.constant.RoleName;
import meddoc.dev.module.prosante.model.Agenda;
import meddoc.dev.module.prosante.model.AppointmentAvg;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.prosante.service.AgendaService;
import meddoc.dev.module.prosante.service.EventService;
import meddoc.dev.module.prosante.service.EventTypeService;
import meddoc.dev.module.prosante.service.HealthProService;
import meddoc.dev.module.search.service.CompanySearchService;
import meddoc.dev.module.search.service.HealthProSearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@Controller
@RequestMapping("/healthPro")
public class HealthProController extends CrudEntityController<HealthPro,Integer> {
    @Autowired
    UserService userService;
    @Autowired
    AgendaService agendaService;
    @Autowired
    EventService eventService;
    @Autowired
    EventTypeService eventTypeService;
    @Autowired
    HealthProSearchService healthProSearchService;
    @Autowired
    CompanySearchService companySearchService;
    @GetMapping("/patientList")
    @PreAuthorize("hasRole('healthpro')")
    public ResponseEntity<Page<PatientDto>> getHealthProPatient(Pageable pageable){
        int made=eventTypeService.getEventTypeId(EventType.MADE);
        HealthPro healthPro=getHealthPro();
        Page<User> page=userService.userEvents(healthPro.getId(),made,pageable);
        Page<PatientDto> patientDtoPage=page.map(user ->
            {
                Timestamp latestAppointment=getHealthProService().getLastAppointmentDate(healthPro.getId(), user.getId(),made);
                int totalAppointment=eventService.getTotalAppointment(healthPro.getId(), user.getId(),made);
                return new PatientDto(user,latestAppointment,totalAppointment);
            });
        return ResponseEntity.ok(patientDtoPage);
    }
    @PostMapping("/addDescription")
    @PreAuthorize("hasRole('healthpro')")
    public ResponseEntity<String> addDescription(@RequestBody String description) throws IOException {
        User user=userService.getCurrentLoggedInUser();
        HealthPro healthPro=getHealthPro();
        healthPro.setDescription(description);
        getHealthProService().save(healthPro);
        updateFromElastic(user,user.getRole(),description);
        return ResponseEntity.ok("success");
    }
    @PutMapping("/updateProfil")
    @PreAuthorize("hasRole('healthpro')")
    public ResponseEntity<String> updateProfil(@RequestBody ProfilMap profilMap) throws IOException {
        User user=userService.getCurrentLoggedInUser();
        HealthPro healthPro=getHealthPro();
        healthPro.setName(profilMap.getName());
        healthPro.setFirstName(profilMap.getFirstname());
        getHealthProService().save(healthPro);
        updateFromElastic(user,user.getRole(),healthPro.getDescription());
        return ResponseEntity.ok("success");
    }

    private void updateFromElastic(User user, Role role,String description) throws IOException {
        if(role.getName().compareToIgnoreCase(RoleName.HEALTHPRO.name())==0 )
            healthProSearchService.updateHealthPro(user,description);
        else if(role.getName().compareToIgnoreCase(RoleName.SECRETARY.name())==0)
            companySearchService.updateCompany(user,description);
    }
    @GetMapping("/getDescription/{id}")
    @PreAuthorize("hasRole('admin')")
    public ResponseEntity<ProfilHproDto> getDescription(@PathVariable int id){
        User user=userService.findById(id);
        HealthPro healthPro=getHealthProService().getHealthProByUser(user);
        ProfilHproDto profileHealthPro=new ProfilHproDto(user,healthPro);
        return ResponseEntity.ok(profileHealthPro);
    }

    @PostMapping("/saveAppointmentAvg")
    @PreAuthorize("hasRole('healthpro')")
    public ResponseEntity<String> saveAppointmentAvg(@NotNull @RequestBody AppointmentAvg appAvg){
        HealthPro healthPro=getHealthPro();
        appAvg.setHealthpro_id(healthPro.getId());
//        User user=userService.getCurrentLoggedInUser();
        agendaService.checkifValidDuration(appAvg.getDuration());
        agendaService.putCorrectCreated_atDate(appAvg);
        agendaService.checkIfItsSameAsLastAvgApp(appAvg);
        agendaService.addAppointmentAvg(appAvg);
        agendaService.reportAgendaBecauseOfAppAvg(appAvg,healthPro.getId(),getAppointmentId(),getPostponedId());
        return ResponseEntity.ok("success");
    }
    @GetMapping("/agendas")
    @PreAuthorize("hasRole('healthpro')")
    public ResponseEntity<List<Agenda>> getAgenda(){
        HealthPro healthPro=getHealthPro();
        List<Agenda> agendas=agendaService.getAgendaByHealthProId(healthPro.getId());
        return ResponseEntity.ok(agendas);
    }
    @GetMapping("/myprofile")
    @PreAuthorize("hasRole('healthpro')")
    public ResponseEntity<ProfilHproDto> getMyProfile(){
        HealthPro healthPro=getHealthPro();
        User user=userService.getCurrentLoggedInUser();
        ProfilHproDto profileHealthPro=new ProfilHproDto(user,healthPro);
        return ResponseEntity.ok(profileHealthPro);
    }
    @GetMapping("/{id}")
    public ResponseEntity<ProfilHproDto> getHealthProById(@PathVariable int id){
        HealthPro healthPro=service.findById(id);
        User user=userService.findByHealthProUser(healthPro.getId());
        ProfilHproDto profileHealthPro=new ProfilHproDto(user,healthPro);
        return ResponseEntity.ok(profileHealthPro);
    }
    @Override
    @Autowired
    @Qualifier("healthProService")
    public void setService(GenericService<HealthPro,Integer> service) {
        this.service = service;
    }
    public HealthProService getHealthProService(){
        return (HealthProService)this.service;
    }

    public HealthPro getHealthPro(){
        User user=userService.getCurrentLoggedInUser();
        HealthPro healthPro=getHealthProService().getHealthProByUser(user);
        return healthPro;
    }
    public int getAppointmentId(){
        int app_id=eventTypeService.getEventTypeId(EventType.APPOINTMENT);
        return app_id;
    }
    public int getPostponedId(){
        int postponed_id=eventTypeService.getEventTypeId(EventType.POSTPONED);
        return postponed_id;
    }
}
