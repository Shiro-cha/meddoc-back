package meddoc.dev;

import meddoc.dev.genericUsage.genericService.QueryBuilderService;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.prosante.repository.HealthProRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import java.util.List;

@SpringBootTest
public class QueryBuilderTest {
    @Autowired
    private QueryBuilderService<HealthPro> qbs;
    @Autowired
    private HealthProRepository hrep;
    @Test
    public void filterByName(){
        String queryRaw="name<CT>s&identifier<CT>ML";
        List<HealthPro> hpro=hrep.findAll(qbs.getSpecifications(queryRaw));
        System.out.println(hpro);
    }
}
