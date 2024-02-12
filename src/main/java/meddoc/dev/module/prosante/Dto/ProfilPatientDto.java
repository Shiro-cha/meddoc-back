package meddoc.dev.module.prosante.Dto;

import lombok.Data;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.module.patient.model.Patient;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.prosante.model.V_pointage_patient;

import java.util.Date;

@Data
public class ProfilPatientDto extends HasStatDto {
    int id;
    int patient_id;
    String identifiant;
    String name;
    String role;
    String firstname;
    String email;
    String contact;
    String address;
    String orderNum;
    String affiliationOrder;
    String speciality_name;
    Date birthdate;
    Date created_at;
    public ProfilPatientDto(User user, Patient patient){
        this.id=user.getId();
        this.email=user.getEmail();
        this.contact=user.getContact();
        this.address=user.getAddress();
        this.identifiant=patient.getIdentifier();
        if(user.getRole()!=null)
            this.role=user.getRole().getName();
        
        this.created_at=user.getCreated_at();
    }
    public ProfilPatientDto(V_pointage_patient v_pointage_patient){
        this(v_pointage_patient.getUser(),v_pointage_patient.getUser().getPatient_info());
        this.total=v_pointage_patient.getTotal();
        this.appointment= getPercentage(v_pointage_patient.getAppointment(),total).doubleValue();
        this.cancelled_by_patient=getPercentage(v_pointage_patient.getCancelled_by_patient(),total).doubleValue();
        this.feed_back=getPercentage(v_pointage_patient.getFeed_back(),total).doubleValue();
        this.made =getPercentage(v_pointage_patient.getMade(),total).doubleValue();
    }

}
