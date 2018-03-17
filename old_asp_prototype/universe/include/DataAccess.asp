<%
'---------------------------------------
' This section is a subset of the MS ADO
' include file ADOVBS.INC that is way too big.
' Copy any needed defines from the ADOVBS.INC
' file and add them here!
'---------------------------------------
'==== Begin of ADOVBS.INC subset ====

'---- CursorLocationEnum Values ----
Const adUseServer = 2
Const adUseClient = 3

'---- CursorTypeEnum Values ----
Const adOpenForwardOnly = 0
Const adOpenKeyset = 1
Const adOpenDynamic = 2
Const adOpenStatic = 3

'---- LockTypeEnum Values ----
Const adLockReadOnly = 1
Const adLockPessimistic = 2
Const adLockOptimistic = 3
Const adLockBatchOptimistic = 4

'---- AffectEnum Values ----
Const adAffectCurrent = 1
Const adAffectGroup = 2
Const adAffectAllChapters = 4

'---- CommandTypeEnum Values ----
Const adCmdUnknown = &H0008
Const adCmdText = &H0001
Const adCmdTable = &H0002
Const adCmdStoredProc = &H0004
Const adCmdFile = &H0100
Const adCmdTableDirect = &H0200

'---- ExecuteOptionEnum Values ----
Const adAsyncExecute = &H00000010
Const adAsyncFetch = &H00000020
Const adAsyncFetchNonBlocking = &H00000040
Const adExecuteNoRecords = &H00000080
Const adExecuteStream = &H00000400

'==== End of ADOVBS.INC subset ====

'---------------------------------------
Function GetDSN()
GetDSN = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
              "Data Source=" & Server.MapPath("..\data\universe.mdb") & ";" & _
              "User Id=admin;" & _
              "Password="

'	GetDSN = "DSN=universe"

' Sample other possibilities...
'	GetDSN = "dsn=CustomerADO;uid=Customeruser;pwd=spot;database=CustomerStuff;"
'	GetDSN = "Provider=MSDASQL.1;Extended Properties=''DSN=corona;DBQ=D:\Dev\Platform\Web\Data\corona.mdb;DriverId=25;FIL=MS Access;MaxBufferSize=2048;PageTimeout=5;"
End Function

'---------------------------------------
Function ExecuteSQL(strSQL) '// Read Only, Forward Only...

	Dim RS
	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.ActiveConnection = GetDSN()
	RS.CursorLocation = adUseServer  '// or adUseClient
	RS.CursorType = adOpenForwardOnly
	RS.LockType = adLockReadOnly
	RS.Source = strSQL
	RS.Open

	Set ExecuteSQL = RS
End Function

'---------------------------------------
Function ExecuteScrollSQL(strSQL) '// Read Only, Scrollable...

	Dim RS

	Set RS = Server.CreateObject("ADODB.Recordset")
'	RS.ActiveConnection = MyConn
	RS.ActiveConnection = GetDSN()
	RS.CursorLocation = adUseServer  '// or adUseClient
	RS.CursorType = adOpenKeyset
	RS.LockType = adLockReadOnly
'	RS.AbsolutePosition = varPosition
	RS.Source = strSQL
	RS.Open

	Set ExecuteScrollSQL = RS
End Function

'---------------------------------------
Function ExecuteUpdateSQL(strSQL) '// Update, Dynamic Scroll...

	Dim RS

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.ActiveConnection = GetDSN()
	RS.CursorLocation = adUseServer  '// or adUseClient
	RS.CursorType = adOpenDynamic
	RS.LockType = adLockBatchOptimistic
	RS.Source = strSQL
	RS.Open

	Set ExecuteUpdateSQL = RS
End Function

'---------------------------------------
Function ExecuteBatchSQL(strSQL) '// Update, No recordset returned!...

	Dim RS

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.ActiveConnection = GetDSN()
	RS.CursorLocation = adUseServer  '// or adUseClient
	RS.CursorType = adOpenDynamic
	RS.LockType = adLockBatchOptimistic
	RS.Source = strSQL
	RS.Open

	Set RS = Nothing

End Function

%>

