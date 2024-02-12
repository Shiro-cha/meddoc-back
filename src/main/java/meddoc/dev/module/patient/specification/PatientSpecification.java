package meddoc.dev.module.patient.specification;

import meddoc.dev.module.patient.model.Patient;
import org.springframework.data.jpa.domain.Specification;

public class PatientSpecification {
    public static Specification<Patient> findByName(String keyword) {
        return (root, query, builder) -> builder.like(builder.lower(root.get("name")),"%" + keyword.toLowerCase() + "%");
    }
    public static Specification<Patient> findByFirstName(String keyword) {
        return (root, query, builder) -> builder.like(builder.lower(root.get("firstname")),"%" + keyword.toLowerCase() + "%");
    }
    public static Specification<Patient> findByCaretaker(int id) {
        return (root, query, builder) -> builder.equal(root.get("careTaker").get("id"), id);
    }
}
