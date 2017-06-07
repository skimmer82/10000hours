<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String driverName="com.mysql.jdbc.Driver";
String userName="xxx";
String userPasswd="xxx";
String dbName="xxx";
String tableName="xxx";
String url="jdbc:mysql://xxx/"+dbName+"?user="+userName+"&password="+userPasswd+"&useUnicode=true&characterEncoding=utf8"; 

Class.forName("com.mysql.jdbc.Driver").newInstance(); 
Connection connection=DriverManager.getConnection(url); 
Statement statement = connection.createStatement();
String user_name = (String) request.getSession().getAttribute("username");
String sql="SELECT * FROM "+tableName+" WHERE name='"+user_name+"'";
ResultSet rs = statement.executeQuery(sql); 
int i=0;
List<String[]> arr = new ArrayList<String[]>();
while(rs.next()){
	String name = rs.getString(1);
	String exercise = rs.getString(2);
	String duration_min = rs.getString(3);
	String note = rs.getString(4);
	arr.add (new String[]{name,exercise,duration_min,note});
}
int arrsize = arr.size();
rs.close();
statement.close();
connection.close();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="gb2312">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>一万个小时</title>
	
    <!-- bootstrap and jquery-->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-2.0.3.min.js"></script> 
    <script src="bootstrap/js/bootstrap.min.js"></script>  
    <script src="bootstrap3-editable/js/bootstrap-editable.js"></script>
   
    <!-- Custom styles for this template -->
    <link href="index_test/jumbotron.css" rel="stylesheet">
	
	<script src="xrecord/record.js" charset="gb2312"></script>
    <script>
	$(document).ready(function() {
	    $.fn.editable.defaults.mode = 'popup';       
		for ( var i=0; i< <%=arrsize%>;i++){
			$('#i'+i).editable();
		}
	});
	
	</script>
</head>

<body>
<%out.print("<h1 align=center>"+user_name+"的学习进度"+"</h1>");%>
<div class="container">
<div id="exerciseList" style="left:2%;position:relative;">
<%
	for (int j=0; j<arr.size(); j++){
	out.print("<div id="+"'u"+j+"'>");  
	out.print("<p id="+"'p"+j+"'>");
	out.print(arr.get(j)[1]+":</p>"); 
	out.print("<div>");
	out.print("<a href=\"#\" id=\""+"i"+j+"\" data-type=\"text\" data-placement=\"right\" ");
	out.print("data-title=\"Enter username\" class=\"editable editable-click\"> ");
	out.print(arr.get(j)[3]);
	out.print("</a>");
	out.print("</div>\n");
	out.print("<input type='button' value='签入' onClick=\"insertInput("+j+",'"
			 +arr.get(j)[0]+"','"+arr.get(j)[1]+"','"+arr.get(j)[2]+"','"+arr.get(j)[3]+"')\" id='input"+j+"'>\n"); 
	out.print("<div class=\"progress\" style=\"width:1000px\">\n");
	out.print("<div class=\"progress-bar\" role=\"progressbar\" aria-valuenow=\""
	+arr.get(j)[2]+"\" aria-valuemin=\"0\" aria-valuemax=\"600\" style=\"min-width: 2em; width:"
	+Integer.parseInt(arr.get(j)[2])*100/2000+"%;\">\n"+arr.get(j)[2]+"/2000"+"\n</div>\n");
	out.print("</div>\n");
	out.print("</div>\n\n"); 
  }
%>
<div style="width:10%; position:relative; left:0; bottom:0">
	<form name="exercise_form" id="exercise_form_1" action="Record" method="post">
	<input type="hidden" name="name" value="<%=user_name%>">
	<input type="hidden" name="url" value="xrecord.jsp"> 
	<input type="text" name="exercise" size="13" class="form-control">
	<input type="submit" value="新建项目" name="submit" > 
	</form>  
</div>
</div>	
</div>
 	
<form name="record_form" id="record_form_1" method="post" >
<input type="hidden" name="name" value="0">
<input type="hidden" name="exercise" value="0">
<input type="hidden" name="duration" value="0">  
<input type="hidden" name="note" value="0">  
<input type="hidden" name="url" value="xrecord.jsp"> 
</form> 

</body>
</html>