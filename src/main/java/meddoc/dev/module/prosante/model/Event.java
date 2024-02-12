package meddoc.dev.module.prosante.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import meddoc.dev.genericUsage.genericModel.HasId;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.module.patient.model.Patient;
import meddoc.dev.module.prosante.constant.EventType;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.annotations.Type;
import org.hibernate.type.SqlTypes;

import java.sql.Timestamp;
import java.util.HashMap;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "event")
public class Event extends HasId {
    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;
    @ManyToOne
    @JoinColumn(name = "healthpro_id")
    @JsonIgnore
    private HealthPro healthPro;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    private Timestamp start_dt;
    private Timestamp end_dt;
    private String reason;
    private int event_type_id;
    private String consultation;
    private Timestamp created_at;
}
