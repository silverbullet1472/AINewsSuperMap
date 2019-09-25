package com.yyw.dao;


import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.PreparedStatement;  
import java.sql.ResultSet;  
import java.sql.SQLException; 

import java.util.ArrayList;
import com.google.gson.Gson;
import com.yyw.bean.Chart;

public class JDBCOperation {

	public Connection getConn() {  
	      String driver = "org.postgresql.Driver";  
	      String url = "jdbc:postgresql://47.102.110.65:5432/tesla_station";
	      String username = "postgres";  
	      String password = "256618";  
	      Connection conn = null;  
	      try {  
	          Class.forName(driver);
	          conn = (Connection) DriverManager.getConnection(url, username, password);  
	      } catch (ClassNotFoundException e) {  
	          e.printStackTrace();  
	      } catch (SQLException e) {  
	          e.printStackTrace();  
	      }  
	      return conn;  
	  }  

	  public String getSuperStation(){  
	      Connection conn = getConn();  
	      //SQL��佫shp�ļ�תΪGeoJSON��ʽ
	      String sql = "SELECT row_to_json(fc) FROM ( SELECT 'FeatureCollection' As type,array_to_json(array_agg(f)) As features FROM (SELECT 'Feature' As type, ST_AsGeoJSON(lg.geom)::json As geometry ,row_to_json((gid,name, address,class,telephone,time,price,port,image)) As properties FROM stationinfo As lg WHERE class=2) As f )  As fc";
	      String geojson= null;
	      try {  
	    	  PreparedStatement pstmt;  
		      pstmt = (PreparedStatement)conn.prepareStatement(sql);   
	          ResultSet rs = pstmt.executeQuery(); 
	          while (rs.next()) {   
	        	  geojson=rs.getString(1);
	          }  
	         
	      } catch (SQLException e) {  
	          e.printStackTrace();  
	      }
	      return geojson;  
	  }  
	  public String getDestiStation(){  
	      Connection conn = getConn();  
	      String sql = "SELECT row_to_json(fc) FROM ( SELECT 'FeatureCollection' As type,array_to_json(array_agg(f)) As features FROM (SELECT 'Feature' As type, ST_AsGeoJSON(lg.geom)::json As geometry ,row_to_json((gid,name, address,class,telephone,time,price,port,image)) As properties FROM stationinfo As lg WHERE class=1) As f )  As fc";
	      String geojson= null;
	      try {  
	    	  PreparedStatement pstmt;  
		      pstmt = (PreparedStatement)conn.prepareStatement(sql);  
	          ResultSet rs = pstmt.executeQuery(); 
	          while (rs.next()) {   
	        	  geojson=rs.getString(1);
	          }  
	         
	      } catch (SQLException e) {  
	          e.printStackTrace();  
	      }
	      return geojson;  
	  }  
	  
	  public void UpdateData(String ID,String NAME,String ADDRESS,String PHONE,String TIME,String PRICE,String PORT){
		 
		  System.out.println(NAME);
		  Connection conn = getConn(); 
		  
		  PreparedStatement psta=null;
		  int id=Integer.parseInt(ID);
	      String sql ="UPDATE stationinfo SET name=?,address=?,telephone=?,time=?,price=?,port=? WHERE gid=?";
	      try{ 
	    	  conn.setAutoCommit(false); //�Զ��ύ
	          psta=(PreparedStatement)conn.prepareStatement(sql);  

	          psta.setString(1, NAME);
	          psta.setString(2, ADDRESS);
	          psta.setString(3, PHONE);
	          psta.setString(4, TIME);
	          psta.setString(5, PRICE);
	          psta.setString(6, PORT);
	          psta.setInt(7, id);        

	          psta.executeUpdate();
	          conn.commit();

	          System.out.println("���ݿ���³ɹ���");
	      }catch(Exception e){  
	          e.printStackTrace();  
	      }finally{
	    	  try  
	          {  
	              // ��һ������ļ�������رգ���Ϊ���رյĻ���Ӱ�����ܡ�����ռ����Դ  
	              // ע��رյ�˳�����ʹ�õ����ȹر�     
	    		  if (psta != null)  
	                  psta.close(); 
	              if (conn != null)  
	                  conn.close();  
	          }  
	          catch (Exception e)  
	          {  
	              e.printStackTrace();  
	          }  
	      }
	}
	  public void AddData(String NAME,String ADDRESS,String PHONE,String TIME,String PRICE,String PORT,int CLASS,Double LONGITUDE,Double LATITUDE){
			 
		  Connection conn = getConn();
		  
		  PreparedStatement psta=null;

	      String sql ="INSERT INTO stationinfo (name, address,telephone,time,price,port,class,lng,lat,geom) VALUES (?,?,?,?,?,?,?,?,?,'POINT("+LONGITUDE+" "+ LATITUDE+")')";

	      try{ 
	    	  conn.setAutoCommit(false); //�Զ��ύ
	          psta=(PreparedStatement)conn.prepareStatement(sql);  

	          psta.setString(1, NAME);
	          psta.setString(2, ADDRESS);
	          psta.setString(3, PHONE);
	          psta.setString(4, TIME);
	          psta.setString(5, PRICE);
	          psta.setString(6, PORT);
	          psta.setInt(7, CLASS);
	          psta.setDouble(8, LONGITUDE);
	          psta.setDouble(9, LATITUDE);
   

	          psta.executeUpdate();
	          conn.commit();

	          System.out.println("���ݿ���³ɹ���");
	      }catch(Exception e){  
	          e.printStackTrace();  
	      }finally{
	    	  try  
	          {  

	    		  if (psta != null)  
	                  psta.close(); 
	              if (conn != null)  
	                  conn.close();  

	          }  
	          catch (Exception e)  
	          {  
	              e.printStackTrace();  
	          }  
	      }
	}
	  
	  
	  
	  public void DeleteData(String ID){
			 
		  System.out.println(ID);
		  Connection conn = getConn(); 
		  
		  PreparedStatement psta=null;
		  int id=Integer.parseInt(ID);

	      String sql ="DELETE FROM stationinfo WHERE gid=?";

	      try{ 
	    	  conn.setAutoCommit(false); //�Զ��ύ
	          psta=(PreparedStatement)conn.prepareStatement(sql);  

	          psta.setInt(1, id);        

	          psta.executeUpdate();
	          conn.commit();

	          System.out.println("����ɾ���ɹ���");
	      }catch(Exception e){  
	          e.printStackTrace();  
	      }finally{
	    	  try  
	          {  
	              // ��һ������ļ�������رգ���Ϊ���رյĻ���Ӱ�����ܡ�����ռ����Դ  
	              // ע��رյ�˳�����ʹ�õ����ȹر�     
	    		  if (psta != null)  
	                  psta.close(); 
	              if (conn != null)  
	                  conn.close();  

	          }  
	          catch (Exception e)  
	          {  
	              e.printStackTrace();  
	          }  
	      }
	}
	  public String queryChartData() {
			ArrayList<Chart> chartArr = new ArrayList<Chart>();
			Connection conn = getConn();
			PreparedStatement psta=null;
			String sql ="select province,count(province) as summary, sum(case when class = 1 then 1 else '0' end) as destination, sum(case when class = 2 then 1 else '0' end) as super from stationinfo group by province";
			try {
				
				psta = (PreparedStatement)conn.prepareStatement(sql);  

				ResultSet rs = psta.executeQuery();


				while(rs.next()) {
					Chart chart = new Chart();
					chart.setProvince(rs.getString("province"));
					chart.setSuperNum(rs.getInt("super"));
					chart.setDestinationNum(rs.getInt("destination"));
					chart.setSummary(rs.getInt("summary"));
					System.out.println(rs.getString("province")+rs.getInt("summary")+","+rs.getInt("super")+","+rs.getInt("destination"));
				    chartArr.add(chart);
				}

				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			Gson gson =new Gson();
			String str=gson.toJson(chartArr);
			System.out.println(str);
			return str;
		    	
		    
		}
	
}

