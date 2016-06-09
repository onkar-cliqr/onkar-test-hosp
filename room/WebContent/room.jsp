<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.servlet.HtmlPages"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>Rooms List|Hospital Checklist</title>
    <link rel="stylesheet" type="text/css" href="css/reset.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/text.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/grid.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/layout.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="screen" />
    <!--[if IE 6]><link rel="stylesheet" type="text/css" href="css/ie6.css" media="screen" /><![endif]-->
    <!--[if IE 7]><link rel="stylesheet" type="text/css" href="css/ie.css" media="screen" /><![endif]-->
    <link href="css/table/demo_page.css" rel="stylesheet" type="text/css" />
    <!--jQuery Date Picker-->
    <script src="js/jquery-ui/jquery.ui.datepicker.min.js" type="text/javascript"></script>
    <!-- BEGIN: load jquery -->
    <script src="js/jquery-1.6.4.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/jquery-ui/jquery.ui.core.min.js"></script>
    <script src="js/jquery-ui/jquery.ui.widget.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.accordion.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.core.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.slide.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.mouse.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.sortable.min.js" type="text/javascript"></script>
    <script src="js/table/jquery.dataTables.min.js" type="text/javascript"></script>
    <!-- END: load jquery -->
     <!--jQuery Date Picker-->
    <script src="js/jquery-ui/jquery.ui.datepicker.min.js" type="text/javascript"></script>
    <script src="js/setup.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
        	
                  $("#container").load("header/header.jsp");
                  $("#menu").load("menu/menu.jsp");
                  
              $(window).bind("pageshow", function(event) {
            	    if (event.originalEvent.persisted) {
            	        window.location.reload(); 
            	    }
            	});
            setupLeftMenu();

            
			setSidebarHeight();
		  	var d = new Date();
		  	var formateddate=$.date(d);
			$.ajax({
	    		  type: 'GET',
	    		  url: 'get?table=rooms &query=active=false or active =false or active =true',
	    		  contentType: 'application/json; charset=utf-8',
	    		  dataType: 'json',
	    		  success: function(jsonData) {
	    			  var string="";
	    			  for(var i=0;i<jsonData.length;i++){
	    				  if(i%2==0){
	    				  string=string+'<tr class="odd gradeX">';
	    				  }else{
	    					  string=string+'<tr class="even gradeC">';
	    				  }
	    				  string=string+ '<td class="col1">'+jsonData[i].id+'</td>'+
	    				  '<td class="col1"><a href="#" onclick="navigateToroomedit(\''+jsonData[i].id+'\')">'+jsonData[i].name+'</a></td>';
	    				  string=string+'<td class="col1">'+jsonData[i].active+'</td>';
	    				  string=string+'</tr>';
	    			  }
	    			  $("#example tbody").append(string);
	    			  $('.datatable').dataTable();
	    			  remove();
	    		  },
	    		  error: function() {
	    		    alert('Error loading PatientID=' + id);
	    		  }
	    	 });
			

        });
      
       
    </script>
</head>
<body>
<% 
response.setHeader( "Expires", "Sat, 6 May 1995 12:00:00 GMT" );

//set standard HTTP/1.1 no-cache headers
response.setHeader( "Cache-Control", "no-store, no-cache, must-revalidate" );

//set IE extended HTTP/1.1 no-cache headers
response.addHeader( "Cache-Control", "post-check=0, pre-check=0" );

//set standard HTTP/1.0 no-cache header
response.setHeader( "Pragma", "no-cache" );
if(request.getSession().getAttribute("fullname")==null){
	
	request.getRequestDispatcher(HtmlPages.loginlink).forward(request, response);
	return;
} 

boolean route=false,validatetabs=true;
if(validatetabs==true){
	String uri = request.getRequestURI();
	String pageName = uri.substring(uri.lastIndexOf("/")+1);
	System.out.println("pageName:"+pageName+","+(String)request.getSession().getAttribute("tabs"));
	if(!((String)request.getSession().getAttribute("tabs")).contains(pageName))
	route=true;
}

if(route){
	request.getRequestDispatcher(HtmlPages.dashboardlink).forward(request, response);
	return;
}%>
    <div class="container_12">
    <div id="container"></div>
        <div class="clear">
        </div>
        <div id="menu"></div>
        <div class="clear">
        </div>
         <div class="grid_10">
            <div class="box round first grid">
                <h2>
                    List of Room  <button onclick="navigateToroomedit()" class="btn btn-darkgrey" id="addnewroom">New Room</button></h2>
                   
                <div class="block">
                    <table class="data display datatable" id="example">
					<thead>
						<tr>
							<th>Room Id</th>
							<th>Room Name</th>
							<th>Active</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
                </div>
            </div>
        </div>
        <div class="clear">
        </div>
    </div>
    <div class="clear">
    </div>
    <div id="site_info">
        <p>
        </p>
    </div>
    <script type="text/javascript">
    	 $(function() {
    	
    });
    </script>
</body>
</html>
