<%@page import="com.servlet.HtmlPages"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>Room Category Parameter Details|Hospital Checklist</title>
     
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
    <script src="js/jquery-ui/jquery.ui.selectable.min.js" type="text/javascript"></script>
     <link href="css/themes/base/jquery.ui.selectable.css" rel="stylesheet" type="text/css" />
    <!-- jQuery dialog end here-->
    <script src="js/jquery-ui/jquery.ui.accordion.min.js" type="text/javascript"></script>
    <!--Fancy Button-->
    <script src="js/fancy-button/fancy-button.js" type="text/javascript"></script>
    <!--jQuery Date Picker-->
    <script src="js/jquery-ui/jquery.ui.datepicker.min.js" type="text/javascript"></script>
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
   width:300px; height:auto;margin:0px auto;
}
    </style>
    <script type="text/javascript">
    setupTinyMCE();</script>
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
      $('input[type="checkbox"]').fancybutton();
  });
  $(window).bind("pageshow", function(event) {
	    if (event.originalEvent.persisted) {
	        window.location.reload(); 
	    }
	});
  var rooms_category_id;
  $(document).ready(function(){ 
	  room_category_parameter_id=$.urlParam('room_category_parameter_id');
	  room_category_name=decodeURI($.urlParam('room_category_name'));
	  room_category_id=decodeURI($.urlParam('room_category_id'));
	  $('#room_category').val(room_category_id);
	  $('#room_category_name').append(room_category_name);
 	  if(room_category_parameter_id &&  room_category_parameter_id != 'undefined')
  	$.ajax({
  		  type: 'GET',
  		  url: 'get?table=room_category_parameter&query=id='+room_category_parameter_id,
  		  contentType: 'application/json; charset=utf-8',
  		  dataType: 'json',
  		  success: function(jsonData) {
  			Object.keys(jsonData[0]).forEach(function(k) {
  				if($('#'+k+'').is('input:checkbox')){
  					$('#'+k+'').attr("checked", true);
  					if(jsonData[0][k])
  	  					$('#'+k+'').parent().children("div").prop('class','fancy-checkbox on');
  				}else
  			 $('#'+k+'').val(jsonData[0][k]);
  			});
  			remove();
  		  },
  		  error: function() {
  		    alert('Error loading');
  		  }
  		  
  		});
 	  else
 		  $('#id').remove();
 	  
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
         <div id="errormessage" style="display:none;">
    <div class="message error" >
                                <h5>Error!</h5>
                                <p>
                                    This is an error message.
                                </p>
                            </div>
                            </div>
         <div class="box round first fullpage">
         <h2>Details</h2>  
         <div class="block ">
         <form id="form">
          <input name="id" id="id" type="hidden" format="int"/>
          <input name="room_category" id="room_category" type="hidden" format="int"/>
         <table class="form">
         <tbody>
          <tr>
         <td class="col1" >
         <label>Room Category Name :</label>
         </td>
         <td class="col2">
  		 <span id="room_category_name"></span>
         </td>
         </tr>
         <tr>
         <td class="col1" >
         <label>Room Parameter Name :</label>
         </td>
         <td class="col2">
  		<input name="name" id="name"/>
         </td>
         </tr>
          <tr>
         <td class="col1" >
         <label>Active :</label>
         </td>
         <td class="col2">
  		<input name="active" id="active" type="checkbox"/>
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
    $(document).ready(function(){ 
    			  $("button").click(function(){
    				  if($(this).attr('id')=='submitNS')
    				  submit();
    			  else if($(this).attr('id')=='cancel')
    				  window.history.back();
    			  else
    				  deleterecord();
    		  });
    });
    function submit(){
    		var formDataObj = {};
    		var jsonlistcounter=0;
    		var isValid = true;
    		 var dataObj = {};
    	  $('form').find("*").not("[type='submit']").not("[type='reset']").each(function(){
              if ($(this).is('select')) {
            	  if($(this).val()==''){
            		  $(this).addClass('error');
            	  isValid=false;
            	  }
            	  else
            		  $(this).removeClass('error');
            	  dataObj[$(this).attr("name")]= ($(this).attr('format')=='int')?$(this).val():"'"+$(this).val()+"'";
              } else if ($(this).is('input:checkbox')) {
            	  dataObj[$(this).attr("name")]= $(this).prop('checked');
              } else if ($(this).is('textarea')){
            	  dataObj[$(this).attr("name")]= ($(this).attr('format')=='int')?$(this).val():"'"+$(this).val()+"'";
              }else if ($(this).is('input:text') || $(this).is('input:radio')|| $(this).is('input:hidden')) {
            	  if($(this).val()==''){
            		  $(this).addClass('error');
            	  isValid=false;
            	  }
            	  else
            		  $(this).removeClass('error');
            	  dataObj[$(this).attr("name")]= ($(this).attr('format')=='int')?$(this).val():"'"+$(this).val()+"'";
              }
    	  });
    	  formDataObj[jsonlistcounter]=(JSON.stringify(dataObj));
    	  if (isValid == false)
    		  event.getPreventDefault();
    	  $.ajax({
    		  
    		  type: "POST",
    		  contentType: 'application/json; charset=utf-8',
    		  dataType: 'json',
    		  url: "post?table=room_category_parameter",
    		  data: JSON.stringify(formDataObj),
    		  success: function( data, textStatus, jQxhr ){
    			  successdailog("room_category_parameter.jsp");	
    			  
    			//  alert(data.msg);
                   // document.location="room_category_parameter.jsp";
                },
                error: function( data,jqXhr, textStatus, errorThrown ){
                	$('#errormessage p').text(data.responseText);
                 	$('#errormessage').css('display','block') ; 
                }
    		});
    	  
    }
    
    function deleterecord(){
	  $.ajax({
		  
		  type: "delete",
		  contentType: 'application/json; charset=utf-8',
		  dataType: 'json',
		  url: "post?table=room_category_parameter&id="+rooms_category_id,
		  success: function( data, textStatus, jQxhr ){
			  	alert(data.msg);
                document.location="room_category_parameter.jsp";
            },
            error: function( data,jqXhr, textStatus, errorThrown ){
            	$('#errormessage p').text(data.responseText);
             	$('#errormessage').css('display','block') ; 
            }
		});
	  
}
    
    </script>
</body>
</html>
