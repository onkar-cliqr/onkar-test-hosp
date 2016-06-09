var user_id;
var user_name;
var room_id;
var room_name;
var mismatchcolor='#FF7E00';
var matchcolor='yellowgreen';
var nacolor='#D3D3D3';


function fnExcelReport(id) {
	
	if(id==""){
		id='example';
	$('#example th').each(function(){$(this).attr('style','background:#8f8f8f;')});
	}
	
	
    var tab_text = '<html xmlns:x="urn:schemas-microsoft-com:office:excel">';
    tab_text = tab_text + '<head><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>';

    tab_text = tab_text + '<x:Name>Report '+new Date()+'</x:Name>';

    tab_text = tab_text + '<x:WorksheetOptions><x:Panes></x:Panes></x:WorksheetOptions></x:ExcelWorksheet>';
    tab_text = tab_text + '</x:ExcelWorksheets></x:ExcelWorkbook></xml></head><body>';

    tab_text = tab_text + "<table border='1px'>";
    tab_text = tab_text + $('#'+id).html();
    tab_text = tab_text + '</table></body></html>';
    
    //alert($('#example').html());

    var data_type = 'data:application/vnd.ms-excel';
    
    var ua = window.navigator.userAgent;
    var msie = ua.indexOf("MSIE ");
    
    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) {
        if (window.navigator.msSaveBlob) {
            var blob = new Blob([tab_text], {
                type: "application/csv;charset=utf-8;"
            });
            navigator.msSaveBlob(blob, 'Report'+new Date()+'.xls');
        }
    } else {
        $('#test').attr('href', data_type + ', ' + encodeURIComponent(tab_text));
        $('#test').attr('download', 'Report '+new Date()+'.xls');
    }
    if(id=="example"){
		id='example';
	$('#example th').each(function(){$(this).attr('style','')});
	}
    //location.reload();

}


function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
    //If JSONData is not an object then JSON.parse will parse the JSON string in an Object
    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
    
    var CSV = '';    
    //Set Report title in first row or line
    
    CSV += ReportTitle + '\r\n\n';

    //This condition will generate the Label/Header
    if (ShowLabel) {
        var row = "";
        
        //This loop will extract the label from 1st index of on array
        for (var index in arrData[0]) {
            
            //Now convert each value to string and comma-seprated
            row += index + ',';
        }

        row = row.slice(0, -1);
        
        //append Label row with line break
        CSV += row + '\r\n';
    }
    
    //1st loop is to extract each row
    for (var i = 0; i < arrData.length; i++) {
        var row = "";
        
        //2nd loop will extract each column and convert it in string comma-seprated
        for (var index in arrData[i]) {
            row += '"' + arrData[i][index] + '",';
        }

        row.slice(0, row.length - 1);
        
        //add a line break after each row
        CSV += row + '\r\n';
    }

    if (CSV == '') {        
        alert("Invalid data");
        return;
    }   
    
    //Generate a file name
    var fileName = "MyReport_";
    //this will remove the blank-spaces from the title and replace it with an underscore
    fileName += ReportTitle.replace(/ /g,"_");   
    
    //Initialize file format you want csv or xls
    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
    
    // Now the little tricky part.
    // you can use either>> window.open(uri);
    // but this will not work in some browsers
    // or you will not get the correct file extension    
    
    //this trick will generate a temp <a /> tag
    var link = document.createElement("a");    
    link.href = uri;
    
    //set the visibility hidden so it will not effect on your web-layout
    link.style = "visibility:hidden";
    link.download = fileName + ".csv";
    
    //this part will append the anchor tag and remove it after automatic click
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

function remove(){
$("[tag='false']").each(function(){
	$(this).remove();
});
}

function getDetailedReport(room_id,date,room_name){
	document.location="reportDetails.jsp?room_id="+room_id+"&date="+date+"&room_name="+room_name;
}

function navigateToSupervisor(room_id,room_name){
	document.location="supervisor.jsp?room_id="+room_id+"&room_name="+room_name;
}

function navigateTorooms_category_parameter_edit(room_category_parameter_id){
	document.location="room_category_parameter_edit.jsp?room_category_parameter_id="+room_category_parameter_id+"&room_category_id="+$('#room_category').val()+"&room_category_name="+$('#room_category').find('option:selected').text();
}

function getReportsByDate(room_category_parameter_id){
	var datefrom=$.date($('#datefrom').datepicker('getDate'));
  	var dateto=$.date($('#dateto').datepicker('getDate'));
	var currentdate=$.date(new Date());
	if(Date.parse(dateto)>Date.parse(currentdate)){
		$('#errormessage p').text('To Date should be less than or equal to '+currentdate);
	 	$('#errormessage').css('display','block') ; 
	}else{
		updateDateReport();
	}
	
}

function groupby(jsonData,column,dc1,dc2,dc3,dc4){
	var rooms = {};

	  $.each(jsonData, function(i, item) {
	      var level = item[column];
	      	if(dc1){
	      		delete item[dc1];
	      	}
	      	if(dc2){
	      		delete item[dc2];
	      	}
	      	if(dc3){
	      		delete item[dc3];
	      	}
	      	if(dc4){
	      		delete item[dc4];
	      	}
	      	
	      if(rooms[level]) {
	    	  rooms[level].push(item);
	      } else {
	    	  rooms[level] = [item];
	      }
	  });

	  var roomrows = $.map(rooms, function(group, key) {
	      var obj = {};
	      obj[key] = group;

	      return obj;
	  });
	  return roomrows;
}

function deletecolumn(jsonData,column){
	 $.each(jsonData, function(i, item) {
	      delete item[column];
	  });
	 return jsonData;
}

var exportjsonData;

function updateDateReport(){
	if($('#reporttable')){
		$('#reporttable').empty();
		$('#reporttable').append('<table class="data display datatable" id="example">'+
		'<thead>'+
		'</thead>'+
		'<tbody>'+
		'</tbody>'+
	'</table>');
		//$('#example tbody').empty();
	}
	 
     // var datefrom=$.datepicker.formatDate('mm/dd/yy',($('#datefrom').datepicker('getDate')));
    //  var dateto=$.datepicker.formatDate('mm/dd/yy',$('#dateto').datepicker('getDate'));
	
	var reportee="";
	var indicators="";
	if($('#myreportees').length>0){
		reportee="&myreportees="+$('#myreportees').val();
		reporteename=$('#myreportees option:selected').text();
		indicators='<table>'+
		  '<tbody>'+
		  '<tr>'+
		  '<td style="background-color: '+mismatchcolor+';width:10px;height:auto;"></td>'+
		  '<td>Miss match in validation done by '+reporteename+'</td>'+
		  '<td style="background-color: '+nacolor+';width:10px;height:auto;"></td>'+
		  '<td>No Records found for '+reporteename+'</td>'+
		  '<td style="background-color: '+matchcolor+';width:10px;height:auto;"></td>'+
		  '<td>Checklist Match by '+reporteename+'</td>'+
		  '</tr>'+
			'</tbody></table>';
	}else{
		indicators='<table>'+
		  '<tbody>'+
		  '<tr>'+
		  '<td style="background-color: '+mismatchcolor+';width:10px;height:auto;"></td>'+
		  '<td>Miss Match in Nursing and Housekeeping Checklist</td>'+
		  '<td style="background-color: '+nacolor+';width:10px;height:auto;"></td>'+
		  '<td>Not validated by Nursing and Housekeeping</td>'+
		  '<td style="background-color: '+matchcolor+';width:10px;height:auto;"></td>'+
		  '<td>Nursing and Housekeeping Checklist match</td>'+
		  '</tr>'+
			'</tbody></table>';
	}
		
	  //	var d = new Date();
	  	var datefrom=$.date($('#datefrom').datepicker('getDate'));
	  	var dateto=$.date($('#dateto').datepicker('getDate'));
		$.ajax({
  		  type: 'GET',
  		  url: "get?table=GetReports&datefrom="+datefrom+"&dateto="+dateto+reportee,
  		  contentType: 'application/json; charset=utf-8',
  		  dataType: 'json',
  		  success: function(jsonData) {
  			  
  			
  			var roomrows=groupby(jsonData,'name');
  			exportjsonData=roomrows;
  			//console.log(JSON.stringify(exportjsonData));
  			  Object.keys(roomrows).forEach(function (key) {
  			      //console.log( key , roomrows[key] );
  			      Object.keys(roomrows[key]).forEach(function (key1) {
	    			      //console.log( key1 , roomrows[key][key1] );
	    			      Object.keys(roomrows[key][key1]).forEach(function (key2) {
		    			      //console.log( key2 , roomrows[key][key1][key2].diff );
		    			});
	    			});
  			});
  			  
  			  
  			  var dates = {};

  			  $.each(jsonData, function(i, item) {
  			      var level = item.datevalidated;

  			      delete item.datevalidated;

  			      if(dates[level]) {
  			    	  dates[level].push(item);
  			      } else {
  			    	  dates[level] = [item];
  			      }
  			  });

  			  var datecolumns = $.map(dates, function(group, key) {
  			      var obj = {};
  			      obj[key] = group;

  			      return obj;
  			  });
  			  
  			  var columns=datecolumns.length;
  			var columnsvalues="";
  			columnsvalues=columnsvalues+'<th>Room Name</th>';
  			  Object.keys(datecolumns).forEach(function (key) {
  				  
  			      Object.keys(datecolumns[key]).forEach(function (key1) {
  			    	columnsvalues=columnsvalues+'<th>'+key1+'</th>';
	    			   
	    			});
  			    
  			});
  			$("#example thead").append('<tr>'+columnsvalues+'</tr>');
  			  
  			  Object.keys(roomrows).forEach(function (key) {
  			      Object.keys(roomrows[key]).forEach(function (key1) {
	    			      var string='<tr><td>'+key1+'</td>';
	    			     // $("#example tbody").append('<tr><td>'+key1+'</td><td>'+key1+'</td><td>'+key1+'</td><td>'+key1+'</td></tr>');
	    			     
	    			      for(var i=0;i<columns;i++){
	    			    	  string=string+'<td></td>';  
	    			      }
	    			      string=string+'</tr>';
	    			      $("#example tbody").append(string);
	    			});
  			});
  			  
  			 
  			  
  			  
  			  /*var col=$('#example thead tr th').filter(function(index) { return $(this).text() === "Room Name"; });
  			  var colindex=$(col).parent().children().index($(col));
  			  
  			  var row=$('#example tbody tr td').filter(function(index) { return $(this).text() === "ROOM_1"; });
  			  
  			  var rowindex=$(row).parent().parent().children().index($(row).parent());
  			  
  			  alert($('#example tr:eq('+rowindex+') > td:eq('+colindex+')').text());
  			  
  			  alert(JSON.stringify(datecolumns));*/
  			  
  			  Object.keys(datecolumns).forEach(function (key) {
  			      ////console.log( key , datecolumns[key] );
  			      Object.keys(datecolumns[key]).forEach(function (key1) {
	    			     // //console.log( key1 , datecolumns[key][key1] );
	    			      Object.keys(datecolumns[key][key1]).forEach(function (key2) {
	    			    	//  //console.log( key2 , datecolumns[key][key1][key2].diff );
	    			    		 // console.log( key2 , datecolumns[key][key1][key2] );
		    			      var col=$('#example thead tr th').filter(function(index) { return $(this).text() === key1; });
			    			  //alert($(col).text());
			    			  var colindex=$(col).parent().children().index($(col));
			    			  
			    			  var row=$('#example tbody tr td').filter(function(index) { return $(this).text() === datecolumns[key][key1][key2].name; });
			    			  //alert($(col).text());
			    			var rowindex=$(row).parent().parent().children().index($(row).parent());
			    			//console.log('datecolumns[key][key1][key2].id:'+datecolumns[key][key1][key2].id)
			    			
			    			
			    			  //alert('rowvalue:'+datecolumns[key][key1][key2].name+',rowindex:'+rowindex+',colvalue:'+key1+',colindex:'+colindex);
			    			  $('#example tr:eq('+(rowindex+1)+') > td:eq('+(colindex)+')').append(datecolumns[key][key1][key2].diff!="null"?(datecolumns[key][key1][key2].diff?'<a href= "#" onclick=getDetailedReport("'+datecolumns[key][key1][key2].roomsid+'","'+key1+'","'+datecolumns[key][key1][key2].name+'")>Matched</a>':'<a href= "#" onclick=getDetailedReport("'+datecolumns[key][key1][key2].roomsid+'","'+key1+'","'+datecolumns[key][key1][key2].name+'")>Mismatch</a>'):'NA');
			    			  if($('#example tr:eq('+(rowindex+1)+') > td:eq('+(colindex)+')').text()=='Matched'){
			    				  $('#example tr:eq('+(rowindex+1)+') > td:eq('+(colindex)+')').attr( 'style',"background-color: "+matchcolor+";");
			    				//  $('#example tr:eq('+(rowindex+1)+') > td:eq('+(colindex)+')').attr('onclick','getDetailedReport("'+datecolumns[key][key1][key2].id+'","'+key1+'")');
			    			  }else  if($('#example tr:eq('+(rowindex+1)+') > td:eq('+(colindex)+')').text()=='Mismatch'){
			    				  $('#example tr:eq('+(rowindex+1)+') > td:eq('+(colindex)+')').attr( 'style',"background-color: "+mismatchcolor+";"); 
			    				//  $('#example tr:eq('+(rowindex+1)+') > td:eq('+(colindex)+')').attr('onclick','getDetailedReport("'+datecolumns[key][key1][key2].id+'","'+key1+'")');
			    			  }else{
			    				  $('#example tr:eq('+(rowindex+1)+') > td:eq('+(colindex)+')').attr( 'style',"background-color: "+nacolor+";");
			    			  }
		    			});
	    			});
  			});
  			  
  			  
  			$('.datatable').dataTable({
  		        dom: 'Bfrtip',
  		        buttons: [
  		            'copy', 'csv', 'excel', 'pdf', 'print'
  		        ]
  		    });
  			
  			  $('#example_length').append(indicators);
  			
  			  
  		  },
  		  error: function() {
  		    alert('Error loading PatientID=' + id);
  		  }
  	 });
		
}


function navigateTousersedit(user_id){
	document.location="useredit.jsp?user_id="+user_id;
}

function navigateToroomedit(room_id){
	document.location="roomedit.jsp?room_id="+room_id;
}

function navigateTorooms_category_edit(rooms_category_id){
	document.location="room_category_edit.jsp?rooms_category_id="+rooms_category_id;
}

$.urlParam = function(name){
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
    if (results==null){
       return null;
    }
    else{
       return results[1] || 0;
    }
}

//custom dailog

function successdailog(screnlink){
	$("#dialog-message").dialog({
  	    modal: true,
  	    draggable: false,
  	    resizable: false,
  	    position: ['center', 'top'],
  	    show: 'blind',
  	    hide: 'blind',
  	    width: 400,
  	    dialogClass: 'ui-dialog',
  	    buttons: {
  	        "Back": function() {
  	            $(this).dialog("close");
  	          document.location=screnlink;
  	        }
  	    }
  	});
	
}

$.date = function(dateObject) {
	   /* var d = new Date(dateObject);
	    var day = d.getDate();
	    var month = d.getMonth() + 1;
	    var year = d.getFullYear();
	    if (day < 10) {
	        day = "0" + day;
	    }
	    if (month < 10) {
	        month = "0" + month;
	    }
	    var date = month + "/" + day + "/" + year;
*/
	//$.format.date(dateObject, 'dd M yy');
	
	    return $.datepicker.formatDate('dd-M-yy', dateObject);
	};

function setSidebarHeight(){
	setTimeout(function(){
var height = $(document).height();
    $('.grid_12').each(function () {
        height -= $(this).outerHeight();
    });
    height -= $('#site_info').outerHeight();
	height-=1;
	//salert(height);
    $('.sidemenu').css('height', height);					   
						},100);
}

//Dashboard chart
function setupDashboardChart(containerElementId) {
    var s1 = [200, 300, 400, 500, 600, 700, 800, 900, 1000];
    var s2 = [190, 290, 390, 490, 590, 690, 790, 890, 990];
    var s3 = [250, 350, 450, 550, 650, 750, 850, 950, 1050];
    var s4 = [2000, 1600, 1400, 1100, 900, 800, 1550, 1950, 1050];
    // Can specify a custom tick Array.
    // Ticks should match up one for each y value (category) in the series.
    var ticks = ['March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November'];

    var plot1 = $.jqplot(containerElementId, [s1, s2, s3, s4], {
        // The "seriesDefaults" option is an options object that will
        // be applied to all series in the chart.
        seriesDefaults: {
            renderer: $.jqplot.BarRenderer,
            rendererOptions: { fillToZero: true }
        },
        // Custom labels for the series are specified with the "label"
        // option on the series option.  Here a series option object
        // is specified for each series.
        series: [
            { label: 'Apples' },
            { label: 'Oranges' },
            { label: 'Mangoes' },
            { label: 'Grapes' }
        ],
        // Show the legend and put it outside the grid, but inside the
        // plot container, shrinking the grid to accomodate the legend.
        // A value of "outside" would not shrink the grid and allow
        // the legend to overflow the container.
        legend: {
            show: true,
            placement: 'outsideGrid'
        },
        axes: {
            // Use a category axis on the x axis and use our custom ticks.
            xaxis: {
                renderer: $.jqplot.CategoryAxisRenderer,
                ticks: ticks
            },
            // Pad the y axis just a little so bars can get close to, but
            // not touch, the grid boundaries.  1.2 is the default padding.
            yaxis: {
                pad: 1.05,
                tickOptions: { formatString: '$%d' }
            }
        }
    });
}
//points charts

function drawPointsChart(containerElement) {


    var cosPoints = [];
    for (var i = 0; i < 2 * Math.PI; i += 0.4) {
        cosPoints.push([i, Math.cos(i)]);
    }

    var sinPoints = [];
    for (var i = 0; i < 2 * Math.PI; i += 0.4) {
        sinPoints.push([i, 2 * Math.sin(i - .8)]);
    }

    var powPoints1 = [];
    for (var i = 0; i < 2 * Math.PI; i += 0.4) {
        powPoints1.push([i, 2.5 + Math.pow(i / 4, 2)]);
    }

    var powPoints2 = [];
    for (var i = 0; i < 2 * Math.PI; i += 0.4) {
        powPoints2.push([i, -2.5 - Math.pow(i / 4, 2)]);
    }

    var plot3 = $.jqplot(containerElement, [cosPoints, sinPoints, powPoints1, powPoints2],
    {
        title: 'Line Style Options',
        // Series options are specified as an array of objects, one object
        // for each series.
        series: [
          {
              // Change our line width and use a diamond shaped marker.
              lineWidth: 2,
              markerOptions: { style: 'dimaond' }
          },
          {
              // Don't show a line, just show markers.
              // Make the markers 7 pixels with an 'x' style
              showLine: false,
              markerOptions: { size: 7, style: "x" }
          },
          {
              // Use (open) circlular markers.
              markerOptions: { style: "circle" }
          },
          {
              // Use a thicker, 5 pixel line and 10 pixel
              // filled square markers.
              lineWidth: 5,
              markerOptions: { style: "filledSquare", size: 10 }
          }
      ]
    }
  );

}

//draw pie chart
function drawPieChart(containerElement) {
    var data = [
    ['Heavy Industry', 12], ['Retail', 9], ['Light Industry', 14],
    ['Out of home', 16], ['Commuting', 7], ['Orientation', 9]
  ];
    var plot1 = jQuery.jqplot('chart1', [data],
    {
        seriesDefaults: {
            // Make this a pie chart.
            renderer: jQuery.jqplot.PieRenderer,
            rendererOptions: {
                // Put data labels on the pie slices.
                // By default, labels show the percentage of the slice.
                showDataLabels: true
            }
        },
        legend: { show: true, location: 'e' }
    }
  );
}
//draw donut chart
function drawDonutChart(containerElement) {
    var s1 = [['a', 6], ['b', 8], ['c', 14], ['d', 20]];
    var s2 = [['a', 8], ['b', 12], ['c', 6], ['d', 9]];

    var plot3 = $.jqplot(containerElement, [s1, s2], {
        seriesDefaults: {
            // make this a donut chart.
            renderer: $.jqplot.DonutRenderer,
            rendererOptions: {
                // Donut's can be cut into slices like pies.
                sliceMargin: 3,
                // Pies and donuts can start at any arbitrary angle.
                startAngle: -90,
                showDataLabels: true,
                // By default, data labels show the percentage of the donut/pie.
                // You can show the data 'value' or data 'label' instead.
                dataLabels: 'value'
            }
        }
    });
}

//draw bar chart
function drawBarchart(containerElement) {
    var s1 = [200, 600, 700, 1000];
    var s2 = [460, -210, 690, 820];
    var s3 = [-260, -440, 320, 200];
    // Can specify a custom tick Array.
    // Ticks should match up one for each y value (category) in the series.
    var ticks = ['May', 'June', 'July', 'August'];

    var plot1 = $.jqplot(containerElement, [s1, s2, s3], {
        // The "seriesDefaults" option is an options object that will
        // be applied to all series in the chart.
        seriesDefaults: {
            renderer: $.jqplot.BarRenderer,
            rendererOptions: { fillToZero: true }
        },
        // Custom labels for the series are specified with the "label"
        // option on the series option.  Here a series option object
        // is specified for each series.
        series: [
            { label: 'Hotel' },
            { label: 'Event Regristration' },
            { label: 'Airfare' }
        ],
        // Show the legend and put it outside the grid, but inside the
        // plot container, shrinking the grid to accomodate the legend.
        // A value of "outside" would not shrink the grid and allow
        // the legend to overflow the container.
        legend: {
            show: true,
            placement: 'outsideGrid'
        },
        axes: {
            // Use a category axis on the x axis and use our custom ticks.
            xaxis: {
                renderer: $.jqplot.CategoryAxisRenderer,
                ticks: ticks
            },
            // Pad the y axis just a little so bars can get close to, but
            // not touch, the grid boundaries.  1.2 is the default padding.
            yaxis: {
                pad: 1.05,
                tickOptions: { formatString: '$%d' }
            }
        }
    });
}
//draw bubble chart
function drawBubbleChart(containerElement) {

    var arr = [[11, 123, 1236, ""], [45, 92, 1067, ""],
  [24, 104, 1176, ""], [50, 23, 610, "A"],
  [18, 17, 539, ""], [7, 89, 864, ""], [2, 13, 1026, ""]];

    var plot1b = $.jqplot(containerElement, [arr], {
        seriesDefaults: {
            renderer: $.jqplot.BubbleRenderer,
            rendererOptions: {
                bubbleAlpha: 0.6,
                highlightAlpha: 0.8,
                showLabels: false
            },
            shadow: true,
            shadowAlpha: 0.05
        }
    });

    // Legend is a simple table in the html.
    // Dynamically populate it with the labels from each data value.
    $.each(arr, function (index, val) {
        $('#' + containerElement).append('<tr><td>' + val[3] + '</td><td>' + val[2] + '</td></tr>');
    });

    // Now bind function to the highlight event to show the tooltip
    // and highlight the row in the legend. 
    $('#' + containerElement).bind('jqplotDataHighlight',
    function (ev, seriesIndex, pointIndex, data, radius) {
        var chart_left = $('#' + containerElement).offset().left,
        chart_top = $('#' + containerElement).offset().top,
        x = plot1b.axes.xaxis.u2p(data[0]),  // convert x axis unita to pixels
        y = plot1b.axes.yaxis.u2p(data[1]);  // convert y axis units to pixels
        var color = 'rgb(50%,50%,100%)';
        $('#tooltip1b').css({ left: chart_left + x + radius + 5, top: chart_top + y });
        $('#tooltip1b').html('<span style="font-size:14px;font-weight:bold;color:' +
      color + ';">' + data[3] + '</span><br />' + 'x: ' + data[0] +
      '<br />' + 'y: ' + data[1] + '<br />' + 'r: ' + data[2]);
        $('#tooltip1b').show();
        $('#legend1b tr').css('background-color', '#ffffff');
        $('#legend1b tr').eq(pointIndex + 1).css('background-color', color);
    });

    // Bind a function to the unhighlight event to clean up after highlighting.
    $('#' + containerElement).bind('jqplotDataUnhighlight',
      function (ev, seriesIndex, pointIndex, data) {
          $('#tooltip1b').empty();
          $('#tooltip1b').hide();
          $('#' + containerElement + ' tr').css('background-color', '#ffffff');
      });
}

//-------------------------------------------------------------- */
// Gallery Actions
//-------------------------------------------------------------- */

function initializeGallery() {
    // When hovering over gallery li element
    $("ul.gallery li").hover(function () {

        var $image = (this);

        // Shows actions when hovering
        $(this).find(".actions").show();

        // If the "x" icon is pressed, show confirmation (#dialog-confirm)
        $(this).find(".actions .delete").click(function () {

            // Confirmation
            $("#dialog-confirm").dialog({
                resizable: false,
                modal: true,
                minHeight: 0,
                draggable: false,
                buttons: {
                    "Delete": function () {
                        $(this).dialog("close");

                        // Removes image if delete is pressed
                        $($image).fadeOut('slow', function () {
                            $($image).remove();
                        });

                    },

                    // Removes dialog if cancel is pressed
                    Cancel: function () {
                        $(this).dialog("close");
                    }
                }
            });

            return false;
        });


        // Changes opacity of the image
        $(this).find("img").css("opacity", "0.5");

        // On hover off
        $(this).hover(function () {
        }, function () {

            // Hides actions when hovering off
            $(this).find(".actions").hide();

            // Changes opacity of the image back to normal
            $(this).find("img").css("opacity", "1");

        });
    });
}
function setupGallery() {

    initializeGallery();
    //-------------------------------------------------------------- */
    //
    // 	**** Gallery Sorting (Quicksand) **** 
    //
    // 	For more information go to:
    //	http://razorjack.net/quicksand/
    //
    //-------------------------------------------------------------- */

    $('ul.gallery').each(function () {

        // get the action filter option item on page load
        var $fileringType = $("ul.sorting li.active a[data-type]").first().before(this);
        var $filterType = $($fileringType).attr('data-id');

        var $gallerySorting = $(this).parent().prev().children('ul.sorting');

        // get and assign the ourHolder element to the
        // $holder varible for use later
        var $holder = $(this);

        // clone all items within the pre-assigned $holder element
        var $data = $holder.clone();

        // attempt to call Quicksand when a filter option
        // item is clicked
        $($gallerySorting).find("a[data-type]").click(function (e) {
            // reset the active class on all the buttons
            $($gallerySorting).find("a[data-type].active").removeClass('active');

            // assign the class of the clicked filter option
            // element to our $filterType variable
            var $filterType = $(this).attr('data-type');
            $(this).addClass('active');
            if ($filterType == 'all') {
                // assign all li items to the $filteredData var when
                // the 'All' filter option is clicked
                var $filteredData = $data.find('li');
            }
            else {
                // find all li elements that have our required $filterType
                // values for the data-type element
                var $filteredData = $data.find('li[data-type=' + $filterType + ']');
            }

            // call quicksand and assign transition parameters
            $holder.quicksand($filteredData, {
                duration: 800,
                easing: 'easeInOutQuad',
                useScaling: true,
                adjustHeight: 'auto'
            }, function () {
                $('.popup').facebox();
                initializeGallery();
            });

            return false;
        });

    });
}

//setup pretty-photo
function setupPrettyPhoto() {

    $("a[rel^='prettyPhoto']").prettyPhoto();
}

//setup tinyMCE

function setupTinyMCE() {
    $('textarea.tinymce').tinymce({
        // Location of TinyMCE script
        script_url: 'js/tiny-mce/tiny_mce.js',

        // General options
        theme: "advanced",
        plugins: "autolink,lists,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,advlist",

        // Theme options
        theme_advanced_buttons1: "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
        theme_advanced_buttons2: "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
        theme_advanced_buttons3: "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
        theme_advanced_buttons4: "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak",
        theme_advanced_toolbar_location: "top",
        theme_advanced_toolbar_align: "left",
        theme_advanced_statusbar_location: "bottom",
        theme_advanced_resizing: true,

        // Example content CSS (should be your site CSS)
        content_css: "css/content.css",

        // Drop lists for link/image/media/template dialogs
        template_external_list_url: "lists/template_list.js",
        external_link_list_url: "lists/link_list.js",
        external_image_list_url: "lists/image_list.js",
        media_external_list_url: "lists/media_list.js",

        // Replace values for the template plugin
        template_replace_values: {
            username: "Some User",
            staffid: "991234"
        }
    });
}

//setup DatePicker
function setDatePicker(containerElement) {
    var datePicker = $('#' + containerElement);
    datePicker.datepicker({
    	changeMonth: true,
        changeYear: true,
        yearRange: '1945:'+(new Date).getFullYear(),
        showOn: "button",
        buttonImage: "img/calendar.gif",
        buttonImageOnly: true,
        dateFormat:'dd-M-yy'
    });
   // $(datePicker).datepicker("option", "dateFormat", ');
}
//setup progressbar
function setupProgressbar(containerElement) {
    $("#" + containerElement).progressbar({
        value: 59
    });
}

//setup dialog box

function setupDialogBox(containerElement, associatedButton) {
    $.fx.speeds._default = 1000;
    $("#" + containerElement).dialog({
        autoOpen: false,
        show: "blind",
        hide: "explode"
    });

    $("#" + associatedButton).click(function () {
        $("#" + containerElement).dialog("open");
        return false;
    });
}

//validate email address
function isValidEmailAddress(emailAddress) {
    var pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
    return pattern.test(emailAddress);
};

//setup accordion

function setupAccordion(containerElement) {
    $("#" + containerElement).accordion();
}

//setup radios and checkboxes
//function setupGrumbleToolTip(elementid) {
//    initializeGrumble(elementid);
//    $('#' + elementid).focus(function () {
//        initializeGrumble(elementid);
//    });
//}

//function initializeGrumble(elementid) {
//    $('#' + elementid).grumble(
//	{
//	    text: 'Whoaaa, this is a lot of text that i couldn\'t predict',
//	    angle: 85,
//	    distance: 50,
//	    showAfter: 1000,
//	    hideAfter: 2000
//	}
//);
//}

//setup left menu

function setupLeftMenu() {
    $("#section-menu")
        .accordion({
            "header": "a.menuitem"
        })
        .bind("accordionchangestart", function (e, data) {
            data.newHeader.next().andSelf().addClass("current");
            data.oldHeader.next().andSelf().removeClass("current");
        })
        .find("a.menuitem:first").addClass("current")
        .next().addClass("current");
		
		$('#section-menu .submenu').css('height','auto');
}
