package com.yyw.servlet;


import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;

import java.sql.Connection;  
import java.sql.PreparedStatement;  
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import com.yyw.dao.JDBCOperation;
public class updateImage extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
		//response.sendRedirect("gjTest.jsp");  
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8"); 
        response.setContentType("text/html;charset=utf-8"); 
        response.setCharacterEncoding("utf-8"); 
        
        
        String std_id="";
       
        
        DiskFileItemFactory  factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        JDBCOperation op=new JDBCOperation();
        try{
        	// 解析请求的内容提取文件数据
            List<FileItem> formItems = upload.parseRequest(request);
            InputStream inputImg=null;
            for (FileItem item : formItems) {
                // 处理在表单中的字段
                if (item.isFormField()) {   
                	String name = item.getFieldName(); // 获取name属性的值
                	//*****这里非常重要！！！！！！！！！涉及到中文乱码的问题
                	String value = item.getString("UTF-8"); // 获取value属性的值
                	
                	if(name.equals("std_id"))
                	{
                		std_id = value;
                		System.out.print(std_id);
                	}
                	
                }else{

                	inputImg = item.getInputStream(); 
                }
                
            }
            Connection conn = op.getConn();

            //String sql = "UPDATE photos set photo =? where city='"+city+"'";
 			
 			
 			String sql = "UPDATE public.stationinfo SET image = ? WHERE gid = '"+std_id+"'";
         	PreparedStatement preStatement = conn.prepareStatement(sql);

         	preStatement.setBinaryStream(1, inputImg, inputImg.available());

         	if(inputImg.available()!=0)
         	{
         		preStatement.execute();
         	}  
         	
         	PrintWriter out = response.getWriter();
            out.write("上传成功");
            out.close();
  
    	
    
    	
      }catch(Exception e){
    	  e.printStackTrace();

    }
        
        
  }
}
