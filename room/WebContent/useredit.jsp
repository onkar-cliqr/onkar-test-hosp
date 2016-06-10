<%@page import="com.servlet.HtmlPages"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>User Details|Hospital Checklist</title>
     
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
    <link href="css/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
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
String uri = request.getRequestURI();
String pageName = uri.substring(uri.lastIndexOf("/")+1);
if(((request.getParameter("user_id")).equals("undefined"))){
	if((Integer)request.getSession().getAttribute("roles_id")!=2){
		 request.getRequestDispatcher(pageName+"?user_id="+request.getSession().getAttribute("user_id")).forward(request, response);
	}else{
	validatetabs=true;
	 out.println(" <script type=\"text/javascript\">var removefields=false</script>");
	}
}else{
	validatetabs=false;
	 if(((Integer.parseInt(request.getParameter("user_id")))==(Integer)request.getSession().getAttribute("user_id"))){
		 out.println(" <script type=\"text/javascript\">var removefields=true</script>");
	 }else{
		 request.getRequestDispatcher(pageName+"?user_id="+request.getSession().getAttribute("user_id")).forward(request, response);
		 out.println(" <script type=\"text/javascript\">var removefields=false</script>");
	 }
}


sadfdsaf

if(validatetabs==true){
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
      $('input[type="checkbox"]').fancybutton();
  });
  
  function managerbind(id){
	  
	/*  var rolegroup;
	  Object.keys(managergroup).forEach(function (key) {
		  Object.keys(managergroup[key]).forEach(function (key1) {
		      if(key1==id){
		    	  $('#manager').empty();
		    	  rolegroup= managergroup[key][key1];
		      }
		  });
	  });
	  console.log(JSON.stringify(rolegroup));
	      Object.keys(rolegroup).forEach(function (key) {
	    	  $('#manager').append('<option value="'+rolegroup[key].id+'">'+rolegroup[key].name+'</option>');	
		});*/
		Object.keys(managergroup).forEach(function (key) {
			console.log(JSON.stringify(managergroup[key]));
		//Object.keys(managergroup[key]).forEach(function (key1) {
			//console.log(JSON.stringify(managergroup[key][key1]));
	    	  $('#manager').append('<option value="'+managergroup[key].id+'">'+managergroup[key].name+'</option>');	
		//});
		});
  }
  
  $(window).bind("pageshow", function(event) {
	    if (event.originalEvent.persisted) {
	        window.location.reload(); 
	    }
	});
  
  
  var user_id;
  var managergroup;
  $(document).ready(function(){ 
	  setDatePicker('dateofbirth');
	  //$('#dateofbirth').datepicker("option", "dateFormat", 'yy-M-dd');
 	   user_id=$.urlParam('user_id');
 		$.ajax({
 	  		  type: 'GET',
 	  		  url: 'get?table=roles',
 	  		  contentType: 'application/json; charset=utf-8',
 	  		  dataType: 'json',
 	  		  success: function(jsonData) {
 	  			jsonData.forEach(function(k) {
 	  			$('#role').append('<option value="'+k.id+'">'+k.name+'</option>');
 	  			$('#role').val(k.id);
 	  			});
 	  			remove();
 	 		
 	  		  },
 	  		  error: function() {
 	  		    alert('Error loading');
 	  		  }
 	  		  
 	  		});
 		$.ajax({
	  		  type: 'GET',
	  		  url: 'get?table=users&query=ismanager=true&columns=id,role,name',
	  		  contentType: 'application/json; charset=utf-8',
	  		  dataType: 'json',
	  		  success: function(jsonData) {
	  			/*jsonData.forEach(function(k) {
	  			$('#manager').append('<option value="'+k.id+'">'+k.name+'</option>');	
	  			});*/
	  			
	  			// managergroup=groupby(jsonData,'role');
	  			managergroup=jsonData;
	  			$('#role').val(2);
	  			managerbind(managergroup);
	  			remove();
	  		  },
	  		  error: function() {
	  		    alert('Error loading');
	  		  }
	  		});
 		
 		
 	  if(user_id &&  user_id != 'undefined')
  	$.ajax({
  		  type: 'GET',
  		  url: 'get?table=users&query=id='+user_id+'',
  		  contentType: 'application/json; charset=utf-8',
  		  dataType: 'json',
  		  success: function(jsonData) {
  			Object.keys(jsonData[0]).forEach(function(k) {
  				if(k=='dateofbirth'){
  					// $("#dateofbirth").val($.datepicker.formatDate('dd-M-yy', new Date(jsonData[0][k])));
  					$('#dateofbirth').datepicker('setDate', new Date(jsonData[0][k]));
  			}else if($('#'+k+'').is('input:checkbox')){
  					//$('#'+k+'').attr("checked", jsonData[0][k]);
  					$('#'+k+'').attr("checked", true);
  					if(jsonData[0][k])
  	  					$('#'+k+'').parent().children("div").prop('class','fancy-checkbox on');
  					
  				}else
  			 $('#'+k+'').val(jsonData[0][k]);
  			 if(k=='name')
  			$('#'+k+'').attr('disabled','true');
  			});
  			remove();
  			//managerbind($('#role').val());
  			
  			
  		  },
  		  error: function() {
  		    alert('Error loading');
  		  }
  		  
  		});
 	  else{
 		  $('#id').remove();
 		// $('input[for="pwd"]').prop('type','hidden');
 		
 	  }
 	  
 	  if(removefields==true){
 		  $('tr[id="roletr"]').remove();
 		 $('tr[id="managertr"]').remove();
 		 $('tr[id="ismanagertr"]').remove();
 		 $('tr[id="activetr"]').remove();
 	  }else{
 		$('tr[id="pwdtr"]').prop('style','visibility: hidden;');
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
         <div id="errormessage" style="display:none;">
    <div class="message error" >
                                <h5>Error!</h5>
                                <p>
                                    This is an error message.
                                </p>
                            </div>
                            </div>
         <div class="box round first fullpage">
         <h2>User Details</h2>  
         <div class="block ">
         <form id="form">
          <input name="id" id="id" type="hidden" format="int"/>
         <table class="form">
         <tbody>
          <tr>
         <td class="col1" >
         <label>User Name :</label>
         </td>
         <td class="col2">
  		<input name="name" id="name"/>
  		<span class="error">Note: User name should be unique</span>
         </td>
         </tr>
         <tr id="pwdtr" >
         <td class="col1" >
         <label>Password :</label>
         </td>
         <td class="col2">
  		<input name="pwd" id="pwd" type="password" value="Welcome" />
         </td>
         </tr>
         <tr>
         <td class="col1" >
         <label>First Name :</label>
         </td>
         <td class="col2">
  		<input name="first_name" id="first_name"/>
         </td>
         </tr>
         <tr>
         <td class="col1" >
         <label>Last Name :</label>
         </td>
         <td class="col2">
  		<input name="last_name" id="last_name"/>
         </td>
         </tr>
         <tr>
         <td class="col1" >
         <label>Email :</label>
         </td>
         <td class="col2">
  		<input name="email" id="email"/>
  		<span name="emailerror" id="emailerror" style="display:none;" class="error"></span>
         </td>
         </tr>
         <tr id="roletr">
         <td class="col1" >
         <label>Role :</label>
         </td>
         <td class="col2">
  		<select name="role" id="role" format="int">
  		</select>
         </td>
          </tr>
         <tr>
         <td class="col1" >
         <label>Date Of Birth :</label>
         </td>
         <td class="col2">
         <input name="dateofbirth" id="dateofbirth"/>
          <span name="dateofbirtherror" id="dateofbirtherror" style="display:none;" class="error"></span>
         </td>
         </tr>
          <tr>
         <td class="col1" >
         <label>Phone Number :</label>
         </td>
         <td class="col2">
         <input name="phonenumber" id="phonenumber"/>
         <span name="phonenumbererror" id="phonenumbererror" style="display:none;" class="error"></span>
         </td>
         </tr>
         <tr>
         <td class="col1" >
         <label>Address :</label>
         </td>
         <td class="col2">
  		<textarea name="address" id="address"></textarea>
         </td>
         </tr>
           <tr id="managertr">
         <td class="col1" >
         <label>Select Manager :</label>
         </td>
         <td class="col2" >
  		<select name="manager" id="manager" format="int">
  		</select>
         </td>
         </tr>
         <tr id="ismanagertr">
         <td class="col1" >
         <label>User is Manager? :</label>
         </td>
         <td class="col2">
  		<input name="ismanager" id="ismanager" type="checkbox"/>
         </td>
         </tr>
          <tr id="activetr">
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
    			  
    			  /*$("select").change(function(){
    				  if($(this).attr('id')=='role'){
    					  managerbind($(this).val());
    				  }
    			  });*/
    			  
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
              }else if ($(this).is('input:password')||$(this).is('input:text') || $(this).is('input:radio')|| $(this).is('input:hidden')) {
            	  if($(this).val()==''){
            		  $(this).addClass('error');
            	  isValid=false;
            	  }
            	  else
            		  $(this).removeClass('error');
            	  dataObj[$(this).attr("name")]= ($(this).attr('format')=='int')?$(this).val():"'"+$(this).val()+"'";
              }
    	  });
    	  
    	  if($('#dateofbirth').val()!=''){
    	  	var datefrom=$('#dateofbirth').datepicker('getDate');
    		var pastdate=new Date();
    		pastdate.setDate(pastdate.getDate() - (365 * 18));
    		if(datefrom>pastdate){
			isValid=false;
			$('#dateofbirtherror').text('Age should be greater than 18 years');
			$('#dateofbirtherror').attr('style','display:block;');
    		}else{
    			$('#dateofbirtherror').attr('style','display:none;');
    		}
    	  }
    	  
    	  if(!isValidEmailAddress( $('#email').val() )){
    		  $('#emailerror').text('Ex : example@example.com');
  			$('#emailerror').attr('style','display:block;');
  			isValid=false;
    	  }else{
    		  $('#emailerror').attr('style','display:none;');
    	  }
    	
    	//validate phone
    	  var phone = $('#phonenumber').val(),
    	      intRegex = /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/;
    	  if((phone.length < 10) || (!intRegex.test(phone)))
    	  {
    		  $('#phonenumbererror').text('Please Enter valid number with country code 910000000000');
    			$('#phonenumbererror').attr('style','display:block;');
    			isValid=false;
    	  }else{
    		  $('#phonenumbererror').attr('style','display:none;');
    	  }
    	  
    	  formDataObj[jsonlistcounter]=(JSON.stringify(dataObj));
    	  if (isValid == false)
    		  event.getPreventDefault();
    	  $.ajax({
    		  
    		  type: "POST",
    		  contentType: 'application/json; charset=utf-8',
    		  dataType: 'json',
    		  url: "post?table=users",
    		  data: JSON.stringify(formDataObj),
    		  success: function( data, textStatus, jQxhr ){
    			  	alert(data.msg);
    			  	 window.history.back();
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
		  url: "post?table=users&id="+user_id,
		  success: function( data, textStatus, jQxhr ){
			  successdailog("users.jsp");	
			//  alert(data.msg);
			  //  window.history.back();
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
