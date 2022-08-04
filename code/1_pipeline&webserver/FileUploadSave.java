package FileUpLoad;
import FileUpLoad.OperateUploadFileUtil;
import FileUpLoad.OperateUploadFileDTO;
import java.io.IOException;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.RandomStringUtils;




/**
 * Servlet implementation class FileUploadSave
 */
public class FileUploadSave extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileUploadSave() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email_address=request.getParameter("email_address");
		//System.out.print(email_address);
		//�õ�����ļ��ϴ�����ʵ��·��
		String realPath = getServletContext().getRealPath("/upload");
		realPath=realPath.replaceAll("\\\\","/")+"/";
		//del file
		File file_all = new File(realPath);
		if(file_all.exists()){
			File[] list = file_all.listFiles();
			DateFormat format = new SimpleDateFormat("yyyyMMdd");
			String formatDate_now = format.format(new Date());
			Integer.parseInt(formatDate_now);
			for (int i = 0; i < list.length; i++){
				String formatDate_file = format.format(new Date(list[i].lastModified()));
			    if(Math.abs(Integer.parseInt(formatDate_now)-Integer.parseInt(formatDate_file))>=30){
			    	list[i].delete();
			    }
			}
		}
		//Ϊ�ļ�����һ���ص������ļ�����Ϊ��ַ���ļ�����upload��
		String Randompathname=RandomStringUtils.randomAlphanumeric(20);				
		File file =new File(realPath+Randompathname+"_"+email_address); 
		if  (! file.exists()  && ! file.isDirectory())    
		{     				   
		    file.mkdir();  
		}
		//System.out.print(realPath+Randompathname);
//�����ݲ������ļ����͵�ַ								
if (ServletFileUpload.isMultipartContent(request)){
	//����OperateUploadFileDTO�����õ��ļ�
    OperateUploadFileDTO dto = OperateUploadFileUtil.parseParam(request);

    String fileName = dto.getParamMap().get("fileName");//�ļ���
    //System.out.print(fileName);
    FileItem item = dto.getFileMap().get("file");//
    //System.out.print(item);

    try {
    	//���ļ�д�������ɵ�����ļ�              
        item.write(new File(realPath+Randompathname+"_"+email_address+"/"+fileName));
        String re="";
        //����json��ʽ���ļ����͵�ַ ��ע����js�л�ȡʱҪע��key��value�Ķ�Ӧ
        re="{" +'"'+"filename"+'"'+":"+'"'+fileName+'"'+","+'"'+"filepath"+'"'+":"+'"'+realPath+Randompathname+"_"+email_address+'"'+","+'"'+"Randompathname"+'"'+":"+'"'+Randompathname+"_"+email_address+'"'+"}";
        response.setContentType("text/html;charset=utf-8");
      //��ȡPrintWriter
        PrintWriter pw = response.getWriter();
      //���json���ݻ�ǰ�ˣ�ǰ̨ʹ��js��ȡ
        pw.println(re);
      //��ջ���
        pw.flush();
      //�ر�
        pw.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

}

}

}