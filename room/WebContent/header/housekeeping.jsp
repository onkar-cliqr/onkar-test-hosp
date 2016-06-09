<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="grid_12 header-repeat">
            <div id="branding">
                <div class="floatleft">
                    <img src="img/logo.png" alt="Logo" /></div>
                <div class="floatright">
                    <div class="floatleft">
                        <img src="img/img-profile.jpg" alt="Profile Pic" /></div>
                    <div class="floatleft marginleft10">
                        <ul class="inline-ul floatleft">
                            <li>Welcome <%=request.getSession().getAttribute("fullname") %> </li>
                            <li><a href="#">Config</a></li>
                            <li><a href="logout.jsp">Logout</a></li>
                        </ul>
                        <br />
                    </div>
                </div>
                <div class="clear">
                </div>
            </div>
        </div>