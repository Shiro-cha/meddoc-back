package meddoc.dev.module.prosante.repository;

import meddoc.dev.module.prosante.model.HealthPro;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface HealthProRepository extends JpaRepository<HealthPro,Integer>, JpaSpecificationExecutor<HealthPro> {
    @Query(value = "SELECT * FROM healthpro WHERE company_id= ?1 ",nativeQuery = true)
    List<HealthPro> findByCompanyId(int companyId);
    @Query(value= "SELECT * FROM healthpro WHERE company_id= ?1 and id= ?2 ",nativeQuery = true)
    Optional<HealthPro> findByCompanyIdAndId(int compnayId, int healthProId);
}
