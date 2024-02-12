package meddoc.dev.module.prosante.service;


import meddoc.dev.module.prosante.constant.EventType;
import meddoc.dev.module.prosante.model.V_account_status;
import meddoc.dev.module.prosante.model.V_appointment_progress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class V_account_st_service {

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;
    @Autowired
    private EventTypeService eventTypesService;
    public V_account_status getAccountStatus(){
        String sql="SELECT COUNT(CASE WHEN healthpro_id IS NOT NULL THEN 1 END) AS total_hpro," +
                "    COUNT(CASE WHEN healthpro_id IS NOT NULL AND role_id IS NOT NULL THEN 1 END) AS hpro_active," +
                "    COUNT(CASE WHEN patient_id IS NOT NULL THEN 1 END) AS total_patient," +
                "    COUNT(CASE WHEN patient_id IS NOT NULL AND role_id IS NOT NULL THEN 1 END) AS patient_active " +
                "FROM " +
                "    useraccount";
        return jdbcTemplate.query(sql,new BeanPropertyRowMapper<>(V_account_status.class)).get(0);
    }


}
