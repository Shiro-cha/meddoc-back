package meddoc.dev.module.prosante.RequestMap;

import lombok.Data;
import meddoc.dev.module.prosante.model.Prescription;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;

@Data
public class ConsultationMap {
    int event_id;
    List<String> symptoms;
    List<Prescription> prescriptions;
    List<String> additional_notes;
}
