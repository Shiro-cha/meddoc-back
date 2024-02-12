package meddoc.dev.module.prosante.model;

import jakarta.persistence.ColumnResult;
import jakarta.persistence.ConstructorResult;
import jakarta.persistence.SqlResultSetMapping;
import lombok.Builder;
import lombok.Data;


import java.sql.Timestamp;

@Data
@Builder
public class AgendaType {
    Timestamp _start;
    Timestamp _end;
     public String  toString(){
         return "start: "+_start+" end: "+_end;
    }
}
