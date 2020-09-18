// ----------------------------------------------------
// Method : Méthode objet :Picture_Editor_Mac.list_thumbnails
// Created 08/12/06 by vdl
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_BLOB:C604($Blb_Buffer)
C_LONGINT:C283($Lon_Colonne; $Lon_i; $Lon_Ligne; $Lon_Selected; $Lon_Size; $Lon_x)
C_TIME:C306($Gmt_File)
C_PICTURE:C286($Pic_Buffer)
C_TEXT:C284($Txt_Choice; $Txt_Dest_Path; $Txt_Extension; $Txt_File_Name; $Txt_Message; $Txt_Path)

//_O_C_STRING(16;$a16_Menu)
C_TEXT:C284($a16_Menu)

ARRAY LONGINT:C221($tLon_Selected; 0x0000)
COPY ARRAY:C226(<>tLon_Selected; $tLon_Selected)

LISTBOX GET CELL POSITION:C971(<>tLstb_Picture; $Lon_Colonne; $Lon_Ligne)
$Lon_Selected:=(LISTBOX Get number of columns:C831(<>tLstb_Picture)*($Lon_Ligne-1))+$Lon_Colonne

If ($Lon_Selected>0)\
 & ($Lon_Selected<=<>Lon_File_Number)
	
	If ($Lon_Selected<=Size of array:C274(<>tPic_thumbnails))
		
		$Txt_Path:=<>tTxt_filePaths{$Lon_Selected}
		
		Case of 
				
				//______________________________________________________
			: (Form event code:C388=On Begin Drag Over:K2:44)
				
				BROWSER_HANDLER("BeginDragOver"; $Txt_Path)
				
				//______________________________________________________
			Else 
				
				BROWSER_SELECTION
				
				Case of 
						
						//……………………………………………………………………………
					: (Form event code:C388=On Double Clicked:K2:5)
						
						OPEN URL:C673("file://"+$Txt_Path)
						
						//……………………………………………………………………………
					: (Contextual click:C713)
						
						BROWSER_MENUS("picture.list")
						
						//……………………………………………………………………………
				End case 
				
				//______________________________________________________
		End case 
	End if 
	
Else 
	
	BROWSER_SELECTION("Unselect")
	
End if 