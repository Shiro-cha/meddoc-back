package meddoc.dev.genericUsage.genericRepo;
import meddoc.dev.genericUsage.genericModel.OtpValidation;
import meddoc.dev.genericUsage.genericModel.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface OtpRepository extends JpaRepository<OtpValidation, Integer> {
}

