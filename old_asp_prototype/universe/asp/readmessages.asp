<% @LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include File="../include/DataAccess.asp" -->
<!-- #include File="../include/Security.asp" -->
<html>
<head>
<link rel="stylesheet" href="../script/style_main.css" type="text/css">
</head>

<body>

<font size=+3><b>Messages</b></font>
<hr>


<%

Dim RS
Dim sSQL

'System Messages are To: Null

	response.write "<b>SYSTEM MESSAGES</b><bR>"

	sSQL = "SELECT * FROM Messages WHERE Subject = 'System'"
	Set RS = ExecuteSQL(sSQL)

	If RS.EOF = True then
		response.write "<br>There are no system messages."
	else
		Do Until RS.EOF
			response.write "<P><i>" & RS("Message") & "</i><br><hr>"
			RS.MoveNext
		Loop
	end if
	
	
	
response.write "<HR><b>PERSONAL MESSAGES</b><bR>"

sSQL = "SELECT Players.PID, Players.PlayerName, Messages.Subject, " & _
	"Messages.MID, Messages.Message " & _
	"FROM Players, Messages WHERE Messages.PID = " & sPID & _
	"AND Players.PID = Messages.PID"
Set RS = ExecuteSQL(sSQL)

	If RS.EOF = True then
		response.write "<br>You currently have no messages."
	else
		Do Until RS.EOF
			response.write "<p><b>From: </b><a href='playerdetails.asp?PID=" & _
			RS("PID") & "'>" & RS("PlayerName") & "</a> "
			response.write "<font size=-1><a href='msgaction.asp?Action=Reply&PID=" & _
			RS("PID") & "'>Reply</a></font>"
			response.write "    <font size=-1><a href='msgaction.asp?Action=Delete&MID=" & _
			RS("MID") & "'>Delete</a></font></p>"
			response.write "<p><font color=blue><b><i>" & RS("Subject") & "</i></b><br>"
			response.write "<i>" & RS("Message") & "</i></font></p><hr>"
			RS.MoveNext
		Loop
	end if

RS.Close
%>
</body>
</html>
