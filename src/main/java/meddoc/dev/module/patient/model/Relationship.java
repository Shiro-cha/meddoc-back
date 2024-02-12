package meddoc.dev.module.patient.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import meddoc.dev.genericUsage.genericModel.HasId;

@Entity
@Table(name = "relationship")
@Data
@RequiredArgsConstructor
public class Relationship extends HasId {
    private String name;
}
