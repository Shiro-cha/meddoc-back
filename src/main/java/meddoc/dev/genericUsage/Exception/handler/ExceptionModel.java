package meddoc.dev.genericUsage.Exception.handler;

import lombok.Data;
import org.springframework.http.HttpStatus;

import java.time.ZonedDateTime;

@Data
public class ExceptionModel {
    String message;
    Throwable throwable;
    HttpStatus httpStatus;
    ZonedDateTime dateTime;
}
