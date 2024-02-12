package meddoc.dev.module.prosante.service;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.module.prosante.model.TypeOfActivity;
import meddoc.dev.module.prosante.repository.TypeOfActivityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class TypeOfActivityService extends GenericService<TypeOfActivity,Integer> {
    public List<TypeOfActivity> getForCompany(){
        return getRepository().getForCompany();
    }
    public List<TypeOfActivity> getForIndependant(){
        return getRepository().getForIndependant();
    }
    @Override
    @Autowired
    @Qualifier("typeOfActivityRepository")
    public void setRepository(JpaRepository<TypeOfActivity, Integer> repository) {
        this.repository = repository;
    }
    public TypeOfActivityRepository getRepository(){
        return (TypeOfActivityRepository) this.repository;
    }
}
