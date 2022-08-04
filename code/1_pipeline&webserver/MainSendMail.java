package SendMail;
import SendMail.MyAuthenticator;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class MainSendMail
 */
public class MainSendMail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MainSendMail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		//获取收件人和mail 的内容
		String RecipientAddress=request.getParameter("RecipientAddress");
		String mailContent=request.getParameter("mailContent");
		
			Message message = null;// 邮件
			//定义邮箱服务器配置
			Properties props=new Properties();
			//163邮件服务器地址
			props.put("mail.smtp.host", "smtp.163.com");
			props.put("mail.smtp.ssl.enable", true);
			// 163邮件服务器端口
			props.put("mail.smtp.port","25");
			//163邮件服务器认证属性
			props.put ("mail.smtp.auth","true");
			try {
			Session session=Session.getInstance(props ,new MyAuthenticator("bioinformatics2021@163.com","IDULIARNITZXVDLH")); 
			 message=new MimeMessage(session);
			
			
			// 设置发送 人地址
			InternetAddress from=new InternetAddress ("bioinformatics2021@163.com");
			message.setFrom(from) ;
			//目标用户邮箱地址
			message.setRecipient (RecipientType.TO , new InternetAddress(RecipientAddress));
			//邮件内容
			message.setSentDate(new Date());//设置发送日期
			message.setSubject("RBPreg");//设置主题
			message.setText(mailContent);//设置文本内容
			
			//发送邮件
			Transport.send(message);
			// System.out.println("success");
			} catch (Exception e) {
                e.printStackTrace();
            }
		}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
