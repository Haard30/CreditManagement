
<% /* 

----------------JSP For viewving all user and selectin one------------------


*/ %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Users</title>
<link rel="stylesheet" href="basicStyle.css" type="text/css"/>
</head>
<body>
<h1 class="style"> Current Users :</h1>
<%

/**
*DBMS fetch for displaying current user
*/
try {
    String connectionURL = "jdbc:mysql://localhost/credit_management";
    Connection connection = null; 
    Class.forName("com.mysql.jdbc.Driver").newInstance(); 
    connection = DriverManager.getConnection(connectionURL, "root", "");
    if(!connection.isClosed())
    {
    	Statement st=connection.createStatement();
		ResultSet rs=st.executeQuery("SELECT user_id,name FROM user "); %>
		<br><br><table border='1' align='center' width=60% height=100% ><tr height="60"><th >USER_ID</th><th >NAME</th></tr>
		
	<% 	while(rs.next()){ 
	%>
			<tr height="40"><td align="center" width=20%><%=rs.getString("user_id")%></td><td align="center"><a href='/CreditManagement/viewInter.view?userid=<%=rs.getString("user_id")%>'><%=rs.getString("name")%></a></td></tr>
			<% 	} %>
	</table>
	<% 
	}
    connection.close();
}
catch(Exception ex){
    out.println("Unable to connect to database.");
}
%>

</body>
</html>