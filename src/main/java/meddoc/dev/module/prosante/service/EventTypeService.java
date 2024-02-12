package meddoc.dev.module.prosante.service;

import meddoc.dev.module.prosante.constant.EventType;
import meddoc.dev.module.prosante.model.EventTypeEntity;
import meddoc.dev.module.prosante.repository.EventTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class EventTypeService  {
    @Autowired
    private EventTypeRepository evenTypeRepository;
    @Autowired
    NamedParameterJdbcTemplate jdbcTemplate;

    public int getEventTypeId(EventType eventType){
        String sql = "SELECT id FROM event_type WHERE name = :value";
        return jdbcTemplate.queryForObject(sql, new MapSqlParameterSource("value", eventType.getValue()), Integer.class);
    }

    public String getEventTypeById(int eventTypeId) {
        String sql = "SELECT name FROM event_type WHERE id = :value";
        return jdbcTemplate.queryForObject(sql, new MapSqlParameterSource("value", eventTypeId), String.class);
    }
    public List<EventTypeEntity> findAllForPatient() {
        int unavailabilityId=getEventTypeId(EventType.UNAVAILABILITY);
        return evenTypeRepository.findAllForPatient(unavailabilityId);
    }

    public List<EventTypeEntity> findAll() {
        return evenTypeRepository.findAll();
    }
}
