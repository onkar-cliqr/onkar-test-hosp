package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.sun.xml.internal.ws.api.addressing.WSEndpointReference.Metadata;

public class Transactions {

	public String getRecords(String table, String query, String returnColumns, String replace) {
		System.out.println(this.getClass().getName() + ",inside getRecords");
		List<JSONObject> jsonList = new ArrayList<>();
		DBConnection db = null;
		try {
			db = new DBConnection();
			Connection con = db.getDBConnection();
			String sql;
			if (returnColumns == null || returnColumns.equals("*") || returnColumns.toLowerCase().equals("all"))
				sql = "select * from " + table;
			else
				sql = "select " + returnColumns + " from " + table;
			sql = sql + query;

			PreparedStatement sqlquery = con.prepareStatement(sql);
			System.out.println(sqlquery);
			ResultSet rs = sqlquery.executeQuery();
			jsonList = convertResultSetIntoJSON(rs);
		} catch (Exception e) {
			e.printStackTrace();
			try {
				jsonList.add(new JSONObject().put("error", "could not get user details"));
			} catch (Exception ee) {
				ee.printStackTrace();
			}
		}
		String ret = jsonList.toString();
		if (replace != null) {
			String[] replaces = replace.split(",");
			System.out.println(replaces.length);

			for (int i = 0; i < replaces.length; i++) {
				System.out.println(!replaces[i].split("\\=")[0].equals("") && !replaces[i].split("\\=")[1].equals(""));
				if (!replaces[i].split("\\=")[0].equals("") && !replaces[i].split("\\=")[1].equals(""))
					ret = ret.replaceAll(replaces[i].split("\\=")[0], replaces[i].split("\\=")[1]);
			}
		}
		return ret;
	}

	public static List<JSONObject> convertResultSetIntoJSON(ResultSet resultSet) throws Exception {
		List<JSONObject> jsonArray = new ArrayList<>();
		while (resultSet.next()) {
			int total_rows = resultSet.getMetaData().getColumnCount();
			JSONObject obj = new JSONObject();
			for (int i = 0; i < total_rows; i++) {
				String columnName = resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase();
				Object columnValue = "";
				SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MMM-yyyy");
				if (resultSet.getMetaData().getColumnType(i + 1) == java.sql.Types.DATE) {
					columnValue = sdf1.format(resultSet.getObject(i + 1));
				} else {
					columnValue = resultSet.getObject(i + 1);
				}
				// if value in DB is null, then we set it to default value
				if (columnValue == null) {
					columnValue = "null";
				}

				if (columnName.equals("pwd")) {
					columnValue = new String(Base64.decodeBase64(((String) columnValue).getBytes()));
				}
				/*
				 * Next if block is a hack. In case when in db we have values
				 * like price and price1 there's a bug in jdbc - both this names
				 * are getting stored as price in ResulSet. Therefore when we
				 * store second column value, we overwrite original value of
				 * price. To avoid that, i simply add 1 to be consistent with
				 * DB.
				 */
				if (obj.has(columnName)) {
					columnName += "1";
				}
				obj.put(columnName, columnValue);
			}
			jsonArray.add(obj);
		}
		return jsonArray;
	}

	public String getroomcategory(HttpServletRequest request) {
		HttpSession se = request.getSession();
		List<JSONObject> retjsonList = new ArrayList<>();
		List<JSONObject> room_categoty = new ArrayList<>();
		DBConnection db = null;
		try {
			db = new DBConnection();
			Connection con = db.getDBConnection();
			String roomcategorysql, roomcategoryparametersql;
			roomcategorysql = "select id ,name from room_category where hospital=" + se.getAttribute("hospital")
					+ " and active=true";
			roomcategoryparametersql = "select name ,id  from room_category_parameter where hospital="
					+ se.getAttribute("hospital") + " and active=true and room_category=";
			PreparedStatement sqlquery = con.prepareStatement(roomcategorysql);
			ResultSet rs = sqlquery.executeQuery();
			room_categoty = convertResultSetIntoJSON(rs);
			List<String> keys = new ArrayList<>();
			for (int i = 0; i < room_categoty.size(); i++) {
				List<JSONObject> room_categoty_parameter = new ArrayList<>();
				JSONObject json = room_categoty.get(i);
				JSONObject jsonToPutLvl1 = new JSONObject();
				JSONArray jsonToPutLvl2 = new JSONArray();
				jsonToPutLvl1.put("id", json.getInt("id"));
				jsonToPutLvl1.put("name", json.getString("name"));
				sqlquery = con.prepareStatement(roomcategoryparametersql + json.getInt("id"));
				rs = sqlquery.executeQuery();
				room_categoty_parameter = convertResultSetIntoJSON(rs);
				for (int room_categoty_parameter_count = 0; room_categoty_parameter_count < room_categoty_parameter
						.size(); room_categoty_parameter_count++) {
					jsonToPutLvl2.put(new JSONObject()
							.put("id", room_categoty_parameter.get(room_categoty_parameter_count).getInt("id"))
							.put("name", room_categoty_parameter.get(room_categoty_parameter_count).getString("name")));
				}

				jsonToPutLvl1.put("childs", jsonToPutLvl2);
				retjsonList.add(jsonToPutLvl1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			try {
				retjsonList.add(new JSONObject().put("error", "could not get user details"));
			} catch (Exception ee) {
				ee.printStackTrace();
			}
		}
		return retjsonList.toString();
	}

	public String tabpermission(HttpServletRequest request) {

		DBConnection db = null;
		String tabs = "";
		try {
			HttpSession se = request.getSession();
			db = new DBConnection();
			Connection con = db.getDBConnection();
			String tabpermission_sql = "select * from tabs where id in (select tabs from tabpermission where active=true and roles="
					+ se.getAttribute("roles_id") + ")";
			System.out.println("tabpermission sql:" + tabpermission_sql);
			PreparedStatement sqlquery = con.prepareStatement(tabpermission_sql);
			ResultSet rs = sqlquery.executeQuery();
			List<JSONObject> tabslist = convertResultSetIntoJSON(rs);
			System.out.println(tabslist.toString());
			/*
			 * if((boolean)se.getAttribute("ismanager")==true){
			 * tabpermission_sql="select * from tabs where id="+14; sqlquery =
			 * con.prepareStatement(tabpermission_sql);
			 * rs=sqlquery.executeQuery(); List<JSONObject> spltabslist =
			 * convertResultSetIntoJSON(rs); tabslist.addAll(spltabslist); }
			 */

			tabs = tabslist.toString();// .replaceAll("\\[|\\]", "");
			se.setAttribute("tabs", tabs);
			System.out.println("tabs accessable: " + tabs);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return tabs;
	}

	public String getRooms(HttpServletRequest request) {
		DBConnection db = null;
		String tabs = "";
		try {
			HttpSession se = request.getSession();
			db = new DBConnection();
			Connection con = db.getDBConnection();
			String tabpermission_sql = "";
			if ((Integer) se.getAttribute("roles_id") != 3)
				tabpermission_sql = "select * from rooms where hospital=" + se.getAttribute("hospital")
						+ " and active=true  and id not in (select rooms from transaction where hospital="
						+ se.getAttribute("hospital") + " and datevalidated='" + request.getParameter("datevalidated")
						+ "')";
			else
				tabpermission_sql = "select * from rooms where hospital=" + se.getAttribute("hospital")
						+ " and active=true  and id in (select rooms from transaction where hospital="
						+ se.getAttribute("hospital") + " and datevalidated='" + request.getParameter("datevalidated")
						+ "' and housekeepingsupervisor=" + se.getAttribute("user_id") + " and validated IS NULL)";
			System.out.println("rooms sql:" + tabpermission_sql);
			PreparedStatement sqlquery = con.prepareStatement(tabpermission_sql);
			ResultSet rs = sqlquery.executeQuery();
			List<JSONObject> tabslist = convertResultSetIntoJSON(rs);
			System.out.println(tabslist.toString());
			tabs = tabslist.toString();// .replaceAll("\\[|\\]", "");
			System.out.println("rooms avaiable: " + tabs);
			tabs = tabs.replaceAll("name", "label");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tabs;
	}

	public String getTabs(HttpServletRequest request) {
		DBConnection db = null;
		String tabs = "";
		try {
			HttpSession se = request.getSession();
			db = new DBConnection();
			Connection con = db.getDBConnection();
			String tabpermission_sql = "";
			if ((Integer) se.getAttribute("roles_id") == 2) {
				tabpermission_sql = "select roles.id,roles.name as rolename from roles where active=true and roles.id!=2";
				System.out.println("rooms sql:" + tabpermission_sql);
				PreparedStatement sqlquery = con.prepareStatement(tabpermission_sql);
				ResultSet rs = sqlquery.executeQuery();
				List<JSONObject> tabslist = convertResultSetIntoJSON(rs);
				System.out.println(tabslist.toString());
				tabs = tabslist.toString();// .replaceAll("\\[|\\]", "");
				System.out.println("Tabs avaiable: " + tabs);
				tabs = tabs.replaceAll("name", "label");
			} else {
				throw new Exception("No Access");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tabs;
	}

	public String getReports(HttpServletRequest request) {
		HttpSession se = request.getSession();
		String dateFrom = request.getParameter("datefrom");
		String dateTo = request.getParameter("dateto");
		String myreportees = request.getParameter("myreportees");
		String myreporteeswhere = "";
		if (myreportees != null && !myreportees.equals("")) {
			myreporteeswhere = " and (nursingsupervisor=" + myreportees + " or housekeepingsupervisor=" + myreportees
					+ ") ";
		}
		List<JSONObject> reportlist = new ArrayList<>();
		DBConnection db = null;
		try {
			db = new DBConnection();
			Connection con = db.getDBConnection();
			/*
			  String sql="  select id,name,datevalidated,diff"+
			  " from (select rooms.id as id,rooms.name as name, dates.datevalidated as datevalidated From (SELECT generate_series(to_date('"
			  +dateFrom+"','dd/Mon/YYYY'),to_date('"+dateTo+
			  "','dd/Mon/YYYY') , '1d')::date as datevalidated) as dates,rooms) as roomswithdate"
			  +
			  " left join (select diff,datevalidated,name from (select * from (select * from ( select validated=checked as diff, datevalidated,rooms from transaction where (validated=true and checked=true) and  datevalidated between '"
			  +dateFrom+"' and '"+dateTo+
			  "' and datevalidated not in ( select datevalidated from transaction where checked=false and datevalidated between '"
			  +dateFrom+"' and '"+dateTo+
			  "' group by datevalidated,checked,rooms"+ " union"+
			  " select datevalidated from transaction where validated=false and datevalidated between '"
			  +dateFrom+"' and '"+dateTo+
			  "' group by datevalidated,validated,rooms"+
			  " ) group by datevalidated,validated,checked,rooms"+ " union"+
			  " select checked as diff,datevalidated,rooms from transaction where checked=false and datevalidated between '"
			  +dateFrom+"' and '"+dateTo+
			  "' group by datevalidated,checked,rooms"+ " union"+
			  " select validated as diff,datevalidated,rooms from transaction where validated=false and datevalidated between '"
			  +dateFrom+"' and '"+dateTo+
			  "' group by datevalidated,validated,rooms )as f) AS diffdates) AS roomsouts,rooms where rooms.id=roomsouts.rooms"
			  + " )as datediff using (name,datevalidated) order by name";
			 */
			/*String sql = "  select id,name,datevalidated,diff"
					+ " from (select rooms.id as id,rooms.name as name, dates.datevalidated as datevalidated From (SELECT generate_series(to_date('"
					+ dateFrom + "','dd/Mon/YYYY'),to_date('" + dateTo
					+ "','dd/Mon/YYYY') , '1d')::date as datevalidated) as dates,rooms) as roomswithdate"
					+ " left join (select diff,datevalidated,name from (select * from (select * from ( select validated=checked as diff, datevalidated,rooms from transaction where hospital="
					+ se.getAttribute("hospital")
					+ " and (validated=true and checked=true) and  datevalidated between '" + dateFrom + "' and '"
					+ dateTo + "' " + myreporteeswhere
					+ " and datevalidated not in ( select datevalidated from transaction where hospital="
					+ se.getAttribute("hospital") + " and checked=false " + myreporteeswhere
					+ " and datevalidated between '" + dateFrom + "' and '" + dateTo
					+ "' group by datevalidated,checked,rooms" + " union"
					+ " select datevalidated from transaction where hospital=" + se.getAttribute("hospital")
					+ " and validated=false " + myreporteeswhere + " and datevalidated between '" + dateFrom + "' and '"
					+ dateTo + "' group by datevalidated,validated,rooms"
					+ " ) group by datevalidated,validated,checked,rooms" + " union"
					+ " select checked as diff,datevalidated,rooms from transaction where hospital="
					+ se.getAttribute("hospital") + " and checked=false " + myreporteeswhere
					+ " and datevalidated between '" + dateFrom + "' and '" + dateTo
					+ "' group by datevalidated,checked,rooms" + " union"
					+ " select validated as diff,datevalidated,rooms from transaction where hospital="
					+ se.getAttribute("hospital") + " and validated=false " + myreporteeswhere
					+ " and datevalidated between '" + dateFrom + "' and '" + dateTo
					+ "' group by datevalidated,validated,rooms )as f) AS diffdates) AS roomsouts,rooms where rooms.id=roomsouts.rooms"
					+ " )as datediff using (name,datevalidated) order by name";
					*/
			String sql="select * from "+
    " (select rooms.id as roomsid,rooms.name as name, dates.datevalidated as datevalidated from"+ 
    " (SELECT generate_series(to_date('"
					+ dateFrom + "','dd/Mon/YYYY'),to_date('"
					+ dateTo + "','dd/Mon/YYYY') , '1d')::date"+ 
    " as datevalidated) as dates ,rooms) as roomswithdate"+
    " left join ("+
    " select * from ("+
    " select * , true as diff from ("+
    " select rooms as roomsid,datevalidated from transaction "+ myreporteeswhere.replace("and", "where")+
    " EXCEPT ("+
    " select rooms as roomsid,datevalidated  from"+
    " transaction "+
    " where hospital=1 and checked=false"+ myreporteeswhere+
    " and datevalidated between '"
					+ dateFrom + "' and '"
					+ dateTo + "'"+
    " group by roomsid,datevalidated"+
    " union"+
    " select rooms as roomsid,datevalidated  from"+
    " transaction"+ 
    " where hospital=1 and validated=false"+ myreporteeswhere+
    " and datevalidated between '"
					+ dateFrom + "' and '"
					+ dateTo + "'"+
    " group by roomsid,datevalidated))as dumpd"+
    " group by roomsid,datevalidated"+
    
" union"+
" select rooms as roomsid,datevalidated ,false as diff from"+
" transaction "+
" where hospital=1 and checked=false"+ myreporteeswhere+
" and datevalidated between '"
					+ dateFrom + "' and '"
					+ dateTo + "'"+
" group by roomsid,datevalidated"+
" union"+
" select rooms as roomsid,datevalidated,false as diff  from"+
" transaction "+
" where hospital=1 and validated=false"+ myreporteeswhere+
" and datevalidated between '"
					+ dateFrom + "' and '"
					+ dateTo + "'"+
" group by roomsid,datevalidated) as trueandfalse) as foo"+
" using (roomsid,datevalidated)";

			System.out.println(sql);
			PreparedStatement sqlquery = con.prepareStatement(sql);
			ResultSet rs = sqlquery.executeQuery();
			reportlist = convertResultSetIntoJSON(rs);
			// System.out.println(reportlist.toString());

			/*
			 * List<String> rooms=new ArrayList<>(); for(int
			 * reportcount=0;reportcount<reportlist.size();reportcount++){
			 * JSONObject report=reportlist.get(reportcount);
			 * if(!rooms.contains(report.get("name"))){ rooms.add(
			 * report.getString("name")); roomsfinallist.add(new
			 * JSONObject(report.get("name"))); } int
			 * roomindex=rooms.indexOf(report.getString("name"));
			 * roomsfinallist.get(roomindex).put("0",new
			 * JSONObject().put("datevalidated", report.get("datevalidated")));
			 * }
			 */

		} catch (Exception e) {
			e.printStackTrace();
		}

		return reportlist.toString();
	}

	public String getReportDetails(HttpServletRequest request) {
		HttpSession se = request.getSession();
		String date = request.getParameter("date");
		String room_id = request.getParameter("room_id");
		List<JSONObject> reportlist = new ArrayList<>();
		DBConnection db = null;
		try {
			db = new DBConnection();
			Connection con = db.getDBConnection();
			String sql = "select unm.name as unm,uhm,rcn, rcpn,uh,un,checked,validated from"
					+ " (select unid,uhm.name as uhm,rcn, rcpn,uh,un,checked,validated from "
					+ " (select uhid,unid,rc.name as rcn, rcpn,uh,un,checked,validated from "
					+ " (SELECT rcp.room_category as rcpid,tlist.id,un.manager as unid,uh.manager as uhid,uh.name as uh,rm.name as rn,rcp.name as rcpn,tlist.checked,tlist.validated,tlist.datevalidated,un.name as un FROM"
					+ " (select * from transaction where hospital=" + se.getAttribute("hospital") + " and rooms="
					+ room_id + " and datevalidated='" + date + "') as tlist"
					+ " JOIN users AS uh ON uh.id = tlist.housekeepingsupervisor"
					+ " JOIN users AS un ON un.id = tlist.nursingsupervisor"
					+ " JOIN room_category_parameter AS rcp ON rcp.id = tlist.room_category_parameter"
					+ " JOIN rooms AS rm ON rm.id = tlist.rooms) as tlgetrc"
					+ " JOIN room_category AS rc ON tlgetrc.rcpid = rc.id) as tlgetmn"
					+ " JOIN users AS uhm ON tlgetmn.uhid = uhm.id) as  tlgetunm"
					+ " JOIN users AS unm ON tlgetunm.unid = unm.id";
			System.out.println(sql);
			PreparedStatement sqlquery = con.prepareStatement(sql);
			ResultSet rs = sqlquery.executeQuery();
			reportlist = convertResultSetIntoJSON(rs);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return reportlist.toString();
	}

	public String getMyReportees(HttpServletRequest request) {
		String date = request.getParameter("date");
		String room_id = request.getParameter("room_id");
		List<JSONObject> reportlist = new ArrayList<>();
		HttpSession se = request.getSession();
		DBConnection db = null;
		try {
			db = new DBConnection();
			Connection con = db.getDBConnection();
			String sql = "select id,name from users where hospital=" + se.getAttribute("hospital") + " and  manager="
					+ se.getAttribute("user_id");
			if((Integer)se.getAttribute("roles_id")==2){
				sql = "select id,name from users where hospital=" + se.getAttribute("hospital") +" and id!="+se.getAttribute("user_id");
			}
			
			System.out.println(sql);
			PreparedStatement sqlquery = con.prepareStatement(sql);
			ResultSet rs = sqlquery.executeQuery();
			reportlist = convertResultSetIntoJSON(rs);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return reportlist.toString();
	}

}
