package meddoc.dev.mailer.controller;

import meddoc.dev.mailer.model.Mail;
import meddoc.dev.mailer.service.IMailService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

public abstract class MailController {
    IMailService mailService;
    @PostMapping("/send")
    public String sendMail(
            Mail mail
            ) {
        mailService.sendMail(mail);
        return "Mail sent";
    }

    public abstract void setMailService(IMailService mailService);
}
