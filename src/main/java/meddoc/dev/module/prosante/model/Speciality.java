package meddoc.dev.module.prosante.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NoArgsConstructor;
import meddoc.dev.genericUsage.genericModel.HasId;
@Data
@Entity
@NoArgsConstructor
@Table(name = "speciality")
public class Speciality extends HasId {
    private String description;
    public Speciality(int id) {
        this.setId(id);
    }

}
