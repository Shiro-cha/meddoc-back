package meddoc.dev.security.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import meddoc.dev.genericUsage.genericModel.HasId;
import meddoc.dev.genericUsage.genericModel.User;

import java.util.Date;
@Entity
@Data
@Table(name = "jwt")
@NoArgsConstructor
public class Jwt  extends HasId {
    public Jwt(String token, Date createdAt, Date expiresAt,int user_id) {
        this.token = token;
        this.createdAt = createdAt;
        this.expiresAt = expiresAt;
        this.user_id=user_id;
    }
    private String token;
    private Date createdAt;
    private Date expiresAt;
    private int user_id;
}
