C_LONGINT:C283($Lon_i; $Lon_Size)
C_TEXT:C284($Txt_Message; $Txt_Path)

$Lon_Size:=Size of array:C274(<>tLon_Selected)

If ($Lon_Size>0)
	If ($Lon_Size=1)
		$Txt_Message:=Replace string:C233(Get localized string:C991("DeleteFile"); "{name}"; <>tTxt_fileNames{<>tLon_Selected})
	Else 
		$Txt_Message:=Replace string:C233(Get localized string:C991("DeleteFiles"); "{number}"; String:C10($Lon_Size))
	End if 
	CONFIRM:C162($Txt_Message; Get localized string:C991("CommonDelete"))
	If (OK=1)
		For ($Lon_i; 1; $Lon_Size; 1)
			$Txt_Path:=<>tTxt_filePaths{<>tLon_Selected{$Lon_i}}
			If (Test path name:C476($Txt_Path)=Is a document:K24:1)
				DELETE DOCUMENT:C159($Txt_Path)
			End if 
		End for 
		BROWSER_HANDLER("update")
	End if 
End if 
