package meddoc.dev.mailer.service;

import meddoc.dev.mailer.model.Mail;

public interface IMailService {
    public void sendMail(
            Mail mail
            );
}
