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
@Table(name = "diagnostic")
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Diagnostic extends HasId {
    String name;
}
