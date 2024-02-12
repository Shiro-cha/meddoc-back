package meddoc.dev.module.prosante.model;

import lombok.Data;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.List;

@Data
public class Prescription {
    String medicament;
    String medicamentType;
    int  duration;
    double day;
    double evening;
    double night;
}
