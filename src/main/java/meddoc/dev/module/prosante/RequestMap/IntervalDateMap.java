package meddoc.dev.module.prosante.RequestMap;

import lombok.Data;
import java.sql.Date;

@Data
@lombok.AllArgsConstructor
@lombok.NoArgsConstructor
public class IntervalDateMap {
    private Date start;
    private Date end;
    private int healthProId;
}
