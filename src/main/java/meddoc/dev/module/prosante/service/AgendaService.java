package meddoc.dev.module.prosante.service;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.module.prosante.RequestMap.AgendaMap;
import meddoc.dev.module.prosante.model.Agenda;
import meddoc.dev.module.prosante.model.AgendaType;
import meddoc.dev.module.prosante.model.AppointmentAvg;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.prosante.repository.AgendaRepository;
import meddoc.dev.module.prosante.repository.HealthPorAgendaRepository;
import meddoc.dev.module.prosante.rsltExtractor.AgendaTypeListExtractor;
import meddoc.dev.notification.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AgendaService extends GenericService<Agenda,Integer> {
    @Autowired
    EntityManager em;
    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;
    @Autowired
    HealthPorAgendaRepository healthPorAgendaRepository;
    @Autowired
    NotificationService notificationService;
    public void reportAppointmentBecauseOfChange(Agenda agenda,int healthpro_id, int appointment_id,int postponed_id) {
        String sql ="UPDATE event set event_type_id=:postponed_id WHERE id in (" +
                "SELECT id from event WHERE healthpro_id=:healthpro_id  and start_dt >= now()" +
                " and EXTRACT(DOW FROM start_dt)=:weekday and CAST(start_dt AS TIME) between :start_time " +
                "and :end_time  and event_type_id=:appointment_id)";
        MapSqlParameterSource params = new MapSqlParameterSource();
        params.addValue("postponed_id",postponed_id);
        params.addValue("appointment_id",appointment_id);
        params.addValue("healthpro_id", healthpro_id);
        params.addValue("weekday", agenda.getDayofweek());
        params.addValue("start_time", agenda.getStart_time());
        params.addValue("end_time", agenda.getEnd_time());
        jdbcTemplate.update(sql,params);
    }
    public List<AgendaType> getAgendaType(int healthProId, Date currDate, Date endDate) {
        String sql = "SELECT * FROM getagendadto(:_start,:_end,:healthpro_id)";
        MapSqlParameterSource params = new MapSqlParameterSource();
        params.addValue("_start", currDate);
        params.addValue("_end", endDate);
        params.addValue("healthpro_id", healthProId);
        List<AgendaType> agendaTypes = jdbcTemplate.query(sql,params,new AgendaTypeListExtractor());
        return agendaTypes;
    }
    public void reportAgendaBecauseOfAppAvg(AppointmentAvg appointmentAvg,int healthpro_id,int appointment_id,int postponed_id) {
        String sql ="UPDATE event set event_type_id=:postponed_id WHERE id in (" +
                "SELECT id from event " +
                " WHERE healthpro_id=:healthpro_id and start_dt >= :start_time and event_type_id = :appointment_id)";
        MapSqlParameterSource params = new MapSqlParameterSource();
        params.addValue("healthpro_id", healthpro_id);
        params.addValue("start_time", appointmentAvg.getCreated_at());
        params.addValue("appointment_id", appointment_id);
        params.addValue("postponed_id", postponed_id);
        jdbcTemplate.update(sql,params);
    }
    @Transactional
    public void addHealthProAgenda(int[] weekdays, Time start_time, Time end_time, int healthProId) {
        try{
        checkIfStartTimeGreater(start_time,end_time);
        isValidWeekDayArray(weekdays);
        setSecondToZero(start_time);
        setSecondToZero(end_time);
        Query query = em.createNativeQuery(
                "INSERT INTO agenda " +
                        "(healthpro_id, dayofweek,start_time,end_time) VALUES (?, ?, ?,?)");
        for(int weekday:weekdays){
           saveRowOfAgenda(query,start_time,end_time,healthProId,weekday);
        }
        }catch (Exception e){throw  e;}
        finally {
            em.close();
        }
    }

    public void setSecondToZero(Time time) {
        Calendar calendar=Calendar.getInstance();
        calendar.setTime(time);
        calendar.set(Calendar.SECOND,0);
        time.setTime(calendar.getTime().getTime());
    }

    private void saveRowOfAgenda(Query query, Time start_time,Time end_time,
                                 int healthProId, int weekDay) {
        checkCollide(0,healthProId,weekDay,start_time,end_time);
        query.setParameter(1, healthProId);
        query.setParameter(2, weekDay);
        query.setParameter(3, start_time);
        query.setParameter(4, end_time);
        query.executeUpdate();
    }
    public void isValidWeekDayArray(int[] weekdays){
        for(int i=0;i<weekdays.length;i++){
            isValidWeekDay(weekdays[i]);
        }
    }
    public void isValidWeekDay(int weekday){
        if(weekday<1 || weekday>7){
            throw new RuntimeException("Le jour de la semaine que vous avez entré n'est pas valide");
        }
    }
    public void checkIfStartTimeGreater(Time start_time,Time end_time){
        if(start_time.compareTo(end_time)>0){
            throw new RuntimeException("la date de début doit être inférieur à la date de fin");
        }
    }
    public void checkifValidDuration(int duration){
        int minDuration=5;
        if(duration<=0 ||  duration<minDuration){
            throw new RuntimeException("la durée doit être positive et supérieur à 5");
        }
    }
    public void putCorrectCreated_atDate(AppointmentAvg appointmentAvg){
        if(appointmentAvg.getCreated_at()==null) {
            appointmentAvg.setCreated_at(new Timestamp(System.currentTimeMillis()));
        }
        else {
            Timestamp created_at=appointmentAvg.getCreated_at();
            Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
            created_at.setSeconds(currentTimestamp.getSeconds());
            created_at.setMinutes(currentTimestamp.getMinutes());
            created_at.setHours(currentTimestamp.getHours());
            created_at.setNanos(currentTimestamp.getNanos());
            appointmentAvg.setCreated_at(created_at);
        }
    }
    @Transactional
    public void addAppointmentAvg(AppointmentAvg appointmentAvg) {
        try{
        Query query=em.createNativeQuery
                ("INSERT INTO appointment_avg (healthpro_id, duration,created_at) VALUES (?, ?,?)");
        query.setParameter(1,appointmentAvg.getHealthpro_id());
        query.setParameter(2,appointmentAvg.getDuration());
        query.setParameter(3,appointmentAvg.getCreated_at());
        query.executeUpdate();}
        catch (Exception e){
            throw e;
        }finally {
            em.close();
        }

    }
    public void checkIfItsSameAsLastAvgApp(AppointmentAvg appointmentAvg){
        int lastAppointmentAvg=getLastAppointmentAvg(appointmentAvg.getHealthpro_id(),appointmentAvg.getCreated_at());
        if(lastAppointmentAvg==appointmentAvg.getDuration()){
            throw new RuntimeException("cette durée moyenne est la même que la dernière durée moyenne");
        }
    }
    public int getLastAppointmentAvg(int healthProId,Timestamp effectiveTimestamp) {
        String sql = "SELECT duration FROM appointment_avg WHERE healthpro_id= :healthpro_id " +
                " and CAST(created_at AS DATE) <= CAST( :effectivetimestamp AS DATE) ORDER BY created_at DESC LIMIT 1 ";
        MapSqlParameterSource params = new MapSqlParameterSource();
        params.addValue("healthpro_id",healthProId);
        params.addValue("effectivetimestamp", effectiveTimestamp);
        int duration = jdbcTemplate.query(sql, params,(rs) ->
            {   if (rs.next())
                    return rs.getInt("duration");
                else return 30;
            });
        return duration;
    }
    public List<Agenda> getAgendaByHealthProId(int healthProId) {
        List<Agenda> agendas=getAgendaRepository().getAgendaByHealthpro_id(healthProId);
        return agendas;
    }
    public void deleteAgenda(int id,HealthPro hpro, int appointmentId,int postponedId) {
        Agenda agenda=getAgendaRepository().findById(id)
                .orElseThrow(()->{throw new RuntimeException("no agenda found ");});
        reportAppointmentBecauseOfChange(agenda,hpro.getId(),appointmentId,postponedId);
        notificationService.notifyreportAgenda(hpro.getId(),agenda.getStart_time(),agenda.getEnd_time(),postponedId);
        getAgendaRepository().delete(agenda);
    }
    public void updateAgenda(Agenda agenda,HealthPro hpro, int appointmentId,int postponedId) {
        checkIfStartTimeGreater(agenda);
        Agenda agendaFromdb=getAgendaRepository().findById(agenda.getId())
                .orElseThrow(()->{throw new RuntimeException("Aucun agenda trouve ");});
        checkIfSameAsBefore(agendaFromdb,agenda);
        agenda.setDayofweek(agendaFromdb.getDayofweek());
        agenda.setHealthpro_id(agendaFromdb.getHealthpro_id());
        agenda.setId(agendaFromdb.getId());
        checkCollide(agenda);
        getAgendaRepository().save(agenda);
        notificationService.notifyreportAgenda(hpro.getId(),agendaFromdb.getStart_time(),agendaFromdb.getEnd_time(),postponedId);
        reportAppointmentBecauseOfChange(agendaFromdb,hpro.getId(),appointmentId,postponedId);
    }
    public void checkIfStartTimeGreater(Agenda agenda) {
        if(agenda.getStart_time().getTime()>agenda.getEnd_time().getTime()){
            throw new RuntimeException("l'heure de début doit être inférieur à l'heure de fin");
        }
    }
    public void checkIfSameAsBefore(Agenda oldAgenda,Agenda newAgenda) {
        boolean isSameStartTime=oldAgenda.getStart_time().getTime()==newAgenda.getStart_time().getTime();
        boolean isSameEndTime=oldAgenda.getEnd_time().getTime()==newAgenda.getEnd_time().getTime();
        if(isSameStartTime && isSameEndTime){
            throw new RuntimeException("aucun changement n'a été effectué");
        }
    }
    public List<Agenda> getCollideAgenda(int id,int healthpro_id,int weekday,Time start_time,Time end_time){
        List<Agenda> agendas=getAgendaRepository().getCollideAgenda
                (id,healthpro_id,weekday,start_time,end_time);
        return agendas;
    }
    public void checkCollide(Agenda agenda) {
        checkCollide(agenda.getId(),agenda.getHealthpro_id()
                ,agenda.getDayofweek(),agenda.getStart_time(),agenda.getEnd_time());
    }
    public void checkCollide(int id,int healthpro_id,int weekday,Time start_time,Time end_time) {
        if(getCollideAgenda(id,healthpro_id,weekday,start_time,end_time).size()>0)
            throw new RuntimeException("cet agenda entre en collision avec un autre agenda");
    }

    @Override
    @Autowired
    @Qualifier("agendaRepository")
    public void setRepository( JpaRepository<Agenda, Integer> repository) {
        this.repository=repository;
    }

    public AgendaRepository getAgendaRepository(){
        return (AgendaRepository) repository;
    }
}