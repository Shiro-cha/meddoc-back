package meddoc.dev.module.prosante.specification;

import jakarta.persistence.criteria.Expression;
import meddoc.dev.module.prosante.model.Event;
import org.springframework.data.jpa.domain.Specification;

import java.sql.Date;


public class EventSpecification {
    public static Specification<Event> healthproHasName(String keyword){
        return (root,query,cb)->
             cb.like(cb.lower(root.get("healthPro").get("name")),"%"+keyword.toLowerCase()+"%");
    }
    public static Specification<Event> healthproHasFirstName(String keyword){
        return (root,query,cb)->
                cb.like(cb.lower(root.get("healthPro").get("firstName")),"%"+keyword.toLowerCase()+"%");
    }
    public static Specification<Event> hasEventTypeId(int id){
        return (root,query,criteriaBuilder)->
                criteriaBuilder.equal(root.get("event_type_id"),id);
    }

    public static Specification<Event> hasReason(String keyword){
        return (root,query,cb)->
             cb.like(cb.lower(root.get("reason")),"%"+keyword.toLowerCase()+"%");
    }
    public static Specification<Event> patientHasName(String keyword){
        return (root,query,cb)->
                cb.like(cb.lower(root.get("patient").get("name")),"%"+keyword.toLowerCase()+"%");
    }
    public static Specification<Event> dateAppointment(Date date){
        return (root,query,criteriaBuilder)-> {
            Expression<Date> startDate = criteriaBuilder.function("date", Date.class, root.get("start_dt"));
            return criteriaBuilder.equal(startDate, date);
        };
    }
    public static Specification<Event> hasHealhProId(int id){
        return (root,query,criteriaBuilder)->
                criteriaBuilder.equal(root.get("healthPro").get("id"),id);
    }
    public static Specification<Event> patientHasFirstName(String keyword){
        return (root,query,cb)->
                cb.like(cb.lower(root.get("patient").get("firstname")),"%"+keyword.toLowerCase()+"%");
    }
    public static Specification<Event> userHasId(int id){
        return (root,query,criteriaBuilder)->
                criteriaBuilder.equal(root.get("user").get("id"),id);
    }
}
