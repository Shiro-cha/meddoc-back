package meddoc.dev.module.prosante.repository;

import meddoc.dev.module.prosante.model.Speciality;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SpecialityRepository extends JpaRepository<Speciality,Integer> {
}
