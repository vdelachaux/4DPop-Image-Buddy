//%attributes = {"invisible":true,"executedOnServer":true}
// ----------------------------------------------------
// Method : server_CREATE_RESOURCES
// Created 28/05/08 by vdl
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_BLOB:C604(${1})

C_BLOB:C604($Blb_Buffer)
C_BOOLEAN:C305($Boo_Document)
C_LONGINT:C283($Lon_i; $Lon_Mode; $Lon_Offset; $Lon_Parameters)
C_TEXT:C284($kTxt_separator; $Txt_Folder; $Txt_Path; $Txt_Structure_Folder)

If (False:C215)
	C_BLOB:C604(server_CREATE_RESOURCES; ${1})
End if 

$Lon_Parameters:=Count parameters:C259

If ($Lon_Parameters>0)
	
	$Txt_Structure_Folder:=Get 4D folder:C485(Database folder:K5:14; *)
	$kTxt_separator:=$Txt_Structure_Folder[[Length:C16($Txt_Structure_Folder)]]
	
	For ($Lon_i; 1; $Lon_Parameters; 1)
		
		$Lon_Offset:=0
		
		BLOB PROPERTIES:C536(${$Lon_i}; $Lon_Mode)
		If ($Lon_Mode#Is not compressed:K22:11)
			EXPAND BLOB:C535(${$Lon_i})
		End if 
		
		BLOB TO VARIABLE:C533(${$Lon_i}; $Txt_Path; $Lon_Offset)
		
		If (OK=1)
			$Txt_Path:=Replace string:C233($Txt_Path; "/"; $kTxt_separator)
			$Txt_Path:=$Txt_Structure_Folder+$Txt_Path
			$Boo_Document:=($Txt_Path[[Length:C16($Txt_Path)]]#$kTxt_separator)
			If ($Boo_Document)
				BLOB TO VARIABLE:C533(${$Lon_i}; $Blb_Buffer; $Lon_Offset)
			End if 
		End if 
		
		If (OK=1)
			
			
			
			If (Test path name:C476($Txt_Path)=Is a document:K24:1)
				DELETE DOCUMENT:C159($Txt_Path)
			Else 
				If ($Boo_Document)
					$Txt_Folder:=doc_Txt_Path_Handler("get.parent.path"; $Txt_Path)
				Else 
					doc_Txt_Path_Handler("create.hierarchy"; $Txt_Path)
				End if 
			End if 
			
			If ((OK=1) & $Boo_Document)
				
				BLOB TO DOCUMENT:C526($Txt_Path; $Blb_Buffer)
				
			End if 
			
		End if 
		
	End for 
	
	NOTIFY RESOURCES FOLDER MODIFICATION:C1052
	
End if 



