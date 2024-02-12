package meddoc.dev.module.patient.controller;

import lombok.Setter;
import meddoc.dev.genericUsage.genericController.CrudEntityController;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.UserService;
import meddoc.dev.module.patient.Dto.PatientDto;
import meddoc.dev.module.patient.model.Patient;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.module.patient.service.PatientService;
import meddoc.dev.module.prosante.Dto.PatientEventDto;
import meddoc.dev.module.prosante.RequestMap.ProfilMap;
import meddoc.dev.module.prosante.constant.EventType;
import meddoc.dev.module.prosante.model.Event;
import meddoc.dev.module.prosante.model.HealthPro;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import static meddoc.dev.module.prosante.specification.EventSpecification.hasEventTypeId;
import static meddoc.dev.module.prosante.specification.EventSpecification.userHasId;

@RestController
@Setter
@RequestMapping("/patient")
@PreAuthorize("hasRole('patient')")
public class PatientController extends CrudEntityController<Patient, Integer> {
    @Autowired
    private UserService userService;
    @GetMapping("/findRelative")
    public Page<PatientDto> findRelative(@RequestParam(required = false) String keyword,Pageable pageable) {
        User user = userService.getCurrentLoggedInUser();
        Page<Patient> patients= getPatientService().findRelative(user.getId(),keyword,pageable);
        return patients.map(patient -> {
            PatientDto patientDto = new PatientDto();
            patientDto.fromModel(patient);
            return patientDto;
        });
    }
    @PutMapping("/updateProfil")
    @PreAuthorize("hasRole('patient')")
    public ResponseEntity<String> updateProfil(@RequestBody ProfilMap profilMap) throws IOException {
        User user=userService.getCurrentLoggedInUser();
        Patient patient=user.getPatient_info();
        patient.setName(profilMap.getName());
        patient.setFirstname(profilMap.getFirstname());
        if(patient.getBirthdate()!=null)
            patient.setBirthdate(profilMap.getBirthdate());
        getPatientService().save(patient);
        if(profilMap.getContact()!=null)
            user.setContact(profilMap.getContact());
        userService.save(user);
        return ResponseEntity.ok("success");
    }
    @GetMapping("/getPatientInfo")
    @PreAuthorize("hasRole('patient')")
    public ResponseEntity<PatientDto> getPatientInfo(){
        User user=userService.getCurrentLoggedInUser();
        Patient patient=user.getPatient_info();
        PatientDto patientDto=new PatientDto(patient,user);
        return ResponseEntity.ok(patientDto);
    }

    @Autowired
    @Qualifier("patientService")
    public void setService(GenericService<Patient,Integer> service) {
        this.service = service;
    }
    public PatientService getPatientService(){
        return (PatientService)this.service;
    }
}