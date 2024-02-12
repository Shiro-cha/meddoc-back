package meddoc.dev.module.prosante.model;

import jakarta.persistence.*;
import lombok.Data;
import org.springframework.data.annotation.Immutable;
@Data
public class V_appointment_progress {
    private int id;
    private int healthpro_id;
    private int event_count;
    private int event_month;
    private int event_year;

}
