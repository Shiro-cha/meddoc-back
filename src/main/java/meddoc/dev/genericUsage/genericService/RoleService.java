package meddoc.dev.genericUsage.genericService;

import meddoc.dev.genericUsage.genericModel.Role;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericRepo.RoleRepository;
import meddoc.dev.module.prosante.constant.RoleName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

@Service
public class RoleService extends GenericService<Role,Integer> {
    public Role getRoleByName(RoleName roleName){
        return getRoleRepository().findByName(roleName.getValue())
                .orElseThrow(()->new RuntimeException("role not found"));
    }

    @Override
    @Autowired
    public void setRepository(JpaRepository<Role, Integer> repository) {
        this.repository=repository;
    }
    public RoleRepository getRoleRepository(){
        return (RoleRepository) this.repository;
    }

    public Role getCorrespondingRole(User user) {
        if(user.getCompany_info() != null){
            return getRoleByName(RoleName.SECRETARY);
        }
        if(user.getHealthpro_info() != null){
            return getRoleByName(RoleName.HEALTHPRO);
        }
        if(user.getPatient_info() != null){
            return getRoleByName(RoleName.PATIENT);
        }
        throw new RuntimeException("user has no correspoding  role for this profile");
    }
}
