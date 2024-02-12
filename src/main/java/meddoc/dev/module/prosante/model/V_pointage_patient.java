package meddoc.dev.module.prosante.model;

import jakarta.persistence.*;
import lombok.Data;
import meddoc.dev.genericUsage.genericModel.User;
import org.springframework.data.annotation.Immutable;

@Entity
@Data
@Immutable
@Table(name = "v_pointage_patient")
public class V_pointage_patient extends HasStat {
    @Id
    private Long id;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}
