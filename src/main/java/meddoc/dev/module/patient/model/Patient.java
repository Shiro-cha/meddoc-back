package meddoc.dev.module.patient.model;

import jakarta.persistence.*;
import lombok.*;
import meddoc.dev.genericUsage.genericModel.HasId;
import meddoc.dev.genericUsage.genericModel.User;

import java.sql.Date;


@Entity
@Table(name = "patient")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Patient extends HasId {
    @Column(unique = true)
    private String identifier;
    private String name;
    private String firstname;
    private boolean gender;
    private Date birthdate;
    @ManyToOne
    @JoinColumn(name = "relationship_id")
    private Relationship relationship;
    @ManyToOne(fetch =  FetchType.LAZY)
    @JoinColumn(name = "caretaker_id",updatable = false)
    private User careTaker;
}
