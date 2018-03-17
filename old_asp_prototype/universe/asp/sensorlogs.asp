<% @LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include File="../include/DataAccess.asp" -->
<!-- #include File="../include/Security.asp" -->
<html>
<head>
<link rel="stylesheet" href="../script/style_main.css" type="text/css">
</head>

<body>

<font size=+3><b>Sensor Log</b></font>
<hr>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<%
Dim sSQL
Dim RS
Dim RS2
'Get the sensor logs from the database...
	
	sSQL = "SELECT Objects.*, SensorLogs.LastContact" & _
			" FROM Objects" & _
			" INNER JOIN SensorLogs ON Objects.OID = SensorLogs.OID" & _
			" WHERE SensorLogs.PID=" & sPID & _
			" ORDER BY SensorLogs.LastContact DESC"	
	Set RS = ExecuteSQL(sSQL)


If RS.EOF = FALSE Then
%>
<tr>
	<td width='33%'><b>Sensor Contact</b></td>
	<td width='66%' colspan='5'><b>Actions</b></td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<%
	Do Until RS.EOF
%>
		<tr>
			<td><%=RS("ObjectName")%></td>
	
			<td><a href='details.asp?OID=<%=RS("OID")%>'>Info</a></td>
<%
		'If there is no owner, you cannot contact, trade or attack.
		If RS("PID") <> "" then
%>
			<td><a href='contact.asp?OID=<%=RS("OID")%>'>Contact</a></td>
<%
		Else
%>
			<td>&nbsp;</td>
<%
		End If
		If RS("Mobile") = True then	
		'it's a mobile body.
		'Show the last known coords from SensorLogs and link to move there.

			sSQL="SELECT X,Y,Z from SensorLogs where PID = " & _
				sPID & " AND OID = " & RS("OID")
			Set RS2=ExecuteSQL(sSQL)
%>
			<td><a href='moveaction.asp?action=ShipMove&X=<%=RS2("X")%>&Y=<%=RS2("Y")%>&Z=<%=RS2("Z")%>'>Move To</a>
			(Last Known Location)</td>
<%
		Else
		'it's a fixed one, set coords to move there...	
		'the actual coords are in the object recordset
			Randomize
%>
			<td><a href='moveaction.asp?action=ShipMove&X=<%=RS("X")%>&Y=<%=RS("Y")%>&Z=<%=RS("Z")%>'>Move To</a></td>
		</tr>
<%
		End If

	RS.MoveNext
	Loop
Else
%>
	<td>There are no sensor logs.</td>
<%
End If
%>
</table>
</body>
</html>