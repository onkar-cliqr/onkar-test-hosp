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
    <script src="js/jquery-ui/jquery.ui.widget.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.datepicker.min.js" type="text/javascript"></script>
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
   width:200px; height:auto;margin:0px auto;
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
}%>
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
  $(document).ready(function(){ 
  	var d = new Date();
  	var formateddate=$.date(d);
  	 $('span#date').append(formateddate);
 	  $('input#date').val(formateddate);
 	  if($.urlParam('room_id')===null || $.urlParam('room_id')===""){
  	$.ajax({
  		  type: 'GET',
  		  url: 'get?table=GetRooms&datevalidated='+formateddate,
  		  contentType: 'application/json; charset=utf-8',
  		  dataType: 'json',
  		  success: function(jsonData) {
  			  for(var i=0;i<jsonData.length;i++){
  				  rooms.push(jsonData[i]);
                    }
  			  $( "#roomno" ).autocomplete({
  				    source: rooms,
  				  select: function(event, ui) {
  					  rooms_id = ui.item.id;
  					  $(this).removeClass('error');
  				}
  				  });
  			remove();
  		  },
  		  error: function() {
  		    alert('Error loading');
  		  }
  		  
  		});
  	 
  	  $( "#roomno" ).val('');
 	  }else{
 		 rooms_id=$.urlParam('room_id');
 		 $( "#roomno" ).val($.urlParam('room_name'));
 		 $( "#roomno" ).attr('disabled','true');
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
<button class="btn btn-darkgrey" id="submitNS">Submit</button>
<button class="btn btn-darkgrey" id="cancel">Back</button>
</div>
         <div class="grid_12">
         <div class="box round first fullpage">
         <h2>Details</h2>  
         <div class="block ">
         <form id="form">
         <table class="form">
         <tbody>
         <tr>
         <td class="col1" >
         <label>Date :</label>
         </td>
         <td class="col2">
        <span  id="date"></span>
  		<input name="date" id="date" type="hidden"/>
         </td>
         </tr>
         <tr>
         <td class="col1" >
         <label>Name :</label>
         </td>
         <td class="col2">
  		<input name="supervisor" id="supervisor" type="hidden" value="<%=request.getSession().getAttribute("user_id") %>"/>
  		<%=request.getSession().getAttribute("fullname") %>
         </td>
         </tr>
          <tr>
         <td class="col1" >
         <label>ROOM :</label>
         </td>
         <td class="col2">
  		<input name="roomno" id="roomno"/>
         </td>
         </tr>
         
          <tr>
         <td class="col1" >
         <label>Select All</label>
         </td>
         <td class="col2">
  			<input name="selectall" id="selectall" type="checkbox"/>
         </td>
         </tr>
         
        </tbody>
        </table>
        </form>
        </div>
         </div>
            </div>
             <div class="clear">
        </div>
        <div id="checklist">
           
           
            </div>
           <div id="child" >
<button class="btn btn-darkgrey" id="submitNS">Submit</button>
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
    $(document).ready(function(){ 
    	
    	$.ajax({
    		  type: 'GET',
    		  url: 'get?table=GetRoomCategory',
    		  contentType: 'application/json; charset=utf-8',
    		  dataType: 'json',
    		  success: function(jsonData) {
    			  var string="";
    			  for(var i=0;i<jsonData.length;i++){
    				  
    			  string=string+'<div class="box round first fullpage"><h2>'+jsonData[i].name+'</h2>  <div class="block ">'
    	           +        '<form id="form">'
                  +'<table class="form">';
    			  if(jsonData[i].childs.length>0)
    			  for(var j=0;j<jsonData[i].childs.length;j++){
    				  string=string+'<tr><td class="col1"><label>'+jsonData[i].childs[j].name+'</label></td><td class="col2"><input type="checkbox" id="'+jsonData[i].childs[j].id+'" name="'+jsonData[i].childs[j].id+'"/></td>';
    				  string=string+'</tr>';
    			  }
    			  
    			  string=string+'</table>'+
                  '</form></div> </div>'
    		        +'';
    			  
    			 
    			  }
    		 
    		 
    			  $("#checklist").append('<div class="grid_12">'+string+'</div>');
    			  $('#checklist input[type="checkbox"]').fancybutton();
    			  $("#checklist").append('');
    			  
    			  $("button").click(function(){
    				  if($(this).attr('id')=='submitNS')
    				  submit();
    			  else if($(this).attr('id')=='cancel')
    				  window.history.back();
    		  });
    			  remove();
    		  },
    		  error: function() {
    		    alert('Error loading PatientID=' + id);
    		  }
    	 });
    	
    	var chekeckvalue=true;
    	var chekeckon=' on';
    	$("#selectall").change(function(){
    		$('#checklist input[type="checkbox"]').each(function(){
    			$(this).attr("checked", chekeckvalue);
    			$(this).parent().children("div").prop('class','fancy-checkbox'+chekeckon);
    		});
    		if(chekeckvalue){
    			chekeckvalue=false;
    			chekeckon='';
    		}else{
    			chekeckvalue=true;
    			chekeckon=' on';
    		}
    	});
    	  	
    }); 

    function submit(){
    		var formDataObj = {};
    		var jsonlistcounter=0;
    		var isValid = true;
    	  $('form').find(":input").not("[type='submit']").not("[type='reset']").not("[type='hidden']").not("#selectall").each(function(){
    		  var dataObj = {};
              if ($(this).is('select')) {
            	  if($(this).val()==''){
            		  $(this).addClass('error');
            	  isValid=false;
            	  }
            	  else
            		  $(this).removeClass('error');
            	  dataObj[$(this).attr("name")]= $(this).val();
              } else if ($(this).is('input:checkbox')) {
            	  dataObj['room_category_parameter']= $(this).attr("name");
            	  dataObj['checked']= $(this).prop('checked');
              } else {
            	  if($(this).val()==''){
            		  $(this).addClass('error');
            	  isValid=false;
            	  }
            	  else
            		  $(this).removeClass('error');
              }
    	  dataObj['datevalidated']="'"+$('input#date').val()+"'" ;
    	  dataObj['rooms']=rooms_id;
    	  formDataObj[jsonlistcounter]=(JSON.stringify(dataObj));
    	  jsonlistcounter=jsonlistcounter+1;
    	  });
    	 
    	  if (isValid == false)
    		  event.getPreventDefault();
    	  $.ajax({
    		  
    		  type: "POST",
    		  contentType: 'application/json; charset=utf-8',
    		  dataType: 'json',
    		  url: "post?table=transaction&action=insert",
    		  data: JSON.stringify(formDataObj),
    		  success: function( data, textStatus, jQxhr ){
    			  successdailog("dashboard.jsp");
                    //document.location="dashboard.jsp";
                },
                error: function( jqXhr, textStatus, errorThrown ){
                	alert(textStatus);
                }
    		});
    	  
    }
    
   
    
    </script>
</body>
</html>
