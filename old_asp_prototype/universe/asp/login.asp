<%
response.write Time

'this code checks the form data, sets session vars, and redirects to main.asp

If Trim(Request.Form("sPlayerName")) <> "" Then
	Response.Write "<BR>You entered : " & Request.Form("sPlayerName")
	
	'Check UserName in the Database
	Set MyConn=Server.CreateObject("ADODB.Connection")
	MyConn.Open "Provider=Microsoft.Jet.OLEDB.4.0;" & _
              "Data Source=" & Server.MapPath("..\data\universe.mdb") & ";" & _
              "User Id=admin;" & _
              "Password="
	sSQL = "SELECT PID, PlayerName, OID from Players where PlayerName = '" & _
		Request.Form("sPlayerName") & "'"
	Set RS = MyConn.Execute(sSQL)

	If RS.EOF = True then	
		response.write "<br><font color=red>Invalid Player Name</font>"
	Else
	'Valid player selected, set a bunch of server variables
		Session("UniversePlayerID") = RS("PID")
		Session("UniversePlayerName") = RS("PlayerName")
		Session("UniversePlayerObjectID") = RS("OID")

		sSQL = "SELECT ObjectName from Objects where OID = " & RS("OID")
		Set RS = MyConn.Execute(sSQL)

		Session("UniversePlayerObjectName") = RS("ObjectName")

		Response.Redirect "main.asp"
	end if
	
	RS.Close
	MyConn.Close
end if
%>

<P><b>WELCOME TO THE UNIVERSE</b></P>
<P><b>Please Log In:</b></P>
<form method="POST" action="login.asp">
	<Input type="text" name="sPlayerName" size=20>
	
	<input type="submit" value="Submit">

<br>
