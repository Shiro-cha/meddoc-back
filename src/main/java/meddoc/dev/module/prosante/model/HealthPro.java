package meddoc.dev.module.prosante.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import meddoc.dev.genericUsage.genericModel.HasId;
import java.util.Date;

@Entity
@Data
@NoArgsConstructor
@Table(name = "healthpro")
public class HealthPro extends HasId  {
    String name;
    String identifier;
    @ManyToOne
    @JoinColumn(name = "affiliation_order_id")
    AffiliationOrder affiliationOrder;
    String orderNum;
    @ManyToOne
    @JoinColumn(name = "speciality_id")
    Speciality speciality;
    String civility;
    String firstName;
    @ManyToOne
    @JoinColumn(name="company_id")
    @JsonIgnore
    Company company;
    Date birthDate;
    @ManyToOne
    @JoinColumn(name = "typeofactivity_id")
    TypeOfActivity typeOfActivity;
    @Column(columnDefinition = "TEXT")
    String description;
}
