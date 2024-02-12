package meddoc.dev.module.prosante.model;

import lombok.Data;

@Data
public class V_account_status {
    int total_hpro;
    int hpro_active;
    int total_patient;
    int patient_active;

}
