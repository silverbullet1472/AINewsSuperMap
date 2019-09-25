package com.yyw.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.yyw.dao.JDBCOperation;
public class editData extends HttpServlet {

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

		request.setCharacterEncoding("UTF-8"); 
        response.setContentType("text/html;charset=UTF-8"); 
        response.setCharacterEncoding("UTF-8");
        
        String std_id = request.getParameter("ID");

        System.out.println(std_id);
        
        JDBCOperation op=new JDBCOperation();
        op.DeleteData(std_id);
        PrintWriter out = response.getWriter();
        out.println(std_id);
        out.close();
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

		request.setCharacterEncoding("UTF-8"); 
        response.setContentType("text/html;charset=UTF-8"); 
        response.setCharacterEncoding("UTF-8");
        
        String std_id = request.getParameter("ID");
        String name = request.getParameter("NAME");
        String address = request.getParameter("ADDRESS");
        String phone = request.getParameter("PHONE");
        String time = request.getParameter("TIME");
        String price = request.getParameter("PRICE");
        String port = request.getParameter("PORT");
       
        
        System.out.println(name);
        
        JDBCOperation op=new JDBCOperation();
        op.UpdateData(std_id,name,address,phone,time,price,port);
        PrintWriter out = response.getWriter();
        out.println(name);
        out.close();
	}

}
