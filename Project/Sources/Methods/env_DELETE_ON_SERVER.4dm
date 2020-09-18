//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : env_DELETE_ON_SERVER
// Created 20/06/08 by vdl
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($kTxt_Separator; $Txt_Path; $Txt_structureFolderPath)

If (False:C215)
	C_TEXT:C284(env_DELETE_ON_SERVER; $1)
End if 

$Txt_Path:=$1
$Txt_structureFolderPath:=Get 4D folder:C485(Database folder:K5:14; *)
$kTxt_Separator:=$Txt_structureFolderPath[[Length:C16($Txt_structureFolderPath)]]

//Convert path to relative
$Txt_Path:=Replace string:C233($Txt_Path; $Txt_structureFolderPath; ""; 1)

// Convert path to posix.
$Txt_Path:=Replace string:C233($Txt_Path; $kTxt_Separator; "/")

//Delete on server
server_DELETE_FILE($Txt_Path)

