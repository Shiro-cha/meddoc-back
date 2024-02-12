package meddoc.dev.module.prosante.repository;

import meddoc.dev.module.prosante.model.Event;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository("eventRepository")
public interface EventRepository extends JpaRepository<Event,Integer>, JpaSpecificationExecutor<Event> {
    @Query(value = "Select * from event where  healthpro_id=?1 " +
            "            and (" +
            "                  (?2 between start_dt and end_dt) " +
            "                  or "  +
            "                  (?3 between start_dt and end_dt)" +
            "                  or " +
            "                  ((start_dt between ?2 and ?3 ) and (end_dt between ?2 and ?3))" +
            "           ) and event_type_id not in (?4,?5,?6) limit 1"
            ,nativeQuery = true)
    Optional<Event> isCollided(int healthpro_id, Timestamp start_time, Timestamp end_time,int postponedAppointmentId,int cancelledByPatient,int unavailableId);
    @Query(value = "Select * from event where healthpro_id=?1 and event_type_id not in (?4,?5) and (start_dt between ?2 and ?3" +
            " or ?2 between start_dt and end_dt)",nativeQuery = true)
    List<Event> findByHealthProId(int healthpro_id,Timestamp start,Timestamp end,int postponedAppointmentId,int cancelledAppointmentId);

    @Query(value = "Select * from event where healthpro_id=?1 and user_id=?2 and event_type_id=?3 order by start_dt desc limit 1",nativeQuery = true)
    Event getLastAppointmentDate(int hProId, int userId,int made);

    @Query(value = "Select * from event where user_id=?1 and healthpro_id=?2 and event_type_id=?3",nativeQuery = true)
    List<Event> findPosponeAppointment(int userId, int healthproId, int postponedId);

    @Query(value = "Select * from event where healthpro_id=?1 and user_id=?2  and event_type_id=?3",nativeQuery = true)
    Page<Event> findEventMade(int hId, int userId, int made, Pageable pageable);
}
