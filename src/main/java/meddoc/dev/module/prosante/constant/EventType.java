package meddoc.dev.module.prosante.constant;

public enum EventType {
    APPOINTMENT("appointment"),
    MISSED("missed"),
    Cancelled_By_Patient("Cancelled_by_patient"),
    CANCELLED_By_HealthPro("Cancelled_by_healthpro"),
    UNAVAILABILITY("unavailability"),
    POSTPONED("postponed"),
    MADE("made"),
    NEED_FEEDBACK("Need_feedback");
    private final String value;

    EventType(String value) {
        this.value = value;
    }
    public String getValue() {
        return value;
    }
}
