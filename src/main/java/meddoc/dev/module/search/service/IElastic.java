package meddoc.dev.module.search.service;

public interface IElastic<EN,EL> {
    EL getFromEntity(EN entity);
}
