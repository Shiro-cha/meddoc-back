package meddoc.dev.module.prosante.Dto;

import lombok.Data;
import meddoc.dev.genericUsage.genericDto.GenericDto;
import meddoc.dev.module.prosante.model.HealthPro;

@Data
public class HealthProDto extends GenericDto<HealthPro> {
    int id;
    int company_id;
    String name;
    String firstname;
    String email;
    String identifier;
    String order_num;
    String profil_picture_url;
    String speciality;
    String company_name;
    String affiliation_order;
    
    @Override
    public HealthPro toModel() {
        HealthPro healthPro = new HealthPro();
        healthPro.setId(this.getId());
        healthPro.setName(this.getName());
        healthPro.setFirstName(this.getFirstname());
        healthPro.setIdentifier(this.getIdentifier());
        healthPro.setOrderNum(this.getOrder_num());
        return healthPro;
    }

    @Override
    public void fromModel(HealthPro model) {
        this.setName(model.getName());
        this.setFirstname(model.getFirstName());
        this.setIdentifier(model.getIdentifier());
        this.setOrder_num(model.getOrderNum());
        this.setSpeciality(model.getSpeciality().getDescription());
//        if(model.getCompany()!=null)
//            this.setCompany_name(model.getCompany().getName());
//        this.setAffiliation_order(model.getAffiliationOrder().getDescription());
    }

}
