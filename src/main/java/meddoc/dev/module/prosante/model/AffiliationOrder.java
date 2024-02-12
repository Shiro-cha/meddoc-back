package meddoc.dev.module.prosante.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import meddoc.dev.genericUsage.genericModel.HasId;

@Data
@Table(name = "affiliationorder")
@Entity
public class AffiliationOrder extends HasId {
    String description;
}
