package meddoc.dev.module.prosante.repository;


import meddoc.dev.module.prosante.model.Symptom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface SymptomRepository extends JpaRepository<Symptom,Integer>, JpaSpecificationExecutor<Symptom> {

}
