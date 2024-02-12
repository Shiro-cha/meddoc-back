package meddoc.dev.module.prosante.controller;

import meddoc.dev.genericUsage.genericController.CrudEntityController;
import meddoc.dev.genericUsage.genericService.GenericService;
import meddoc.dev.module.prosante.model.AffiliationOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/affiliationorder")
public class AffiliationOrderController extends CrudEntityController<AffiliationOrder,Integer> {
    @Override
    @Autowired
    @Qualifier("affiliationOrderService")
    public void setService(GenericService<AffiliationOrder,Integer> service) {
        this.service = service;
    }
}
