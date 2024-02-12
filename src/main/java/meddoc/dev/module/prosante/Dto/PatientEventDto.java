package meddoc.dev.module.prosante.Dto;

import lombok.Data;
import meddoc.dev.module.prosante.model.Event;

import java.sql.Timestamp;
@Data
public class PatientEventDto {
    int id;
    Timestamp rdv_date;
    int patient_id;
    String patient_name;
    String patient_first_name;
    int healthpro_id;
    String healthpro_name;
    String healthpro_firstname;
    String reason;
    String event_name;
    String consultation;
    public PatientEventDto(Event event,String  event_name){
        this.event_name=event_name;
        this.rdv_date=event.getStart_dt();
        this.healthpro_id=event.getHealthPro().getId();
        this.healthpro_name=event.getHealthPro().getName();
        this.healthpro_firstname=event.getHealthPro().getFirstName();
        this.reason=event.getReason();
        this.patient_id=event.getPatient().getId();
        this.patient_name=event.getPatient().getName();
        this.patient_first_name= event.getPatient().getFirstname();
        this.consultation= (event.getConsultation()==null)?"":event.getConsultation().toString();
        this.id=event.getId();
    }
}
