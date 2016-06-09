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
				  string=string+'<tr><td class="col1"><label >'+jsonData[i].childs[j].name+'</label></td><td class="col2"><input type="checkbox" id="'+jsonData[i].childs[j].id+'" name="'+jsonData[i].childs[j].id+'"/></td></tr>';
			  }
			  
			  string=string+'</table>'+
              '</form></div> </div>'
		        +'';
			  
			 
			  }
		 
		 
			  $("#checklist").append('<div class="grid_12">'+string+'</div>');
			  $('input[type="checkbox"]').fancybutton();
			  $("#checklist").append('<button class="btn btn-darkgrey" id="submitNS">Submit</button>');
			  
			  $("#submitNS").click(function(){submit();});
		  },
		  error: function() {
		    alert('Error loading PatientID=' + id);
		  }
	 });
	  	
	  	
}); 

function submit(){
		var formDataObj = {};
		var jsonlistcounter=0;
		var isValid = true;
	  $('form').find(":input").not("[type='submit']").not("[type='reset']").not("[type='hidden']").each(function(){
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
	  dataObj['nursingsupervisor']=users_id ;
	  dataObj['rooms']=rooms_id ;
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
                alert(data.msg);
            },
            error: function( jqXhr, textStatus, errorThrown ){
            	alert(textStatus);
            }
		});
	  
}




