package meddoc.dev.module.prosante.service;

import meddoc.dev.genericUsage.genericModel.Role;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericRepo.UserRepository;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.module.prosante.model.Company;
import meddoc.dev.module.prosante.model.HealthPro;
import meddoc.dev.module.prosante.repository.CompanyRepository;
import meddoc.dev.module.prosante.repository.HealthProRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CompanyService extends GenericService<Company,Integer> {
    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;
    @Autowired
    private HealthProRepository healthProRepository;
    @Autowired
    private UserRepository userRepository;
    public void isEnoughHeatltPro(Company company){
        int maxAccount=company.getTypeOfActivity().getMaxAccountPermitted();
        int numberOfHealthPro=getNumberOfHealthPro(company.getId());
        if (numberOfHealthPro==maxAccount){
            throw new RuntimeException("Vous avez atteint le nombre maximum de compte activé");
        }
    }
    public void activateAccount(HealthPro healthPro, Role healthProRole ) {
        User user= userRepository.findByHealthProId(healthPro.getId()).orElseThrow(
                ()->{ throw new RuntimeException("Utilisateur introuvable ");}
        );
        if(user.getRole()==null) {
            user.setRole(healthProRole);
            userRepository.save(user);
        }
    }
    public void desactivateAccount(HealthPro healthPro){
        User user= userRepository.findByHealthProId(healthPro.getId()).orElseThrow(
                ()->{ throw new RuntimeException("Utilisateur introuvable ");}
        );
        if(user.getRole()!=null){
            user.setRole(null);
            userRepository.save(user);
        }
    }
    public List<HealthPro> getLhealthPro(Company company){
        return healthProRepository.findByCompanyId(company.getId());
    }
    public int getNumberOfHealthPro(int companyId){
        String sql = "SELECT count(*) as total FROM useraccount where " +
                " healthpro_id in (select id FROM healthpro WHERE company_id= :company_id) and role_id is not null ";
        MapSqlParameterSource params = new MapSqlParameterSource();
        params.addValue("company_id",companyId);
        int numberOfHealthPro= jdbcTemplate.query(sql, params,(rs) -> {   if (rs.next())
            return rs.getInt("total");
        else return 0;
        });
        return numberOfHealthPro;
    }
    @Override
    @Autowired
    @Qualifier("companyRepository")
    public void setRepository(JpaRepository<Company, Integer> repository) {
        this.repository = repository;
    }

    public CompanyRepository getRepository(){
        return (CompanyRepository) this.repository;
    }
}
