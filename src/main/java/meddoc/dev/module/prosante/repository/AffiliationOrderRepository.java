package meddoc.dev.module.prosante.repository;

import meddoc.dev.module.prosante.model.AffiliationOrder;
import meddoc.dev.module.prosante.model.Civility;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AffiliationOrderRepository extends JpaRepository<AffiliationOrder,Integer> {
}
