<% @LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include File="../include/DataAccess.asp" -->
<!-- #include File="../include/Security.asp" -->
<html>
<head>
<link rel="stylesheet" href="../script/style_main.css" type="text/css">
</head>

<body>

<font size=+3><b>Stellar Object Database</b></font>
<hr>

<p><b>NOTICE:</b> Access to this database will soon be restricted.  Access is granted by the Administrator of the Galactic Mapping Consortium on Earth.</p>
<hr>

These are the current statistics for the Universe:

<br>

<%
Dim RS
Dim RS2
Dim sSQL

On Error Resume Next
sSQL = "SELECT * from TYPES"
Set RS = ExecuteSQL(sSQL)

Do Until RS.EOF
response.write "<b>" & RS("TypeName") & "</b><br>"

	sSQL = "SELECT * from OBJECTS where TID = " & RS("TID")
	Set RS2 = ExecuteSQL(sSQL)
	
	do until rs2.EOF
	response.write "<a href='details.asp?OID=" & RS2("OID") & "'>" & RS2("ObjectName") & "</a><br>"
	RS2.movenext
	Loop
%>

<br>

<%
RS.MoveNext
Loop
%>


<hr>


These are the current details for each Object:

<br>

<%
'On Error Resume Next
sSQL = "SELECT * from OBJECTS"
Set RS = ExecuteSQL(sSQL)

Do Until RS.EOF
response.write "<b>" & RS("ObjectName") & "</b><br>"
response.write "X: " & RS("X") & "<br>"
response.write "Y: " & RS("Y") & "<br>"
response.write "Z: " & RS("Z") & "<br>"

	sSQL = "SELECT * from ATTRIBUTES where OID = " & RS("OID")
	Set RS2 = ExecuteSQL(sSQL)
	
	do until rs2.EOF
	response.write RS2("AType") & " :: " & RS2("ATag") & _
		 " :: " & RS2("AValue") & " :: " & RS2("ASubValue") &"<br>"
	RS2.movenext
	Loop
%>

<br>

<%
RS.MoveNext
Loop
RS.Close
RS2.Close
%>