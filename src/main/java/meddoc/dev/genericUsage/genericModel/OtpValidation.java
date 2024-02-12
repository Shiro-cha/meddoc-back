package meddoc.dev.genericUsage.genericModel;


import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Entity
@Table(name = "otpvalidation")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OtpValidation extends HasId{
    String digit_code;
    int user_id;
    Timestamp created_at;
    Timestamp expires_at;
}
