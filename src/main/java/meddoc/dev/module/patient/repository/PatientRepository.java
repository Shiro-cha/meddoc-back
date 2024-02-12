package meddoc.dev.module.patient.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import meddoc.dev.module.patient.model.Patient;
import java.util.List;
import java.util.Optional;
@Repository
public interface PatientRepository extends JpaRepository<Patient, Integer>, JpaSpecificationExecutor<Patient> {
    Optional<Patient> findByIdentifier(String identifier);
    @Query(value="SELECT * from patient where caretaker_id=?1",nativeQuery = true)
    List<Patient> findAllByCareTakerId(int id);
    @Query(value="SELECT * from patient where id=?1 and caretaker_id=?2",nativeQuery = true)
    Optional<Patient> findByIdAndUserId(int id,int user_id);

}
