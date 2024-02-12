package meddoc.dev.module.patient.service;

import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.module.patient.model.Relationship;
import meddoc.dev.module.patient.repository.RelationshipRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

@Service
public class RelationshipService extends GenericService<Relationship,Integer> {
    @Override
    @Autowired
    @Qualifier("relationshipRepository")
    public void setRepository(JpaRepository<Relationship, Integer> repository) {
        this.repository = repository;
    }
    public RelationshipRepository getRelationshipRepository(){
        return (RelationshipRepository)this.repository;
    }
}
