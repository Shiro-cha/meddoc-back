package meddoc.dev.genericUsage.genericService;

import jakarta.persistence.EntityManager;
import meddoc.dev.genericUsage.genericModel.Role;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericRepo.UserRepository;
import meddoc.dev.genericUsage.RequestBodyMap.ChangePasswordMap;
import meddoc.dev.genericUsage.statistique.StatService;
import meddoc.dev.module.prosante.Dto.ProfilCompanyDto;
import meddoc.dev.module.prosante.Dto.ProfilHproDto;
import meddoc.dev.module.prosante.model.V_pointage_healthpro;
import meddoc.dev.module.prosante.model.V_pointage_patient;
import meddoc.dev.module.prosante.service.ViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import org.apache.commons.io.FilenameUtils;

@Service
public class UserService extends GenericService<User,Integer> {
    private User user;

    @Value("${image.directory}")
    private String imageDirectory;
    @Autowired
    private  BCryptPasswordEncoder bCryptPasswordEncoder;
    @Autowired
    private ViewService viewService;
    public Page<User> userEvents(int healthProId, int eventTypeId, Pageable pageable){
        return getUserRepository().getUserInEvent(healthProId,eventTypeId,pageable);
    }
    public void activateUser(User user,Role role) {
        user.setRole(role);
        getUserRepository().save(user);
    }

    public User findByEmail(String email) {
       return getUserRepository().findByEmail(email)
               .orElseThrow(()->new RuntimeException("email not found"));
    }
    public User findByHealthProUser(int hId){
        return getUserRepository().findByHealthProId(hId)
                .orElseThrow(()->new RuntimeException("healthProId not found"));
    }

    public User getCurrentLoggedInUser(){
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        return findByEmail(username);
    }
    public void changePassword(ChangePasswordMap chPassMap) {
        if(chPassMap.getNewPassword().compareTo(chPassMap.getConfirmPassword())!=0){
            throw new RuntimeException("les deux mots de passe ne sont pas identiques");
        }
        isSameAsBefore(chPassMap.getNewPassword());
        getUser().setPassword(bCryptPasswordEncoder.encode(chPassMap.getNewPassword()));
        getUserRepository().save(getUser());
    }
    private void isSameAsBefore(String newPassword) {
        if(bCryptPasswordEncoder.matches(newPassword, user.getPassword())){
            throw new RuntimeException("Mot de passe identique à la précédente");
        }
    }

    public void setUser(User user) {
        this.user = user;
    }

    public HashMap<String,List<?>> getUnactivatedUsers() {
        List<User> healthProUsers=getUserRepository().findUnactivatedHealthProUsers();
        List<User> companyUsers=getUserRepository().findUnactivatedCompanyUsers();
        HashMap<String,List<?>> unactivatedUsers=new HashMap<>();
        unactivatedUsers.put("healthProUsers",getProfilsHpro(healthProUsers));
        unactivatedUsers.put("companyUsers",getProfilCompany(companyUsers));
        return unactivatedUsers;
    }
    public List<ProfilHproDto> getProfilsHpro(List<User> users){
        List<ProfilHproDto> hpros=new ArrayList<>();
        users.stream().forEach(user -> {
            ProfilHproDto hpro=new ProfilHproDto(user,user.getHealthpro_info());
            hpros.add(hpro);
        });
        return hpros;
    }
    public List<ProfilCompanyDto> getProfilCompany(List<User> users){
        List<ProfilCompanyDto> companies=new ArrayList<>();
        users.stream().forEach(user -> {
            ProfilCompanyDto company=new ProfilCompanyDto(user,user.getCompany_info());
            companies.add(company);
        });
        return companies;
    }

    public Page<V_pointage_healthpro> getHealthProUsers(String keyword,double percentageFeedBack,double percentageCancel,int roleSum,Pageable pageable) {
        Specification specification=Specification.where(null);
        if(keyword!=null && !keyword.isEmpty()){
            specification=specification.and(ViewService.getHealthProSpecification(keyword));
        }
        if(percentageFeedBack>0 && percentageFeedBack<=100){
            specification=specification.and(ViewService.gteStat(percentageFeedBack,"feed_back"));
        }
        if(percentageCancel>0 && percentageCancel<=100){
            specification=specification.and(ViewService.gteStat(percentageCancel,"cancelled_by_hpro"));
        }
        Specification hasRoleSpec=Specification.where(null);
        Specification hasNoRoleSpec=Specification.where(null);
        if(roleSum==1 || roleSum==3){
            hasNoRoleSpec=ViewService.role_idNull();
        }
        if(roleSum==2 || roleSum==3){
            hasRoleSpec=ViewService.role_idNotNull();
        }
        specification=specification.and(Specification.where(hasRoleSpec).or(hasNoRoleSpec));

        Page<V_pointage_healthpro> healthProUsers=viewService.getV_pointage_hpro_rep().findAll(specification,pageable);
        return healthProUsers;
    }
    public Page<V_pointage_patient> getPatientUsers(String keyword,double percentageMissed,double percentageCancel,int roleSum,Pageable pageable) {
        Specification specification=Specification.where(null);
        if(keyword!=null && !keyword.isEmpty()){
            specification=specification.and(ViewService.getPatientSpecification(keyword));
        }
        if(percentageMissed>0 && percentageMissed<=100){
            specification=specification.and(ViewService.gtePatientStat(percentageMissed,"missed"));
        }
        if(percentageCancel>0 && percentageCancel<=100){
            specification=specification.and(ViewService.gtePatientStat(percentageCancel,"cancelled_by_patient"));
        }

        Specification hasRoleSpec=Specification.where(null);
        Specification hasNoRoleSpec=Specification.where(null);
        if(roleSum==1 || roleSum==3){
            hasNoRoleSpec=ViewService.role_idNull();
        }
        if(roleSum==2 || roleSum==3){
            hasRoleSpec=ViewService.role_idNotNull();
        }
        specification=specification.and(Specification.where(hasRoleSpec).or(hasNoRoleSpec));
        Page<V_pointage_patient> patientUsers=viewService.getV_pointage_patient_rep().findAll(specification,pageable);
        return patientUsers;
    }

    public User getUser() {
        if(user==null)
            throw new RuntimeException("user is null set user first");
        return user;
    }
    public void deactivateUser(User user) {
        user.setRole(null);
        getUserRepository().save(user);
    }
    @Override
    public User findById(Integer id) {
        return getUserRepository().findById(id)
                .orElseThrow(()->new RuntimeException("user not found"));
    }

    @Override
    @Autowired
    public void setRepository(JpaRepository<User, Integer> repository) {
        this.repository=repository;
    }

    public UserRepository getUserRepository(){
        return (UserRepository) this.repository;
    }
    public void uploadImage(User user, MultipartFile image) {
        String path=imageDirectory;
        makeDirectoryIfNotExist(path);
        String newImageName=getFilename(user).concat(".").concat(FilenameUtils.getExtension(image.getOriginalFilename()));
        Path fileNamePath= Paths.get(imageDirectory, newImageName);
        try {
            Files.write(fileNamePath, image.getBytes());
            if(user.getProfile_picture_url()!=null){
                Files.delete(Paths.get(imageDirectory,user.getProfile_picture_url()));
            }
            user.setProfile_picture_url(newImageName);
            getUserRepository().save(user);
        }catch (Exception e){
            throw new RuntimeException("erreur lors de l'upload de l'image");
        }
    }
    private String getFilename(User user){
        Timestamp timestamp=new Timestamp(System.currentTimeMillis());
        return user.getId()+"_"+timestamp.getTime();
    }
    public void makeDirectoryIfNotExist(String path){
        File file=new File(path);
        if(!file.exists()){
            file.mkdir();
        }
    }
}
