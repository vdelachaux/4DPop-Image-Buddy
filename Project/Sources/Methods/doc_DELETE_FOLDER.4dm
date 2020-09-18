//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : doc_DELETE_FOLDER
// Created 12/01/08 by Vincent
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($Lon_i)
C_TEXT:C284($kTxt_Separator; $Txt_Path)

ARRAY TEXT:C222($tTxt_Files; 0)
ARRAY TEXT:C222($tTxt_Folders; 0)

If (False:C215)
	C_TEXT:C284(doc_DELETE_FOLDER; $1)
End if 

$Txt_Path:=$1
$kTxt_Separator:=Get 4D folder:C485[[Length:C16(Get 4D folder:C485)]]

If ($Txt_Path[[Length:C16($Txt_Path)]]#$kTxt_Separator)
	$Txt_Path:=$Txt_Path+$kTxt_Separator
End if 

If (Test path name:C476($Txt_Path)=Is a folder:K24:2)
	
	DOCUMENT LIST:C474($Txt_Path; $tTxt_Files)
	
	For ($Lon_i; 1; Size of array:C274($tTxt_Files); 1)
		DELETE DOCUMENT:C159($Txt_Path+$tTxt_Files{$Lon_i})
		If (OK=0)
			$Lon_i:=MAXLONG:K35:2-1
		End if 
	End for 
	
	FOLDER LIST:C473($Txt_Path; $tTxt_Folders)
	
	For ($Lon_i; 1; Size of array:C274($tTxt_Folders); 1)
		doc_DELETE_FOLDER($Txt_Path+$tTxt_Folders{$Lon_i})
		If (OK=0)
			$Lon_i:=MAXLONG:K35:2-1
		End if 
	End for 
	
	If (OK=1)
		DELETE FOLDER:C693($Txt_Path)
	End if 
	
End if 
