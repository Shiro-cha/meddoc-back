package meddoc.dev.module.prosante.constant;

public enum RoleName {
    PATIENT("patient"),
    SECRETARY("secretary"),
    HEALTHPRO("healthpro"),
    ADMIN("admin");
    private final String value;

    RoleName(String value) {
        this.value = value;
    }
    public String getValue() {
        return value;
    }
}
