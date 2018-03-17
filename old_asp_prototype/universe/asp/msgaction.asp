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
Dim sMessage
Dim sSubject
Dim sSQL

sSubject = Replace(Request.Form("sSubject"), "'", "''")
sMessage = Replace(Trim(Request.Form("sMessage")), "'", "''")

'Select Case based on QueryString values
Select Case Request.QueryString("Action")
	Case "Delete"
		response.write "You chose Delete"
	Case "Reply"
		response.write "You chose Reply"
	Case "New"

	'Post the data sent from contact.asp

	If Trim(Request.Form("sMessage")) <> "" Then
	
		'save the message
		sSQL = "INSERT INTO Messages (PID, SentByPID, Subject, Message) VALUES (" & _
			Request.Form("sPID") & "," & Request.Form("sSentByPID") & _
			",'" & sSubject & "','" & _
			sMessage & "')"

		ExecuteUpdateSQL(sSQL)

		Response.Write "Message sent successfully..."

		'Response.Redirect "main.asp"
	Else
		response.write "<br><FONT COLOR='RED'>You must enter a Message</FONT>"
	end if

end select
%>
</body>
</html>