package meddoc.dev.module.prosante.controller;

import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.UserService;
import meddoc.dev.module.prosante.model.V_account_status;
import meddoc.dev.module.prosante.model.V_appointment_progress;
import meddoc.dev.module.prosante.model.V_pointage_healthpro;
import meddoc.dev.module.prosante.model.V_pointage_patient;
import meddoc.dev.module.prosante.service.V_account_st_service;
import meddoc.dev.module.prosante.service.V_appointmentService;
import meddoc.dev.module.prosante.service.ViewService;
import org.apache.http.client.protocol.ResponseProcessCookies;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/view")

public class ViewController  {
    @Autowired
    ViewService viewService;
    @Autowired
    UserService userService;
    @Autowired
    V_appointmentService v_appointmentService;
    @Autowired
    V_account_st_service v_account_st_service;
    @GetMapping("/healthpro")
    @PreAuthorize("hasRole('admin')")
    public ResponseEntity<Page<V_pointage_healthpro>> getV_pointage_hpro(Pageable pageable){
        Page<V_pointage_healthpro> page=viewService.getV_pointage_hpro_rep().findAll(Specification.where(null),pageable);
        return ResponseEntity.ok(page);
    }
    @GetMapping("/patient")
    @PreAuthorize("hasRole('admin')")
    public ResponseEntity<Page<V_pointage_patient>> getV_pointage_patient(Pageable pageable){
        Page<V_pointage_patient> page = viewService.getV_pointage_patient_rep().findAll(Specification.where(null),pageable);
        return ResponseEntity.ok(page);
    }
    @GetMapping("/healthPro/appointment")
    @PreAuthorize("hasRole('healthpro')")
    public ResponseEntity<List<V_appointment_progress>> getHealthProAppointment(){
        User user=userService.getCurrentLoggedInUser();
        int hId=user.getHealthpro_info().getId();
        List<V_appointment_progress> list=v_appointmentService.getAppointmentProgress(hId);
        return ResponseEntity.ok(list);
    }
    @GetMapping("/accountStatus")
    @PreAuthorize("hasRole('admin')")
    public ResponseEntity<V_account_status> getAccountStatus(){
        V_account_status v_account_status=v_account_st_service.getAccountStatus();
        return ResponseEntity.ok(v_account_status);
    }
}
