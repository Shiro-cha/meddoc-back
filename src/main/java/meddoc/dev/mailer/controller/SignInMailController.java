package meddoc.dev.mailer.controller;

import meddoc.dev.mailer.service.IMailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/mail/signin")
public class SignInMailController extends MailController{
    @Qualifier("mailerService")
    @Autowired
    public void setMailService(IMailService mailService) {
        this.mailService = mailService;
    }
}
