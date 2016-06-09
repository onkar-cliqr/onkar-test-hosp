<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.servlet.HtmlPages"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>Reports|Hospital Checklist</title>
    <link rel="stylesheet" type="text/css" href="css/reset.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/text.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/grid.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/layout.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="screen" />
    <!--[if IE 6]><link rel="stylesheet" type="text/css" href="css/ie6.css" media="screen" /><![endif]-->
    <!--[if IE 7]><link rel="stylesheet" type="text/css" href="css/ie.css" media="screen" /><![endif]-->
    <link href="css/table/demo_page.css" rel="stylesheet" type="text/css" />
    <link href="css/fancy-button/fancy-button.css" rel="stylesheet" type="text/css" />
    <!--Jquery UI CSS-->
    <link href="css/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
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
   
    <!--jQuery Date Picker End-->
    <script type="text/javascript" src="js/table/table.js"></script>
    <script src="js/setup.js" type="text/javascript"></script>
     <!-- END: load jquery -->
    <!--jQuery Date Picker Start-->
    <script src="js/jquery-ui/jquery.ui.datepicker.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
        	 setDatePicker('datefrom');
             setDatePicker('dateto');
                  $("#container").load("header/header.jsp");
                  $("#menu").load("menu/menu.jsp");
                  
              $(window).bind("pageshow", function(event) {
            	    if (event.originalEvent.persisted) {
            	        window.location.reload(); 
            	    }
            	});
            setupLeftMenu();
            setSidebarHeight();
           
           // var date = $('#myDatePicker').datepicker('getDate');
           var d = new Date();
     d.setMonth( d.getMonth( ) - 1 );
      $('#datefrom').datepicker('setDate', d);
      $('#dateto').datepicker('setDate', new Date());
          updateDateReport();

          
          $("button").click(function(){
		   if($(this).attr('id')=='generate')
			  JSONToCSVConvertor(exportjsonData, "Vehicle Report", true);
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
}
%>
    <div class="container_12">
    <div id="container"></div>
        <div class="clear">
        </div>
        <div id="menu"></div>
        <div class="clear">
        </div>
         <div class="grid_10">
         <div id="errormessage" style="display:none;">
    <div class="message error" >
                                <h5>Error!</h5>
                                <p>
                                    This is an error message.
                                </p>
                            </div>
                            </div>
            <div class="box round first grid">
                <h2>
                    Hospital Room Report 
                               
                            <button onclick="getReportsByDate()" class="btn btn-darkgrey" id="addnewuser">Display</button>
                              <label>Date From:</label><input type="text" id="datefrom" />
                              <label>Date To:</label><input type="text" id="dateto" />
                            </h2>
                 
                <div class="block">
                 <div id="reporttable">
                    
				</div>
				<a  href="#" class="btn btn-darkgrey" style="color: #fff;" onClick="javascript:fnExcelReport('');" id="test">Export Report to Excel</a>
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
    <style type="text/css">
      
.dataTables_wrapper{
width: 100%;
overflow: auto;
}

.sorting,.sorting_desc,.sorting_asc {padding: 8px 20px 0px;

}

tr.odd td, tr.even td {
    padding-left: 5px;
    border: 1px solid #e6e6e6;
}


    </style>
</body>
</html>
