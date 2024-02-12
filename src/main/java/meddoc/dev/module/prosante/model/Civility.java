package meddoc.dev.module.prosante.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import meddoc.dev.genericUsage.genericModel.HasId;
@Data
@Table(name = "civility")
@Entity
public class Civility extends HasId {
    String description;
}
