<%
'---------------------------------------
''Function DetermineNewCoordinate(current, dest, speed)
'Dim diff
'Dim newdiff
'Dim newVal
	
'	diff = current - dest

'	'if you are within range...do nothing
'	If diff > speed Then
'		newVal = current + speed
'		
'		newdiff = newVal - dest
'			
'		If newdiff > diff Then
'		    newVal = current - speed
'		End If
'		'If ETA < (newdiff / 60) Then ETA = (newdiff / 60)
'				
'		'bArrived = False
'		Else 
'			newVal = (dest + int(rnd*9))
'		End If
'DetermineNewCoordinate = newVal
	
'End Function
'---------------------------------------
Function UpdateObjectsInTransit()
Dim RS
Dim sSQL
Dim currentX
Dim currentY
Dim currentZ
Dim Xdest
Dim Ydest
Dim Zdest
Dim diff
Dim newdiff
Dim newX
Dim newY
Dim newZ
Dim speed
Dim bArrived
Dim ETA

'Set speed here
speed = 500



'First, select all objects from the database that have Destination coordinates
	sSQL="SELECT OID, ObjectName, PID, X, Y, Z, Xdest, Ydest, Zdest from Objects" & _
		" WHERE Xdest <> Null" & _
		" AND Ydest <> Null" & _
		" AND Zdest <> Null" 
	
	Set RS = ExecuteSQL(sSQL)
	
	Do Until RS.EOF
		'Reason how to update
		'xdest is the goal, and x is the current location.

		'we will be toggling the bArrived value until all 3 coords have arrived
		'at the end, if bArrived is true, we will remove the destination data from
		'the record, which means that transit is complete.
		'If anything sets it false, we are not there yet...
		
		bArrived = True
		ETA = 0
		
		'XXXXXXXXXXXXXX
			
			'DetermineNewCoordinate RS("X"), RS("Xdest"), speed
			
			currentX = RS("X")
			Xdest = RS("Xdest")

			diff = currentX - Xdest

			'if you are within range...do nothing
			If diff > speed Then
				newX = currentX + speed
				
				newdiff = newX - Xdest
			
				If newdiff > diff Then
				    newX = CurrentX - speed
				End If
				
				'set ETA
				If ETA < (newdiff / speed) Then ETA = (newdiff / speed)
				
				bArrived = False
			Else 
				newX = (Xdest + int(rnd*9))
			End If
		
		'YYYYYYYYYYYYYY
			currentY = RS("Y")
			Ydest = RS("Ydest")

			diff = currentY - Ydest

			'if you are within range...do nothing
			If diff > speed Then
				newY = currentY + speed
				
				newdiff = newY - Ydest
			
				If newdiff > diff Then
				    newY = CurrentY - speed
				End If
				
				'set ETA
				If ETA < (newdiff / speed) Then ETA = (newdiff / speed)
				
				bArrived = False
			Else 
				newY = (Ydest + int(rnd*9))
			End If

		'ZZZZZZZZZZZZZZ
			currentZ = RS("Z")
			Zdest = RS("Zdest")

			diff = currentZ - Zdest

			'if you are within range...do nothing
			If diff > speed Then
				newZ = currentZ + speed
				
				newdiff = newZ - Zdest
			
				If newdiff > diff Then
				    newZ = CurrentZ - speed
				End If
				
				'set ETA
				If ETA < (newdiff / speed) Then ETA = (newdiff / speed)

				bArrived = False
			Else 
				newZ = (Zdest + int(rnd*9))
			End If
				

'when you get there...remove the dest data from the record...

		If bArrived = False Then
			'not there yet, just update
			sSQL = "UPDATE OBJECTS SET X=" & newX & _
				", Y=" & newY & _
				", Z=" & newZ & _
				", ArrivalTime=" & Round(ETA, 0) & _
				" WHERE OID=" & RS("OID")
		Else
			'we have arrived, update and clear dest fields...
			sSQL = "UPDATE OBJECTS SET X=" & newX & _
				", Y=" & newY & _
				", Z=" & newZ & _
				", Xdest=Null" & _
				", Ydest=Null" & _
				", Zdest=Null" & _
				", ArrivalTime=Null" & _
				" WHERE OID=" & RS("OID")
		End If		
		
		Response.Write RS("ObjectName") & " is in transit. "
		Response.Write "Destination ETA ... " & Round(ETA, 0) & " minutes.<br>"
		Response.Flush
		'Response.Write sSQL & "<p>"
				
		ExecuteUpdateSQL(sSQL)

		'This happens automatically so I commented it out...
		'SensorSweep RS("OID"), RS("PID")

	RS.MoveNext
	Loop

	UpdateObjectsInTransit = True
End Function

'------------------------------------------
Function SensorSweep(sPlayerObjectID, sPlayerID)
'This function will perform a sensor sweep for the specified object.
'It places an entry into sensor logs and returns nothing. 
'It also will notify the player if something is found.

Dim RS
Dim RS2
Dim sSQL
Dim LowX
Dim LowY
Dim LowZ
Dim HighX
Dim HighY
Dim HighZ

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

	Set RS = ExecuteSQL(sSQL)

	Do Until RS.EOF
		'check Sensor logs and add if necessary...
		'For mobile objects, also add the last known XYZ...
		
		sSQL="Select Count(*) from SensorLogs where PID = " & sPlayerID & " AND OID = " & RS("OID")
		Set RS2 = ExecuteSQL(sSQL)	
	
		'First, check if sensed object is mobile...
		If RS("Mobile") = True then
			If RS2(0) < 1 then 
				'no record of this object, add it
				sSQL="INSERT INTO SensorLogs (PID, OID, X, Y, Z, LastContact) " & _
					"VALUES (" & sPlayerID & "," & RS("OID") & "," & RS("X") & _
					"," & RS("Y") & "," & RS("Z") & ",'" & Now() & "')"
				
				'Notify of new Object code goes here
				NotifyPlayer("New Starship detected.  Check Sensor Logs.")
			else
				'there is a record, update the XYZ
				sSQL="UPDATE SensorLogs SET X=" & RS("X") & _
					",Y=" & RS("Y") & ",Z=" & RS("Z") & ",LastContact='" & Now() & _
					"' WHERE PID = " & sPlayerID & _
					" AND OID=" & RS("OID")
			end if
			
		else
			'now for fixed objects, just add them once...XYZ is in the objects table.
			If RS2(0) < 1 then
				'There is no sensor record, add one
				sSQL = "INSERT INTO SensorLogs (PID, OID, LastContact) " & _
						"VALUES (" & sPlayerID & "," & RS("OID") & ",'" & Now() & "')"
				
				'Notify of new Object code goes here
				NotifyPlayer("New Stellar Object detected.  Check Sensor Logs.")
			end if		
		end if
			
			ExecuteUpdateSQL(sSQL)
	
	RS.MoveNext
	Loop

'you have no sensor range
Else
	response.write sPlayerObjectName & " has no sensor capability."
End if

End Function

'-----------------------------------
Function NotifyPlayer(msg)
	Response.Write "Notifying Player with Message :: " & msg & "<br>"
	Response.Flush
End Function

'-----------------------------------
Function SensorSweep_Automatic()
Dim RS
Dim sSQL

'Any object that has a sensor range and an owner gets evaluated.
sSQL = "Select OID, PID from Objects where SensorRange > 0 and PID <> Null"
Set RS = ExecuteSQL(sSQL)

Do Until RS.EOF
	Response.Write "Sensor sweep for " & RS("OID") & "<br>"
	Response.Flush
	SensorSweep RS("OID"), RS("PID")
RS.MoveNext
Loop

SensorSweep_Automatic = True

End Function

Function DoConversions()

Dim RS
Dim sSQL
Dim dtNow

dtNow = Now()

'Run through all open conversions and process them...
sSQL = "Select OID, SourceAttributeID, SourceResult, TargetAttributeID, TargetResult" & _
		" from Conversions where CompletionTime < '" & dtNow & "'"
'response.Write sSQL

Set RS = ExecuteSQL(sSQL)
If Not RS.EOF Then
	Do Until RS.EOF
		response.Write "Updating Object " & RS("OID") & " Attributes: "
		response.Write "Adjusting Asset Type " & RS("SourceAttributeID") & " by " & RS("SourceResult")
		response.Write " and Asset Type " & RS("TargetAttributeID") & " by " & RS("TargetResult")
		'update the players attributes by adjusting the assets.  
		'If they don't have the target asset...insert it.
		
		'Decrease the Source Assets...
		sSQL = "update Attributes set ASubValue = (ASubValue - " & RS("SourceResult") & _
			") where AID = " & RS("SourceAttributeID")
		response.Write sSQL		
		ExecuteUpdateSQL(sSQL)
		
		'Increase the Target Assets...
		sSQL = "update Attributes set ASubValue = (ASubValue + " & RS("TargetResult") & _
			") where AID = " & RS("TargetAttributeID")
		response.Write sSQL		
		ExecuteUpdateSQL(sSQL)
	
	RS.MoveNext
	Loop

	'Delete the Conversions that we just did	
	sSQL = "delete from Conversions where CompletionTime < '" & dtNow & "'"
	ExecuteUpdateSQL(sSQL)

End If
DoConversions = True

End Function
%>

