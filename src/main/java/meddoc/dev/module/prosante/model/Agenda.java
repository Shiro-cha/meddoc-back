package meddoc.dev.module.prosante.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import meddoc.dev.genericUsage.genericModel.HasId;

import java.sql.Time;

@Data
@Table(name = "agenda")
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Agenda extends HasId {
    int dayofweek;
    Time start_time;
    Time end_time;
    int healthpro_id;
}
