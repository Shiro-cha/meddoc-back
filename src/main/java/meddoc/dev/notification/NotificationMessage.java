package meddoc.dev.notification;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import meddoc.dev.genericUsage.genericModel.HasId;

import java.sql.Timestamp;

@AllArgsConstructor
@Data
@NoArgsConstructor
@Entity
@Table(name = "notification")
public class NotificationMessage extends HasId {
    private int user_id;
    private String type;
    private String message;
    private Timestamp created_at;
    private Timestamp seen_at;
}
