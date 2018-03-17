<%
'---------------------------------------
Dim sPID
Dim sPlayer
Dim sPlayerObjectID
Dim sPlayerObjectName

sPID = Session("UniversePlayerID")
sPlayer = Session("UniversePlayerName")
sPlayerObjectID = Session("UniversePlayerObjectID")
sPlayerObjectName = Session("UniversePlayerObjectName")

'Make sure there is a valid player...
If sPlayer <> "" Then
	'Response.Write "<table width='100%'>"
	'response.write "<tr><td>" & Time & "</td>"
	'response.write "<td>Player Name: " & sPlayer & "</td>"
	'response.write "<td>Current Location: " & sPlayerObjectName & "</td>"
	'response.write "<td><a href='/universe/login.asp'>Log Off</a></td>"
	'response.write "</table><hr>"
Else
	response.redirect "login.asp"
End if

'Make sure player has a current location...
If sPlayerObjectID <> "" Then
	'do nothing if there is a location...		
Else
	response.write "<br>It appears that there is no location " & _
	"associated with your user.  Contact the Game Administrator.<br>"		
End If

'---------------------------------------
%>

