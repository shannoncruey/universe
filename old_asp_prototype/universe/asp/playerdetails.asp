<% @LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include File="../include/DataAccess.asp" -->
<!-- #include File="../include/Security.asp" -->
<html>
<head>
<link rel="stylesheet" href="../script/style_main.css" type="text/css">
</head>

<body>

<font size=+3><b>Player Details</b></font>
<hr>
<p>I am considering hiding the contact information.  I hope I can use the message table and then send the messages via the players preferred method of contact without disclosing email or chat addresses.  Also, this way users can play without any external notification.</p>

<%
Dim sSQL
Dim RS
Dim sRequestedPID
Dim RS2

sRequestedPID = Request.QueryString("PID")

sSQL = "SELECT * FROM Players WHERE PID = " & sRequestedPID
Set RS = ExecuteSQL(sSQL)
	
	sSQL="SELECT ObjectName from Objects wHERE OID = " & RS("OID")
	Set RS2=ExecuteSQL(sSQL)


response.write "<br><b>" & RS("PlayerName") & "</b><br>"
response.write "Email: <a href='mailto://" & RS("Email") & "'>" & RS("Email") & "</a><br>"
If RS("AIM") <> "" then response.write "AIM: " & RS("AIM") & "<br>"
If RS("ICQ") <> "" then response.write "ICQ: " & RS("ICQ") & "<br>"
response.write "Started: " & RS("StartDate") & "<br>"
response.write "Level: " & RS("PLevel") & "<br>"


%>

<hr>

<%
response.write "Current Location: <a href=details.asp?OID=" & RS("OID") & ">" & RS2("ObjectName") & "</a><br>"

sSQL="SELECT OID, ObjectName from Objects wHERE PID = " & sRequestedPID
	Set RS=ExecuteSQL(sSQL)

response.write "<P>Has Ownership of: <br>" 
	Do Until RS.EOF
		response.write "<a href=details.asp?OID=" & RS("OID") & ">" & RS("ObjectName") & "</a><br>"
		RS.MoveNext
	Loop

RS.Close
RS2.Close
%>
</body>
</html>