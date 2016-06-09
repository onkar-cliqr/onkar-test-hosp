/**
 * 
 */
$(document).ready(function(){ 
	  $("#Login").click(function(){submit();});
});
function submit(){
		var formDataObj = {};
		var jsonlistcounter=0;
		var dataObj={};
		var isValid = true;
				if($('#name').val()==''){
        		  $('#name').addClass('error');
        		  isValid=false;
				}
				else
					$('#name').removeClass('error');
				if($('#pwd').val()==''){
					isValid=false;
	        		  $('#pwd').addClass('error');
					}
					else
						$('#pwd').removeClass('error');
	  if (isValid == true){
		  dataObj[$('#name').attr("name")]="'"+$('#name').val()+"'";
		  dataObj[$('#pwd').attr("name")]=$('#pwd').val();
		  formDataObj[0]=(JSON.stringify(dataObj));
	  $.ajax({
		  type: "POST",
		  contentType: 'application/json; charset=utf-8',
		  dataType: 'json',
		  url: 'post?table=users&action=get',
		  data: JSON.stringify(formDataObj),
		  success: function( data, textStatus, jQxhr ){
               if(data.err){
            	   $('#errormessage p').text(data.err);
            	$('#errormessage').css('display','block') ;  
               }else{
               	$('#errormessage').css('display','none') ;  
               	document.location=data.redirect;
               }
            },
            error: function( data,jqXhr, textStatus, errorThrown ){
            	 $('#errormessage p').text(data.responseText);
             	$('#errormessage').css('display','block') ; 
            }
		});
	  }
	  
}