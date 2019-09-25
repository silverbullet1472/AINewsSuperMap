package com.yyw.servlet;
import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.yyw.dao.JDBCOperation;
import net.sf.json.JSONArray;

public class loadChart extends HttpServlet {

	/**
	 * 
	 */
	

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 
        response.setContentType("text/html;charset=UTF-8"); 
        response.setCharacterEncoding("UTF-8");
		//创建DAO
        JDBCOperation op = new JDBCOperation();
		//从数据库里取数据
		String chartArr = op.queryChartData();

		//ArrayList对象转化为JSON对象
		JSONArray json = JSONArray.fromObject(chartArr);
		//控制台显示JSON
		System.out.println(json.toString());
		//返回到JSP
		PrintWriter writer = response.getWriter();
		writer.println(json);
		writer.flush();
		//关闭输出流
		writer.close();
	}
}

