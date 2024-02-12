package meddoc.dev.module.prosante.service;


import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.module.prosante.model.Civility;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.prosante.repository.CivilityRepository;
import meddoc.dev.module.prosante.repository.HealthProRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

@Service
public class CivilityService extends GenericService<Civility,Integer> {
    @Override
    @Autowired
    @Qualifier("civilityRepository")
    public void setRepository(JpaRepository<Civility, Integer> repository) {
        this.repository = repository;
    }
    public CivilityRepository getRepository(){
        return (CivilityRepository) this.repository;
    }
}
