package SendMail;


import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import java.util.Date;
import java.util.Properties;

public class mail {
	public static void main(String[ ] args) throws Exception{
		Message message = null;// ���� 
		//�����������������
		Properties props=new Properties();
		//163�ʼ���������ַ
		props.put("mail.smtp.host", "smtp.163.com");
		props.put("mail.smtp.ssl.enable", true);
		// 163�ʼ��������˿�
		props.put("mail.smtp.port","25");
		//163�ʼ���������֤����
		props.put ("mail.smtp.auth","true");
		Session session=Session.getInstance(props ,new MyAuthenticator("bioinformatics2021@163.com","IDULIARNITZXVDLH")); 
		 message=new MimeMessage(session);
		
		
		// ���÷��� �˵�ַ
		InternetAddress from=new InternetAddress ("bioinformatics2021@163.com");
		message.setFrom(from) ;
		//Ŀ���û������ַ
		message.setRecipient (RecipientType.TO , new InternetAddress("3428255976@qq.com"));
		message.setSentDate(new Date());//���÷�������
		message.setSubject("weiwei");//��������
		message.setText("I love you");//�����ı�����
		 //System.out.println(message);
		
		
		Transport.send(message);//�������������
	}
}
