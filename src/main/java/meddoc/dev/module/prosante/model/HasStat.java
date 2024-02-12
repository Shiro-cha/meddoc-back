package meddoc.dev.module.prosante.model;

import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.Transient;

@lombok.Data
@MappedSuperclass
public class HasStat {
     int made;
     int missed;
     int cancelled_by_hpro;
     int cancelled_by_patient;
     int appointment;
     int postponed;
     int feed_back;
     int total;
}
