package meddoc.dev.genericUsage.statistique;

import lombok.Data;
@Data
public class AppointmentStat {
    int total;
    int canceled; //select count(*) from event where type=canceled where user_id=?
    int missed; //select count(*) from event where type=missed where user_id=?
    int made; //select count(*) from event where type=made where user_id=?
    int postponed; //select count(*) from event where type=postponed where user_id=?
    int waiting; //select count(*) from event where type=appointment where user_id=?
    public void makeTotal(){
        this.total=missed+waiting+postponed+made+canceled;
    }
}
