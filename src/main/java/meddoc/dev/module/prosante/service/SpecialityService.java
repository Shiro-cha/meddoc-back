package meddoc.dev.module.prosante.service;


import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.module.prosante.model.Civility;
import meddoc.dev.module.prosante.model.Speciality;
import meddoc.dev.module.prosante.repository.CivilityRepository;
import meddoc.dev.module.prosante.repository.SpecialityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

@Service
public class SpecialityService extends GenericService<Speciality,Integer> {
    @Override
    @Autowired
    @Qualifier("specialityRepository")
    public void setRepository(JpaRepository<Speciality, Integer> repository) {
        this.repository = repository;
    }
    public SpecialityRepository getRepository(){
        return (SpecialityRepository) this.repository;
    }
}
