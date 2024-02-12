package meddoc.dev.module.prosante.service;

import com.google.gson.Gson;
import jakarta.transaction.Transactional;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.genericUsage.genericService.UserService;
import meddoc.dev.module.patient.model.Patient;
import meddoc.dev.module.prosante.RequestMap.ConsultationMap;
import meddoc.dev.module.prosante.constant.EventType;
import meddoc.dev.module.prosante.model.Company;
import meddoc.dev.module.prosante.model.Consultation;
import meddoc.dev.module.prosante.model.Event;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.prosante.repository.EventRepository;
import meddoc.dev.notification.NotificationService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import static meddoc.dev.module.prosante.specification.EventSpecification.*;

@Service
public class EventService extends GenericService<Event,Integer> {
    @Autowired
    EventTypeService eventTypeService;
    @Value("${image.directory}consultations/")
    private String imageDirectory;
    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;
    @Autowired
    private NotificationService notificationService;
    @Autowired
    private UserService userService;
    public void requestFeedBack(int healthProId,int user_id){
        String sql="Update event set event_type_id=:need_feed_back where event_type_id=:appointment_id and" +
                " start_dt<=current_timestamp and  ";
        MapSqlParameterSource map=new MapSqlParameterSource();
        int appointment_id=eventTypeService.getEventTypeId(EventType.APPOINTMENT);
        int need_feed_back=eventTypeService.getEventTypeId(EventType.NEED_FEEDBACK);
        map.addValue("appointment_id",appointment_id);
        map.addValue("need_feed_back",need_feed_back);
        if(healthProId>0) {
            map.addValue("h_id",healthProId);
            sql+=" healthpro_id=:h_id";
        }else if(user_id>0){
            map.addValue("user_id",user_id);
            sql+=" user_id=:user_id";
        }
        jdbcTemplate.update(sql,map);
    }
    public void reportAppointment(int event_id,int current_userId,Timestamp start, Timestamp end) {
        Event event = this.findById(event_id);
        int hProId= event.getHealthPro().getId();
        int huserId = userService.findByHealthProUser(hProId).getId();
        if(current_userId!=event.getUser().getId()) throw new RuntimeException("Vous n'avez pas le droit de faire cette action");
        checkIfDateIsAlreadyBefore(start);
        checkCollision(hProId,start,end);
        event.setStart_dt(start);
        event.setEnd_dt(end);
        event.setEvent_type_id(eventTypeService.getEventTypeId(EventType.APPOINTMENT));
        this.save(event);
        notificationService.notifyForAppointment(event,huserId);
    }
    public List<Event> getListPostponedAppointment(int user_id,int healthpro_id){
        int postponedId=eventTypeService.getEventTypeId(EventType.POSTPONED);
        List<Event> events=getEventRepository().findPosponeAppointment(user_id,healthpro_id,postponedId);
        return events;
    }
    public void takeAppointment(int hUserId,User user, HealthPro healthPro, Patient patient, Timestamp start, Timestamp end,String reason) {
        checkIfDateIsAlreadyBefore(start);
        checkCollision(healthPro.getId(),start,end);
        isInPlanningOfAppointment(healthPro.getId(),start,end);
        Event event = new Event();
        event.setHealthPro(healthPro);
        event.setUser(user);
        event.setPatient(patient);
        event.setStart_dt(start);
        event.setEnd_dt(end);
        event.setReason(reason);
        event.setEvent_type_id(eventTypeService.getEventTypeId(EventType.APPOINTMENT));
        this.save(event);
        notificationService.notifyForAppointment(event,hUserId);
    }
    private void isInPlanningOfAppointment(int healthProId,Timestamp start, Timestamp end) {
        String sql = "select ARRAY[(:start,:end)]::agendadto[] " +
                " <@ (select getagendadto(CAST(:start as DATE),CAST(:end as DATE),:healthpro_id))";
        MapSqlParameterSource params = new MapSqlParameterSource();
        params.addValue("start", start);
        params.addValue("end", end);
        params.addValue("healthpro_id", healthProId);
        boolean isPlanning  = jdbcTemplate.query(sql,params,resultSet ->{
            resultSet.next();
            return resultSet.getBoolean(1);
        });
        if(!isPlanning) throw new RuntimeException("Not in planning");
    }
    @Transactional
    public void putUnavailability(User user, HealthPro healthPro, Timestamp start, Timestamp end, String reason) {
        checkIfDateIsAlreadyBefore(start);
        Event event = new Event();
        int postponed_id = eventTypeService.getEventTypeId(EventType.POSTPONED);
        event.setHealthPro(healthPro);
        event.setUser(user);
        event.setStart_dt(start);
        event.setEnd_dt(end);
        event.setReason(reason);
        event.setEvent_type_id(eventTypeService.getEventTypeId(EventType.UNAVAILABILITY));
        reportAppointmentBecauseOfChange(start,end,healthPro.getId(),eventTypeService.getEventTypeId(EventType.APPOINTMENT),postponed_id);
        notificationService.notifyForReport(healthPro.getId(),start,end,postponed_id);
        this.save(event);
    }
    public void reportAppointmentBecauseOfChange(Timestamp start,Timestamp end, int healthpro_id, int appointment_id, int postponed_id) {
        String sql ="UPDATE event set event_type_id=:postponed_id WHERE id in (" +
                "SELECT id from event WHERE healthpro_id=:healthpro_id and " +
                " (start_dt between :_start and :_end or end_dt between :_start and :_end) " +
                " and event_type_id=:appointment_id)";
        jdbcTemplate.update(sql,getParamsForGetEvents(healthpro_id,start,end,postponed_id,appointment_id));
    }
    public MapSqlParameterSource getParamsForGetEvents(int healthpro_id, Timestamp start, Timestamp end, int postponed_id, int appointment_id) {
        MapSqlParameterSource params = new MapSqlParameterSource();
        params.addValue("postponed_id",postponed_id);
        params.addValue("appointment_id",appointment_id);
        params.addValue("healthpro_id", healthpro_id);
        params.addValue("_start",start);
        params.addValue("_end", end);
        return params;
    }
    public void checkIfDateIsAlreadyBefore(Timestamp start) {
        if(start.before(Timestamp.from(Instant.now()))) throw new RuntimeException("Date ulterieur");
    }
    public void checkCollision(int healthpro_id,Timestamp start_time,Timestamp end_time) {
        Timestamp st_time_onesecond = new Timestamp(start_time.getTime()+1000);
        Timestamp ed_time_onesecond = new Timestamp(end_time.getTime()-1000);
        int postponed_id = eventTypeService.getEventTypeId(EventType.POSTPONED);
        int canceledByPatientId = eventTypeService.getEventTypeId(EventType.Cancelled_By_Patient);
        int unavailabilityId = eventTypeService.getEventTypeId(EventType.UNAVAILABILITY);
        if(getEventRepository().isCollided(healthpro_id,st_time_onesecond,ed_time_onesecond,
                postponed_id,canceledByPatientId,unavailabilityId).isPresent()){
            throw new RuntimeException("Collision detected !");
        }
    }
    public List<Event> getHealthProEvent(HealthPro healthPro, Timestamp start, Timestamp end) {
        int postponedId=eventTypeService.getEventTypeId(EventType.POSTPONED);
        int canceledByPatientId=eventTypeService.getEventTypeId(EventType.Cancelled_By_Patient);
        return getEventRepository().findByHealthProId(healthPro.getId(),start,end,postponedId,canceledByPatientId);
    }
    public EventRepository getEventRepository() {
        return (EventRepository) this.repository;
    }
    @Transactional
    public void putCancelAppointment(Event event,int eventTypeId,int user_id) {
        checkIfCanCancel(event);
        event.setEvent_type_id(eventTypeId);
        notificationService.notifyForAnnulation(event,user_id);
        this.save(event);
    }

    public Page<Event> getPatientEvent(User user, String keyword, int[] evenTypeIds, Pageable pageable, Date date) {
        Specification<Event> spec=Specification.where(
            userHasId(user.getId())
        );
        if(date!=null) spec=spec.and(dateAppointment(date));
        spec=spec.and(getCommonFilter(keyword));
        if(evenTypeIds!=null) {
            Specification specEventId=Specification.where(null);
            for (int evenTypeId : evenTypeIds) {
                specEventId = specEventId.or(hasEventTypeId(evenTypeId));
            }
            spec=spec.and(specEventId);
        } else {
            int appointmentId = eventTypeService.getEventTypeId(EventType.APPOINTMENT);
            int madeAppointmentId = eventTypeService.getEventTypeId(EventType.MADE);
            int missedId = eventTypeService.getEventTypeId(EventType.MISSED);
            int postponedAppointmentId = eventTypeService.getEventTypeId(EventType.POSTPONED);
            int canceledHealthPro = eventTypeService.getEventTypeId(EventType.CANCELLED_By_HealthPro);
            int canceledByPatientId = eventTypeService.getEventTypeId(EventType.Cancelled_By_Patient);
            spec = spec.and(
                    Specification.where(hasEventTypeId(appointmentId))
                            .or(hasEventTypeId(madeAppointmentId))
                            .or(hasEventTypeId(missedId))
                            .or(hasEventTypeId(postponedAppointmentId))
                            .or(hasEventTypeId(canceledHealthPro))
                            .or(hasEventTypeId(canceledByPatientId))
            );
        }
        return getEventRepository().findAll(spec,pageable);
    }
    private Specification<Event> getCommonFilter(String keyword) {
        Specification<Event> spec=Specification.where(null);
        if(keyword!=null){
            spec= spec.or(healthproHasName(keyword))
                    .or(healthproHasFirstName(keyword));
            spec=spec.or(patientHasName(keyword))
                    .or(patientHasFirstName(keyword));
            spec=spec.or(hasReason(keyword));
        }
        return spec;
    }
    @Transactional
    public void absent(User user,Event appointment) {
        if(!appointment.getStart_dt().before(Timestamp.from(Instant.now()))){
            throw  new RuntimeException("La date de rendez-vous n'est pas encore dépassée");
        }
        canFeedBackAppointment(user,appointment);
        appointment.setEvent_type_id(eventTypeService.getEventTypeId(EventType.MISSED));
        getEventRepository().save(appointment);
        notificationService.notifyForMissedAppointment(appointment);
    }
    public void checkIfCanCancel(Event event) {
        if(event.getEvent_type_id() != eventTypeService.getEventTypeId(EventType.APPOINTMENT)
        )
            throw new RuntimeException("Vous ne pouvez pas annuler cette evenement");
        if(event.getStart_dt().before(Timestamp.from(Instant.now())))
            throw new RuntimeException("Vous ne pouvez plus annuler ce rendez-vous");
    }
    public void canFeedBackAppointment(User user, Event appointment) {
//        TODO: AUTHORIZE MANAGER
        boolean isManagerOfHealthPro;
        boolean isHealthProOnAppointment=user.getHealthpro_info().getId()==appointment.getHealthPro().getId();
        int appointmentTypeId=eventTypeService.getEventTypeId(EventType.APPOINTMENT);
        int need_feed_back=eventTypeService.getEventTypeId(EventType.NEED_FEEDBACK);
        boolean isFeedBackEvent=appointment.getEvent_type_id()==need_feed_back;
        boolean isAppointmentEvent=appointment.getEvent_type_id()==appointmentTypeId ;
        if(!isHealthProOnAppointment && (isAppointmentEvent || isFeedBackEvent)){
            throw new RuntimeException("Vous ne pouvez plus modifier cette consultation");
        }
        if(appointment.getStart_dt().after(Timestamp.from(Instant.now()))) {
            throw new RuntimeException("Vous ne pouvez pas encore modifier ce rendez-vous");
        }
    }
    @Transactional
    public void makeConsultation(Event appointment, ConsultationMap csltMap,List<MultipartFile> images) {
        Consultation consultation=new Consultation();
        consultation.setTime(appointment.getStart_dt());
        consultation.setDate(appointment.getStart_dt());
        consultation.setSymptoms(csltMap.getSymptoms());
        consultation.setPrescriptions(csltMap.getPrescriptions());
        consultation.setAdditional_notes(csltMap.getAdditional_notes());
        fillDoctorName(appointment,consultation);
        fillCompanyName(appointment,consultation);
        if(images!=null) {
            List<String> imgNameOnServer = getUploadImageName(appointment, images);
            consultation.setImages(imgNameOnServer);
        }
        Gson gson=new Gson();
        appointment.setConsultation(gson.toJson(consultation));
        appointment.setEvent_type_id(eventTypeService.getEventTypeId(EventType.MADE));
        getEventRepository().save(appointment);
        notificationService.notifyForConsultationResult(appointment);
    }
    private void fillDoctorName(Event appointment,Consultation consultation) {
        consultation.setDoctorName(appointment.getHealthPro().getCivility()+" "+
                appointment.getHealthPro().getFirstName()+" "+appointment.getHealthPro().getName());
    }
    private void fillCompanyName(Event appointment,Consultation consultation) {
        Company company=appointment.getHealthPro().getCompany();
        if(company!=null) {
            consultation.setCompanyName(company.getName());
            consultation.setNif(company.getNif());
            consultation.setAddress(company.getAddress());
            consultation.setStat(company.getStat());
        }
    }
    private List<String> getUploadImageName(Event event,List<MultipartFile> files) {
        List<String> imageNames=new ArrayList<>();
        for(MultipartFile file:files){
            if(!file.isEmpty()){
                imageNames.add(uploadImage(event,file));
            }
        }
        return imageNames;
    }
    public String uploadImage(Event event, MultipartFile image) {
        String path=imageDirectory;
        makeDirectoryIfNotExist(path);
        String newImageName=getFilename(event).concat(".").concat(FilenameUtils.getExtension(image.getOriginalFilename()));
        Path fileNamePath= Paths.get(imageDirectory, newImageName);
        try {
            Files.write(fileNamePath, image.getBytes());
            return newImageName;
        }catch (Exception e){
            throw new RuntimeException("erreur lors de l'upload de l'image");
        }
    }
    private String getFilename(Event event){
        Timestamp timestamp=new Timestamp(System.currentTimeMillis());
        return event.getId()+"_"+timestamp.getTime();
    }
    public void makeDirectoryIfNotExist(String path){
        File file=new File(path);
        if(!file.exists()){
            file.mkdir();
        }
    }
    public void deleteUnavailability(Event event, User user) {
        if(event.getEvent_type_id()!=eventTypeService.getEventTypeId(EventType.UNAVAILABILITY))
            throw new RuntimeException("Vous ne pouvez pas faire cette action ");
        if(event.getUser().getId()!=user.getId())
            throw new RuntimeException("Vous n'avez pas la permission nécéssaire pour effectuer cette action");
        this.getEventRepository().delete(event);
    }

    @Override
    @Autowired
    @Qualifier("eventRepository")
    public void setRepository(JpaRepository<Event, Integer> repository) {
        this.repository = repository;
    }

    public int getTotalAppointment(int hid, int user_id, int made) {
        System.err.println("user_id "+user_id+" made"+made+" hid"+hid);
        String sql="select count(id) as total from event where event_type_id=:made " +
                " and healthpro_id=:hid and user_id=:user_id";
        MapSqlParameterSource map=new MapSqlParameterSource();
        map.addValue("hid",hid);
        map.addValue("user_id",user_id);
        map.addValue("made",made);
        AtomicInteger total= new AtomicInteger();
        jdbcTemplate.query(sql,map,rs ->{
            total.set(rs.getInt("total"));
        });
        System.err.println("total "+total.get());
        return total.get();
    }

    public Page<Event> getListEventMade(int hId, int userId,Pageable pageable) {
        int made=eventTypeService.getEventTypeId(EventType.MADE);
        return getEventRepository().findEventMade(hId,userId,made,pageable);
    }
}
