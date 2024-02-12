package meddoc.dev.genericUsage.genericRepo;

import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.module.patient.model.Patient;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> , JpaSpecificationExecutor<User> {
    Optional<User> findByEmail(String email);
    @Query(value =
            "Select * from useraccount  where (email=?1 or contact=?1) ",
            nativeQuery = true)
    Optional<User> findByLogin(String login);
    @Query(value =
            "SELECT * from useraccount where  (useraccount.email=?1 or useraccount.contact=?1)  " +
                    "and exists(select * from otpvalidation where  digit_code=?2 and expires_at>now() and useraccount.id=otpvalidation.user_id)",
            nativeQuery = true)
    Optional<User> findByLoginAndDigitCode(String login, String digitCode);
    @Query(value = "SELECT * from useraccount where healthpro_id is not null and role_id is null ", nativeQuery = true)
    List<User> findUnactivatedHealthProUsers();
    @Query(value = "SELECT * from useraccount where company_id is not null and role_id is null ", nativeQuery = true)
    List<User> findUnactivatedCompanyUsers();
    @Query(value = "SELECT * from useraccount where healthpro_id=?1",nativeQuery = true)
    Optional<User> findByHealthProId(int healthProId);
    @Query(value = "SELECT * from useraccount where patient_id=?1",nativeQuery = true)
    User findByBypatientId(int patientId);
    @Query(value =
            "SELECT * from useraccount where id in" +
                    " (select user_id from event where healthpro_id=?1 and event_type_id=?2)"
            ,nativeQuery = true)
    Page<User> getUserInEvent(int healthProId, int eventTypeId, Pageable pageable);

}

