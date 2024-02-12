package meddoc.dev.module.patient.controller;

import meddoc.dev.genericUsage.genericController.CrudEntityController;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.module.patient.model.Relationship;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/relationship")
@PreAuthorize("hasRole('patient')")
public class RelationshipController extends CrudEntityController<Relationship,Integer> {
    @Override
    @Autowired
    @Qualifier("relationshipService")
    public void setService(GenericService<Relationship, Integer> service) {
        this.service = service;
    }
}
