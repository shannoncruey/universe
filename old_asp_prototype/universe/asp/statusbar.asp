<% @LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include File="../include/DataAccess.asp" -->
<!-- #include File="../include/Security.asp" -->
<html>
<head>
<meta http-equiv="Refresh" content="30">
<link rel="stylesheet" href="../script/style_bottom.css" type="text/css">
</head>

<body>
<%
Dim sSQL
Dim RS
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<%
'Check to see your current status
sSQL = "SELECT ArrivalTime, X, Y, Z, Xdest, Ydest, Zdest from Objects where OID = " & sPlayerObjectID
Set RS = ExecuteSQL(sSQL)

If Not RS.EOF Then
	If RS("ArrivalTime") <> "" Then
%>
<tr>
<td align="center">In Transit</td>
<td>Destination</td><td>X::<%=RS("X")%> Y::<%=RS("Y")%> Z::<%=RS("Z")%></td>
<td>Current Position</td><td>X::<%=RS("Xdest")%> Y::<%=RS("Ydest")%> Z::<%=RS("Zdest")%></td>
<td>ETA</td><td><%=RS("ArrivalTime")%> minutes.</td>
</tr>
<%
	Else
%>
<tr><td>Stationary at Coordinates</td><td>X::<%=RS("X")%> Y::<%=RS("Y")%> Z::<%=RS("Z")%></td></tr>
<%
	End If
End If

%>
</table>
</body>
</html>
