<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>

<% /* 

----------------JSP For Transferring Credits------------------


*/ %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Transfer Page</title>
<link rel="stylesheet" href="basicStyle.css" type="text/css"/>
</head>
<body>
<form action='/CreditManagement/TransferLogic.logic'>
<% /* 
Getting sessions of current user
*/ %>
<% session=request.getSession(); %>
<h2>Name : <%=(String)session.getAttribute("UserName") %></h2>
<h2 id="red">My Current Credits : <%=session.getAttribute("CurrentCredit")%></h2>
<h2>Enter Amount <input type="number" name="creditamount"  placeholder="Enter a positive number" required/><br>
 <br>Select User For transfer:</h2>
 <%
String s= session.getAttribute("UserId").toString();
 int uid=Integer.parseInt(s);
try {
	/*
	*Connecting DB to select which user for transfer
	*/
    String connectionURL = "jdbc:mysql://localhost/credit_management";
    Connection connection = null; 
    Class.forName("com.mysql.jdbc.Driver").newInstance(); 
    connection = DriverManager.getConnection(connectionURL, "root", "");
    if(!connection.isClosed())
    {
    	Statement st=connection.createStatement();
		ResultSet rs=st.executeQuery("SELECT user_id,name FROM user WHERE user_id !='"+uid+"'"); %>
		<table border='3' align='center' width=70%><tr height="60"><th>USER_ID</th ><th>NAME</th><th >SELECTION</th></tr>
		
	<% 	while(rs.next()){ 
	%>
			<tr height="40"><td align="center"><%=rs.getString("user_id")%></td><td align="center"><a href='/CreditManagement/viewInter.view?userid=<%=rs.getString("user_id")%>'><%=rs.getString("name")%></a></td>
			<td align="center" width=15%><input type="radio" name="to_id" value=<%=rs.getString("user_id")%>></td>
			</tr>
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
<br><br>
<input type="submit" id="submit" value="Transfer Credits" align="center"/>
</form><br>

</body>
</html>