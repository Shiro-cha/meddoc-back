package meddoc.dev.module.patient.Dto;

import lombok.Data;
import meddoc.dev.genericUsage.genericDto.GenericDto;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.module.patient.model.Patient;
import meddoc.dev.module.patient.model.Relationship;
import java.sql.Date;
import java.sql.Timestamp;

@Data
public class PatientDto extends GenericDto<Patient> {
    private int id;
    private int user_id;
    private String identifier;
    private String name;
    private String firstname;
    private String address;
    private boolean gender;
    private Date birthdate;
    private Relationship relationship;
    private Timestamp latestAppointment;
    private String contact;
    private String email;
    private int totalAppointment;
    public PatientDto() {
    }
    public PatientDto(User user, Timestamp latestAppointment, int totalAppointment) {
        Patient patient=user.getPatient_info();
        this.setUser_id(user.getId());
        this.setContact(user.getContact());
        this.setEmail(user.getEmail());
        this.setId(patient.getId());
        this.setIdentifier(patient.getIdentifier());
        this.setName(patient.getName());
        this.setFirstname(patient.getFirstname());
        this.setGender(patient.isGender());
        this.setBirthdate(patient.getBirthdate());
        this.totalAppointment=totalAppointment;
        if(latestAppointment!=null){
            this.setLatestAppointment(latestAppointment);
        }
    }
    public PatientDto(Patient patient,User user) {
        this.setId(patient.getId());
        this.setIdentifier(patient.getIdentifier());
        this.setName(patient.getName());
        this.setFirstname(patient.getFirstname());
        this.setGender(patient.isGender());
        this.setBirthdate(patient.getBirthdate());
        this.setRelationship(patient.getRelationship());
        this.setUser_id(user.getId());
        this.setContact(user.getContact());
        this.setEmail(user.getEmail());
    }
    @Override
    public Patient toModel() {
        Patient patient = new Patient();
        patient.setId(this.getId());
        patient.setIdentifier(this.getIdentifier());
        patient.setName(this.getName());
        patient.setFirstname(this.getFirstname());
        patient.setGender(this.isGender());
        patient.setRelationship(this.getRelationship());
        patient.setBirthdate(this.getBirthdate());
        return patient;
    }
    @Override
    public void fromModel(Patient model) {
        this.setId(model.getId());
        this.setIdentifier(model.getIdentifier());
        this.setName(model.getName());
        this.setFirstname(model.getFirstname());
        this.setGender(model.isGender());
        this.setRelationship(model.getRelationship());
        this.setBirthdate(model.getBirthdate());

    }
}
