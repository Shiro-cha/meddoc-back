package meddoc.dev.module.prosante.Dto;

import lombok.Data;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.module.prosante.model.HasStat;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.prosante.model.V_pointage_healthpro;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;

@Data
public class ProfilHproDto  extends HasStatDto {
    int id;
    int healthPro_id;
    String identifiant;
    String name;
    String role;
    String firstname;
    String email;
    String contact;
    String address;
    String identifier;
    String orderNum;
    String affiliationOrder;
    String speciality_name;
    String description;
    Date birthdate;
    Date created_at;

    public ProfilHproDto(User user, HealthPro healthPro){
        this.id=user.getId();
        this.contact=user.getContact();
        this.address=user.getAddress();
        this.email=user.getEmail();
        this.identifiant=healthPro.getIdentifier();
        if(user.getRole()!=null)
            this.role=user.getRole().getName();

        this.created_at=user.getCreated_at();
        this.name=healthPro.getName();
        this.healthPro_id=healthPro.getId();
        this.firstname=healthPro.getFirstName();
        this.orderNum=healthPro.getOrderNum();
        if(healthPro.getDescription()!=null)
            this.description=healthPro.getDescription();

        if(healthPro.getAffiliationOrder()!=null)
            this.affiliationOrder=healthPro.getAffiliationOrder().getDescription();

        this.speciality_name=healthPro.getSpeciality().getDescription();
        this.birthdate=healthPro.getBirthDate();
    }
    public ProfilHproDto(V_pointage_healthpro v_pointage_healthpro){
        this(v_pointage_healthpro.getUser(),v_pointage_healthpro.getUser().getHealthpro_info());
        this.total=v_pointage_healthpro.getTotal();
        this.appointment= getPercentage(v_pointage_healthpro.getAppointment(),total).doubleValue();
        this.cancelled_by_hpro=getPercentage(v_pointage_healthpro.getCancelled_by_hpro(),total).doubleValue();
        this.cancelled_by_patient=getPercentage(v_pointage_healthpro.getCancelled_by_patient(),total).doubleValue();
        this.feed_back=getPercentage(v_pointage_healthpro.getFeed_back(),total).doubleValue();
        this.made =getPercentage(v_pointage_healthpro.getMade(),total).doubleValue();
        this.missed=getPercentage(v_pointage_healthpro.getMissed(),total).doubleValue();
        this.postponed=getPercentage(v_pointage_healthpro.getPostponed(),total).doubleValue();
    }

}
