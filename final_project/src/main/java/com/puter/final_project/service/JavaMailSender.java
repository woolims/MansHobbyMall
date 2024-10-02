package com.puter.final_project.service;

import java.io.InputStream;

import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.MimeMessagePreparator;

import jakarta.mail.internet.MimeMessage;

public interface JavaMailSender extends MailSender {

    MimeMessage createMimeMessage();

    MimeMessage createMimeMessage(InputStream var1) throws MailException;

    void send(MimeMessage var1) throws MailException;
    void send(MimeMessage... var1) throws MailException;
    void send(MimeMessagePreparator var1) throws MailException;
    void send(MimeMessagePreparator... var1) throws MailException;

}
