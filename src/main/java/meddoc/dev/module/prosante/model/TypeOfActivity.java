package meddoc.dev.module.prosante.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import meddoc.dev.genericUsage.genericModel.HasId;

@Data
@Table(name = "typeofactivity")
@Entity
public class TypeOfActivity extends HasId {
    String description;
    int maxAccountPermitted;
    String identifier;
}
