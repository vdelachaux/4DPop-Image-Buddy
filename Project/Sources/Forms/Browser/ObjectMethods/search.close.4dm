<>Txt_SearchBox:=""
OBJECT SET VISIBLE:C603(Self:C308->; False:C215)

If (Size of array:C274(<>tTxt_File_Paths_Back)#Size of array:C274(<>tTxt_filePaths))
	
	COPY ARRAY:C226(<>tTxt_File_Paths_Back; <>tTxt_filePaths)
	COPY ARRAY:C226(<>tTxt_File_Names_Back; <>tTxt_fileNames)
	COPY ARRAY:C226(<>tPic_Thumbnails_Back; <>tPic_thumbnails)
	
	ARRAY LONGINT:C221(<>tLon_Selected; 0)
	
	LISTBOX DELETE COLUMN:C830(<>tLstb_Picture; 1; LISTBOX Get number of columns:C831(<>tLstb_Picture))
	<>Lon_File_Number:=Size of array:C274(<>tPic_thumbnails)
	
	//BROWSER_FILL (-><>tLstb_Picture;-><>tPic_thumbnails;<>kLon_Cellule_Width)
	BROWSER_FILL(-><>tLstb_Picture; -><>tPic_thumbnails)
	
	<>Lon_Timer_Event_Event:=-2
	SET TIMER:C645(-1)
	
End if 