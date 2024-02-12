package meddoc.dev.genericUsage.genericDto;

import lombok.NoArgsConstructor;
import meddoc.dev.genericUsage.genericModel.HasId;

import java.util.ArrayList;
import java.util.List;
public abstract class GenericDto<E extends HasId> {
    public <DTO> List<DTO> toDtoList(List<E> models) throws InstantiationException, IllegalAccessException {
        List<DTO> dtos = new ArrayList<>();
        GenericDto dto;
        for (E model : models) {
            dto = this.getClass().newInstance();
            dto.fromModel(model);
            dtos.add((DTO) dto);
        }
        return dtos;
    }

    abstract public E toModel();
    abstract public void fromModel(E model);
}
