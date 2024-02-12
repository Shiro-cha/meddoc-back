package meddoc.dev.genericUsage.genericService;

import meddoc.dev.genericUsage.genericModel.OtpValidation;
import meddoc.dev.genericUsage.genericModel.Role;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericRepo.OtpRepository;
import meddoc.dev.genericUsage.genericRepo.RoleRepository;
import meddoc.dev.security.service.CodeValidationGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

@Service
public class OtpService extends GenericService<OtpValidation,Integer> {
    public OtpValidation generateOtpValidation(User user){
        OtpValidation otpValidation=OtpValidation.builder()
                .user_id(user.getId())
                .digit_code(CodeValidationGenerator.generateCode())
                .created_at(CodeValidationGenerator.generateCreatedAt())
                .expires_at(CodeValidationGenerator.generateExpiresAt())
                .build();
        return otpValidation;
    }
    @Autowired
    @Override
    public void setRepository(JpaRepository<OtpValidation, Integer> repository) {
        this.repository=repository;
    }
    public OtpRepository getOtpRepository(){
        return (OtpRepository) this.repository;
    }
}
