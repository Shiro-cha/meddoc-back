package meddoc.dev.module.prosante.controller;

import meddoc.dev.genericUsage.genericController.CrudEntityController;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.module.prosante.model.TypeOfActivity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/typeOfActivity")
public class TypeOfActivityController extends CrudEntityController<TypeOfActivity,Integer> {
    @GetMapping("/forCompany")
    public List<TypeOfActivity> getForCompany(){
        return ((meddoc.dev.module.prosante.service.TypeOfActivityService)service).getForCompany();
    }
    @GetMapping("/forIndependant")
    public List<TypeOfActivity> getForIndependant(){
        return ((meddoc.dev.module.prosante.service.TypeOfActivityService)service).getForIndependant();
    }
    @Override
    @Autowired
    @Qualifier("typeOfActivityService")
    public void setService(GenericService<TypeOfActivity,Integer> service) {
        this.service = service;
    }
}
