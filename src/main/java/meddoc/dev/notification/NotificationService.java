package meddoc.dev.notification;

import lombok.Data;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericRepo.UserRepository;
import meddoc.dev.module.prosante.model.Event;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import java.sql.Time;
import java.sql.Timestamp;
import java.util.List;

@Service
@Data
public class NotificationService {
    @Autowired
    private NotificationRepository notificationRepository;
    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;
    @Autowired
    SimpMessagingTemplate simpMessagingTemplate;
    @Autowired
    private UserRepository userRepository;
    public void seenNotif(int id){
        String sql="update notification set seen_at=current_timestamp where id=:id";
        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("id",id);
        jdbcTemplate.update(sql,parameters);
    }
    public void makePopUpToFrontEnd(int user_id){
        simpMessagingTemplate.convertAndSendToUser(""+user_id, "/specific", "notification");
    }
    public void notifyForReport(int healthpro_id, Timestamp start, Timestamp end, int postponed_id){
        Timestamp currentTimestamp=new Timestamp(System.currentTimeMillis());
        String sql="select notifyreport(:healthpro_id,:_start,:_end,:postponed_id,:created_at)";
        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("healthpro_id",healthpro_id);
        parameters.addValue("_start",start);
        parameters.addValue("_end",end);
        parameters.addValue("postponed_id",postponed_id);
        parameters.addValue("created_at",currentTimestamp);
        jdbcTemplate.queryForObject(sql,parameters,Integer.class);
        makePopUpForReport(getByCreated_at(currentTimestamp));
    }
    public void notifyreportAgenda(int healthpro_id, Time start, Time end, int postponed_id){
        Timestamp currentTimestamp=new Timestamp(System.currentTimeMillis());
        String sql="select notifyreportagenda(:healthpro_id,:_start,:_end,:postponed_id,:created_at)";
        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("healthpro_id",healthpro_id);
        parameters.addValue("_start",start);
        parameters.addValue("_end",end);
        parameters.addValue("postponed_id",postponed_id);
        parameters.addValue("created_at",currentTimestamp);
        jdbcTemplate.queryForObject(sql,parameters,Integer.class);
        makePopUpForReport(getByCreated_at(currentTimestamp));
    }
    public void notifyaddAgenda(int healthpro_id,int postponed_id,Timestamp created_at){
        String sql="select notifyaddagenda(:healthpro_id,:postponed_id,:created_at)";
        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("healthpro_id",healthpro_id);
        parameters.addValue("postponed_id",postponed_id);
        parameters.addValue("created_at",created_at);
        jdbcTemplate.queryForObject(sql,parameters,Integer.class);
        makePopUpForReport(getByCreated_at(created_at));
    }
    public List<NotificationMessage> getByCreated_at(Timestamp created_at){
        return notificationRepository.findByCreated_at(created_at);
    }
    public void makePopUpForReport(List<NotificationMessage> notificationMessages){
        for(NotificationMessage notificationMessage:notificationMessages){
            makePopUpToFrontEnd(notificationMessage.getUser_id());
        }
    }
    public void makePopUpForAnnulation(Event event,int user_id){
        if(event.getUser().getId()!=user_id){
            getPatientUserId(event.getPatient().getId());
        }
        makePopUpToFrontEnd(user_id);
    }
    public List<NotificationMessage> getByUser_id(int user_id){
        return notificationRepository.findByUser_id(user_id);
    }
    public int getPatientUserId(int patientId){
        User user=userRepository.findByBypatientId(patientId);
        return user.getId();
    }
    public void notifyForAnnulation(Event event, int user_id){
        String sql="select  notifyannulation(:event_id,:user_id)";
        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("event_id",event.getId());
        parameters.addValue("user_id",user_id);
        jdbcTemplate.queryForObject(sql,parameters,Integer.class);
        makePopUpForAnnulation(event,user_id);
    }
    public void notifyForAppointment(Event event,int hUserId){
        String sql="select notifyappointment(:event_id,:huser_id)";
        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("event_id",event.getId());
        parameters.addValue("huser_id",hUserId);
        jdbcTemplate.queryForObject(sql,parameters,Integer.class);
        makePopUpToFrontEnd(hUserId);
    }
    public void notifyForConsultationResult(Event event){
        String sql="select notifyresultat(:event_id)";
        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("event_id",event.getId());
        jdbcTemplate.queryForObject(sql,parameters,Integer.class);
        makePopUpToFrontEnd(event.getUser().getId());
    }
    public void notifyForMissedAppointment(Event event){
        String sql="select notifymissed(:event_id)";
        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("event_id",event.getId());
        jdbcTemplate.queryForObject(sql,parameters,Integer.class);
        makePopUpToFrontEnd(event.getUser().getId());
    }
}
