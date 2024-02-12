package meddoc.dev.module.prosante.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import meddoc.dev.genericUsage.genericModel.HasId;

@Data
@Table(name = "symptom")
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Symptom extends HasId {
    String name;
}
