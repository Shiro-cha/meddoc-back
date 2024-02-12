package meddoc.dev.Event;

import meddoc.dev.module.prosante.model.Agenda;
import meddoc.dev.module.prosante.service.AgendaService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import java.sql.Time;
import static org.junit.jupiter.api.Assertions.assertThrows;

@SpringBootTest
@ExtendWith(MockitoExtension.class)
public class AgendaTest extends Util {
    @Autowired
    private AgendaService agendaService;


}
