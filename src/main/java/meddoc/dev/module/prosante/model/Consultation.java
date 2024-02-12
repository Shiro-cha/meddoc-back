package meddoc.dev.module.prosante.model;

import lombok.Data;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.List;
@Data
public class Consultation {
    String companyName;
    String nif;
    String stat;
    String address;
    String doctorName;
    Date date;
    Time time;
    List<String> symptoms;
    List<Prescription> prescriptions;
    List<String> additional_notes;
    List<String> images;

    public void setTime(Timestamp timestamp){
        time=new Time(timestamp.getHours(),timestamp.getMinutes(),00);
    }
    public void setDate(Timestamp timestamp){
        date=new Date(timestamp.getTime());
    }
}
