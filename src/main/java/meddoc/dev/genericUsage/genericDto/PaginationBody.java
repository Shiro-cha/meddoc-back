package meddoc.dev.genericUsage.genericDto;

import lombok.Data;

import java.util.List;
@Data

public class PaginationBody <L>{
    int page;
    int size;
    List<L> list;
}
