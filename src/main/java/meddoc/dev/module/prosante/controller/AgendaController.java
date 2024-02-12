package meddoc.dev.module.prosante.controller;

import jakarta.validation.constraints.NotNull;
import meddoc.dev.genericUsage.genericController.CrudEntityController;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.genericUsage.genericService.UserService;
import meddoc.dev.module.prosante.RequestMap.AgendaMap;
import meddoc.dev.module.prosante.RequestMap.IntervalDateMap;
import meddoc.dev.module.prosante.constant.EventType;
import meddoc.dev.module.prosante.model.Agenda;
import meddoc.dev.module.prosante.model.AgendaType;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.prosante.service.AgendaService;
import meddoc.dev.module.prosante.service.EventTypeService;
import meddoc.dev.module.prosante.service.HealthProService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/agenda")
public class AgendaController extends CrudEntityController<Agenda,Integer> {
    @Autowired
    private HealthProService healthProService;
    @Autowired
    private UserService userService;
    @Autowired
    private EventTypeService eventTypeService;
    @PostMapping("/agendaTypes")
    public ResponseEntity<List<AgendaType>> getAgendaType(@RequestBody IntervalDateMap intervalDateMap) {
        HealthPro healthPro=getHealthProById(intervalDateMap.getHealthProId());
        List<AgendaType> agendaTypes=
                getAgendaService().getAgendaType(healthPro.getId(),intervalDateMap.getStart(),
                        intervalDateMap.getEnd());
        return ResponseEntity.ok(agendaTypes);
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteAgenda(@PathVariable int id) {
        User user=userService.getCurrentLoggedInUser();
        HealthPro healthpro= user.getHealthpro_info();
        getAgendaService().deleteAgenda(id,healthpro,getAppointmentId(),getPostponedId());
        return ResponseEntity.ok("success");
    }
    @PostMapping("/saveAgenda")
    public ResponseEntity<String> saveAgenda(@NotNull @RequestBody AgendaMap agendaMap) {
        User user=userService.getCurrentLoggedInUser();
        HealthPro healthpro=(agendaMap.getHealthProId()==0) ? user.getHealthpro_info() : getHealthProById(agendaMap.getHealthProId());
        getAgendaService().
                addHealthProAgenda(agendaMap.getWeekdays(),agendaMap.getStart_time(),
                        agendaMap.getEnd_time(), healthpro.getId());
        return ResponseEntity.ok("success");
    }
    @PutMapping
    public ResponseEntity<String> updateAgenda(@RequestBody AgendaMap agendaMap){
        User user=userService.getCurrentLoggedInUser();
        HealthPro hpro=(agendaMap.getHealthProId()==0) ? user.getHealthpro_info() : getHealthProById(agendaMap.getHealthProId()) ;
        Agenda agenda=new Agenda();
        agenda.setId(agendaMap.getId());
        agenda.setStart_time(agendaMap.getStart_time());
        agenda.setEnd_time(agendaMap.getEnd_time());
        getAgendaService().updateAgenda(agenda,hpro,getAppointmentId(),getPostponedId());
        return ResponseEntity.ok("success !");
    }
    private int getAppointmentId(){
        return eventTypeService.getEventTypeId(EventType.APPOINTMENT);
    }
    private int getPostponedId(){
        return eventTypeService.getEventTypeId(EventType.POSTPONED);
    }
    private HealthPro getHealthProById(int id){
        return healthProService.findById(id);
    }
    @Override
    @Autowired
    @Qualifier("agendaService")
    public void setService(GenericService<Agenda,Integer> service) {
        this.service = service;
    }
    public AgendaService getAgendaService(){
        return (AgendaService) this.service;
    }

}