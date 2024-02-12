package meddoc.dev.module.prosante.Dto;

import lombok.Data;
import meddoc.dev.module.prosante.model.Consultation;
import meddoc.dev.module.prosante.model.Event;

import java.sql.Timestamp;
import java.util.HashMap;

@Data
public class EventDto {
    int id;
    HashMap<String,Object> patient;
    Timestamp start_dt;
    Timestamp end_dt;
    String reason;
    String event_name;
    String consultation;
    public EventDto(Event event, String event_name){
        this.id=event.getId();
        this.start_dt=event.getStart_dt();
        this.end_dt=event.getEnd_dt();
        if(event.getPatient()!=null) {
            this.patient = new HashMap<>();
            this.patient.put("id", event.getPatient().getId());
            this.patient.put("name", event.getPatient().getName());
            this.patient.put("firstname", event.getPatient().getFirstname());
        }
        this.reason=event.getReason();
        this.event_name=event_name;
        this.consultation=event.getConsultation();
    }

}
