package meddoc.dev.module.prosante.RequestMap;

import lombok.Data;

import java.sql.Time;

@Data
@lombok.AllArgsConstructor
@lombok.NoArgsConstructor
public class AgendaMap {
    private int id;
    private int[] weekdays;
    private Time start_time;
    private Time end_time;
    private int healthProId;
}
