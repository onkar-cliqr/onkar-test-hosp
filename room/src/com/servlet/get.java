package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.Transactions;

/**
 * Servlet implementation class get
 */
@WebServlet("/get")
public class get extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public get() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String table = request.getParameter("table");
		Transactions tr = new Transactions();
		HttpSession se = request.getSession();
		boolean role = ((Integer) se.getAttribute("roles_id") == 2);
		String ret = "";
		if (!table.startsWith("Get")) {
			String query = request.getParameter("query");

			String returnColumns = request.getParameter("columns");
			String replace = request.getParameter("replace");
			if (!role) {
				if (query == null || query.equals(""))
					query = " where active=true" + " and hospital=" + se.getAttribute("hospital") + " ";
				else
					query = " where " + query + " and active=true" + " and hospital=" + se.getAttribute("hospital")
							+ " ";
			} else {
				if (query != null && !query.equals(""))
					query = " where " + query + " and hospital=" + se.getAttribute("hospital") + " ";
				else
					query = " where " + " hospital=" + se.getAttribute("hospital") + " ";
				;
			}
			ret = tr.getRecords(table, query, returnColumns, replace).toString();
		} else if (table.equals("GetRoomCategory")) {
			ret = tr.getroomcategory(request);
		} else if (table.equals("Gettabpermission")) {
			ret = tr.tabpermission(request);
		} else if (table.startsWith("GetRooms")) {
			ret = tr.getRooms(request);
		} else if (table.startsWith("GetTabs")) {
			ret = tr.getTabs(request);
		} else if (table.startsWith("GetReports")) {
			System.out.println("GetReports");
			ret = tr.getReports(request);
		} else if (table.startsWith("GetReportDetails")) {
			System.out.println("GetReportDetails");
			ret = tr.getReportDetails(request);
		} else if (table.startsWith("GetMyReportees")) {
			System.out.println("GetMyReportees");
			ret = tr.getMyReportees(request);
		}
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		// Assuming your json object is **jsonObject**, perform the following,
		// it will return your json object
		System.out.println("Get call: " + ret);
		out.print(ret);
		out.flush();

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
