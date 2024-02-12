package meddoc.dev.genericUsage.Exception.handler;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ExceptionHandler {
    @org.springframework.web.bind.annotation.ExceptionHandler(value = RuntimeException.class)
    public ResponseEntity<Object> handleException(RuntimeException e){
        ExceptionModel exceptionModel = new ExceptionModel();
        exceptionModel.setMessage(e.getMessage());
        exceptionModel.setThrowable(e.getCause());
        exceptionModel.setHttpStatus(org.springframework.http.HttpStatus.BAD_REQUEST);
        exceptionModel.setDateTime(java.time.ZonedDateTime.now());
        return new ResponseEntity<>(exceptionModel, org.springframework.http.HttpStatus.BAD_REQUEST);
    }

}
