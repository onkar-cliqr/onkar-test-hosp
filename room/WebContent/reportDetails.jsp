<%@page import="com.servlet.HtmlPages"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>Room Checklist|Hospital Checklist</title>
     
    <link rel="stylesheet" type="text/css" href="css/reset.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/text.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/grid.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/layout.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="screen" />
    <!--[if IE 6]><link rel="stylesheet" type="text/css" href="css/ie6.css" media="screen" /><![endif]-->
    <!--[if IE 7]><link rel="stylesheet" type="text/css" href="css/ie.css" media="screen" /><![endif]-->
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
    <script src="js/jquery-ui/jquery.ui.autocomplete.min.js" type="text/javascript"></script>
    <!-- END: load jquery -->
    <!--jQuery Date Picker-->
    <script src="js/jquery-ui/jquery.ui.datepicker.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.widget.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.progressbar.min.js" type="text/javascript"></script>
    <!-- jQuery dialog related-->
    <script src="js/jquery-ui/external/jquery.bgiframe-2.1.2.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.mouse.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.draggable.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.position.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.resizable.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.dialog.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.core.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.blind.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.explode.min.js" type="text/javascript"></script>
    <!-- jQuery dialog end here-->
    <script src="js/jquery-ui/jquery.ui.accordion.min.js" type="text/javascript"></script>
    <!--Fancy Button-->
    <script src="js/fancy-button/fancy-button.js" type="text/javascript"></script>
   
    <script src="js/setup.js" type="text/javascript"></script>
    <!-- Load TinyMCE -->
    <script src="js/tiny-mce/jquery.tinymce.js" type="text/javascript"></script>
    <!-- /TinyMCE -->
    <style type="text/css">
        #progress-bar
        {
            width: 400px;
        }
                div#child {
   width:400px; height:auto;margin:0px auto;
}
    </style>
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
        <script type="text/javascript">
  $(function(){
      $("#container").load("header/header.jsp");
      $("#menu").load("menu/menu.jsp");
      
  });
  $(window).bind("pageshow", function(event) {
	    if (event.originalEvent.persisted) {
	        window.location.reload(); 
	    }
	});
  
  </script>
   <div id="container"></div>
        <div class="clear">
        </div>
        <div id="menu"></div>
        <div class="clear">
        </div>

<div id="child" >
<button class="btn btn-darkgrey" id="cancel">Back</button>
<a  href="#" class="btn btn-darkgrey" style="color: #fff;" onClick="javascript:fnExcelReport('form');" id="test">Export Report to Excel</a>
</div>
<form id="form">
         <div class="grid_12">
         <div class="box round first fullpage">
         <h2>Details</h2>  
         <div class="block">
         <table class="form">
         <tbody>
         <tr>
         <td class="col1" >
         <label>Date :</label>
         </td>
         <td class="col1">
        <span  id="date"></span>
         </td>
         <td class="col1" >
         <label>Housekeeping User :</label>
         </td>
         <td class="col1">
        <span  id="housekeepinguser"></span>
         </td>
         <td class="col1" >
         <label>Housekeeping Manager :</label>
         </td>
         <td class="col1">
        <span  id="housekeepingmanager"></span>
         </td>
         </tr>
         <tr>
         <td class="col1" >
         <label>Roo Name :</label>
         </td>
         <td class="col1">
  		<span  id="room_name"></span>
         </td>
         <td class="col1" >
         <label>Nursing User :</label>
         </td>
         <td class="col1">
        <span  id="nursinguser"></span>
         </td>
         <td class="col1" >
         <label>Nursing Manager :</label>
         </td>
         <td class="col1">
        <span  id="nursingmanager"></span>
         </td>
         </tr>
        </tbody>
        </table>
        </div>
         </div>
            </div>
             <div class="clear">
        </div>
        <div id="checklist">
            </div>
            </form>
           <div id="child" >
<button class="btn btn-darkgrey" id="cancel">Back</button>
</div>
        <div class="clear">
        </div>
        <div class="clear">
    </div>
    <div id="site_info">
        <p>
        </p>
    </div>
        </div>
     <script type="text/javascript">
    var rooms=[];
    var users=[];
    var users_id;
    var rooms_id;
    var date;
    var exportjsonData
    $(document).ready(function(){ 
    	room_id=$.urlParam('room_id');
   	  room_name=decodeURI($.urlParam('room_name'));
   	  date=$.urlParam('date');
   		 $( "#room_name" ).append(room_name);
   		 $( "#date" ).append(date);
    	$.ajax({
    		  type: 'GET',
    		  url: 'get?table=GetReportDetails&room_id='+room_id+'&date='+date,
    		  contentType: 'application/json; charset=utf-8',
    		  dataType: 'json',
    		  success: function(jsonData) {
    			  exportjsonData=jsonData;
    			  housingsupervisor=jsonData[0].uh;
    			  nursingsupervisor=jsonData[0].un;
    			  
    			  $('#housekeepinguser').text(jsonData[0].uh);
    			  $('#housekeepingmanager').text(jsonData[0].uhm);
    			  $('#nursinguser').text(jsonData[0].un);
    			  $('#nursingmanager').text(jsonData[0].unm);
    			  
    			  var roomrows=groupby(jsonData,'rcn','uh','un');
    			  Object.keys(roomrows).forEach(function (key) {
    				  var string="";
      			      Object.keys(roomrows[key]).forEach(function (key1) {
      			    	
      			    	 
       				  string=string+'<div class="box round first fullpage"><h2>'+key1+'</h2>  <div class="block ">'
          	           +        '<form id="form">'
                        +'<table class="form"><tr>';
                        string=string+'<td class="col1"><label></label></td><td class="col2">Nursing Supervisor</td><td> House Keeping Supervisor</td></td></tr><tr>';
                        Object.keys(roomrows[key][key1]).forEach(function (key2) {
                        	console.log(roomrows[key][key1][key2]);
      			    	string=string+'<td class="col1" '+((roomrows[key][key1][key2].validated!=roomrows[key][key1][key2].checked)||(roomrows[key][key1][key2].validated==false)||(roomrows[key][key1][key2].checked==false)?'style="color: #FF0000;"':'')+'><label >'+roomrows[key][key1][key2].rcpn+'</label></td>'+
      			    	'<td class="col2">'+
      			    	roomrows[key][key1][key2].checked
      			    	//'<input disabled type="checkbox"  '+roomrows[key][key1][key2].checked+ '   '+(roomrows[key][key1][key2].checked==false?'':'checked')+'/>'+
      			    	'</td>';
      			    	string=string+'<td class="col2">'+
      			    	roomrows[key][key1][key2].validated
      			    	//'<input disabled type="checkbox"  '+roomrows[key][key1][key2].validated+ '   '+(roomrows[key][key1][key2].validated==false?'':'checked')+'/>'+
      			    	'</td>';
      				  string=string+'</tr>';
                        });
    	    			
      			    string=string+'</table>'+
                    '</form></div> </div>'
      		        +'';
                    
      			  $("#checklist").append('<div class="grid_12">'+string+'</div>');
      			    });
      			});
    			  remove();
    		  },
    		  error: function() {
    		    alert('Error loading PatientID=' + id);
    		  }
    	 });
    	  	
    	$("button").click(function(){
		   if($(this).attr('id')=='cancel')
			  window.history.back();
		   else if($(this).attr('id')=='generate')
				  JSONToCSVConvertor(exportjsonData, "Vehicle Report", true);
	  });	
    }); 

  
    </script>
</body>
</html>
