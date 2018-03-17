<% /* 

----------------JSP for displaying failed or successful transaction------------------


*/ %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="basicStyle.css" type="text/css"/>
<title>Transaction status</title>
</head>
<body>
<% session=request.getSession(); %>
<% String st= (String) session.getAttribute("status"); 
%>
<h2>Transaction: <%=st %></h2>

<a href="viewAll.jsp" class="button" >View All Users</a>
</body>
</html>