package meddoc.dev.module.prosante.controller;

import meddoc.dev.genericUsage.genericService.QueryBuilderService;
import meddoc.dev.genericUsage.genericService.UserService;
import meddoc.dev.module.prosante.RequestMap.NameMap;
import meddoc.dev.module.prosante.model.Diagnostic;
import meddoc.dev.module.prosante.model.Medicament;
import meddoc.dev.module.prosante.model.MedicamentType;
import meddoc.dev.module.prosante.model.Symptom;
import meddoc.dev.module.prosante.repository.DiagnosticRepository;
import meddoc.dev.module.prosante.repository.MedicamentRepository;
import meddoc.dev.module.prosante.repository.MedicamentTypeRepository;
import meddoc.dev.module.prosante.repository.SymptomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;


@Controller
@RequestMapping("/consultation")
@PreAuthorize("hasRole('healthpro')")
public class ConsultationController  {
    @Autowired
    UserService userService;
    @Autowired
    QueryBuilderService<Medicament> search;
    @Autowired
    SymptomRepository symptomRepository;
    @Autowired
    MedicamentRepository medicamentRepository;
    @Autowired
    MedicamentTypeRepository medicamentTypeRepository;
    @Autowired
    DiagnosticRepository diagnosticRepository;

    @GetMapping("/medicament")
    public ResponseEntity<List<Medicament>> findMedicament(@RequestParam String query){
        List<Medicament> medicaments=medicamentRepository.findAll(search.getSpecifications(query, Medicament.class));
        return ResponseEntity.ok(medicaments);
    }
    @GetMapping("/symptom")
    public ResponseEntity<List<Symptom>> findSymptom(@RequestParam String query){
        List<Symptom> symptoms=symptomRepository.findAll(search.getSpecifications(query, Symptom.class));

        return ResponseEntity.ok(symptoms);
    }
    @GetMapping("/medicamentType")
    public ResponseEntity<List<MedicamentType>> findMedicamentType(@RequestParam String query){
        List<MedicamentType> medicamentTypes=medicamentTypeRepository.findAll(search.getSpecifications(query, MedicamentType.class));
        List<String> names=medicamentTypes.stream().map(medicamentType -> medicamentType.getName()).collect(Collectors.toList());
        return ResponseEntity.ok(medicamentTypes);
    }
    @GetMapping("/diagnostic")
    public ResponseEntity<List<String>> findDiagnostic(@RequestParam String query){
        List<Diagnostic> diagnostics=diagnosticRepository.findAll(search.getSpecifications(query, Diagnostic.class));
        List<String> names=diagnostics.stream().map(diagnostic -> diagnostic.getName()).collect(Collectors.toList());
        return ResponseEntity.ok(names);
    }
    @PostMapping ("/symptom")
    public ResponseEntity<String> addSymptom(@RequestBody NameMap nmap){
        String nameLc=nmap.getName().toLowerCase();
        Symptom symptom=new Symptom();
        symptom.setName(nameLc);
        symptomRepository.save(symptom);
        return ResponseEntity.ok("success");
    }
    @PostMapping ("/medicamentType")
    public ResponseEntity<String> addMedicamentType(@RequestBody NameMap nmap){
        String nameLc=nmap.getName().toLowerCase();
        MedicamentType medicamentType=new MedicamentType();
        medicamentType.setName(nameLc);
        medicamentTypeRepository.save(medicamentType);
        return ResponseEntity.ok("success");
    }
    @PostMapping ("/medicament")
    public ResponseEntity<String> addMedicament(@RequestBody NameMap nmap) {
        String nameLc=nmap.getName().toLowerCase();
        Medicament medicament=new Medicament();
        medicament.setName(nameLc);
        medicamentRepository.save(medicament);
        return ResponseEntity.ok("success");
    }
    @PostMapping ("/diagnostic")
    public ResponseEntity<String> addDiagnostic(@RequestBody NameMap nmap){
        String nameLc=nmap.getName().toLowerCase();
        Diagnostic diagnostic=new Diagnostic();
        diagnostic.setName(nameLc);
        diagnosticRepository.save(diagnostic);
        return ResponseEntity.ok("success");
    }
}
