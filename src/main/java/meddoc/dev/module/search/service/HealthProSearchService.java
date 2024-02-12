package meddoc.dev.module.search.service;

import com.google.gson.Gson;
import com.google.gson.internal.LinkedTreeMap;
import lombok.Data;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.search.model.HealthProSearch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Data
public class HealthProSearchService implements IElastic<HealthPro, HealthProSearch>{
    @Autowired
    ElasticService elasticService;
    @Override
    public HealthProSearch getFromEntity(HealthPro entity) {
        HealthProSearch hsearch = new HealthProSearch();
        hsearch.setId(String.valueOf(entity.getId()));
        hsearch.setFirstname(entity.getFirstName());
        hsearch.setName(entity.getName());
        hsearch.setSpeciality(entity.getSpeciality().getDescription());
        hsearch.setOrder_num(entity.getOrderNum());
        return hsearch;
    }
    public void saveHealthPro(User user) throws IOException {
        HealthProSearch hsearch = getFromEntity(user.getHealthpro_info());
        hsearch.setContact(user.getContact());
        hsearch.setAddress(user.getAddress());
        hsearch.setEmail(user.getEmail());
        if(user.getHealthpro_info().getDescription() != null)
            hsearch.setKeywords(extractKeyWords(user.getHealthpro_info().getDescription()));
        elasticService.insert(hsearch,hsearch.getId());
    }

    public void deleteHealthPro(User user) throws IOException {
        HealthProSearch hsearch = getFromEntity(user.getHealthpro_info());
        elasticService.delete(hsearch.getIndex(), String.valueOf(hsearch.getId()));
    }
    public void updateHealthPro(User user,String description) throws IOException {
        HealthProSearch hsearch = getFromEntity(user.getHealthpro_info());
        hsearch.setContact(user.getContact());
        hsearch.setAddress(hsearch.getAddress());
        hsearch.setEmail(user.getEmail());
        hsearch.setKeywords(extractKeyWords(description));
        elasticService.update(hsearch,hsearch.getId());
    }
    private String extractKeyWords(String description){
        Gson gson = new Gson();
        HashMap<String, Object> map = gson.fromJson(description, HashMap.class);
        if(map == null) return "";
        ArrayList<String> keyWords=map.get("keywords") == null ? null:(ArrayList<String>) map.get("keywords");
        if(keyWords == null) return "";
        String keyWord = keyWords.stream().collect(Collectors.joining(" "));
        return keyWord;
    }
}
