package meddoc.dev.Event;

import meddoc.dev.module.prosante.service.EventService;
import org.junit.Assert;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import java.sql.Timestamp;

@SpringBootTest
@ExtendWith(MockitoExtension.class)
public class EventTester extends Util {
    @Autowired
    private EventService eventService;

}
