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
		//����DAO
        JDBCOperation op = new JDBCOperation();
		//�����ݿ���ȡ����
		String chartArr = op.queryChartData();

		//ArrayList����ת��ΪJSON����
		JSONArray json = JSONArray.fromObject(chartArr);
		//����̨��ʾJSON
		System.out.println(json.toString());
		//���ص�JSP
		PrintWriter writer = response.getWriter();
		writer.println(json);
		writer.flush();
		//�ر������
		writer.close();
	}
}

