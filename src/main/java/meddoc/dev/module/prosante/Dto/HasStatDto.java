package meddoc.dev.module.prosante.Dto;

import lombok.Data;

import java.math.BigDecimal;
import java.math.RoundingMode;

@Data
public class HasStatDto {
    double appointment;
    double cancelled_by_hpro;
    double cancelled_by_patient;
    double feed_back;
    double made;
    double missed;
    double postponed;
    int total;
    BigDecimal getPercentage(double value, double total) {
        if(total==0)
            return new BigDecimal(0).setScale(2, RoundingMode.HALF_UP);
        return new BigDecimal((value/total)*100).setScale(2, RoundingMode.HALF_UP);
    }
    double getTotal(int appointment,int cancelled_by_hpro,int cancelled_by_patient,int feed_back,int made,int missed,int postponed){
        return appointment+cancelled_by_hpro+cancelled_by_patient+feed_back+made+missed+postponed;
    }
}
