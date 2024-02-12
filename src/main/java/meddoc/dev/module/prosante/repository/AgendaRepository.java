package meddoc.dev.module.prosante.repository;

import meddoc.dev.module.prosante.model.Agenda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.sql.Time;
import java.util.List;

@Repository
public interface AgendaRepository extends JpaRepository<Agenda,Integer> {
    @Query(value = "Select * from agenda where id!=?1 and healthpro_id=?2 and dayofweek=?3 " +
            "and (" +
            "             (?4 between start_time and end_time) " +
            "         or " +
            "             (?5 between start_time and end_time) " +
            "        or  (" +
            "            (start_time between ?4 and ?5 ) and (end_time between ?4 and ?5) " +
            "            )" +
            "  )",
            nativeQuery = true)
    List<Agenda> getCollideAgenda(int agendaId,int healthpro_id,int weekday,Time start_time, Time end_time);

    @Query(value="select * from agenda where healthpro_id=?1",nativeQuery = true)
    List<Agenda> getAgendaByHealthpro_id(int healthProId);
}
