<% @LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include File="../include/DataAccess.asp" -->
<!-- #include File="../include/Security.asp" -->
<html>
<head>
<link rel="stylesheet" href="../script/style_main.css" type="text/css">
</head>

<body>

<font size=+3><b>Contact</b></font>
<hr>

<%
Dim RS
Dim sSQL
Dim sOID

sOID = Request.QueryString("OID")


sSQL = "SELECT DISTINCTROW Objects.OID, Objects.ObjectName, Objects.PID, " & _
	"Players.PlayerName FROM Objects, Players WHERE Objects.OID = " & sOID & _
	" AND Players.PID = Objects.PID"

Set RS = ExecuteSQL(sSQL)
%>
	Sending a message to <b><%=RS("PlayerName")%></b><br>
	Regarding <b><%=RS("ObjectName")%></b><br>
	<form method='POST' action='msgaction.asp?Action=New'>
	<Input type='hidden' name='sPID' value='<%=RS("PID")%>'>
	<Input type='hidden' name='sSentByPID' Value='<%=sPID%>'>
	<Input type='hidden' name='sSubjectOID' Value='<%=RS("OID")%>'>
	Subject: <Input type='text' name='sSubject' Value='Re: <%=RS("ObjectName")%>'><br>
	Message:<br><textarea rows=10 cols=50 name='sMessage'></textarea>
	<br><input type='submit' value='Submit'>

</body>
</html>

