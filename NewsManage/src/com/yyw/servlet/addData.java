package com.yyw.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.yyw.dao.JDBCOperation;
public class addData extends HttpServlet {

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
        
        String name = request.getParameter("NAME");
        String address = request.getParameter("ADDRESS");
        String phone = request.getParameter("PHONE");
        String time = request.getParameter("TIME");
        String price = request.getParameter("PRICE");
        String port = request.getParameter("PORT");
        Double lng = Double.parseDouble(request.getParameter("LONGITUDE"));
        Double lat = Double.parseDouble(request.getParameter("LATITUDE"));
        int sta_class = Integer.parseInt(request.getParameter("CLASS"));
       
        
        System.out.println(name);
        
        JDBCOperation op=new JDBCOperation();
        op.AddData(name,address,phone,time,price,port,sta_class,lng,lat);
        PrintWriter out = response.getWriter();
        out.println(name);
        out.close();
	}

}
