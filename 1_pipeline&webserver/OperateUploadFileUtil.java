package FileUpLoad;
import FileUpLoad.OperateUploadFileDTO;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


import javax.servlet.http.HttpServletRequest;

import java.util.List;

public class OperateUploadFileUtil {

    /**
     * ��request���н����������ϴ����ļ�
     * @param request
     */
    public static OperateUploadFileDTO parseParam(HttpServletRequest request) {

        OperateUploadFileDTO result = new OperateUploadFileDTO();

//����һ��FileItem���� ͨ��DiskFileItemFactory���󴴽��ļ��ϴ��������
        ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());
        upload.setHeaderEncoding("UTF-8");

        try {
//ͨ���ļ��ϴ������������request���󣬻�ȡ�����е�FileItem����
            List<FileItem> fileItemList = upload.parseRequest(request);

//�����������б��FileItem�� �����������ز���
            for(FileItem fileItem : fileItemList) {
//�ж�������������һ����ͨ�ı���
                if(fileItem.isFormField()) {
                    result.getParamMap().put(fileItem.getFieldName(),fileItem.getString("UTF-8"));
//������Ǳ�����ͨ�ı��򣬾���
                } else {
                    result.getFileMap().put(fileItem.getFieldName(),fileItem);
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
