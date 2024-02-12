package meddoc.dev.module.prosante.repository;

import meddoc.dev.module.prosante.model.Agenda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface HealthPorAgendaRepository extends JpaRepository<Agenda,Integer> {
    @Query(value =" SELECT * FROM healthpro_agenda WHERE healthpro_id = ?1 AND dayofweek = ?2"
            ,nativeQuery = true)
    List<Agenda> findAgendaByDayOfWeek(int healthProId, int dayOfWeek, Date date);
}
