//%attributes = {"invisible":true,"executedOnServer":true}
// ----------------------------------------------------
// Method : server_DELETE_FILE
// Created 20/06/08 by vdl
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($Txt_Path; $Txt_Separator; $Txt_Structure_Folder)

If (False:C215)
	C_TEXT:C284(server_DELETE_FILE; $1)
End if 

$Txt_Path:=$1
$Txt_Structure_Folder:=Get 4D folder:C485(Database folder:K5:14; *)
$Txt_Separator:=$Txt_Structure_Folder[[Length:C16($Txt_Structure_Folder)]]
$Txt_Path:=Replace string:C233($Txt_Path; "/"; $Txt_Separator)
$Txt_Path:=$Txt_Structure_Folder+$Txt_Path

If (Test path name:C476($Txt_Path)=Is a document:K24:1)
	DELETE DOCUMENT:C159($Txt_Path)
End if 

