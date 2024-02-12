package meddoc.dev.module.prosante.controller;

import meddoc.dev.genericUsage.genericController.CrudEntityController;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.module.prosante.model.Civility;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/civility")
public class CivilityController extends CrudEntityController<Civility,Integer> {
    @Override
    @Autowired
    @Qualifier("civilityService")
    public void setService(GenericService<Civility,Integer> service) {
        this.service = service;
    }
}
