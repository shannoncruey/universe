<% @LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include File="../include/DataAccess.asp" -->
<!-- #include File="../include/Security.asp" -->
<html>
<head>
<link rel="stylesheet" href="../script/style_main.css" type="text/css">
</head>

<body>

<font size=+3><b>Collect Resources</b></font>
<hr>

<%
Dim RS
Dim RS2
Dim sSQL
Dim sStep
Dim iOID
Dim iConverterID
Dim iSourceAID
Dim iTargetAssetID
Dim iTargetAID
Dim iAmount
Dim iYield
Dim iTime
Dim sCompletionTime
Dim sTimeRemaining


sStep = Request.QueryString("Step")
'Pop a combo with users existing attributes...user selects one...
'refresh with a combo for a target asset type...
'show conversion result and ask to commit.


If sStep = "1" Then
iOID = Request.QueryString("OID")
iConverterID = Request.QueryString("Converter")

	sSQL = "Select b.AValue as Source, a.SourceResult," & _
			" c.AValue as Target, a.TargetResult," & _
			" a.CompletionTime" & _
			" from Conversions a, Attributes b, Attributes c" & _
			" where a.OID = " & sPlayerObjectID & _
			" and a.sourceAttributeID = b.AID" & _
			" and a.targetAttributeID = c.AID"
			
	Set RS = ExecuteSQL(sSQL)

	If Not RS.EOF Then
		sTimeRemaining = DateDiff("n", Now(), RS(4))
%>
	Collection in Progress:<br>
	<%Do Until RS.EOF%>
		 <br><%=RS(1)%>&nbsp;<%=RS(0)%> will yield <%=RS(3)%>&nbsp;<%=RS(2)%> in <%=sTimeRemaining%> minutes.
	<%
	RS.MoveNext
	Loop
	End If

%>
	<form action='../asp/collect.asp?Step=2' method=post>
	<input type=hidden name=OID value='<%=iOID%>'>
	<input type=hidden name=converterID value='<%=iConverterID%>'>

<%	sSQL = "SELECT AID, AValue FROM Attributes" & _
		" WHERE OID = " & iOID & " AND AType = 'Resource'"
	Set RS=ExecuteSQL(sSQL)

	If Not RS.EOF Then
	%>
		Select Resource to Collect: 
		<select id='srcAID' NAME="srcAID">
	<%
		Do Until RS.EOF %>
			<option value=<%=RS("AID")%>><%=RS("AValue")%></option>
	<%		RS.MoveNext
		Loop
	%>
			</select>
			<input type=text name=Amount>
			<input type=submit name=Next value='Next >>'>
	</form>
	<%
	End If
	RS.Close
End If

If sStep = "2" Then

iSourceAID = Request.Form("srcAID")
iAmount = Request.Form("Amount")
iOID = Request.Form("OID")
iConverterID = Request.Form("ConverterID")
%>
Converting <%=iAmount%> of <%=iSourceAID%> to...<br>
	<form action='../asp/convert.asp?Step=3' method=post ID="Form2">
	<input type=hidden name=OID value='<%=iOID%>' ID="Hidden5">
	<input type=hidden name=srcAID value='<%=iSourceAID%>' ID="Hidden8">
	<input type=hidden name=converterID value='<%=iConverterID%>' ID="Hidden9">
	<input type=hidden name=Amount value='<%=iAmount%>' ID="Hidden10">
<%
	sSQL = "SELECT * FROM Assets WHERE AssetType <> 'Converter'"
	Set RS=ExecuteSQL(sSQL)

	If Not RS.EOF Then
	%>
		Select Target Asset: 
		<select id="tgtAssetID" NAME="tgtAssetID">
	<%
		Do Until RS.EOF %>
			<option value=<%=RS("AssetID")%>><%=RS("AssetName")%></option>
	<%		RS.MoveNext
		Loop
	%>
			</select>
			<input type=submit name=Next value='Next >>' ID="Submit2">
	</form>
	<%
	End If
	RS.Close
End If


If sStep = "3" Then

'!!!!!!!!!!!!!!!!!!!!!Put Step 3 from convert back in...in fact, maybe use convert for
'convert, collect, and transfer....
'response.Write request.Form
iOID = Request.Form("OID")
iSourceAID = Request.Form("srcAID")
iTargetAssetID = Request.Form("tgtAssetID")
iAmount = Request.Form("Amount")
iConverterID = Request.Form("ConverterID")
%>

	<form action='../asp/collect.asp?Step=Final' method=post ID="Form1">
	<input type=hidden name=OID value='<%=iOID%>' ID="Hidden7">
	<input type=hidden name=srcAID value='<%=iSourceAID%>' ID="Hidden1">
	<input type=hidden name=converterID value='<%=iConverterID%>' ID="Hidden2">
	<input type=hidden name=Amount value='<%=iAmount%>' ID="Hidden3">
	<input type=hidden name=tgtAssetID value='<%=iTargetAssetID%>' ID="Hidden4">
<%
	'how long will it take?
	sSQL = "SELECT ConversionTime from Assets WHERE AssetID = " & _
			"(SELECT AssetID FROM Attributes WHERE OID = " & sPlayerObjectID & _
			" AND AType = 'Converter')"

	Set RS = ExecuteSQL(sSQL)
	If Not RS.EOF Then
		iTime = cInt(iAmount) * cSng(RS(0))
	End If
	
	If iTime > 0 Then
%>
	<input type=hidden name=Time value='<%=iTime%>' ID="Hidden6">
Collection will take <%=iTime%> seconds.<br>
	<input type=submit name=Commit value='Commit' ID="Submit1">
	</form>
<%	
	End If	
End If

If sStep = "Final" Then
'response.Write request.Form
iOID = Request.Form("OID")
iSourceAID = Request.Form("srcAID")
iTargetAssetID = Request.Form("tgtAssetID")
iAmount = Request.Form("Amount")
iConverterID = Request.Form("ConverterID")
iYield = Request.Form("Yield")
iTime = Request.Form("Time")

	'Figure out the Completion DateTimeStamp
	sCompletionTime = DateAdd("s", iTime, Now())

	'create or update the target attribute...
	sSQL = "SELECT AID from Attributes where OID = " & sPlayerObjectID & _
			" AND AssetID = " & iTargetAssetID

	Set RS = ExecuteSQL(sSQL)
	If Not RS.EOF Then
		iTargetAID = RS("AID")
	Else
		'have to create it...
		sSQL = "INSERT INTO Attributes (OID, AType, AValue, ASubValue, AssetID)" & _
				" SELECT " & iOID & ",'Resource', AssetName, 0, AssetID from Assets where AssetID = " & iTargetAssetID
		response.Write sSQL
		ExecuteUpdateSQL(sSQL)
		
		'Get the New AID
		sSQL = "SELECT AID from Attributes where OID = " & iOID  & _
				" and AssetID = " & iTargetAssetID
		response.Write sSQL
		Set RS2 = ExecuteSQL(sSQL)
		
		If Not RS2.EOF Then
			iTargetAID = RS2("AID")
		End If
	End If

	sSQL = "INSERT INTO Conversions" & _
			" (OID, SourceAttributeID, SourceResult," & _
			" TargetAttributeID, TargetResult," & _
			" CompletionTime) VALUES (" & _
			iOID & "," & iSourceAID & "," & iAmount & _
			"," & iTargetAID & "," & iYield & _
			",'" & sCompletionTime & "')"
		ExecuteUpdateSQL(sSQL)
		
	Response.Redirect("../asp/convert.asp?Step=1&OID=" & iOID & "&Converter=" & iConverterID)
	
End If

%>

</body>
</html>