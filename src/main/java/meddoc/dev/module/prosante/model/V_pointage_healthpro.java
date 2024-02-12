package meddoc.dev.module.prosante.model;

import jakarta.persistence.*;
import lombok.Data;
import meddoc.dev.genericUsage.genericModel.User;
import org.springframework.data.annotation.Immutable;

@Entity
@Data
@Immutable
@Table(name = "v_pointage_healthpro")
public class V_pointage_healthpro extends HasStat {
    @Id
    private Long id;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}
