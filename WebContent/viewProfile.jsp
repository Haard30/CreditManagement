<% /* 

----------------JSP For viewving Particular profile------------------


*/ %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile</title>
<link rel="stylesheet" href="basicStyle.css" type="text/css"/>
</head>
<body>
<form>
<% session=request.getSession(); %>
<h2>User_ID :  <%= session.getAttribute("UserId") %></h2>
<h2>Name : <%=(String)session.getAttribute("UserName") %></h2>
<h2>Email ID : <%=(String)session.getAttribute("EmailId") %></h2>
<h2 id="red">Current Credits : <%=session.getAttribute("CurrentCredit")%></h2>

</form><br>
<a href="TransferCredit.jsp?userid=<%=session.getAttribute("UserId")%>" class="button" >Transfer credits</a>
</body>
</html>