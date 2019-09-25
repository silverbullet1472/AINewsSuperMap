package com.yyw.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.yyw.dao.JDBCOperation;
public class loadData extends HttpServlet {

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

		//System.out.println("============================");
		doPost(request, response);
		
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
	        String CLASS = request.getParameter("class");
	        System.out.println(CLASS);
	        if(CLASS.equals("super")){
	        	JDBCOperation op = new JDBCOperation();  
		        String geojson=op.getSuperStation();
		        PrintWriter out = response.getWriter();
		        System.out.println("123");
		        System.out.println("super");
		        System.out.println(geojson);
		        System.out.println("***************");
		        out.println(geojson);
		        out.close();
	        }
	        else if(CLASS.equals("destination")){
	        	JDBCOperation op = new JDBCOperation();  
		        String geojson=op.getDestiStation();
		        PrintWriter out = response.getWriter();
		        System.out.println("123");
		        System.out.println("destination");
		        System.out.println(geojson);
		        System.out.println("***************");
		        out.println(geojson);
		        out.close();
	        
	        }
	        else {
	        	System.out.println("error");
	        }

	        
	}

}

