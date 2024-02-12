package meddoc.dev.module.prosante.service;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.persistence.criteria.Expression;
import lombok.Data;
import meddoc.dev.module.prosante.model.V_pointage_healthpro;
import meddoc.dev.module.prosante.model.V_pointage_patient;
import meddoc.dev.module.prosante.repository.V_pointage_Hpro_Rep;
import meddoc.dev.module.prosante.repository.V_pointage_Patient_Rep;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

@Service
@Data
public class ViewService  {
    @Autowired
    private V_pointage_Hpro_Rep v_pointage_hpro_rep;
    @Autowired
    private V_pointage_Patient_Rep v_pointage_patient_rep;
    public static Specification<V_pointage_healthpro> findByName(String name) {
        return (root, query, builder) -> builder.like(builder.lower(root.get("user").get("healthpro_info").get("name")), "%"+name.toLowerCase()+"%");
    }
    public static Specification<V_pointage_patient> findByPatientName(String name) {
        return (root, query, builder) -> builder.like(builder.lower(root.get("user").get("patient_info").get("name")), "%"+name.toLowerCase()+"%");
    }
    public static Specification<V_pointage_healthpro> findByFirstName(String lastName) {
        return (root, query, builder) -> builder.like(builder.lower(root.get("user").get("healthpro_info").get("firstName")), "%"+lastName.toLowerCase()+"%");
    }
    public static Specification<V_pointage_patient> findByPatientFirstName(String lastName) {
        return (root, query, builder) -> builder.like(builder.lower(root.get("user").get("patient_info").get("firstname")), "%"+lastName.toLowerCase()+"%");
    }
    public static Specification<V_pointage_healthpro> findByEmail(String email) {
        return (root, query, builder) -> builder.like(builder.lower(root.get("user").get("email")),"%"+email.toLowerCase()+"%");
    }
    public static Specification<V_pointage_patient> findByPatientEmail(String email) {
        return (root, query, builder) -> builder.like(builder.lower(root.get("user").get("email")), "%"+email.toLowerCase()+"%");
    }
    public static Specification<V_pointage_healthpro> findByContact(String contact) {
        return (root, query, builder) -> builder.like(builder.lower(root.get("user").get("contact")), "%"+contact.toLowerCase()+"%");
    }
    public static Specification<V_pointage_patient> findByPatientContact(String contact) {
        return (root, query, builder) -> builder.like(builder.lower(root.get("user").get("contact")), "%"+contact.toLowerCase()+"%");
    }
    public static Specification<V_pointage_healthpro> findByAddress(String address) {
        return (root, query, builder) -> builder.equal(builder.lower(root.get("user").get("address")), "%"+address.toLowerCase()+"%");
    }
    public static Specification<V_pointage_patient> findByPatientAddress(String address) {
        return (root, query, builder) -> builder.equal(builder.lower(root.get("user").get("address")), "%"+address.toLowerCase()+"%");
    }
    public static Specification<V_pointage_healthpro> gteStat(double stat,String statName) {
         return (root, query, builder) -> {
             Expression<Number> totalOrOneExpression = builder.<Number>selectCase()
                     .when(builder.equal(root.get("total"), 0), 1)
                     .otherwise(root.get("total"));

             Expression<Number> percentageExpression = builder.prod(
                     builder.quot(root.get(statName),
                                totalOrOneExpression
                             ), 100.0
             );
            return builder.ge(percentageExpression, stat);
        };
    }
    public static Specification<V_pointage_patient> gtePatientStat(double stat,String statName) {
        return (root, query, builder) -> {
            Expression<Number> totalOrOneExpression = builder.<Number>selectCase()
                    .when(builder.equal(root.get("total"), 0), 1)
                    .otherwise(root.get("total"));
            Expression<Number> percentageExpression = builder.prod(
                    builder.quot(root.get(statName),
                            totalOrOneExpression
                    ), 100.0
            );
            return builder.ge(percentageExpression, stat);
        };
    }
    public static Specification<V_pointage_patient> patientGeStat(double stat,String statName) {
        return (root, query, builder) -> {
            Expression<Number> percentageExpression = builder.prod(
                    builder.quot(root.get(statName), root.get("total")), 100.0
            );
            return builder.ge(percentageExpression, stat);
        };
    }

    public static Specification<V_pointage_healthpro> findBySpeciality(String speciality) {
        return (root, query, builder) -> builder.like(builder.lower(root.get("user").get("healthpro_info").get("speciality")
                .get("description")), "%"+speciality+"%");
    }

    public static Specification<V_pointage_healthpro> role_idNotNull() {
        return (root, query, builder) -> builder.isNotNull(root.get("user").get("role"));
    }
    public static Specification<V_pointage_patient> role_idNotNullPatient() {
        return (root, query, builder) -> builder.isNotNull(root.get("user").get("role"));
    }
    public static Specification<V_pointage_healthpro> role_idNull() {
        return (root, query, builder) -> builder.isNull(root.get("user").get("role"));
    }
    public static Specification<V_pointage_patient> role_idNullPatient() {
        return (root, query, builder) -> builder.isNull(root.get("user").get("role"));
    }

    public static Specification<V_pointage_healthpro> getHealthProSpecification(String keyword) {
        return Specification.where(findByName(keyword))
                .or(findByFirstName(keyword))
                .or(findByEmail(keyword))
                .or(findByContact(keyword))
                .or(findByAddress(keyword))
                .or(findBySpeciality(keyword));
    }
    public static Specification<V_pointage_patient> getPatientSpecification(String keyword) {
        return Specification.where(findByPatientName(keyword))
                .or(findByPatientFirstName(keyword))
                .or(findByPatientEmail(keyword))
                .or(findByPatientContact(keyword))
                .or(findByPatientAddress(keyword));
    }
}
