package meddoc.dev.mailer.model;


import lombok.Builder;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

@Setter

public class Mail {
//    protected MultipartFile[] files;
    protected String to;
    protected String[] cc;
    protected String subject;
    protected String body;

    public String getBody()  {
        if(this.body==null) throw new RuntimeException("body of the mail is empty");
        return this.body;
    }

//    public MultipartFile[] getFiles() {
//        if(this.files==null) return new MultipartFile[0];
//        return files;
//    }

    public String getSubject() {
        return subject;
    }

    public String getTo() {
        if(this.to==null || this.to.isBlank()) throw new RuntimeException("the correspondant is required") ;
        return to;
    }

    public String[] getCc() {
        if(this.cc==null) return new String[0];
        return cc;
    }

}
