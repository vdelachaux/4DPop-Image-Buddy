// ----------------------------------------------------
// Method : Méthode formulaire : Picture_Editor_Mac
// Created 08/12/06 by vdl
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_LONGINT:C283($Lon_Bottom; $Lon_Event; $Lon_Left; $Lon_Right; $Lon_Timer_Event_Event; $Lon_Top)
C_TEXT:C284($Txt_Path; $Txt_resourcesFoldrPath)

$Lon_Event:=Form event code:C388

Case of 
		//______________________________________________________
	: ($Lon_Event=On Load:K2:1)
		
		<>bSplitter_1:=0
		<>bSplitter_2:=0
		
		//Get & set splitter positions {
		preferences("spliter_1.get"; ->$Lon_Top)
		<>bSplitter_1:=Choose:C955($Lon_Top>155; $Lon_Top; $Lon_Top-155)
		
		//preferences ("spliter_2.get";->$Lon_Top)
		//<>bSplitter_2:=Choisir($Lon_Top>=461;$Lon_Top;461-$Lon_Top)
		//preferences ("spliter_2.get";-><>bSplitter_2)
		//}
		
		OBJECT SET FONT:C164(*; "@"; OBJECT Get font:C1069(*; ""))
		
		(OBJECT Get pointer:C1124(Object named:K67:5; "_Copyright"))->:=svg_Pic_copyright(env_Get_InfoPlist_Value("CFBundleDisplayName")+" v"+env_Get_InfoPlist_Value("CFBundleShortVersionString"))
		
		<>Lon_Timer_Event_Event:=-1
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($Lon_Event=On Resize:K2:27)
		SET TIMER:C645(0)
		
		BROWSER_FILL(-><>tLstb_Picture; -><>tPic_thumbnails)
		BROWSER_SELECTION("Redo")
		
		OBJECT GET COORDINATES:C663(<>Pic_display; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
		OBJECT SET VISIBLE:C603(<>Pic_display; ($Lon_Bottom-$Lon_Top)>=30)
		
		obj_CENTER("_spinner"; "list_thumbnails"; Vertically centered:K39:4+Horizontally centered:K39:1)
		obj_CENTER("NoPicture"; "list_thumbnails"; Vertically centered:K39:4+Horizontally centered:K39:1)
		obj_CENTER("h.anchor.1"; "preview"; Horizontally centered:K39:1)
		obj_CENTER("h.anchor.2"; "00_Splitter_Horizontal_2"; Vertically centered:K39:4)
		obj_CENTER("h.anchor.2"; "preview"; Horizontally centered:K39:1)
		
		<>Lon_Timer_Event_Event:=Choose:C955(<>Lon_Timer_Event_Event=0; -2; <>Lon_Timer_Event_Event)
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($Lon_Event=On Timer:K2:25)
		SET TIMER:C645(0)
		
		$Lon_Timer_Event_Event:=<>Lon_Timer_Event_Event
		<>Lon_Timer_Event_Event:=0
		
		Case of 
				
				//______________________________________________________
			: ($Lon_Timer_Event_Event=1)
				
				BROWSER_SELECTION("Unselect")
				LISTBOX DELETE COLUMN:C830(<>tLstb_Picture; 1; LISTBOX Get number of columns:C831(<>tLstb_Picture))
				GET LIST ITEM PARAMETER:C985(<>Lst_resources; *; "path"; $Txt_Path)
				BROWSER_HANDLER("ListPictures"; $Txt_Path)
				BROWSER_FILL(-><>tLstb_Picture; -><>tPic_thumbnails)
				<>Lon_Timer_Event_Event:=-2
				
				//______________________________________________________
			: ($Lon_Timer_Event_Event=-1)
				
				//Update interface according to splitter position {
				OBJECT GET COORDINATES:C663(<>bSplitter_1; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
				OBJECT SET VISIBLE:C603(*; "@_Menu"; $Lon_Top<=40)
				OBJECT SET VISIBLE:C603(*; "@_List"; $Lon_Top>40)
				
				OBJECT GET COORDINATES:C663(<>Pic_display; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
				OBJECT SET VISIBLE:C603(<>Pic_display; ($Lon_Bottom-$Lon_Top)>=30)
				//}
				
				DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_resources; "path"; $Txt_resourcesFoldrPath)
				BROWSER_HANDLER("ListPictures"; $Txt_resourcesFoldrPath)
				GOTO OBJECT:C206(<>Lst_resources)
				<>Lon_Timer_Event_Event:=-2
				
				//______________________________________________________
			: ($Lon_Timer_Event_Event=-2)
				
				BROWSER_FILL(-><>tLstb_Picture; -><>tPic_thumbnails)
				lstb_AUTOMATIC_SCROOLBARS(-><>tLstb_Picture)
				OBJECT SET VISIBLE:C603(*; "_spinner"; False:C215)
				BROWSER_SELECTION("Redo")
				
				//______________________________________________________
			Else 
				
				BROWSER_SELECTION("Redo")
				<>Lon_Timer_Event_Event:=-2
				
				//______________________________________________________
		End case 
		
		If (<>Lon_Timer_Event_Event#0)
			
			SET TIMER:C645(-1)
			
		End if 
		
		//______________________________________________________
	: ($Lon_Event=On Unload:K2:2)
		
		OBJECT GET COORDINATES:C663(<>bSplitter_1; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
		preferences("spliter_1.set"; ->$Lon_Top)
		OBJECT GET COORDINATES:C663(<>bSplitter_2; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
		preferences("spliter_2.set"; ->$Lon_Top)
		
		//______________________________________________________
	: ($Lon_Event=On Close Box:K2:21)
		
		CANCEL:C270
		
		//______________________________________________________
	Else 
		
		TRACE:C157
		
		//______________________________________________________
End case 

