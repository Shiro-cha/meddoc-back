package meddoc.dev.mailer.service;

import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import meddoc.dev.mailer.model.Mail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MailerService implements IMailService{
    @Autowired
    private JavaMailSender javaMailSender;

    @Value("${spring.mail.username}")
    private String fromEmail;

    @Override
    public void sendMail(Mail mail) {
        MimeMessage mimeMessage= javaMailSender.createMimeMessage();
        MimeMessageHelper helper=null;
        try {
            helper=new MimeMessageHelper(mimeMessage,true);
            helper.setFrom(fromEmail);
            helper.setTo(mail.getTo());
            helper.setSubject(mail.getSubject());
            helper.setText(mail.getBody());
            javaMailSender.send(mimeMessage);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
