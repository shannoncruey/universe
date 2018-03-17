<% @LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include File="../include/DataAccess.asp" -->
<!-- #include File="../include/Server.asp" -->
<html>
<head>
<meta http-equiv="Refresh" content="60">
</head>

<body>
<font size=+3><b>Server</b></font>

<%
'This file is the basis for the running service server that will
'eventually control the universe.  Currently, it is an asp page with a refresh
'tag for testing.
'Eventually, it will be a running VB process.

'!!!If you change the meta refresh, you should change the ETA section
'of ../include/Server.asp to match.

Dim bResult

%>
<hr>
<font size=+2>Objects in Transit</font><br>
<%
bResult = UpdateObjectsInTransit()
%>

<hr>
<font size=+2>Sensor Scans</font><br>
<%
bResult = SensorSweep_Automatic()
%>

<hr>
<font size=+2>Perform Conversions...</font><br>
<%
bResult = DoConversions()
%>
</body>
</html>
