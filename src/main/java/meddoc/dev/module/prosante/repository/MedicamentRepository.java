package meddoc.dev.module.prosante.repository;


import meddoc.dev.module.prosante.model.Medicament;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface MedicamentRepository extends JpaRepository<Medicament,Integer>, JpaSpecificationExecutor<Medicament> {

}
