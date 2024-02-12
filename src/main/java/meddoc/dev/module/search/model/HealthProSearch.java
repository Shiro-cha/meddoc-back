package meddoc.dev.module.search.model;
@lombok.Data

public class HealthProSearch extends HasIndex {
    private String id;
    private String firstname;
    private String name;
    private String email;
    private String speciality;
    private String order_num;
    private String address;
    private String contact;
    private String keywords;
}
