<% @LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include File="../include/DataAccess.asp" -->
<!-- #include File="../include/Security.asp" -->
<html>
<head>
<meta http-equiv="Refresh" content="60">
<link rel="stylesheet" href="../script/style_main.css" type="text/css">
</head>

<SCRIPT LANGUAGE="JScript">
function doPosition()
{
	xytwo.style.top = document.all.xyone.offsetHeight/2 - 
	xytwo.offsetHeight/2;
	xytwo.style.left = document.all.xyone.offsetWidth/2 - 
	xytwo.offsetWidth/2;

	ztwo.style.top = document.all.zone.offsetHeight/2 - 
	ztwo.offsetHeight/2;
	ztwo.style.left = document.all.zone.offsetWidth/2 - 
	ztwo.offsetWidth/2;
}
</SCRIPT>
</HEAD>

<BODY onload="doPosition()">

<font size=+3><b>Short Range Sensors</b></font>
<hr>




<table>
<tr>
	<td>
<DIV ID=xyone STYLE="position:relative;top:10px;height:300px;width:300px;background-color:black;overflow:auto">

<%
Dim RS
Dim RS2
Dim RS3
Dim sSQL
Dim LowX
Dim LowY
Dim LowZ
Dim HighX
Dim HighY
Dim HighZ

Dim sX
Dim sY
Dim sZ



'Get the current location XYZ from the database...
sSQL = "SELECT DISTINCTROW * FROM Objects WHERE OID = " & sPlayerObjectID
Set RS = ExecuteSQL(sSQL)

'You cannot sense if you have no sensors...
If RS("SensorRange") > 0 Then
'You have sensors, so do this...

LowX = RS("X") - RS("SensorRange")
HighX = RS("X") + RS("SensorRange")
LowY = RS("Y") - RS("SensorRange")
HighY = RS("Y") + RS("SensorRange")
LowZ = RS("Z") - RS("SensorRange")
HighZ = RS("Z") + RS("SensorRange")

sSQL = "SELECT * FROM Objects WHERE X BETWEEN " & _
       LowX & " AND " & HighX & " AND Y BETWEEN " & _
       LowY & " AND " & HighY & " AND Z BETWEEN " & _
       LowZ & " AND " & HighZ & _
       " AND OID <> " & RS("OID") & " ORDER BY OID"

Set RS2 = ExecuteSQL(sSQL)

If RS2.EOF = FALSE Then
%>
	<DIV ID=xytwo title="<%=sPlayerObjectName & " " & RS("X") & "," & RS("Y")%>" STYLE="position:absolute;width:1px;height:1px;">
	<a href="../asp/details.asp?OID=<%=sPlayerObjectID%>" style="color:green;TEXT-DECORATION:none">&curren;</a>
	</DIV>

<%
	Do Until RS2.EOF
	'The 125 is the hardcoded width of the DIV.  It should be corrected
	'once I figure out how to do the DIV.
	
		sX = (((RS2("X")) - (RS("X"))) * (150  / RS("SensorRange")) + 150)
		sY = (((RS("Y")) - (RS2("Y"))) * (150  / RS("SensorRange")) + 150)
	
%>
		<DIV ID="<%=RS2("ObjectName")%>" title="<%=RS2("ObjectName") & " " & RS2("X") & "," & RS2("Y")%>" STYLE="position:absolute;left:<%=sX%>px;top:<%=sY%>px;width:1px;height:1px;">
			<%If RS2("Mobile") Then%>
			<a href="../asp/details.asp?OID=<%=RS2("OID")%>" style="color:red;TEXT-DECORATION:none">&thorn;</a>
			<%Else%>
			<a href="../asp/details.asp?OID=<%=RS2("OID")%>" style="color:blue;TEXT-DECORATION:none">•</a>
			<%End If%>
		</DIV>

<%
	RS2.MoveNext
	Loop	
%>		
		</DIV>
	</td>
	<td>
		<DIV ID="zone" STYLE="position:relative;top:10px;height:300px;width:12px;background-color:black;overflow:hidden">
		<DIV ID="ztwo" title="<%=sPlayerObjectName & " " & RS("X") & "," & RS("Y") & "," & RS("Z")%> " STYLE="position:absolute;width:1px;height:1px;color:green;">
		<a href="../asp/details.asp?OID=<%=sPlayerObjectID%>" style="color:green;TEXT-DECORATION:none">&curren;</a>
		</DIV>

<%
RS2.MoveFirst

	Do Until RS2.EOF
		sZ = (((RS("Z")) - (RS2("Z"))) * (150  / RS("SensorRange")) + 150)

%>
		<DIV ID="<%=RS2("ObjectName")%>" title="<%=RS2("ObjectName") & " " & RS2("X") & "," & RS2("Y") & "," & RS2("Z")%>" STYLE="position:absolute;left:3px;top:<%=sZ%>px;width:1px;height:1px;color:red;">
			<%If RS2("Mobile") Then%>
			<a href="../asp/details.asp?OID=<%=RS2("OID")%>" style="color:red;TEXT-DECORATION:none">&thorn;</a>
			<%Else%>
			<a href="../asp/details.asp?OID=<%=RS2("OID")%>" style="color:blue;TEXT-DECORATION:none">•</a>
			<%End If%>
		</DIV>
<%
	RS2.MoveNext
	Loop
%>	
		</DIV>
	</td>
</tr>
</table>


<%
RS2.MoveFirst
%>
<hr>
<table border="0" cellpadding="0" cellspacing="0" width="90%">

<tr>
	<td width='30%'><b>Sensor Contact</b></td>
	<td width='60%' colspan='5'><b>Actions</b></td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<%

	Do Until RS2.EOF
%>
		<tr>
			<td><%=RS2("ObjectName")%></td>
	
			<td><a href='../asp/details.asp?OID=<%=RS2("OID")%>'>Info</a></td>
			<td><a href='../asp/moveaction.asp?action=ShipMove&X=<%=RS2("X")%>&Y=<%=RS2("Y")%>&Z=<%=RS2("Z")%>'>Move To</a></td>
<%
		'If there is no owner, you cannot contact, trade or attack.
		If RS2("PID") <> "" then
%>
			<td><a href='../asp/contact.asp?OID=<%=RS2("OID")%>'>Contact</a></td>
			<td><a href='../asp/trade.asp?OID=<%=RS2("OID")%>'>Trade</a></td>
			<td><a href='../asp/attack.asp?OID=<%=RS2("OID")%>'>Attack</a></td>
		</tr>

<%
		else
		'since there is no owner, you can claim the object.
%>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td><a href='../asp/claim.asp?OID=<%=RS2("OID")%>'>Claim</a></td>
			<td><a href='../asp/collect.asp?Step=1&OID=<%=RS2("OID")%>'>Collect</a></td>
<%
		end if

		'Finally, check Sensor logs and add if necessary...
		'For mobile objects, also add the last known XYZ...
		
		sSQL="Select Count(*) from SensorLogs where PID = " & sPID & " AND OID = " & RS("OID")
		Set RS3 = ExecuteSQL(sSQL)	
	
	
		'If RS2(0) < 1 Then
		'First, check if sensed object is mobile...
		If RS("Mobile") = True then
		
		If RS3(0) < 1 then 
				'no record of this object, add it
				sSQL="INSERT INTO SensorLogs (PID, OID, X, Y, Z) " & _
					"VALUES (" & sPID & "," & RS("OID") & "," & RS("X") & _
					"," & RS("Y") & "," & RS("Z") & ")"
			else
				'there is a record, update the XYZ
				sSQL="UPDATE SensorLogs SET X=" & RS("X") & _
					",Y=" & RS("Y") & ",Z=" & RS("Z") & " WHERE PID = " & sPID & _
					" AND OID=" & RS("OID")
			end if
			
		else
			'now for fixed objects, just add them once...XYZ is in the objects table.
			If RS3(0) < 1 then
				'There is no sensor record, add one
				sSQL = "INSERT INTO SensorLogs (PID, OID) VALUES (" & sPID & "," & RS("OID") & ")"
	
			end if		
		end if
			ExecuteUpdateSQL(sSQL)
	
	RS2.MoveNext
	Loop
Else
%>
	<td>Nothing detected in sensor range.</td>
<%
End If


'you have no sensor range
Else
%>
	<td><%=sPlayerObjectName%> has no sensor capability.</td>
<%
End if
%>
</table>
</body>
</html>
