package meddoc.dev.security.repository;

import meddoc.dev.security.model.Jwt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.util.Optional;
@Repository
public interface JwtRepository extends JpaRepository<Jwt, Integer> {
    @Query(value = "SELECT * FROM jwt where token=?1 and expires_at>now() and user_id=?2",
    nativeQuery = true)
    Optional<Jwt> getJwtByTokenAndUser(String token,int user_id);
    @Modifying
    @Query(value = "UPDATE jwt set expires_at=now()  where expires_at>now() and (patient_identifier=?1 or health_identifier=?1)",
            nativeQuery = true)
    void expiredAllTokens(String identifier);
    @Modifying
    @Transactional
    @Query(value = "UPDATE jwt set expires_at=now()  where token=?1",
            nativeQuery = true)
    void expiredToken(String token);
}