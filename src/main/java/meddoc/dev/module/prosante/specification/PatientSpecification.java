package meddoc.dev.module.prosante.specification;

import jakarta.persistence.criteria.*;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.module.patient.Dto.PatientDto;
import meddoc.dev.module.patient.model.Patient;
import meddoc.dev.module.prosante.model.Event;
import org.springframework.data.jpa.domain.Specification;

import java.sql.Date;


public class PatientSpecification {
    public static Specification<User> hasEventWithHealthProId(int healthProId,int eventTypeId) {
        return (root, query, criteriaBuilder) -> {
            Join<User, Event> eventJoin = root.join("event", JoinType.INNER);
            criteriaBuilder.isNotEmpty(eventJoin.get("id"));
            Predicate healthProIdPredicate = criteriaBuilder.equal(eventJoin.get("healthPro").get("id"), healthProId);
            Predicate eventTypeIdPredicate = criteriaBuilder.equal(eventJoin.get("eventType").get("id"), eventTypeId);
            return criteriaBuilder.and(healthProIdPredicate,eventTypeIdPredicate);
        };
    }
    public static Specification<Patient> findByKeyword(String field,String keyword){
        return (root,query,cb) ->{
            Expression<String> fieldExpression = cb.lower(root.get(field));
            return cb.like(fieldExpression,"%"+keyword.toLowerCase()+"%");
        };
    }
}
