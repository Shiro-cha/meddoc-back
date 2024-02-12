package meddoc.dev.module.prosante.RequestMap;

import lombok.Data;

import java.sql.Timestamp;

@Data
@lombok.AllArgsConstructor
@lombok.NoArgsConstructor
public class EventMap {
    private int event_id;
    private Timestamp start;
    private Timestamp end;
    private int healthProId;
    private int patientId;
    private String reason;
}
