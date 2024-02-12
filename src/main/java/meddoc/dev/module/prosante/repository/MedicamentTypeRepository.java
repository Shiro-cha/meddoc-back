package meddoc.dev.module.prosante.repository;


import meddoc.dev.module.prosante.model.MedicamentType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface MedicamentTypeRepository extends JpaRepository<MedicamentType,Integer>, JpaSpecificationExecutor<MedicamentType> {

}
