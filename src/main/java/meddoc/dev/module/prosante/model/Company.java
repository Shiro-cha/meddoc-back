package meddoc.dev.module.prosante.model;

import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;
import meddoc.dev.genericUsage.genericModel.HasId;

import java.sql.Date;

@Data
@Table(name = "company")
@Entity
public class Company extends HasId  {
    String name;
    String nif;
    String stat;
    @ManyToOne
    @JoinColumn(name = "typeofactivity_id")
    TypeOfActivity typeOfActivity;
    String images;
    String socialreason;
    Date creationdate;
    String address;
    String picture;
}
