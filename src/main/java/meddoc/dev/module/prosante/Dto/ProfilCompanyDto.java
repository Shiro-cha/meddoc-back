package meddoc.dev.module.prosante.Dto;

import lombok.Data;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.module.prosante.model.Company;
import meddoc.dev.module.prosante.model.HealthPro;

import java.util.Date;

@Data
public class ProfilCompanyDto {
    int id;
    int company_id;
    String role;
    String company_name;
    String email;
    String contact;
    String nif;
    String stat;
    String address;
    String socialreason;
    String typeOfActivity;
    Date creationDate;
    Date created_at;
    public ProfilCompanyDto(User user, Company company){
        this.id=user.getId();
        this.email=user.getEmail();
        this.contact=user.getContact();
        this.address=user.getAddress();
        if(user.getRole()!=null)
            this.role=user.getRole().getName();
        this.created_at=user.getCreated_at();

        this.company_name= company.getName();
        this.company_id=company.getId();
        this.nif=company.getNif();
        this.stat=company.getStat();
        this.creationDate=company.getCreationdate();
        this.socialreason=company.getSocialreason();
        this.typeOfActivity=company.getTypeOfActivity().getDescription();
    }

}
