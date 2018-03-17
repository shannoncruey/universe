<% @LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include File="../include/Security.asp" -->
<html>
<head>
<link rel="stylesheet" href="../script/style_main.css" type="text/css">
</head>

<body>

<font size=+3><b>Set a Course</b></font>
<hr>


There are four ways to move in the Universe.  You can:<br>

1) Perform a <a href="/universe/sensorsweep.asp">Sensor Sweep</a> and move to a detected location,<br>
2) Select a location from your <a href='sensorlogs.asp'>Sensor Logs</a> and go there,<br>
3) Select a location from the <a href='sod.asp'>Stellar Object Database</a>, (If you have access permissions...) <br>
-OR-<br>
4) Specify X,Y, and Z coordinates in space.


<HR>
Select a destination:
<br>
Enter the exact coordinates below<br>

<p><b>Enter new Coordinates:</b></p>

<form method="POST" action="moveaction.asp?action=ShipMove">
	X: <Input type="text" name="X" size=20>
	Y: <Input type="text" name="Y" size=20>
	Z: <Input type="text" name="Z" size=20>
	<input type="submit" value="Submit">

