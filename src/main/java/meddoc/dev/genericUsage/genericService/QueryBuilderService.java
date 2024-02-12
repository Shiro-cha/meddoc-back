package meddoc.dev.genericUsage.genericService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.function.BiFunction;

@Service
public class QueryBuilderService<L> {
    @Autowired
    SpecificationService<L> specificationService;
    public Specification<L> getSpecifications(String queryRaw){
        List<Specification<L>> specifications=new ArrayList<>();
        String [] queries=separateQuery(queryRaw);
        HashMap<String, BiFunction<String,String,Specification<L>>> methodMap=specificationService.getMethodIntoHashMap();
        for (String query:queries)  {
            String convention=specificationService.getConventionFilter(query);
            String [] queryArray=query.split(convention);
            String field=queryArray[0];
            String value=queryArray[1];
            specifications.add(methodMap.get(convention).apply(field,value));
        }
        return getSpecification(specifications);
    }
    public<T> Specification<T> getSpecifications(String queryRaw,Class<T> clazz){
        SpecificationService<T> mySpecService = new SpecificationService<T>();
        List<Specification<T>> specifications=new ArrayList<>();
        String [] queries=separateQuery(queryRaw);
        HashMap<String, BiFunction<String,String,Specification<T>>> methodMap=mySpecService.getMethodIntoHashMap();
        for (String query:queries){
            String convention=specificationService.getConventionFilter(query);
            String [] queryArray=query.split(convention);
            String field=queryArray[0];
            String value=queryArray[1];
            specifications.add(methodMap.get(convention).apply(field,value));
        }
        return getSpecification(specifications,clazz);
    }
    public<T> Specification<T> getSpecification(List<Specification<T>> specifications,Class<T> clazz){
        Specification<T> specification=specifications.get(0);
        for (int i=1;i<specifications.size();i++){
            specification=specification.and(specifications.get(i));
        }
        return specification;
    }
    public Specification<L> getSpecification(List<Specification<L>> specifications){
        Specification<L> specification=specifications.get(0);
        for (int i=1;i<specifications.size();i++){
            specification=specification.and(specifications.get(i));
        }
        return specification;
    }
    public String[] separateQuery(String query){
        return query.split("&");
    }
}
