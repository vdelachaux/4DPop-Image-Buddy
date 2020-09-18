// ----------------------------------------------------
// Method : Méthode objet : Browser.◊Resource_List
// Created 10/01/08 by Vincent de Lachaux
// ----------------------------------------------------
// Modified by vdl (20/06/08)
// C/S update
// ----------------------------------------------------
C_LONGINT:C283($0)

C_BOOLEAN:C305($Boo_Update)
C_LONGINT:C283($Lon_Drop_Position; $Lon_Event; $Lon_Index; $Lon_Reference; $Lon_UID; $Lon_x)
C_PICTURE:C286($Pic_Buffer)
C_TEXT:C284($kTxt_Separator; $Txt_Buffer; $Txt_File_Name; $Txt_Folder_Dest; $Txt_Folder_Name; $Txt_Path_Source; $Txt_resourcesFoldrPath)


$0:=-1

$Lon_Event:=Form event code:C388
$kTxt_Separator:=Get 4D folder:C485[[Length:C16(Get 4D folder:C485)]]

Case of 
		//______________________________________________________
	: ($Lon_Event=On Clicked:K2:4) & (Contextual click:C713)
		BROWSER_MENUS("folder.list")
		//______________________________________________________
	: ($Lon_Event=On Getting Focus:K2:7)
		OBJECT SET ENABLED:C1123(*; "Navig.@"; False:C215)
		//______________________________________________________
	: ($Lon_Event=On Losing Focus:K2:8)
		OBJECT SET ENABLED:C1123(*; "Navig.@"; True:C214)
		
		//______________________________________________________
	: ($Lon_Event=On Selection Change:K2:29)
		
		GET LIST ITEM:C378(<>Lst_resources; *; $Lon_Reference; $Txt_Folder_Name)
		OBJECT SET TITLE:C194(*; "Folder_Menu"; $Txt_Folder_Name)
		BROWSER_HANDLER("update")
		SET TIMER:C645(0)
		SET TIMER:C645(5)
		
		//______________________________________________________
	: ($Lon_Event=On Drop:K2:12)
		
		$Lon_Drop_Position:=Drop position:C608
		
		//Get a path in the drag container
		$Txt_Path_Source:=Get file from pasteboard:C976(1)
		
		Case of 
				//______________________________________________________
			: (Length:C16($Txt_Path_Source)=0)  //No path : try an image
				
				If ($Lon_Drop_Position=-1)
					$Lon_Drop_Position:=1
				End if 
				
				ARRAY TEXT:C222($tTxt_4Dsignatures; 0x0000)
				ARRAY TEXT:C222($tTxt_nativeTypes; 0x0000)
				GET PASTEBOARD DATA TYPE:C958($tTxt_4Dsignatures; $tTxt_nativeTypes)
				
				If (Find in array:C230($tTxt_4Dsignatures; "com.4d.private.picture.4dpicture")>0)
					GET PICTURE FROM PASTEBOARD:C522($Pic_Buffer)
					
					If (OK=1)
						$Txt_File_Name:=Get localized string:C991("NewImage")
						$Txt_File_Name:=Request:C163(Get localized string:C991("Name"); $Txt_File_Name; Get localized string:C991("CommonCreate"))
						
						If (OK=1)
							GET LIST ITEM:C378(<>Lst_resources; $Lon_Drop_Position; $Lon_UID; $Txt_Buffer)
							GET LIST ITEM PARAMETER:C985(<>Lst_resources; $Lon_UID; "path"; $Txt_Folder_Dest)
							
							GET LIST ITEM PARAMETER:C985(<>Lst_resources; *; "path"; $Txt_Buffer)
							$Boo_Update:=($Txt_Buffer=$Txt_Folder_Dest)
							
							$Txt_Folder_Dest:=doc_Txt_Path_Handler("format.folder"; $Txt_Folder_Dest)
							$Txt_File_Name:=$Txt_Folder_Dest+doc_Txt_Path_Handler("set.extension"; $Txt_File_Name; "4pct")
							WRITE PICTURE FILE:C680($Txt_File_Name; $Pic_Buffer; ".4pct")
							
							// Added by vdl (20/06/08)
							//  C/S update
							// {
							If (OK=1)
								//Update the file on the server
								env_CREATE_ON_SERVER($Txt_File_Name)
							End if 
							//}
							
							If ($Boo_Update)
								BROWSER_HANDLER("update")
							End if 
						End if 
					End if 
					
				Else 
					BEEP:C151
					
				End if 
				//______________________________________________________
			: (Test path name:C476($Txt_Path_Source)=Is a folder:K24:2)
				
				$Txt_Folder_Name:=$Txt_Path_Source
				
				If ($Txt_Folder_Name[[Length:C16($Txt_Folder_Name)]]=$kTxt_Separator)
					$Txt_Folder_Name:=Substring:C12($Txt_Folder_Name; 1; Length:C16($Txt_Folder_Name)-1)
				End if 
				
				Repeat 
					$Lon_x:=Position:C15($kTxt_Separator; $Txt_Folder_Name)
					If ($Lon_x>0)
						$Txt_Folder_Name:=Delete string:C232($Txt_Folder_Name; 1; $Lon_x)
					End if 
				Until ($Lon_x=0)
				
				If ($Lon_Drop_Position=-1)
					APPEND TO LIST:C376(<>Lst_resources; $Txt_Folder_Name; <>Lon_UID+1; Browser_Lon_Folder_List($Txt_Path_Source; -><>Lon_UID; <>kPic_folderIcon); True:C214)
					SET LIST ITEM ICON:C950(<>Lst_resources; 0; <>kPic_folderIcon)
					SET LIST ITEM PARAMETER:C986(<>Lst_resources; 0; "path"; $Txt_Path_Source)
					
					SELECT LIST ITEMS BY POSITION:C381(<>Lst_resources; Count list items:C380(<>Lst_resources))
					
					BROWSER_HANDLER("update")
					
				End if 
				//______________________________________________________
			: (Test path name:C476($Txt_Path_Source)=Is a document:K24:1)
				
				If ($Lon_Drop_Position=-1)
					$Lon_Drop_Position:=1
				End if 
				
				GET LIST ITEM:C378(<>Lst_resources; $Lon_Drop_Position; $Lon_UID; $Txt_Buffer)
				GET LIST ITEM PARAMETER:C985(<>Lst_resources; $Lon_UID; "path"; $Txt_Folder_Dest)
				
				GET LIST ITEM PARAMETER:C985(<>Lst_resources; *; "path"; $Txt_Buffer)
				$Boo_Update:=($Txt_Buffer=$Txt_Folder_Dest)
				
				DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_resources; "path"; $Txt_resourcesFoldrPath)
				If ($Txt_Folder_Dest=($Txt_resourcesFoldrPath+"@"))
					
					If ($Txt_Folder_Dest[[Length:C16($Txt_Folder_Dest)]]#$kTxt_Separator)
						$Txt_Folder_Dest:=$Txt_Folder_Dest+$kTxt_Separator
					End if 
					
					$Lon_Index:=1
					
					Repeat 
						
						ON ERR CALL:C155("No_Error")
						READ PICTURE FILE:C678($Txt_Path_Source; $Pic_Buffer)
						ON ERR CALL:C155("")
						
						If (OK=1)
							$Txt_File_Name:=$Txt_Path_Source
							
							If ($Txt_File_Name[[Length:C16($Txt_File_Name)]]=$kTxt_Separator)
								$Txt_File_Name:=Substring:C12($Txt_File_Name; 1; Length:C16($Txt_File_Name)-1)
							End if 
							
							Repeat 
								$Lon_x:=Position:C15($kTxt_Separator; $Txt_File_Name)
								If ($Lon_x>0)
									$Txt_File_Name:=Delete string:C232($Txt_File_Name; 1; $Lon_x)
								End if 
							Until ($Lon_x=0)
							
							COPY DOCUMENT:C541($Txt_Path_Source; $Txt_Folder_Dest+$Txt_File_Name; *)
							
							// Added by vdl (20/06/08)
							//  C/S update
							// {
							If (OK=1)
								//Update the file on the server
								env_CREATE_ON_SERVER($Txt_Folder_Dest+$Txt_File_Name)
							End if 
							//}
							
						End if 
						
						$Lon_Index:=$Lon_Index+1
						$Txt_Path_Source:=Get file from pasteboard:C976($Lon_Index)
						
					Until ($Txt_Path_Source="")
					
					If ($Boo_Update)
						BROWSER_HANDLER("update")
					End if 
					
				End if 
				//______________________________________________________
		End case 
		
		SET CURSOR:C469
		//______________________________________________________
	: ($Lon_Event=On Drag Over:K2:13)
		$Txt_Path_Source:=Get file from pasteboard:C976(1)
		If ($Txt_Path_Source="")
			GET PICTURE FROM PASTEBOARD:C522($Pic_Buffer)
			If (Picture size:C356($Pic_Buffer)>0)
				$0:=0
			End if 
		Else 
			$0:=0
		End if 
		//______________________________________________________
End case 
