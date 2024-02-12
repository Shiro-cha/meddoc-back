package meddoc.dev.module.patient.service;

import lombok.Setter;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.module.patient.model.Patient;
import meddoc.dev.module.patient.repository.PatientRepository;
import meddoc.dev.module.patient.specification.PatientSpecification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;
@Service("patientService")
@Setter
public class PatientService extends GenericService<Patient, Integer> {
    public Page<Patient> findRelative(int caretakerId,String keyword, Pageable pageable){
        Specification<Patient> specification= Specification.where(PatientSpecification.findByCaretaker(caretakerId));
        if(keyword!=null){
            specification=specification.and(PatientSpecification.findByName(keyword).or(PatientSpecification.findByFirstName(keyword)));
        }
        return getPatientRepository().findAll(specification,pageable);
    }
    @Autowired
    @Qualifier("patientRepository")
    public void setRepository(JpaRepository<Patient,Integer> repository){
        this.repository = repository;
    }
    public Patient getByIdentifier(String identifier) {
        return getPatientRepository().findByIdentifier(identifier).orElseThrow(()->new RuntimeException("Patient not found !"));
    }
    public List<Patient> findAllByCareTakerId(int id){
        return getPatientRepository().findAllByCareTakerId(id);
    }
    public PatientRepository getPatientRepository(){
        return (PatientRepository)this.repository;
    }
    public void updateRelative(User user, Patient patient,String identifier) {
        patient.setCareTaker(user);
        update(patient,identifier);
    }
    public void update(Patient patient,String identifier){
        Patient patient2Update=getByIdentifier(identifier);
        patient2Update.setFirstname(patient.getFirstname());
        patient2Update.setName(patient.getName());
        patient2Update.setBirthdate(patient.getBirthdate());
        patient2Update.setGender(patient.isGender());
        patient2Update.setRelationship(patient.getRelationship());
        patient2Update.setGender(patient.isGender());
        patient2Update.setBirthdate(patient.getBirthdate());
        patient2Update.setCareTaker(patient.getCareTaker());
        getPatientRepository().save(patient2Update);
    }
    public Patient getPatientByIdAndUser(int id,User user){
        if(user.getPatient_info().getId()==id || id==0)
            return user.getPatient_info();
        return getPatientRepository().findByIdAndUserId(id,user.getId())
                .orElseThrow(()->new RuntimeException("patient not found"));
    }

}
