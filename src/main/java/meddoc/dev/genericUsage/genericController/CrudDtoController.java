package meddoc.dev.genericUsage.genericController;

import jakarta.validation.Valid;
import meddoc.dev.genericUsage.genericDto.GenericDto;
import meddoc.dev.genericUsage.genericModel.HasId;
import meddoc.dev.genericUsage.genericService.GenericService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

public abstract class CrudDtoController<DTO extends GenericDto,E extends HasId,ID> {
    protected GenericService<E,ID> service;

    protected GenericDto<E> dto;
    @PostMapping("/create")
    public ResponseEntity<DTO> create(@Valid @RequestBody DTO model) {
            service.save((E) model.toModel());
            return ResponseEntity.ok(model);
    }

    @GetMapping("/read")
    public ResponseEntity<List<DTO>> read() throws InstantiationException, IllegalAccessException {
        List<E> models = service.findAll();
        List<DTO> dtos = dto.toDtoList(models);
        return ResponseEntity.ok(dtos);
    }

    @PutMapping("/update/{id}")
    public  ResponseEntity<DTO> update(@PathVariable ID id,@Valid @RequestBody DTO model) {
        E modelToUpdate = service.findById(id);
        E modelToSave = (E) model.toModel();
        if (modelToUpdate != null) {
            modelToSave.setId(modelToUpdate.getId());
            service.save(modelToSave);
        }
        model.fromModel(modelToSave);
        return ResponseEntity.ok(model);
    }
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<E> delete(@PathVariable ID id) {
        E modelToDelete = service.findById(id);
        service.deleteById(id);
        return ResponseEntity.ok(modelToDelete);
    }
    public abstract void setService(GenericService service);
    public abstract void setDto();
}
