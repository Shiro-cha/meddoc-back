package meddoc.dev.genericUsage.genericModel;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.MappedSuperclass;
import lombok.Data;

@Data
@MappedSuperclass
public class HasId {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

}
