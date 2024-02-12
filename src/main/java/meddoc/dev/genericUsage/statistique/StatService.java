package meddoc.dev.genericUsage.statistique;

import meddoc.dev.module.prosante.constant.EventType;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.prosante.repository.HealthProRepository;
import meddoc.dev.module.prosante.service.EventTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

@Service
public class StatService {
    @Autowired
    NamedParameterJdbcTemplate jdbcTemplate;
    @Autowired
    EventTypeService eventTypeService;
    @Autowired
    HealthProRepository healthProRepository;
    public AppointmentStat getPatientOrHealthProStat(int patientId,int healthProId,int month,int year){
        int waiting = eventTypeService.getEventTypeId(EventType.APPOINTMENT);
        int made = eventTypeService.getEventTypeId(EventType.MADE);
        int postponed = eventTypeService.getEventTypeId(EventType.POSTPONED);
        int canceledByHealthPro = eventTypeService.getEventTypeId(EventType.CANCELLED_By_HealthPro);
        int canceledByPatientId = eventTypeService.getEventTypeId(EventType.Cancelled_By_Patient);
        int missed = eventTypeService.getEventTypeId(EventType.MISSED);
        AppointmentStat appStat=new AppointmentStat();
        appStat.setWaiting(getStatByEventTypeId(waiting,patientId,healthProId,month,year));
        appStat.setMade(getStatByEventTypeId(made,patientId,healthProId,month,year));
        appStat.setPostponed(getStatByEventTypeId(postponed,patientId,healthProId,month,year));
        if(patientId!=0){
            appStat.setCanceled(getStatByEventTypeId(canceledByPatientId,patientId,healthProId,month,year));
        }
        else if(healthProId!=0){
            appStat.setCanceled(getStatByEventTypeId(canceledByHealthPro,patientId,healthProId,month,year));
        }
        appStat.setMissed(getStatByEventTypeId(missed,patientId,healthProId,month,year));
        appStat.makeTotal();
        return appStat;
    }
    public AppointmentStat getCompanyStat(int companyId,int month,int year){
        List<HealthPro> hpros=healthProRepository.findByCompanyId(companyId);
        List<AppointmentStat> appStats= new ArrayList<>();
        hpros.forEach(healthPro -> {
            appStats.add(getPatientOrHealthProStat(0,healthPro.getId(),month,year));
        });
        AppointmentStat appStat=new AppointmentStat();
        appStat.setMissed(sumMissed(appStats));
        appStat.setMade(sumMade(appStats));
        appStat.setWaiting(sumWaiting(appStats));
        appStat.setPostponed(sumPostponed(appStats));
        appStat.setCanceled(sumCanceled(appStats));
        appStat.makeTotal();
        return appStat;
    }
    public int sumMade(List<AppointmentStat> appStats){
        AtomicInteger sum= new AtomicInteger();
        appStats.forEach(appointmentStat -> {
            sum.addAndGet(appointmentStat.getMade());
        });
        return sum.get();
    }
    public int sumMissed(List<AppointmentStat> appStats){
        AtomicInteger sum= new AtomicInteger();
        appStats.forEach(appointmentStat -> {
            sum.addAndGet(appointmentStat.getMissed());
        });
        return sum.get();
    }
    public int sumCanceled(List<AppointmentStat> appStats){
        AtomicInteger sum= new AtomicInteger();
        appStats.forEach(appointmentStat -> {
            sum.addAndGet(appointmentStat.getCanceled());
        });
        return sum.get();
    }
    public int sumWaiting(List<AppointmentStat> appStats){
        AtomicInteger sum= new AtomicInteger();
        appStats.forEach(appointmentStat -> {
            sum.addAndGet(appointmentStat.getWaiting());
        });
        return sum.get();
    }
    public int sumPostponed(List<AppointmentStat> appStats){
        AtomicInteger sum= new AtomicInteger();
        appStats.forEach(appointmentStat -> {
            sum.addAndGet(appointmentStat.getPostponed());
        });
        return sum.get();
    }
    public Integer getStatByEventTypeId(int eventTypeId,int user_id,int healthProId,int month,int year){
        String appStat = "select count(id) from event where event_type_id=:evtypeid ";
        MapSqlParameterSource params = new MapSqlParameterSource();
        params.addValue("evtypeid",eventTypeId);
        boolean isValidMonth = month>0 && month<=12;
        boolean isValidYear = year>2022 && year<=Calendar.getInstance().get(Calendar.YEAR);
        if(isValidYear && isValidMonth){
            params.addValue("theyear",year);
            params.addValue("themonth",month);
            appStat+=" and EXTRACT(MONTH from start_dt)=:themonth and  EXTRACT(YEAR from start_dt)=:theyear";
        }
        if(user_id>0) {
            params.addValue("user_id", user_id);
            appStat+=" and user_id=:user_id ";
        }else {
            params.addValue("healthpro_id", healthProId);
            appStat+=" and healthpro_id=:healthpro_id ";
        }
        int result = jdbcTemplate.query(appStat,params,rsExtract());
        return result;
    }

    private ResultSetExtractor<Integer> rsExtract(){
        return rs -> {
            if(rs.next()){
                return rs.getInt(1);
            }
            return 0;
        };
    }
}
