package meddoc.dev.module.search.service;

import lombok.Data;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.module.prosante.model.Company;
import meddoc.dev.module.search.model.CompanySearch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
@Data
public class CompanySearchService implements IElastic<Company,CompanySearch> {
    @Autowired
    ElasticService elasticService;
    @Override
    public CompanySearch getFromEntity(Company entity) {
        CompanySearch companySearch= new CompanySearch();
        companySearch.setId(String.valueOf(entity.getId()));
        companySearch.setName(entity.getName());
        companySearch.setAddress(entity.getAddress());
        companySearch.setTypeofActivity(entity.getTypeOfActivity().getDescription());
        return companySearch;
    }
    public void saveCompany(User user) throws IOException {
        CompanySearch companySearch = getFromEntity(user.getCompany_info());
        elasticService.insert(companySearch,String.valueOf(companySearch.getId()));
    }
    public void deleteCompany(User user) throws IOException {
        CompanySearch companySearch = getFromEntity(user.getCompany_info());
        elasticService.delete(companySearch.getIndex(), String.valueOf(companySearch.getId()));
    }

    public void updateCompany(User user,String description) throws IOException {
        CompanySearch companySearch = getFromEntity(user.getCompany_info());
        elasticService.update(companySearch,companySearch.getId());
    }
}
