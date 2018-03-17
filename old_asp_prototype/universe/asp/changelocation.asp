<% @LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include File="../include/DataAccess.asp" -->
<!-- #include File="../include/Security.asp" -->
<html>
<head>
<link rel="stylesheet" href="../script/style_main.css" type="text/css">
</head>

<body>

<font size=+3><b>Change Player Location</b></font>
<hr>
<p>In order to move between the locations that you own, they must be within docking range.  (50 units for now)</p>

<%
Dim RS
Dim sSQL
Dim LowX, LowY, LowZ
Dim highX, HighY, HighZ

sSQL="SELECT X,Y,Z from Objects WHERE OID = " & sPlayerObjectID 
	Set RS=ExecuteSQL(sSQL)


LowX = RS("X") - 50
HighX = RS("X") + 50
LowY = RS("Y") - 50
HighY = RS("Y") + 50
LowZ = RS("Z") - 50
HighZ = RS("Z") + 50

sSQL = "SELECT * FROM Objects WHERE X BETWEEN " & _
       LowX & " AND " & HighX & " AND Y BETWEEN " & _
       LowY & " AND " & HighY & " AND Z BETWEEN " & _
       LowZ & " AND " & HighZ & _
       " AND OID <> " & sPlayerObjectID & "AND PID = " & sPID & " ORDER BY OID"
Set RS=ExecuteSQL(sSQL)

response.write "<P>Can move to: <br>" 

	Do Until RS.EOF
		response.write "<a href=moveaction.asp?Action=PlayerMove&Target=" & RS("OID") & ">" & RS("ObjectName") & "</a><br>"
		RS.MoveNext
	Loop

RS.Close
%>
</body>
</html>