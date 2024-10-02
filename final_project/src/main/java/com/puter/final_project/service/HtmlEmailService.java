package com.puter.final_project.service;

import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class HtmlEmailService implements EmailService{

    private final JavaMailSender javaMailSender;

    @Override
    public void send(EmailMessage emailMessage){

        MimeMessage mimeMessage = javaMailSender.createMimeMessage();
        
        try{
            MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, false, "UTF-8");
            mimeMessageHelper.setTo(emailMessage.getTo());
            mimeMessageHelper.setSubject(emailMessage.getMessage());
            mimeMessageHelper.setText(emailMessage.getMessage(), true);
            javaMailSender.send(mimeMessage);
            System.out.printf("sent email: {}", emailMessage.getMessage());
        } catch (MessagingException e){
            System.out.printf("failed to send email", e);
        }
    }
}
