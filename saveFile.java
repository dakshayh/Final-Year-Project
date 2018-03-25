package com.Performance.Controller;

import com.Performance.Connection.ConnectionFactory;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.CipherOutputStream;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@MultipartConfig(location = "/tmp", fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class saveFile extends HttpServlet {

    private String college;
    long sizeInBytes;
    FileItem flItem = null;
    Connection con = null;
    PreparedStatement pst = null;
    private String StoreFiles;
    private String DecryptFiles;
    private String EncryptFiles;
    private String name;
    private String pricing;
    private String filesize;
    String key;
    FileInputStream fis,fis1;
    FileOutputStream fos,fos1;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();

        javax.servlet.http.HttpSession session = request.getSession();
        try {
            StoreFiles = (String) session.getAttribute("upload");
            DecryptFiles = (String) session.getAttribute("decryption");
            //user = (String) session.getAttribute("username");
            EncryptFiles = (String) session.getAttribute("encryption");
            long start=System.currentTimeMillis();
            boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
            if (isMultiPart) {
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List items = upload.parseRequest(request);
                Iterator<FileItem> iter = items.iterator();
                while (iter.hasNext()) {
                    FileItem fileItem = iter.next();
                    if (fileItem.isFormField()) {
                        processFormField(fileItem);
                    } else {
                        flItem = fileItem;
                        name = new File(fileItem.getName()).getName();
                        sizeInBytes = fileItem.getSize();
                        filesize = String.valueOf(sizeInBytes);
                        fileItem.write(new File(StoreFiles + File.separator + name));
                        
                        key = "squirrel123"; 

			fis = new FileInputStream(StoreFiles + File.separator + name);
			fos = new FileOutputStream(EncryptFiles + File.separator + name);
                        try {
                            encrypt(key, fis, fos);
                        } catch (Throwable ex) {
                            Logger.getLogger(saveFile.class.getName()).log(Level.SEVERE, null, ex);
                        }

			fis1 = new FileInputStream(EncryptFiles + File.separator + name);
			fos1= new FileOutputStream(DecryptFiles + File.separator + name);
                        try {
                            decrypt(key, fis1, fos1);
                        } catch (Throwable ex) {
                            Logger.getLogger(saveFile.class.getName()).log(Level.SEVERE, null, ex);
                        }
                                               

                        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                        Date date = new Date();
                        long end=System.currentTimeMillis();
                        String size=String.valueOf(Double.parseDouble(filesize) /1024);
                        System.out.println("Size :"+size);
                        String time=String.valueOf(end-start);
                        con = ConnectionFactory.getConnection();
                        pst = con.prepareStatement("insert into datatable(schemaname,uploadfile,encryptfile,decryptfile,time,filesize,file,filecost) values(?,?,?,?,?,?,?,?)");
                        pst.setString(1, college);
                        pst.setString(2, StoreFiles + File.separator + name);
                        pst.setString(3, EncryptFiles + File.separator + name);
                        pst.setString(4, DecryptFiles + File.separator + name);
                        pst.setString(5, time);
                        pst.setString(6, size);
                        pst.setString(7, name);
                        pst.setString(8,pricing);
                   
                 
                        int i = pst.executeUpdate();
                       // pst = con.prepareStatement("insert into uploads(username,cloudid,uploadfile,encryptfile,decryptfile,uploadtime,filesize,file) values(?,?,?,?,?,?,?,?)");
                        if (i > 0) {
                            
                        
                            out.println("<html>");
                            out.print("<script language='JavaScript'>alert('Your Record Uploaded.');</script>");
                            out.println("<script> location.replace('addSchemaData.jsp'); </script>");
                            out.println("</html>");
                        } else {
                            out.println("<html>");
                            out.print("<script language='JavaScript'>alert('Your Record not Uploaded.');</script>");
                            out.println("<script> location.replace('addSchemaData.jsp'); </script>");
                            out.println("</html>");
                        }
                          
                    }

                }

            }


        } catch (Exception e) {
            e.printStackTrace();

        }


    }

   
	public static void encrypt(String key, InputStream is, OutputStream os) throws Throwable {
		encryptOrDecrypt(key, Cipher.ENCRYPT_MODE, is, os);
	}

	public static void decrypt(String key, InputStream is, OutputStream os) throws Throwable {
		encryptOrDecrypt(key, Cipher.DECRYPT_MODE, is, os);
	}

	public static void encryptOrDecrypt(String key, int mode, InputStream is, OutputStream os) throws Throwable {

		DESKeySpec dks = new DESKeySpec(key.getBytes());
		SecretKeyFactory skf = SecretKeyFactory.getInstance("DES");
		SecretKey desKey = skf.generateSecret(dks);
		Cipher cipher = Cipher.getInstance("DES"); 

		if (mode == Cipher.ENCRYPT_MODE) {
			cipher.init(Cipher.ENCRYPT_MODE, desKey);
			CipherInputStream cis = new CipherInputStream(is, cipher);
			doCopy(cis, os);
		} else if (mode == Cipher.DECRYPT_MODE) {
			cipher.init(Cipher.DECRYPT_MODE, desKey);
			CipherOutputStream cos = new CipherOutputStream(os, cipher);
			doCopy(is, cos);
		}
	}

	public static void doCopy(InputStream is, OutputStream os) throws IOException {
		byte[] bytes = new byte[1024];
		int numBytes;
		while ((numBytes = is.read(bytes)) != -1) {
			os.write(bytes, 0, numBytes);
		}
		os.flush();
		os.close();
		is.close();
	}
        

    private void processFormField(FileItem item) {
        if (item.getFieldName().equals("college")) {
            college = item.getString();
        }else if (item.getFieldName().equals("city")) {
            pricing = item.getString();
        }
    }
}
