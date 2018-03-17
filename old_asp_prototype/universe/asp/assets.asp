<% @LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include File="../include/DataAccess.asp" -->
<!-- #include File="../include/Security.asp" -->
<html>
<head>
<link rel="stylesheet" href="../script/style_main.css" type="text/css">
</head>

<body>

<font size=+3><b>Assets</b></font>
<hr>

<table border="0" cellpadding="0" cellspacing="0" width="90%">

<%
Dim RS
Dim RS2
Dim sSQL
Dim currentOID
Dim sType

'This query works, but I'm too tired to figure out how to display the results.
'So, I'll do two queries

'sSQL = "SELECT" & _
'		" Types.TYPENAME," & _
'		" Objects.OID," & _
'		" Objects.OBJECTNAME," & _
'		" Objects.SensorRange," & _
'		" Objects.AttackRating," & _
'		" Objects.DefenseRating," & _
'		" Objects.Description," & _
'		" Objects.DescURL," & _
'		" Objects.PID," & _
'		" Attributes.AType," & _
'		" Attributes.ATag," & _
'		" Attributes.AValue," & _
'		" Attributes.ASubValue" & _
'		" FROM" & _
'		" (Types INNER JOIN Objects ON (Types.TID = Objects.TID)" & _
'		" AND (Types.TID = Objects.TID))" & _
'		" LEFT JOIN Attributes ON Objects.OID = Attributes.OID" & _
'		" WHERE Objects.PID=" & sPID

sSQL = "SELECT" & _
		" Types.TYPENAME," & _
		" Objects.OID," & _
		" Objects.OBJECTNAME," & _
		" Objects.SensorRange," & _
		" Objects.AttackRating," & _
		" Objects.DefenseRating," & _
		" Objects.Description," & _
		" Objects.DescURL," & _
		" Objects.PID" & _
		" FROM" & _
		" (Types INNER JOIN Objects ON (Types.TID = Objects.TID)" & _
		" AND (Types.TID = Objects.TID))" & _
		" WHERE Objects.PID=" & sPID

	Set RS = ExecuteSQL(sSQL)
	
	Do Until RS.EOF
%>

		<tr><td colspan=6><font size='+1'><b><%=RS("ObjectName")%></b></font></td></tr>   	
		<tr><td>&nbsp;</td></tr>
<%
		sSQL = "SELECT * from ATTRIBUTES where OID = " & RS("OID")
		Set RS2 = ExecuteSQL(sSQL)
	
If Not RS2.EOF Then
%>
		<tr>
			<td><b>Category</b></td>
			<td><b>Description</b></td>
			<td><b>Type</b></td>
			<td><b>Value</b></td>
		</tr>   	

<%
		do until rs2.EOF
		sType = RS2("AType")
		If sType = "Converter" Then
			sType = "<a href=../asp/convert.asp?Step=1&OID=" & RS("OID") & "&Converter=" & RS2("AssetID") & ">" & sType & "</a>"
		End If
%>
		<tr>
			<td><%=sType%></td>
			<td><%=RS2("AValue")%></td>
			<td><%=RS2("ATag")%></td>
			<td><%=RS2("ASubValue")%></td>
<%
		RS2.movenext
		Loop
%>
		<tr><td>&nbsp;</td></tr>
<%
Else
%>
		<tr><td><a>Add Attributes</a></td></tr>
		<tr><td>&nbsp;</td></tr>

<%
End If
	RS.MoveNext
	Loop
%>
</table>
</body>
</html>