package meddoc.dev.module.prosante.model;

import lombok.Data;
import java.util.List;

@Data
public class Description {
    String presentation;
    List<Diplome> diplomes;
    List<Experience> experiences;
    List<Tarif> tarifs;
}
