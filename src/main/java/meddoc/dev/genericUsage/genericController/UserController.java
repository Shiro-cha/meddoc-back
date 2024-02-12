package meddoc.dev.genericUsage.genericController;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import meddoc.dev.genericUsage.genericModel.User;
import meddoc.dev.genericUsage.genericService.UserService;
import meddoc.dev.module.patient.Dto.PatientDto;
import meddoc.dev.genericUsage.RequestBodyMap.ChangePasswordMap;
import meddoc.dev.module.patient.model.Patient;
import meddoc.dev.module.patient.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private PatientService patientService;
    @RequestMapping(value = "/uploadImage",method = RequestMethod.POST,
            consumes=MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<String> imageUpload(@RequestPart("image") MultipartFile image){
        User user = userService.getCurrentLoggedInUser();
        userService.uploadImage(user,image);
        return ResponseEntity.ok("image uploaded successfully");
    }
    @GetMapping("/getImage")
    public ResponseEntity<String> getImageEndpoint(){
        User user=userService.getCurrentLoggedInUser();
        String prefix="http://localhost:8080/images/";
        return ResponseEntity.ok(prefix+user.getProfile_picture_url());
    }

    @PostMapping("/createRelative")
    @PreAuthorize("hasRole('patient')")
    public ResponseEntity<PatientDto> create(
            @Valid @RequestBody PatientDto relative
    ){
        Patient patient= relative.toModel();
        User user=userService.getCurrentLoggedInUser();
        patient.setCareTaker(user);
        patientService.save(patient);
        return ResponseEntity.ok(relative);
    }
    @GetMapping("/readRelative")
    public ResponseEntity<List<PatientDto>> readRelative(){
        User user=userService.getCurrentLoggedInUser();
        List<Patient> patients=patientService.findAllByCareTakerId(user.getId());
        List<PatientDto> patientDtos=
        patients.stream().map(patient -> {
            PatientDto patientDto=new PatientDto();
            patientDto.fromModel(patient);
            return patientDto;
        }).collect(Collectors.toList());
        return ResponseEntity.ok(patientDtos);
    }
    @PutMapping("/updateRelative/{identifier}")
    @PreAuthorize("hasRole('patient')")
    public ResponseEntity<String> updateByIdentifier(
            @PathVariable("identifier") String identifier,
            @Valid @RequestBody PatientDto patientDto
    ){
        Patient patient=patientDto.toModel();
        User user =userService.getCurrentLoggedInUser();
        patientService.updateRelative(user,patient,identifier);
        return ResponseEntity.ok("realtive successfully updated");
    }
    @PutMapping("/updatePatient/{identifier}")
    @PreAuthorize("hasRole('patient')")
    public ResponseEntity<String> updatePatientByIdentifier(
            @PathVariable("identifier") String identifier,
            @Valid @RequestBody PatientDto patientDto
    ){
        Patient patient=patientDto.toModel();
        patientService.update(patient,identifier);
        return ResponseEntity.ok("patient successfully updated");
    }
//    @DeleteMapping("/deletebyidentifier/{identifier}")
//    @PreAuthorize("hasRole('patient')")
//    public ResponseEntity<?> deleteByIdentifier(
//            @PathVariable("identifier") String identifier
//    ){
//        Patient p=patientService.getByIdentifier(identifier);
//        patientService.deleteById(p.getId());
//        return ResponseEntity.ok("Caretaked successfully deleted");
//    }
    @PutMapping("/changePassword")
    public ResponseEntity<String> changePassword(
            @RequestBody ChangePasswordMap chPassMap
    ) {
        try {
            User user= userService.getCurrentLoggedInUser();
            userService.setUser(user);
            userService.changePassword(chPassMap);
            return ResponseEntity.ok("Le mot de passe a été changé ");
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
