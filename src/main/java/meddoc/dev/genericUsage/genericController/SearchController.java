package meddoc.dev.genericUsage.genericController;

import meddoc.dev.genericUsage.genericService.QueryBuilderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.awt.print.Pageable;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class SearchController<L> {
    @Autowired
    private QueryBuilderService queryBuilderService;
    public  List<Specification<L>> buildSpecification(String query){
        List<Specification<L>> specifications = new ArrayList<>();
        return  specifications;
    }

//    @GetMapping
//    public ResponseEntity<?> getAllController(@RequestParam(required = false) String query, Pageable page){
//        return ResponseEntity.ok().body(getAll(query,page));
//    }
//    public  List<?> getAll(String query, Pageable page){
//        Specification<Customer> specification =buildSpecification(query,new ArrayList<>());
//        Page<Customer> customerPage = customerRepository.findAll(specification,page);
//        List<CustomerDto> customerDtoList = customerPage.getContent().stream().map(CustomerDto::new).collect(Collectors.toList());
//        return new PageImpl<CustomerDto>(customerDtoList,page,customerPage.getTotalElements();
//    }

}
