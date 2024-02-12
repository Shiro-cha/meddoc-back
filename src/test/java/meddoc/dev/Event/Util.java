package meddoc.dev.Event;

import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.module.patient.model.Patient;
import meddoc.dev.module.prosante.constant.EventType;
import meddoc.dev.module.prosante.model.Agenda;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.prosante.service.EventTypeService;
import org.junit.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import java.util.HashMap;

@Component
public class Util {
    @Autowired
    private EventTypeService eventTypeService;
    public int getEventTypeId(){
        return eventTypeService.getEventTypeId(EventType.APPOINTMENT);
    }
    public Patient getPatient(){
        Patient patient = new Patient();
        patient.setId(54);
        return patient;
    }
    public HealthPro getHealthPro(){
        HealthPro healthPro = new HealthPro();
        healthPro.setId(88);
        return healthPro;
    }
    public Agenda getAgenda(){
        Agenda agenda = new Agenda();
        agenda.setId(404);
        return agenda;
    }
    public HashMap<String,Object> getConsultation(){
        HashMap<String,Object> consultation = new HashMap<>();
        consultation.put("consultation","consultation");
        return consultation;
    }
    public User getUser(){
        User user = new User();
        user.setId(42);
        return user;
    }
}
