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
		Message message = null;// 卫星 
		//定义邮箱服务器配置
		Properties props=new Properties();
		//163邮件服务器地址
		props.put("mail.smtp.host", "smtp.163.com");
		props.put("mail.smtp.ssl.enable", true);
		// 163邮件服务器端口
		props.put("mail.smtp.port","25");
		//163邮件服务器认证属性
		props.put ("mail.smtp.auth","true");
		Session session=Session.getInstance(props ,new MyAuthenticator("bioinformatics2021@163.com","IDULIARNITZXVDLH")); 
		 message=new MimeMessage(session);
		
		
		// 设置发送 人地址
		InternetAddress from=new InternetAddress ("bioinformatics2021@163.com");
		message.setFrom(from) ;
		//目标用户邮箱地址
		message.setRecipient (RecipientType.TO , new InternetAddress("3428255976@qq.com"));
		message.setSentDate(new Date());//设置发送日期
		message.setSubject("weiwei");//设置主题
		message.setText("I love you");//设置文本内容
		 //System.out.println(message);
		
		
		Transport.send(message);//火箭送卫星上天
	}
}
