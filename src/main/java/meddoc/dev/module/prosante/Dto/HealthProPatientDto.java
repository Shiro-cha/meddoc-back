package meddoc.dev.module.prosante.Dto;

import lombok.Data;
import java.sql.Date;
@Data
public class HealthProPatientDto {
    int healthProId;
    int patientId;
    String patientName;
    String patientFirstName;
    Date lastAppointment;
    int totalAppointment;
    public HealthProPatientDto(int healthProId, int patientId, String patientName, String patientFirstName, Date lastAppointment, int totalAppointment) {
        this.healthProId = healthProId;
        this.patientId = patientId;
        this.patientName = patientName;
        this.patientFirstName = patientFirstName;
        this.lastAppointment = lastAppointment;
        this.totalAppointment = totalAppointment;
    }
}
