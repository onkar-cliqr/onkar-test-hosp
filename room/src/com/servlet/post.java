package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import database.DBConnection;
import database.Transactions;

/**
 * Servlet implementation class post
 */
@WebServlet("/post")
public class post extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public post() {
		super();
		// TODO Auto-generated constructor stub
	}

	/*
	 * @Override protected void doDelete(HttpServletRequest request,
	 * HttpServletResponse response) throws ServletException, IOException { //
	 * TODO Auto-generated method stub String table =
	 * request.getParameter("table"); String id = request.getParameter("id");
	 * PrintWriter out = response.getWriter(); try {
	 * out.print("{\"msg\":\""+delete(table, id)+"\"}"); out.flush(); } catch
	 * (Exception e) { e.printStackTrace(); out.print(
	 * "{\"err\":\"Do no have permission\"}"); out.flush(); }
	 * 
	 * }
	 */

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@SuppressWarnings("static-access")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String table = request.getParameter("table");
		HttpSession se = request.getSession();
		Integer user_id = (Integer) se.getAttribute("user_id");
		String action = request.getParameter("action");
		if (action == null) {
			action = "";
		}
		String reqvalue = util.getBody(request);
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		if (table.equals("transaction") && action.equals("insert")) {
			try {
				JSONObject json = new JSONObject(reqvalue);
				System.out.println(json.toString());

				for (int i = 0; i < json.length(); i++) {
					String whereclause = "";
					JSONObject jobject = new JSONObject(json.getString("" + i));
					List<String> cols = new ArrayList<>();
					List<Object> values = new ArrayList<>();
					System.out.println(jobject.toString());

					jobject.put("hospital", se.getAttribute("hospital"));
					if (jobject.has("checked")) {
						for (int j = 0; j < jobject.names().length(); j++) {
							if (!jobject.names().getString(j).equals("checked")) {
								whereclause = whereclause + jobject.names().getString(j) + "="
										+ jobject.get(jobject.names().getString(j)) + " and ";
							}
							cols.add(jobject.names().getString(j));
							values.add((Object) jobject.get(jobject.names().getString(j)));
							System.out.println("key = " + jobject.names().getString(j) + " value = "
									+ jobject.get(jobject.names().getString(j)));
						}
						whereclause = whereclause.substring(0, whereclause.lastIndexOf(" and "));

						if ((Integer) se.getAttribute("roles_id") == 3) {
							cols.add("housekeepingsupervisor");
							update(table, (cols), (values), whereclause);
						} else if ((Integer) se.getAttribute("roles_id") == 1) {
							cols.add("nursingsupervisor");
							values.add(user_id);
							cols.add("housekeepingsupervisor");
							values.add(se.getAttribute("manager"));
							insert(table, (cols).toString().replaceAll("\\[|\\]", ""),
									(values).toString().replaceAll("\\[|\\]", ""), whereclause);
						}
					}
				}

				out.print("{\"msg\":\"successfully updated the details\"}");
				out.flush();
			} catch (Exception e) {
				e.printStackTrace();
				out.print("{\"err\":\"Please check the details\"}");
				out.flush();
			}
		} else if (table.equals("users") && action.equals("get")) {
			try {
				JSONObject json = new JSONObject(reqvalue);
				System.out.println(json.toString());

				String whereclause = "";
				JSONObject jobject = new JSONObject(json.getString("0"));
				List<String> cols = new ArrayList<>();
				List<Object> values = new ArrayList<>();
				// for(int j = 0; j<jobject.names().length(); j++){
				cols.add("name");
				cols.add("pwd");
				byte[] pwd = Base64.encodeBase64(jobject.getString("pwd").getBytes());
				values.add(jobject.getString("name"));
				values.add(new String(pwd));
				whereclause = whereclause + " name=" + jobject.getString("name") + " and pwd='" + new String(pwd)
						+ "' and active=true and ";
				// System.out.println( "key = " + jobject.names().getString(j) +
				// " value = " + jobject.get(jobject.names().getString(j)));
				// }
				System.out.println(new String(Base64.encodeBase64("Welcome".getBytes())));
				String ret = query(table, cols.toString().replaceAll("\\[|\\]", ""),
						values.toString().substring(1, values.toString().length() - 1),
						whereclause.substring(0, whereclause.lastIndexOf(" and ")));
				System.out.println("User Details: " + ret);
				JSONObject retjson = new JSONObject(ret);
				if (retjson.has("err")) {
					out.print(retjson.toString());
				} else {
					JSONObject login = new JSONObject(retjson.getString("login").replaceAll("\\[|\\]", ""));
					se.setAttribute("fullname", login.getString("last_name") + "," + login.getString("first_name"));
					se.setAttribute("user_id", login.getInt("id"));
					se.setAttribute("roles_id", login.getInt("role"));
					se.setAttribute("vendor", login.getInt("vendor"));
					se.setAttribute("manager", login.getInt("manager"));
					se.setAttribute("ismanager", login.getBoolean("ismanager"));
					se.setAttribute("hospital", login.getInt("hospital"));
					login.put("redirect", HtmlPages.dashboardlink);
					String hospitalquery = query("hospital", " name,logo ", "", "id=" + login.getInt("hospital"));
					JSONObject hostpitaljson = new JSONObject(
							new JSONObject(hospitalquery).getString("login").replaceAll("\\[|\\]", ""));
					se.setAttribute("hospitalname", hostpitaljson.getString("name"));
					se.setAttribute("hospitallogo", hostpitaljson.getString("logo"));
					out.print("{\"redirect\":\"" + HtmlPages.dashboardlink + "\"}");
				}
				out.flush();
			} catch (Exception e) {
				e.printStackTrace();
				out.print(e.getMessage());
				out.flush();
			}

		} else {
			try {
				JSONObject json = new JSONObject(reqvalue);
				System.out.println(json.toString());
				String whereclause = "";
				JSONObject jobject = new JSONObject(json.getString("0"));
				jobject.put("hospital", se.getAttribute("hospital"));
				// jobject.put("vendor", "1");
				List<String> cols = new ArrayList<>();
				List<Object> values = new ArrayList<>();
				System.out.println(jobject.toString());
				for (int j = 0; j < jobject.names().length(); j++) {
					if (jobject.names().getString(j).equals("id")) {
						whereclause = jobject.names().getString(j) + "=" + jobject.get(jobject.names().getString(j));
					} else {
						if (jobject.names().getString(j).equals("name")) {
							whereclause = jobject.names().getString(j) + "="
									+ jobject.get(jobject.names().getString(j));
						}
						if (jobject.names().getString(j).equals("pwd")) {
							String pwd = ((String) jobject.get(jobject.names().getString(j))).substring(1,
									((String) jobject.get(jobject.names().getString(j))).length() - 1);
							values.add("'" + new String(Base64.encodeBase64((pwd).getBytes())) + "'");
						} else
							values.add((Object) jobject.get(jobject.names().getString(j)));
					}
					cols.add(jobject.names().getString(j));
					System.out.println("key = " + jobject.names().getString(j) + " value = "
							+ jobject.get(jobject.names().getString(j)));
				}
				String returnmsg = "{\"msg\":\"successfully updated the details\"}";

				if ((Integer) se.getAttribute("roles_id") == 2
						|| (Integer) se.getAttribute("user_id") == jobject.getInt("id")) {
					if (cols.contains("id")) {
						cols.remove("id");
						update(table, (cols), (values), whereclause);
					} else {
						insert(table, (cols).toString().replaceAll("\\[|\\]", ""),
								(values).toString().replaceAll("\\[|\\]", ""), whereclause);
					}
				} else {
					returnmsg = "{\"msg\":\"Cannot update the details/No access\"}";
				}
				out.print(returnmsg);
				out.flush();
			} catch (Exception e) {
				e.printStackTrace();
				out.print(e.getMessage().contains("Detail:") ? e.getMessage().split("Detail:")[1] : e.getMessage());
				out.flush();
			}
		}
	}

	public void insert(String table, String cols, String values, String whereclause) throws Exception {
		DBConnection db = new DBConnection();
		try {
			Connection con = db.getDBConnection();
			System.out.println(cols);
			System.out.println(values);
			Statement st = con.createStatement();

			String sql = "insert into " + table + " (" + cols + ") values(" + values + ")";
			String sqlquery = "select count(*) from " + table + " where " + whereclause;
			System.out.println(sqlquery);
			PreparedStatement pt = con.prepareStatement(sqlquery);
			ResultSet rs = pt.executeQuery();
			rs.next();
			// if(rs.getInt(1)<=0){
			// System.out.println(sql);
			st.executeUpdate(sql);
			System.out.println("successful inserted");

			/*
			 * }else{ throw new Exception("Already exists"); }
			 */

		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}

	}

	public void update(String table, List<String> cols, List<Object> values, String whereclause) throws Exception {
		DBConnection db = new DBConnection();
		try {
			Connection con = db.getDBConnection();
			Statement st = con.createStatement();
			String updatesql = "";
			for (int i = 0; i < cols.size() - 1; i++) {
				updatesql = updatesql + cols.get(i) + "=" + values.get(i) + ",";
			}
			System.out.println(this.getClass().getName() + " updatesql in:" + updatesql);
			updatesql = updatesql.substring(0, updatesql.length() - 1);
			updatesql = updatesql.replaceAll("checked", "validated");
			String sql = "update  " + table + " set " + updatesql + " where " + whereclause;
			System.out.println(sql);
			st.executeUpdate(sql);
			System.out.println("successful updated");
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}

	}

	public String query(String table, String cols, String values, String whereclause) throws Exception {
		DBConnection db = new DBConnection();
		JSONObject retjson = new JSONObject();
		List<JSONObject> jsonList = new ArrayList<>();
		try {
			Connection con = db.getDBConnection();
			System.out.println(cols);
			System.out.println(values);
			String sqlquery = "select * from " + table + " where  " + whereclause;
			System.out.println(sqlquery);
			PreparedStatement pt = con.prepareStatement(sqlquery);
			ResultSet rs = pt.executeQuery();
			jsonList = Transactions.convertResultSetIntoJSON(rs);
			if (jsonList.size() > 0) {
				retjson.put("login", jsonList.toString());
			} else {
				throw new Exception("Username and Password invalid..");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
		return retjson.toString();

	}

	public String delete(String table, String id) throws Exception {
		DBConnection db = new DBConnection();
		try {
			Connection con = db.getDBConnection();
			String sqlquery = "update " + table + " set active=false where id=" + id;
			System.out.println(sqlquery);
			PreparedStatement pt = con.prepareStatement(sqlquery);
			pt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
		return "Successfull deleted";

	}

}
