package meddoc.dev.module.prosante.service;


import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.module.prosante.constant.EventType;
import meddoc.dev.module.prosante.model.Civility;
import meddoc.dev.module.prosante.model.V_appointment_progress;
import meddoc.dev.module.prosante.repository.CivilityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class V_appointmentService  {

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;
    @Autowired
    private EventTypeService eventTypesService;
    public List<V_appointment_progress> getAppointmentProgress(int healthpro_id){
        int made=eventTypesService.getEventTypeId(EventType.MADE);
        String sql="SELECT  healthpro_id , COUNT(id) AS event_count," +
                "EXTRACT(MONTH FROM start_dt) AS event_month," +
                "EXTRACT(YEAR FROM start_dt) AS event_year FROM  event ";
        String groupBy=" GROUP BY healthpro_id, event_month, event_year";
        MapSqlParameterSource map = new MapSqlParameterSource();
        sql=sql+" WHERE healthpro_id=:healthpro_id and event_type_id=:event_type_id";
        sql+=groupBy;
        map.addValue("healthpro_id", healthpro_id);
        map.addValue("event_type_id", made);
        return jdbcTemplate.query(sql,map,new BeanPropertyRowMapper<>(V_appointment_progress.class));
    }


}
