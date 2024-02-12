package meddoc.dev.module.prosante.repository;

import meddoc.dev.module.prosante.model.Civility;
import meddoc.dev.module.prosante.model.TypeOfActivity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TypeOfActivityRepository extends JpaRepository<TypeOfActivity,Integer> {
    @Query(value = "SELECT * FROM typeofactivity where max_account_permitted>1",nativeQuery = true)
    List<TypeOfActivity> getForCompany();
    @Query(value = "SELECT * FROM typeofactivity where max_account_permitted=1",nativeQuery = true)
    List<TypeOfActivity> getForIndependant();
}
