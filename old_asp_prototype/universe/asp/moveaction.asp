<% @LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include File="../include/DataAccess.asp" -->
<!-- #include File="../include/Security.asp" -->
<!-- #include File="../include/Server.asp" -->

<%
Dim RS
Dim sAction
Dim sX
Dim sY
Dim sZ
Dim sSQL
Dim sTargetOID

sAction = Request.QueryString("Action")


Select Case sAction

Case "ShipMove"
	sX = Request.QueryString("X")
	sY = Request.QueryString("Y")
	sZ = Request.QueryString("Z")
	
	'If the call came from move...then the values are in a form and not a querystring
	If sX = "" Then
		sX = Request.Form("X")
		sY = Request.Form("Y")
		sZ = Request.Form("Z")
	End If

	response.write "Destination Coordinates Entered (" & sX & "::" & sY & "::" & sZ & ")<br>"


	sSQL="SELECT * from Objects wHERE OID = " & sPlayerObjectID
	Set RS=ExecuteSQL(sSQL)
		
	If RS("Mobile") <> True then
	'You are on a fixed object, you must move to a ship.

		response.write "<bR>" & RS("ObjectName") & " is not capable of " & _
		"interstellar transit.  You must move your player to a starship or other mode of transport.<br>"
		response.write "<a href='/universe/changelocation.asp'>Move your player</a> to a different location.<br>"
		

	Else
	'You are on a mobile ship...

		If sX <> "" AND sY <> "" AND sZ <> "" Then
		
			'set new coords in the Database
			sSQL = "UPDATE OBJECTS SET Xdest=" & (sX +int(rnd*9)) & _
				", Ydest=" & (sY +int(rnd*9)) & _
				", Zdest=" & (sZ +int(rnd*9)) & " WHERE OID=" & sPlayerObjectID
			ExecuteUpdateSQL(sSQL)

	
			Response.write "Drive Systems Engaged<br><br>"
			
			UpdateObjectsInTransit()
			
			'Response.Redirect "main.asp"
		Else
			response.write "<br><FONT COLOR='RED'>All 3 coords " & _
			"were not passed from the calling form.  Contact the Game Administrator.</FONT>"
		end if

	end if

Case "PlayerMove"
	sTargetOID = Request.QueryString("Target")

	If sTargetOID <> "" Then
		
			'set new location in the player table
			sSQL = "UPDATE Players SET OID=" & sTargetOID & _
				" WHERE PID=" & sPID
			ExecuteUpdateSQL(sSQL)

			'Now update the session variables for Player Object.

			Session("UniversePlayerObjectID") = sTargetOID
			
			sSQL = "Select ObjectName from Objects WHERE OID=" & sTargetOID
			Set RS = ExecuteSQL(sSQL)

			Session("UniversePlayerObjectName") = RS("ObjectName")

			

			Response.write "Transfer Successful<br>"

			
			RS.Close
			'Response.Redirect "main.asp"
			
		Else
			response.write "<br><FONT COLOR='RED'>The Target ObjectID " & _
			"was not passed from the calling form.  Contact the Game Administrator.</FONT>"
		end if
End select

%>
