C_BOOLEAN:C305($Boo_Update)
C_LONGINT:C283($Lon_Event; $Lon_x)
C_TEXT:C284($Txt_Buffer)

$Lon_Event:=Form event code:C388

Case of 
		//______________________________________________________
	: ($Lon_Event=On Getting Focus:K2:7)
		
		OBJECT SET VISIBLE:C603(*; "@.focus.@"; True:C214)
		OBJECT SET ENABLED:C1123(*; "Navig.@"; False:C215)
		
		If (Length:C16(Self:C308->)=0)
			
			COPY ARRAY:C226(<>tTxt_filePaths; <>tTxt_File_Paths_Back)
			COPY ARRAY:C226(<>tTxt_fileNames; <>tTxt_File_Names_Back)
			COPY ARRAY:C226(<>tPic_thumbnails; <>tPic_Thumbnails_Back)
			
			ARRAY TEXT:C222(<>tTxt_filePaths; 0)
			ARRAY TEXT:C222(<>tTxt_fileNames; 0)
			ARRAY PICTURE:C279(<>tPic_thumbnails; 0)
			
		End if 
		
		//______________________________________________________
	: ($Lon_Event=On Losing Focus:K2:8)
		
		OBJECT SET VISIBLE:C603(*; "@.focus.@"; False:C215)
		OBJECT SET ENABLED:C1123(*; "Navig.@"; True:C214)
		OBJECT SET VISIBLE:C603(*; "search.close"; Length:C16(Self:C308->)#0)
		
		//______________________________________________________
	: ($Lon_Event=On After Edit:K2:43)
		
		$Txt_Buffer:=Get edited text:C655
		$Boo_Update:=(Length:C16($Txt_Buffer)>0)
		OBJECT SET VISIBLE:C603(*; "search.close"; $Boo_Update)
		
		If ($Boo_Update)
			
			ARRAY TEXT:C222(<>tTxt_filePaths; 0)
			ARRAY TEXT:C222(<>tTxt_fileNames; 0)
			ARRAY PICTURE:C279(<>tPic_thumbnails; 0)
			
			Repeat 
				
				$Lon_x:=Find in array:C230(<>tTxt_File_Names_Back; "@"+$Txt_Buffer+"@"; $Lon_x+1)
				
				If ($Lon_x>0)
					
					APPEND TO ARRAY:C911(<>tTxt_filePaths; <>tTxt_File_Paths_Back{$Lon_x})
					APPEND TO ARRAY:C911(<>tTxt_fileNames; <>tTxt_File_Names_Back{$Lon_x})
					APPEND TO ARRAY:C911(<>tPic_thumbnails; <>tPic_Thumbnails_Back{$Lon_x})
					
				End if 
				
			Until ($Lon_x=-1)
			
		Else 
			
			$Boo_Update:=(Size of array:C274(<>tTxt_File_Paths_Back)#Size of array:C274(<>tTxt_filePaths))
			
			If ($Boo_Update)
				
				COPY ARRAY:C226(<>tTxt_File_Paths_Back; <>tTxt_filePaths)
				COPY ARRAY:C226(<>tTxt_File_Names_Back; <>tTxt_fileNames)
				COPY ARRAY:C226(<>tPic_Thumbnails_Back; <>tPic_thumbnails)
				
			End if 
			
		End if 
		
		If ($Boo_Update)
			
			ARRAY LONGINT:C221(<>tLon_Selected; 0)
			
			LISTBOX DELETE COLUMN:C830(<>tLstb_Picture; 1; LISTBOX Get number of columns:C831(<>tLstb_Picture))
			<>Lon_File_Number:=Size of array:C274(<>tPic_thumbnails)
			
			//BROWSER_FILL (-><>tLstb_Picture;-><>tPic_thumbnails;<>kLon_Cellule_Width)
			BROWSER_FILL(-><>tLstb_Picture; -><>tPic_thumbnails)
			
			<>Lon_Timer_Event_Event:=-2
			SET TIMER:C645(-1)
		End if 
		
		//______________________________________________________
End case 
