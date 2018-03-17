<% @LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include File="../include/DataAccess.asp" -->
<!-- #include File="../include/Security.asp" -->
<html>
<head>
<link rel="stylesheet" href="../script/style_main.css" type="text/css">
</head>

<body>

<%
Dim sSQL
Dim RS
Dim RS2
Dim sOID
Dim sLevel

sOID = Request.QueryString("OID")

sSQL = "SELECT DISTINCTROW * FROM Objects WHERE OID = " & sOID
Set RS = ExecuteSQL(sSQL)


		response.write "<P><B><font size=+3>" & RS("ObjectName") & "</font></b><br>"
'If there is no owner, you cannot contact, trade or attack.
		If RS("PID") <> "" then
		response.write "   <font size=-1><a href='contact.asp?OID=" & _
		RS("OID") & "'>" & "Contact" & "</a></font>"
		end if
	
	'Display the XYZ, but not for mobile objects...
	If RS("Mobile") = True then
	'It's mobile, so you don't know...
	'Until we can look at the sensor logs and get show the last location.
		response.write "<hr><B>CURRENT LOCATION:</b><br>"
		response.write "Unknown...<br>"
	
	else
	'it's a fixed object, so show XYZ...
		response.write "<hr><B>LOCATION:</b><br>"
		response.write "<br>X: " & RS("X") & "<br>"
		response.write "Y: " & RS("Y") & "<br>"
		response.write "Z: " & RS("Z") & "<br>"
	end if

	Response.write "<hr><B>DETAILS:</b><br> "

'show the owner...
	If RS("PID") <> "" then
		sSQL="SELECT PID, PlayerName, PLevel from PLAYERS where PID =" & RS("PID")
		Set RS2=ExecuteSQL(sSQL)
	'set a var to the Level to use below in figuring out defense capability
		sLevel = RS2("PLeveL")
		response.write "<br>Owner: <a href=playerdetails.asp?PID=" & _
			RS2("PID") & ">" & RS2("PlayerName") & "</a><br>"
	end if

	sSQL = "SELECT * from ATTRIBUTES where OID = " & sOID
	Set RS2 = ExecuteSQL(sSQL)
	
	do until rs2.EOF
	response.write RS2("AType") & " :: " & RS2("ATag") & _
		 " :: " & RS2("AValue") & " :: " & RS2("ASubValue") &"<br>"
		
	RS2.movenext
	Loop


response.write "<p><B>DESCRIPTION:</b><br>" & RS("Description")
	If RS("DescURL") <> "" then 
		response.write "<p><B>FULL DESCRIPTION:</b><br>" & _
		"<a href=" & RS("DescURL") & ">" & RS("DescURL") & "</a>"
	end if

	

response.write "<hr><b>DEFENSE CAPABILITY</b><BR>"
response.write "Commander Level: " & sLevel & "<br>"
response.write "Defense Rating: " & RS("DefenseRating") & "<br>"
response.write "Attack Rating: " & RS("AttackRating") & "<br>" 
response.write "<b>Total Defense Capability:</b> " & (RS("DefenseRating") + RS("AttackRating")) * sLevel
	



response.write "<HR>"

RS2.Close
RS.Close
%>
</body>
</html>