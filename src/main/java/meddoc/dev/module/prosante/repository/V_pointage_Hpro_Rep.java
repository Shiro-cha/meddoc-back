package meddoc.dev.module.prosante.repository;

import meddoc.dev.module.prosante.model.V_pointage_healthpro;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;


@Repository
public interface V_pointage_Hpro_Rep extends JpaRepository<V_pointage_healthpro,Integer>, JpaSpecificationExecutor<V_pointage_healthpro> {

}
