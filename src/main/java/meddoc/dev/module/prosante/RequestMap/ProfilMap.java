package meddoc.dev.module.prosante.RequestMap;

import lombok.Data;

import java.sql.Date;
import java.sql.Time;

@Data
@lombok.AllArgsConstructor
@lombok.NoArgsConstructor
public class ProfilMap {
    private String name;
    private String firstname;
    private Date birthdate;
    private String contact;
}
