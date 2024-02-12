package meddoc.dev.module.prosante.service;

import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.module.patient.model.Patient;
import meddoc.dev.module.patient.repository.PatientRepository;
import meddoc.dev.module.prosante.model.Event;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.prosante.repository.EventRepository;
import meddoc.dev.module.prosante.repository.HealthProRepository;
import meddoc.dev.module.prosante.specification.PatientSpecification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;

@Service
public class HealthProService extends GenericService<HealthPro,Integer> {
    @Autowired
    private PatientRepository patientRepository;
    @Autowired
    private EventRepository eventRepository;

    public HealthPro getHealthProByCompanyAndId(int compnayId,int healthProId) {
        return getRepository().findByCompanyIdAndId(compnayId,healthProId)
                .orElseThrow(()->new RuntimeException("health pro not found"));
    }
    public HealthPro getHealthProByUser(User user) {
        HealthPro healthPro=user.getHealthpro_info();
        if(healthPro==null){
            throw new RuntimeException("user is not a health pro");
        }
        return healthPro;
    }

    @Override
    @Autowired
    @Qualifier("healthProRepository")
    public void setRepository(JpaRepository<HealthPro, Integer> repository) {
        this.repository = repository;
    }

    public HealthProRepository getRepository(){
        return (HealthProRepository) this.repository;
    }
    public Page<User> getHealthProPatient(int id,int eventTypeId,String keyword,Pageable pageable) {
        //Specification<Patient> spec = PatientSpecification.hasEventWithHealthProId(id,eventTypeId);
        /*if(keyword!=null){
            spec=spec.and(PatientSpecification.findByKeyword("name",keyword)
                    .or(PatientSpecification.findByKeyword("firstname",keyword)));
        }*/
        return null;
    }

    public Timestamp getLastAppointmentDate(int hProId, int userId,int made) {
        Event event=eventRepository.getLastAppointmentDate(hProId,userId,made);
        if(event!=null){
            return event.getStart_dt();
        }
        return null;
    }

}
