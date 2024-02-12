package meddoc.dev;

import meddoc.dev.Event.Util;
import meddoc.dev.module.prosante.model.AgendaType;
import meddoc.dev.module.prosante.service.AgendaService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import java.sql.Date;
import java.util.List;

@SpringBootTest
public class AgendaTest extends Util {
    @Autowired
    AgendaService agendaService;
    @Test
    public void getAgendaForNow(){
        Date currdate=new Date(System.currentTimeMillis());
        Date tomorrow= new Date(System.currentTimeMillis());
        List<AgendaType> agdtype= agendaService.getAgendaType(88,currdate,tomorrow);
        System.out.println(agdtype);
    }
}
