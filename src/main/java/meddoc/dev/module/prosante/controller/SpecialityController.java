package meddoc.dev.module.prosante.controller;

import meddoc.dev.genericUsage.genericController.CrudEntityController;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.module.prosante.model.Speciality;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/speciality")
public class SpecialityController extends CrudEntityController<Speciality,Integer> {
    @Override
    @Autowired
    @Qualifier("specialityService")
    public void setService(GenericService<Speciality,Integer> service) {
        this.service = service;
    }
}
