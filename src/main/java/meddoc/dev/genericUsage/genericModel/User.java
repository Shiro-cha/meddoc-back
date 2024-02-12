package meddoc.dev.genericUsage.genericModel;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import meddoc.dev.module.patient.model.Patient;
import meddoc.dev.module.prosante.model.Company;
import meddoc.dev.module.prosante.model.Event;
import meddoc.dev.module.prosante.model.HealthPro;
import org.hibernate.annotations.Fetch;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.sql.Timestamp;
import java.util.Collection;
import java.util.List;

@Entity
@Table(name = "useraccount")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User extends HasId implements UserDetails {
    String email;
    String password;
    String contact;
    String address;
    @ManyToOne
    @JoinColumn(name = "role_id")
    Role role;
    @ManyToOne(fetch =  FetchType.LAZY)
    @JoinColumn(name = "patient_id")
    @JsonIgnore
    Patient patient_info;
    @ManyToOne(fetch =  FetchType.LAZY)
    @JoinColumn(name="healthpro_id")
    @JsonIgnore
    HealthPro healthpro_info;
    @ManyToOne(fetch =  FetchType.LAZY)
    @JoinColumn(name="company_id")
    @JsonIgnore
    Company company_info;
    Timestamp created_at;
    String profile_picture_url;

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }
    @Override
    public String getUsername() {
        return email;
    }
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }
    @Override
    public boolean isEnabled() {
        return true;
    }
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        if(this.role!=null)
            return List.of(new SimpleGrantedAuthority("ROLE_"+this.role.getName()));
        return List.of();
    }
    @Override
    public String getPassword() {
        return password;
    }
}

