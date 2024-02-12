package meddoc.dev.module.prosante.controller;

import lombok.Setter;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.genericUsage.genericController.CrudEntityController;
import meddoc.dev.genericUsage.genericService.UserService;
import meddoc.dev.module.patient.model.Patient;
import meddoc.dev.module.patient.service.PatientService;
import meddoc.dev.module.prosante.Dto.EventDto;
import meddoc.dev.module.prosante.Dto.PatientEventDto;
import meddoc.dev.module.prosante.RequestMap.ConsultationMap;
import meddoc.dev.module.prosante.RequestMap.EventMap;
import meddoc.dev.module.prosante.constant.EventType;
import meddoc.dev.module.prosante.model.Event;
import meddoc.dev.module.prosante.model.EventTypeEntity;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.prosante.service.EventTypeService;
import meddoc.dev.module.prosante.service.HealthProService;
import meddoc.dev.module.prosante.service.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@Controller
@Setter
@RequestMapping("/event")
public class EventController extends CrudEntityController<Event,Integer> {
    @Autowired
    private UserService userService;
    @Autowired
    private PatientService patientService;
    @Autowired
    private EventTypeService eventTypeService;
    @Autowired
    private HealthProService healthProService;
    @PostMapping("/takeAppointment")
    @PreAuthorize("hasRole('patient')")
    public ResponseEntity<String> takeAppointment(@RequestBody EventMap eventMap) {
        User user=userService.getCurrentLoggedInUser();
        if(eventMap.getEvent_id()>0){
            getEventService().reportAppointment(eventMap.getEvent_id(),user.getId(),eventMap.getStart(),eventMap.getEnd());
            return ResponseEntity.ok("Appointment reported successfully");
        }
        Patient patient=patientService.getPatientByIdAndUser(eventMap.getPatientId(),user);
        HealthPro healthPro=getHealthProById(eventMap.getHealthProId());
        int healthProUserId=userService.findByHealthProUser(healthPro.getId()).getId();
        getEventService().takeAppointment(healthProUserId,user,healthPro,patient,
                eventMap.getStart(), eventMap.getEnd(), eventMap.getReason());
        return ResponseEntity.ok("Appointment taken successfully");
    }
    @GetMapping("/getEventMade/{patient_user_id}")
    @PreAuthorize("hasRole('healthpro')")
    public ResponseEntity<Page<EventDto>> getEventMade(@PathVariable int patient_user_id, Pageable pageable){
        int hpro=userService.getCurrentLoggedInUser().getHealthpro_info().getId();
        Page<Event> events=getEventService().getListEventMade(hpro,patient_user_id,pageable);
        Page<EventDto> eventDtos=events.map(event -> new EventDto(event,"made"));
        return ResponseEntity.ok(eventDtos);
    }
    @GetMapping("/getPostponed/{healthProId}")
    @PreAuthorize("hasRole('patient')")
    public ResponseEntity<List<EventDto>> getPostponed(@PathVariable int healthProId){
        User user=userService.getCurrentLoggedInUser();
        List<Event> events=getEventService().getListPostponedAppointment(user.getId(),healthProId);
        List<EventDto> eventDtos=events.stream().map(event -> new EventDto(event,"postponed")).toList();
        return ResponseEntity.ok(eventDtos);
    }

//    @RequestMapping(value = "/consultation",consumes= MediaType.MULTIPART_FORM_DATA_VALUE,method = RequestMethod.POST)
//    @PreAuthorize("hasRole('healthpro')")
//    public ResponseEntity<String> consultation(@RequestParam("images") List<MultipartFile> images,
//                                               @RequestParam("csltMap") ConsultationMap csltMap){
//        User user=userService.getCurrentLoggedInUser();
//        Event appointment=getEventService().findById(csltMap.getEvent_id());
//        getEventService().canChangeThisAppointment(user,appointment);
//        getEventService().makeConsultation(appointment,csltMap,images);
//        return ResponseEntity.ok("consultation success !");
//    }
    @PutMapping("/absent/{event_id}")
    @PreAuthorize("hasRole('healthpro')")
    public ResponseEntity<String> absentPatient(@PathVariable int event_id){
        User user=userService.getCurrentLoggedInUser();
        Event appointment=getEventService().findById(event_id);
        getEventService().absent(user,appointment);
        return ResponseEntity.ok("success");
    }


    @PostMapping("/consultation")
    @PreAuthorize("hasRole('healthpro')")
    public ResponseEntity<String> consultation(
                                               @RequestBody ConsultationMap csltMap) {
        User user=userService.getCurrentLoggedInUser();
        Event appointment=getEventService().findById(csltMap.getEvent_id());
        getEventService().canFeedBackAppointment(user,appointment);
        getEventService().makeConsultation(appointment,csltMap,null);
        return ResponseEntity.ok("consultation success !");
    }
    @GetMapping("/patient")
    @PreAuthorize("hasRole('patient')")
    public ResponseEntity<Page<PatientEventDto>> getPatientEvent(@RequestParam(required = false) String keyword,
                                                                 @RequestParam(required = false) int[] eventTypeIds,
                                                                 @RequestParam(required =false ) String date
                                                                 ,Pageable pageable) throws ParseException {
        User user =userService.getCurrentLoggedInUser();
        getEventService().requestFeedBack(0,user.getId());
        Date dt=null;
        if(date!=null){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
           dt= new Date(sdf.parse(date).getTime());
        }
        Page<Event> events=getEventService().getPatientEvent(user,keyword,eventTypeIds,pageable,dt);
        return getListResponseEntity(events);
    }
    @PutMapping("/cancelByPatient/{id}")
    @PreAuthorize("hasRole('patient')")
    public ResponseEntity<String> cancelAppointment(@PathVariable int id){
        User user=userService.getCurrentLoggedInUser();
        Event event=getEventService().findById(id);
        if (event.getUser().getId()!=user.getId()){
            throw new RuntimeException("Pas autorisé à faire cette action");
        }
        User hUser=userService.findByHealthProUser(event.getHealthPro().getId());
        int canceledByPatient=eventTypeService.getEventTypeId(EventType.Cancelled_By_Patient);
        getEventService().putCancelAppointment(event,canceledByPatient,hUser.getId());
        return ResponseEntity.ok("le rendez-vous a ete annulé");
    }
    @PutMapping("/cancelByHealthPro/{id}")
    @PreAuthorize("hasRole('healthpro')")
    public ResponseEntity<String> cancelByHealthPro(@PathVariable int id){
        User user=userService.getCurrentLoggedInUser();
        Event event=getEventService().findById(id);
        if (event.getHealthPro().getId()!=user.getHealthpro_info().getId()){
            throw new RuntimeException("Pas autorisé à faire cette action");
        }
        int cancelByHealthPro=eventTypeService.getEventTypeId(EventType.CANCELLED_By_HealthPro);
        getEventService().putCancelAppointment(event,cancelByHealthPro,event.getUser().getId());
        return ResponseEntity.ok("le rendez-vous a été annulé");
    }

    @PostMapping("/putUnavailability")
    @PreAuthorize("hasRole('healthpro')")
    public ResponseEntity<String> putUnavailability(@RequestBody EventMap eventMap){
        User user=userService.getCurrentLoggedInUser();
        HealthPro healthPro= (eventMap.getHealthProId()==0) ? user.getHealthpro_info() : getHealthProById(eventMap.getHealthProId());
        getEventService().putUnavailability(user,healthPro,
                eventMap.getStart(), eventMap.getEnd(), eventMap.getReason());
        return ResponseEntity.ok("cette indisponibilité a été prise en compte");
    }

    @DeleteMapping("/deleteUnavailability/{event_id}")
    @PreAuthorize("hasRole('healthpro')")
    public ResponseEntity<String> deleteUnavailability(@PathVariable int event_id){
        User user=userService.getCurrentLoggedInUser();
        Event event=getEventService().findById(event_id);
        getEventService().deleteUnavailability(event,user);
        return ResponseEntity.ok("L'indisponibilité a été supprimée");
    }
    @PostMapping
    @PreAuthorize("hasRole('healthpro')")
    public ResponseEntity<List<EventDto>> getEvents(@RequestBody EventMap eventMap){
        HealthPro healthpro=userService.getCurrentLoggedInUser().getHealthpro_info();
        getEventService().requestFeedBack(healthpro.getId(),0);
        List<Event> events=getEventService().getHealthProEvent(healthpro,eventMap.getStart(),eventMap.getEnd());
        List<EventDto> eventDtos=events.stream().map(event -> {
            String eventType=eventTypeService.getEventTypeById(event.getEvent_type_id());
            return new EventDto(event,eventType);
        }).toList();
        return ResponseEntity.ok(eventDtos);
    }
    @GetMapping("/patientEventTypes")
    public ResponseEntity<List<EventTypeEntity>> getPatientEventTypes(){
        List<EventTypeEntity> eventTypes=eventTypeService.findAllForPatient();
        return ResponseEntity.ok(eventTypes);
    }
    @GetMapping("/healthProEventTypes")
    public ResponseEntity<List<EventTypeEntity>> getHealthProEventTypes(){
        List<EventTypeEntity> eventTypes=eventTypeService.findAll();
        return ResponseEntity.ok(eventTypes);
    }
    public EventService getEventService(){
        return (EventService) this.service;
    }
    private HealthPro getHealthProById(int id){
        return healthProService.findById(id);
    }
    private ResponseEntity<Page<PatientEventDto>> getListResponseEntity(Page<Event> events) {
        Page<PatientEventDto> eventDtos=events.map(event -> {
            String eventType = eventTypeService.getEventTypeById(event.getEvent_type_id());
            PatientEventDto patientEventDto = new PatientEventDto(event, eventType);
            return patientEventDto;
        });
        return ResponseEntity.ok(eventDtos);
    }
    @Override
    @Autowired
    @Qualifier("eventService")
    public void setService(GenericService<Event, Integer> service) {
        this.service = service;
    }
}
