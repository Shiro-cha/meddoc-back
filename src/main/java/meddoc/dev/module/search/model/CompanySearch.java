package meddoc.dev.module.search.model;

import lombok.Data;
@Data
public class CompanySearch extends HasIndex {
    private String id;
    private String name;
    private String speciality;
    private String typeofActivity;
    private String contact;
    private String address;
    private String keyWords;
    private String description;
}
