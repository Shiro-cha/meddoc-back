package meddoc.dev.genericUsage.genericController;

import meddoc.dev.genericUsage.genericModel.HasId;
import meddoc.dev.genericUsage.genericService.GenericService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

public abstract class CrudEntityController<L extends HasId,ID> {
    protected GenericService<L,ID> service;
    @PostMapping("/create")
    public ResponseEntity<L> create(@RequestBody L model) {
            service.save(model);
            return ResponseEntity.ok(model);
    }

    @GetMapping("/read")
    public ResponseEntity<List<L>> read() {
        return ResponseEntity.ok(service.findAll());
    }

    @PutMapping("/update/{id}")
    public  ResponseEntity<L> update(@PathVariable ID id, @RequestBody L model) {
        L modelToUpdate = service.findById(id);
        if (modelToUpdate != null) {
            model.setId(modelToUpdate.getId());
            service.save(model);
        }
        return ResponseEntity.ok(modelToUpdate);
    }
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<L> delete(@PathVariable ID id) {
        L modelToDelete = service.findById(id);
        service.deleteById(id);
        return ResponseEntity.ok(modelToDelete);
    }
    public abstract void setService(GenericService<L,ID> service);
}
