package meddoc.dev;

import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericRepo.UserRepository;
import meddoc.dev.module.prosante.RequestMap.ConsultationMap;
import meddoc.dev.module.prosante.model.Event;
import meddoc.dev.module.prosante.service.EventService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import java.util.ArrayList;

@SpringBootTest
public class EventTest {
    @Autowired
    EventService eventService;
    @Autowired
    UserRepository userRepository;
    @Test
    public void testConsultation(){
        Event event=eventService.findById(98);
        ConsultationMap csMap=new ConsultationMap();
        csMap.setEvent_id(98);
        csMap.setPrescriptions(new ArrayList<>());
        csMap.setSymptoms(new ArrayList<>());
        csMap.setAdditional_notes(new ArrayList<>());
    }
    @Test
    public void test(){
        Pageable pageable= Pageable.unpaged();
         Page<User> page=userRepository.getUserInEvent(88,5,pageable);
         System.out.println(page.getContent());
    }

}
