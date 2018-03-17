<% @LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include File="../include/DataAccess.asp" -->
<!-- #include File="../include/Security.asp" -->
<html>
<head>
<link rel="stylesheet" href="../script/style_main.css" type="text/css">
</head>

<body>

<font size=+3><b>Trade</b></font>
<hr>

<P>
Trading is a 4 step process.<br>
1) Review this page of all the details about the selected object.<br>

<%
response.write "2) <a href='contact.asp?OID=" & sOID & "'>" & _
	"Contact" & "</a> the owner and request a transction.<br>"
response.write "3) <a href='readmessages.asp'>Check your Messages</a> " & _
	"for a response from the owner.<br>"
response.write "4) <a href='transfergoods.asp?OID=" & sOID & "'>" & _
	"Transfer</a> goods to the owner.<br>"
 
%>
</P>
<hr>

<%
Dim sSQL
Dim RS
Dim sOID

sOID = Request.QueryString("OID")

sSQL = "SELECT DISTINCTROW * FROM Objects WHERE OID = " & sOID
Set RS = ExecuteSQL(sSQL)


response.write "<P><B><font size=+3>" & RS("ObjectName") & "</font></b><br>"


	sSQL = "SELECT * from ATTRIBUTES where OID = " & sOID
	Set RS = ExecuteSQL(sSQL)
	
	do until rs.EOF
	If RS("AType") <> "Attribute" Then
		response.write RS("AType") & " :: " & RS("ATag") & _
		 " :: " & RS("AValue") & " :: " & RS("ASubValue") &"<br>"
	End if	
	RS.movenext
	Loop

	sSQL = "SELECT Description, DescURL FROM Objects WHERE OID = " & sOID
	Set RS = ExecuteSQL(sSQL)

	response.write "<p><B>DESCRIPTION:</b><br>" & RS("Description")
	
	If RS("DescURL") <> "" then 
		response.write "<p><B>FULL DESCRIPTION:</b><br>" & _
		"<a href=" & RS("DescURL") & ">" & RS("DescURL") & "</a>"
	end if

RS.Close
%>
</body>
</html>
