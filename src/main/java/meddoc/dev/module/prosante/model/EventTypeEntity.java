package meddoc.dev.module.prosante.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import meddoc.dev.genericUsage.genericModel.HasId;
@Data
@Entity
@Table(name = "event_type")
public class EventTypeEntity extends HasId {
    private String name;
}
