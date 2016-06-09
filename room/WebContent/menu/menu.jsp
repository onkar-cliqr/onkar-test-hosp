<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <script type="text/javascript">
 $(document).ready(function(){ 
  $(function(){
      $.ajax({
		  type: 'GET',
		  url: 'get?table=Gettabpermission',
		  contentType: 'application/json; charset=utf-8',
		  dataType: 'json',
		  success: function(jsonData) {
			  var string="<ul class=\"nav main\">";
			  for(var i=0;i<jsonData.length;i++){
				  if(jsonData[i].istab==true){
				  string=string+'<li ><a href="'+jsonData[i].link+'"><span ';
				  if(jsonData[i].icon!=null)
					  string=string+'style="background:url(img/'+jsonData[i].icon+') no-repeat center left;"';
				 string=string+'>'+jsonData[i].name+'</span></a> </li>';
				  }
			  }
			  $("div#menus").append(string+"</ul>");
		  
		  },
		  error: function() {
		    alert('Error loading');
		  }
	 });
      
     var pagename=$(location).attr('pathname').substring($(location).attr('pathname').lastIndexOf('/') + 1);
     pagename=pagename.replace("_edit", "");
      //$('a[href="'+pagename+'"]').attr('style','background-color: rgb(16, 61, 95);');
      setInterval(function() {
		    $('a[href="'+pagename+'"]').attr('style','background-color: rgb(16, 61, 95);');
		}, 250);
      
  });
 

 });
  </script>
  <div class="grid_12">
  <div id="menus">
  </div>
        </div>
        
        <div id="site_info" style="position: fixed;bottom: 0;width: 100%;">
        <p>
        Desinged and developed by ThinkFours Solutions
        </p>
    </div>
    
    <div id="dialog-message" title="Important information" style="display:none;">
    <span class="ui-state-default"><span class="ui-icon ui-icon-info" style="float:left; margin:0 7px 0 0;"></span></span>
    <div style="margin-left: 23px;">
        <p>
            Successfully Updated </p>
        </div>
        </div>
        
  