package meddoc.dev.genericUsage.genericService;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.function.BiFunction;
@Service
public class SpecificationService<L> {
    List<String> conventionFilter=List.of("<EQ>","<NE>","<IN>","<CT>","<SW>","<EW>","<GT>","<LT>","<GE>","<LE>");

    public String  getConventionFilter(String query) {
        for (String convention:conventionFilter) {
            if(query.contains(convention)){
                return convention;
            }
        }
        throw new RuntimeException("Convention not found");
    }
    public HashMap<String, BiFunction<String,String,Specification<L>>> getMethodIntoHashMap(){
        HashMap<String, BiFunction<String,String,Specification<L>>> methodMap = new HashMap<>();
        methodMap.put("<EQ>",this::equalUtility);
        methodMap.put("<NE>",this::notEqualUtility);
        methodMap.put("<IN>",this::inUtility);
        methodMap.put("<GT>",this::greaterThanUtility);
        methodMap.put("<LT>",this::lessThanUtility);
        methodMap.put("<GE>",this::greaterThanEqualUtility);
        methodMap.put("<LE>",this::lessThanEqualUtility);
        methodMap.put("<SW>",this::startsWithUtility);
        methodMap.put("<EW>",this::endsWithUtility);
        methodMap.put("<CT>",this::containsUtility);
        return methodMap;
    }

    public  Specification<L> equalUtility(String field, String value){
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(field),value);
    }
    public Specification<L> notEqualUtility(String field,String value){
        return (root, query, criteriaBuilder) -> criteriaBuilder.notEqual(root.get(field),value);
    }
    public Specification<L> inUtility(String field,String value){
        return (root, query, criteriaBuilder) -> root.get(field).in(value);
    }
    public Specification<L> greaterThanUtility(String field,String value){
        return (root, query, criteriaBuilder) -> criteriaBuilder.greaterThan(root.get(field),value);
    }
    public Specification<L> lessThanUtility(String field,String value){
        return (root, query, criteriaBuilder) -> criteriaBuilder.lessThan(root.get(field),value);
    }
    public Specification<L> greaterThanEqualUtility(String field,String value){
        return (root, query, criteriaBuilder) -> criteriaBuilder.greaterThanOrEqualTo(root.get(field),value);
    }
    public Specification<L> lessThanEqualUtility(String field,String value){
        return (root, query, criteriaBuilder) -> criteriaBuilder.lessThanOrEqualTo(root.get(field),value);
    }
    public Specification<L> startsWithUtility(String field,String value){
        return (root, query, criteriaBuilder) -> criteriaBuilder.like(root.get(field),value+"%");
    }
    public Specification<L> endsWithUtility(String field,String value){
        return (root, query, criteriaBuilder) -> criteriaBuilder.like(root.get(field),"%"+value);
    }
    public Specification<L> containsUtility(String field,String value){
        return (root, query, criteriaBuilder) -> criteriaBuilder.like(root.get(field),"%"+value+"%");
    }
}
