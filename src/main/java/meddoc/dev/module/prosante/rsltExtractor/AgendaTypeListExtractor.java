package meddoc.dev.module.prosante.rsltExtractor;

import meddoc.dev.module.prosante.model.AgendaType;
import org.postgresql.jdbc.PgArray;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ResultSetExtractor;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.*;

public class AgendaTypeListExtractor implements ResultSetExtractor<List<AgendaType>> {
    @Override
    public List<AgendaType> extractData(ResultSet rs) throws SQLException, DataAccessException {
            rs.next();
            PgArray pgArray= (PgArray) rs.getArray("getagendadto");
            Object[] rawData= (Object[]) pgArray.getArray();
        return getAgendaTypeList(rawData);
    }
    List<AgendaType> getAgendaTypeList(Object[] rawData){
        List<AgendaType> agendaTypes=new ArrayList<>();
        for (Object row : rawData) {
            agendaTypes.add(parseToAgendaType(row.toString()));
        }
        return agendaTypes;
    }
    AgendaType parseToAgendaType(String input) {
        String cleanedInput = input.replaceAll("[(\"\")]", "");
        String[] parts = cleanedInput.split(",");
        AgendaType agendaType = AgendaType.
                builder()
                ._start(Timestamp.valueOf(parts[0]+".00"))
                ._end(Timestamp.valueOf(parts[1]+".00"))
                .build();
        return agendaType;
    }
}
