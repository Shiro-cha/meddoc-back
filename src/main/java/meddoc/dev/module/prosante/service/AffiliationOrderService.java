package meddoc.dev.module.prosante.service;


import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.module.prosante.model.AffiliationOrder;
import meddoc.dev.module.prosante.model.Civility;
import meddoc.dev.module.prosante.repository.AffiliationOrderRepository;
import meddoc.dev.module.prosante.repository.CivilityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

@Service
public class AffiliationOrderService extends GenericService<AffiliationOrder,Integer> {
    @Override
    @Autowired
    @Qualifier("affiliationOrderRepository")
    public void setRepository(JpaRepository<AffiliationOrder, Integer> repository) {
        this.repository = repository;
    }
    public AffiliationOrderRepository getRepository(){
        return (AffiliationOrderRepository) this.repository;
    }
}
