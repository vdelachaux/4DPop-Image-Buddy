//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : BROWSER_MENUS
// Created 14/01/08 by Vincent de Lachaux
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_expanded; $Boo_remote; $Boo_Replace)
C_LONGINT:C283($kLon_celluleWidth; $kLon_offset; $kLon_Thumbnail_Width; $Lon_bottom; $Lon_column; $Lon_count; $Lon_countPictures; $Lon_i; $Lon_left; $Lon_line)
C_LONGINT:C283($Lon_platform; $Lon_reference; $Lon_right; $Lon_selected; $Lon_top; $Lon_x; $Lst_sublist)
C_TIME:C306($Gmt_resources)
C_PICTURE:C286($Pic_buffer; $Pic_Cellule; $Pic_title)
C_TEXT:C284($Mnu_choice; $Mnu_main; $Txt_element; $Txt_entryPoint; $Txt_extension; $Txt_fileName; $Txt_folderName; $Txt_index; $Txt_message; $Txt_name)
C_TEXT:C284($Txt_parentPath; $Txt_path; $Txt_targetPath)

ARRAY LONGINT:C221($tLon_IDs; 0)
ARRAY TEXT:C222($tTxt_names; 0)

If (False:C215)
	C_TEXT:C284(BROWSER_MENUS; $1)
End if 

$Txt_entryPoint:=$1

DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_thumb; "cellule-width"; $kLon_celluleWidth)
DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_thumb; "thumb-width"; $kLon_Thumbnail_Width)
DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_thumb; "offset"; $kLon_offset)
DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_resources; "remote"; $Boo_remote)

$Mnu_main:=Create menu:C408

Case of 
		
		//______________________________________________________
	: ($Txt_entryPoint="picture.list")
		
		ARRAY LONGINT:C221($tLon_selected; 0x0000)
		COPY ARRAY:C226(<>tLon_Selected; $tLon_selected)
		
		LISTBOX GET CELL POSITION:C971(<>tLstb_Picture; $Lon_column; $Lon_line)
		$Lon_selected:=(LISTBOX Get number of columns:C831(<>tLstb_Picture)*($Lon_line-1))+$Lon_column
		$Txt_path:=<>tTxt_filePaths{$Lon_selected}
		
		If (Size of array:C274($tLon_selected)=1)
			
			APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonOpen"))
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "picture.open")
			
			APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonRename")+"...")
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "picture.rename")
			
			APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonDuplicate"))
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "picture.duplicate")
			
			mnu_APPEND_SEPARATION_LINE($Mnu_main)
			
			APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonMenuItemCopy"))
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "picture.copy")
			
			mnu_APPEND_SEPARATION_LINE($Mnu_main)
			
			APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("Convert")+"…")
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "picture.Transform")
			
		End if 
		
		//AJOUTER LIGNE MENU($a16_Menu;Lire traduction chaine("CommonMenuItemPaste"))
		//FIXER REFERENCE LIGNE MENU($a16_Menu;-1;"picture.paste")
		//Si (Lire fichier dans conteneur(1)="")
		//LIRE IMAGE DANS CONTENEUR($Pic_Buffer)
		//Si (OK=0)
		//INACTIVER LIGNE MENU($a16_Menu;-1)
		//Fin de si
		//Fin de si
		
		If (False:C215)
			
			If (Size of array:C274($tLon_selected)=1)
				
				APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("Transparency"))
				
				If ($Boo_remote)
					
					DISABLE MENU ITEM:C150($Mnu_main; -1)
					
				Else 
					
					SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "picture.transparency")
					
				End if 
			End if 
		End if 
		
		If (Size of array:C274($tLon_selected)>0)
			
			mnu_APPEND_SEPARATION_LINE($Mnu_main)
			
			APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonDelete"))
			//Si (◊Boo_Remote_Mode)
			//INACTIVER LIGNE MENU($a16_Menu;-1)
			//Sinon
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "picture.delete")
			//Fin de si
		End if 
		
		//______________________________________________________
	: ($Txt_entryPoint="action")
		
		$Lon_selected:=Selected list items:C379(<>Lst_resources)
		$Lon_selected:=Choose:C955($Lon_selected=0; 1; $Lon_selected)
		
		GET LIST ITEM:C378(<>Lst_resources; $Lon_selected; $Lon_reference; $Txt_element; $Lst_sublist; $Boo_expanded)
		GET LIST ITEM PARAMETER:C985(<>Lst_resources; $Lon_reference; "path"; $Txt_path)
		
		APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("ImportPICTResourcesFromFile"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "import.PICT")
		
		If ($Boo_remote)
			
			DISABLE MENU ITEM:C150($Mnu_main; -1)
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("ImportCicnResourcesFromFile"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "import.cicn")
		If ($Boo_remote)
			
			DISABLE MENU ITEM:C150($Mnu_main; -1)
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("ImportFromPictureLibrary"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "import.library")
		
		If ($Boo_remote)
			
			DISABLE MENU ITEM:C150($Mnu_main; -1)
			
		Else 
			
			PICTURE LIBRARY LIST:C564($tLon_IDs; $tTxt_names)
			
			If (Size of array:C274($tLon_IDs)=0)
				
				DISABLE MENU ITEM:C150($Mnu_main; -1)
				
			End if 
		End if 
		
		//______________________________________________________
	: ($Txt_entryPoint="folder.list")
		
		$Lon_selected:=Selected list items:C379(<>Lst_resources)
		$Lon_selected:=Choose:C955($Lon_selected=0; 1; $Lon_selected)
		
		GET LIST ITEM:C378(<>Lst_resources; $Lon_selected; $Lon_reference; $Txt_element; $Lst_sublist; $Boo_expanded)
		GET LIST ITEM PARAMETER:C985(<>Lst_resources; $Lon_reference; "path"; $Txt_path)
		
		APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("NewFolder")+"…")
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "folder.add")
		
		If ($Lon_selected>0)
			
			If (Not:C34($Boo_remote))
				
				If ($Lon_reference#1)
					
					mnu_APPEND_SEPARATION_LINE($Mnu_main)
					APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonRename")+"...")
					SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "folder.rename")
					
					APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonDuplicate"))
					SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "folder.duplicate")
					
					mnu_APPEND_SEPARATION_LINE($Mnu_main)
					APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonDelete"))
					SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "folder.delete")
					
				End if 
				
				mnu_APPEND_SEPARATION_LINE($Mnu_main)
				APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("ShowOnDisk"))
				SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "folder.open")
				
				mnu_APPEND_SEPARATION_LINE($Mnu_main)
				APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("ImportPICTResourcesFromFile"))
				SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "import.PICT")
				
				APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("ImportCicnResourcesFromFile"))
				SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "import.cicn")
				
				PICTURE LIBRARY LIST:C564($tLon_IDs; $tTxt_names)
				
				If (Size of array:C274($tLon_IDs)>0)
					
					APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("ImportFromPictureLibrary"))
					SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "import.library")
					
				End if 
			End if 
			
			mnu_APPEND_SEPARATION_LINE($Mnu_main)
			APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonRefresh"))
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "folder.refresh")
			
		End if 
		
		//______________________________________________________
	Else 
		
		TRACE:C157
		
		//______________________________________________________
End case 

If (Count menu items:C405($Mnu_main)>0)
	
	$Mnu_choice:=Dynamic pop up menu:C1006($Mnu_main)
	
	Case of 
			//______________________________________________________
		: (Length:C16($Mnu_choice)=0)
			
			//nothing more to do
			
			//______________________________________________________
		: ($Mnu_choice="import.library")
			
			OBJECT GET COORDINATES:C663(*; "list_thumbnails"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
			OBJECT SET VISIBLE:C603(*; "_spinner"; ($Lon_bottom-$Lon_top)>15)
			
			$Txt_path:=doc_Txt_Path_Handler("format.folder"; $Txt_path)
			ARRAY TEXT:C222($tTxt_import; 0x0000)
			
			$Lon_countPictures:=Size of array:C274($tLon_IDs)
			
			For ($Lon_i; 1; $Lon_countPictures; 1)
				GET PICTURE FROM LIBRARY:C565($tLon_IDs{$Lon_i}; $Pic_buffer)
				If (OK=1)
					$Txt_name:=$tTxt_names{$Lon_i}
					$Txt_name:=doc_Txt_Path_Handler("format.filename"; $Txt_name)
					
					If (Length:C16($Txt_name)=0)
						
						$Txt_name:="PictLib_"+String:C10($tLon_IDs{$Lon_i})
						
					End if 
					
					Repeat 
						
						$Lon_x:=Find in array:C230($tTxt_names; $Txt_name; $Lon_x+1)
						$Lon_count:=$Lon_count+Num:C11(($Lon_x>0) & ($Lon_x<$Lon_i))
						
					Until ($Lon_x=$Lon_i) | ($Lon_x=-1)
					
					If ($Lon_count>0)
						$Txt_name:=$Txt_name+"_"+String:C10($Lon_count)
					End if 
					
					$Txt_index:=""
					Repeat 
						$Lon_x:=Find in array:C230($tTxt_import; $Txt_name+$Txt_index+".png")
						If ($Lon_x>0)
							$Txt_index:=String:C10(Num:C11($Txt_index)+1)
						Else 
							$Txt_name:=$Txt_name+$Txt_index+".png"
						End if 
					Until ($Lon_x<0)
					
					WRITE PICTURE FILE:C680($Txt_path+$Txt_name; $Pic_buffer; ".png")
					If (OK=1)
						APPEND TO ARRAY:C911($tTxt_import; $Txt_name)
					End if 
					
				End if 
			End for 
			
			BROWSER_HANDLER("update")
			
			//______________________________________________________
		: ($Mnu_choice="import.@")
			
			$Gmt_resources:=Open resource file:C497("")
			
			If (OK=1)
				
				$Mnu_choice:=Replace string:C233($Mnu_choice; "import."; "")
				RESOURCE LIST:C500($Mnu_choice; $tLon_IDs; $tTxt_names; $Gmt_resources)
				
				If (OK=1)
					
					$Lon_countPictures:=Size of array:C274($tLon_IDs)
					
					If ($Lon_countPictures>0)
						
						CONFIRM:C162(\
							Replace string:C233(\
							Replace string:C233(\
							Get localized string:C991("YouWantToImport"); \
							"{ImageNumber}"; String:C10($Lon_countPictures)); \
							"{destFolder}"; doc_Txt_Path_Handler("get.name"; $Txt_path)))
						
						If (OK=1)
							
							OBJECT GET COORDINATES:C663(*; "list_thumbnails"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
							OBJECT SET VISIBLE:C603(*; "_spinner"; ($Lon_bottom-$Lon_top)>15)
							
							$Txt_path:=doc_Txt_Path_Handler("format.folder"; $Txt_path)
							ARRAY TEXT:C222($tTxt_import; 0x0000)
							
							For ($Lon_i; 1; $Lon_countPictures; 1)
								
								CLEAR VARIABLE:C89($Lon_count)
								CLEAR VARIABLE:C89($Txt_index)
								
								If ($Mnu_choice="PICT")
									
									GET PICTURE RESOURCE:C502($tLon_IDs{$Lon_i}; $Pic_buffer; $Gmt_resources)
									
								Else 
									
									GET ICON RESOURCE:C517($tLon_IDs{$Lon_i}; $Pic_buffer; $Gmt_resources)
									
								End if 
								
								If (OK=1)
									
									$Txt_name:=Get resource name:C513($Mnu_choice; $tLon_IDs{$Lon_i}; $Gmt_resources)
									
									$Txt_name:=doc_Txt_Path_Handler("format.filename"; $Txt_name)
									
									If (Length:C16($Txt_name)=0)
										
										$Txt_name:=$Mnu_choice+"_"+String:C10($tLon_IDs{$Lon_i})
										
									End if 
									
									Repeat 
										
										$Lon_x:=Find in array:C230($tTxt_names; $Txt_name; $Lon_x+1)
										$Lon_count:=$Lon_count+Num:C11(($Lon_x>0) & ($Lon_x<$Lon_i))
										
									Until ($Lon_x=$Lon_i) | ($Lon_x=-1)
									
									If ($Lon_count>0)
										
										$Txt_name:=$Txt_name+"_"+String:C10($Lon_count)
										
									End if 
									
									Repeat 
										
										$Lon_x:=Find in array:C230($tTxt_import; $Txt_name+$Txt_index+".png")
										
										If ($Lon_x>0)
											
											$Txt_index:=String:C10(Num:C11($Txt_index)+1)
											
										Else 
											
											$Txt_name:=$Txt_name+$Txt_index+".png"
											
										End if 
										
									Until ($Lon_x<0)
									
									WRITE PICTURE FILE:C680($Txt_path+$Txt_name; $Pic_buffer; ".png")
									
									If (OK=1)
										
										APPEND TO ARRAY:C911($tTxt_import; $Txt_name)
										
									End if 
									
								Else 
									
									TRACE:C157  //Error
									
								End if 
								
							End for 
							
							BROWSER_HANDLER("update")
							
						Else 
							
							//Escape
							
						End if 
						
					Else 
						
						//No PICT resources
						
					End if 
					
					CLOSE RESOURCE FILE:C498($Gmt_resources)
					
				Else 
					
					TRACE:C157  //Error
					
				End if 
				
			Else 
				
				//Escaped
				
			End if 
			
			//______________________________________________________
		: ($Mnu_choice="picture.open")
			
			//OUVRIR URL WEB("file://"+$Txt_Path)
			_O_PLATFORM PROPERTIES:C365($Lon_platform)
			
			If ($Lon_platform=Windows:K25:3)
				
				OPEN URL:C673(Replace string:C233($Txt_path; "file://"; ""))
				
			Else 
				
				LAUNCH EXTERNAL PROCESS:C811("open "+POSIX_Path(Replace string:C233($Txt_path; "file://"; "")))
				
			End if 
			
			//______________________________________________________
		: ($Mnu_choice="picture.delete")
			
			$Lon_count:=Size of array:C274($tLon_selected)
			
			If ($Lon_count=1)
				
				$Txt_message:=Replace string:C233(Get localized string:C991("DeleteFile"); "{name}"; <>tTxt_fileNames{$Lon_selected})
				
			Else 
				
				$Txt_message:=Replace string:C233(Get localized string:C991("DeleteFiles"); "{number}"; String:C10($Lon_count))
				
			End if 
			
			CONFIRM:C162($Txt_message; Get localized string:C991("CommonDelete"))
			
			If (OK=1)
				
				For ($Lon_i; 1; $Lon_count; 1)
					
					$Txt_path:=<>tTxt_filePaths{$tLon_selected{$Lon_i}}
					
					If (Test path name:C476($Txt_path)=Is a document:K24:1)
						
						DELETE DOCUMENT:C159($Txt_path)
						
						// Added by vdl (20/06/08)
						//  C/S update {
						If (OK=1)
							
							env_DELETE_ON_SERVER($Txt_path)
							
						End if 
						//}
						
					End if 
					
				End for 
				
				BROWSER_HANDLER("update")
				
			End if 
			
			//______________________________________________________
		: ($Mnu_choice="picture.duplicate")
			
			$Txt_extension:=doc_Txt_Path_Handler("get.extensions"; <>tTxt_fileNames{$Lon_selected})
			
			Repeat 
				
				$Txt_fileName:=Replace string:C233(<>tTxt_fileNames{$Lon_selected}; "."+$Txt_extension; "")
				$Txt_fileName:=$Txt_fileName+Get localized string:C991("BrowserCopy")+String:C10($Lon_x; " ##); ##);)")
				$Txt_fileName:=doc_Txt_Path_Handler("set.extension"; $Txt_fileName; $Txt_extension)
				$Txt_targetPath:=Replace string:C233($Txt_path; <>tTxt_fileNames{$Lon_selected}; $Txt_fileName)
				$Lon_x:=$Lon_x+1
				
			Until (Test path name:C476($Txt_targetPath)#Is a document:K24:1)
			
			COPY DOCUMENT:C541($Txt_path; $Txt_targetPath)
			
			// Added by vdl (20/06/08)
			//  C/S update {
			If (OK=1)
				
				env_CREATE_ON_SERVER($Txt_targetPath)
				
			End if 
			//}
			
			If (OK=1)
				
				BROWSER_HANDLER("update")
				
			End if 
			
			//______________________________________________________
		: ($Mnu_choice="picture.rename")
			
			$Txt_extension:=doc_Txt_Path_Handler("get.extensions"; <>tTxt_fileNames{$Lon_selected})
			
			$Txt_fileName:=Request:C163(Get localized string:C991("Name"); <>tTxt_fileNames{$Lon_selected}; Get localized string:C991("CommonRename"))
			
			If (OK=1)
				
				$Txt_fileName:=doc_Txt_Path_Handler("set.extension"; $Txt_fileName; $Txt_extension)
				$Txt_targetPath:=doc_Txt_Path_Handler("get.parent.path"; $Txt_path)+$Txt_fileName
				
				MOVE DOCUMENT:C540($Txt_path; $Txt_targetPath)
				
				If (OK=1)
					
					// Added by vdl (20/06/08)
					//  C/S update {
					If (OK=1)
						
						env_CREATE_ON_SERVER($Txt_targetPath)
						env_DELETE_ON_SERVER($Txt_path)
						
					End if 
					//}
					
					<>tTxt_filePaths{$Lon_selected}:=Replace string:C233(<>tTxt_filePaths{$Lon_selected}; <>tTxt_fileNames{$Lon_selected}; $Txt_fileName)
					<>tTxt_fileNames{$Lon_selected}:=$Txt_fileName
					<>Txt_pictureName:=$Txt_fileName
					<>Txt_pictureName:=<>Txt_fileName
					
					//=======================================================================
					If (Length:C16($Txt_fileName)>14)
						
						$Txt_fileName:=Substring:C12($Txt_fileName; 1; 13)+"\r"+Substring:C12($Txt_fileName; 14)
						
					End if 
					
					$Pic_title:=svg_Pic_DrawText($Txt_fileName; 10; ""; 0; $kLon_Thumbnail_Width; 24; ""; 0; 10; Align center:K42:3; 0; 0)
					READ PICTURE FILE:C678(<>tTxt_filePaths{$Lon_selected}; <>tPic_thumbnails{$Lon_selected})
					CREATE THUMBNAIL:C679(<>tPic_thumbnails{$Lon_selected}; <>tPic_thumbnails{$Lon_selected}; $kLon_Thumbnail_Width-$kLon_offset; $kLon_Thumbnail_Width-$kLon_offset; Scaled to fit prop centered:K6:6)
					
					COMBINE PICTURES:C987($Pic_Cellule; <>kPic_Cellule; Superimposition:K61:10; $Pic_title; 0; $kLon_celluleWidth-$kLon_offset-20)
					COMBINE PICTURES:C987(<>tPic_thumbnails{$Lon_selected}; $Pic_Cellule; Superimposition:K61:10; <>tPic_thumbnails{$Lon_selected}; $kLon_offset; $kLon_offset)
					CONVERT PICTURE:C1002(<>tPic_thumbnails{$Lon_selected}; ".png")
					//=======================================================================
					
					BROWSER_SELECTION("Redo")
					
				End if 
			End if 
			
			//______________________________________________________
		: ($Mnu_choice="picture.copy")
			
			SET FILE TO PASTEBOARD:C975($Txt_path)
			
			//______________________________________________________
		: ($Mnu_choice="picture.Transform")
			
			<>Txt_fileName:=<>tTxt_fileNames{$Lon_selected}
			<>Pic_display:=(OBJECT Get pointer:C1124(Object named:K67:5; "preview"))->
			
			$Lon_x:=Open form window:C675("Transform"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4; *)
			DIALOG:C40("Transform")
			CLOSE WINDOW:C154
			
			If (OK=1)
				
				BROWSER_HANDLER("Transform")
				
				$Txt_path:=Replace string:C233(<>tTxt_filePaths{$Lon_selected}; <>tTxt_fileNames{$Lon_selected}; <>Txt_fileName)
				$Boo_Replace:=(Test path name:C476($Txt_path)=Is a document:K24:1)
				
				If ($Boo_Replace)
					
					CONFIRM:C162(Get localized string:C991("AFileWithThisNameAlreadyExist"))
					
					If (OK=1)
						
						DELETE DOCUMENT:C159($Txt_path)
						
					End if 
					
				Else 
					
					OK:=1
					
				End if 
				
				If (OK=1)
					
					WRITE PICTURE FILE:C680($Txt_path; <>Pic_Preview; <>tTxt_Codecs{<>tTxt_Names})
					
					// Added by vdl (20/06/08)
					//  C/S update {
					If (OK=1)
						
						env_DELETE_ON_SERVER($Txt_path)
						env_CREATE_ON_SERVER($Txt_path)
						
					End if 
					//}
					
					If ($Boo_Replace)
						
						<>tTxt_fileNames{$Lon_selected}:=<>Txt_fileName
						<>tTxt_filePaths{$Lon_selected}:=$Txt_path
						<>Txt_pictureName:=<>Txt_fileName
						
						<>tPic_thumbnails{$Lon_selected}:=<>Pic_Preview
						$Txt_fileName:=<>Txt_fileName
						
						//=======================================================================
						If (Length:C16($Txt_fileName)>14)
							
							$Txt_fileName:=Substring:C12($Txt_fileName; 1; 13)+"\r"+Substring:C12($Txt_fileName; 14)
							
						End if 
						
						$Pic_title:=svg_Pic_DrawText($Txt_fileName; 10; ""; 0; $kLon_Thumbnail_Width; 24; ""; 0; 10; Align center:K42:3; 0; 0)
						READ PICTURE FILE:C678(<>tTxt_filePaths{$Lon_selected}; <>tPic_thumbnails{$Lon_selected})
						CREATE THUMBNAIL:C679(<>tPic_thumbnails{$Lon_selected}; <>tPic_thumbnails{$Lon_selected}; $kLon_Thumbnail_Width-$kLon_offset; $kLon_Thumbnail_Width-$kLon_offset; Scaled to fit prop centered:K6:6)
						
						COMBINE PICTURES:C987($Pic_Cellule; <>kPic_Cellule; Superimposition:K61:10; $Pic_title; 0; $kLon_celluleWidth-$kLon_offset-20)
						COMBINE PICTURES:C987(<>tPic_thumbnails{$Lon_selected}; $Pic_Cellule; Superimposition:K61:10; <>tPic_thumbnails{$Lon_selected}; $kLon_offset; $kLon_offset)
						CONVERT PICTURE:C1002(<>tPic_thumbnails{$Lon_selected}; ".png")
						//=======================================================================
						
					Else 
						
						BROWSER_HANDLER("update")
						
					End if 
				End if 
				
				BROWSER_SELECTION("Redo")
				
			End if 
			
			//______________________________________________________
		: ($Mnu_choice="picture.transparency")
			
			//$Txt_Path:=Dossier temporaire+Chaine(Nombre de millisecondes)
			//$Gmt_File:=Creer fichier ressources($Txt_Path)
			//Si (OK=1)
			//  //$Pic_Buffer:=<>Pic_Display
			//$Pic_Buffer:=<>Pic_Display
			//ECRIRE RESSOURCE IMAGE(15000;<>Pic_Display;$Gmt_File)
			//TRANSFORMER IMAGE($Pic_Buffer;Passage en niveaux de gris)
			//IMAGE VERS BLOB($Pic_Buffer;$Blb_Buffer;"PICT")
			//ECRIRE RESSOURCE("MASK";15000;$Blb_Buffer;$Gmt_File)
			//LIRE RESSOURCE IMAGE(15000;<>Pic_Display;$Gmt_File)
			//CONVERTIR IMAGE(<>Pic_Display;"png")
			//FERMER FICHIER RESSOURCES($Gmt_File)
			//SUPPRIMER DOCUMENT($Txt_Path)
			//
			//$Txt_File_Name:=doc_Txt_Path_Handler ("set.extension";<>tTxt_File_Names{$Lon_Selected};"png")
			//$Txt_Path:=doc_Txt_Path_Handler ("get.parent.path";<>tTxt_File_Paths{$Lon_Selected})+$Txt_File_Name
			//ECRIRE FICHIER IMAGE($Txt_Path;<>Pic_Display;".png")
			//Si (OK=1)
			//<>tTxt_File_Names{$Lon_Selected}:=$Txt_File_Name
			//<>tTxt_File_Paths{$Lon_Selected}:=$Txt_Path
			//<>Txt_Picture_Name:=$Txt_File_Name
			//Fin de si
			//Fin de si
			
			//______________________________________________________
		: ($Mnu_choice="folder.add")
			
			$Txt_folderName:=Request:C163(Get localized string:C991("FolderName"); Get localized string:C991("NewFolder"); Get localized string:C991("CommonCreate"))
			
			If (OK=1)
				
				If (Length:C16($Txt_path)=0)
					
					DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_resources; "path"; $Txt_path)
					//$Txt_path:=<>kTxt_resourcesFolderPath
					
				End if 
				
				If ($Txt_path[[Length:C16($Txt_path)]]#Folder separator:K24:12)
					
					$Txt_path:=$Txt_path+Folder separator:K24:12
					
				End if 
				
				$Txt_path:=$Txt_path+$Txt_folderName
				If (Test path name:C476($Txt_path)=Is a folder:K24:2)
					
					BEEP:C151  //the folder already exist
					
				Else 
					
					$Txt_path:=doc_Txt_Path_Handler("create.folder"; $Txt_path)
					
					If (OK=1)
						
						// Added by vdl (20/06/08)
						//  C/S update {
						If (OK=1)
							
							env_CREATE_ON_SERVER($Txt_path)
							
						End if 
						//}
						
						If (Not:C34(Is a list:C621($Lst_sublist)))
							
							$Lst_sublist:=New list:C375
							
						End if 
						
						<>Lon_UID:=<>Lon_UID+1
						APPEND TO LIST:C376($Lst_sublist; $Txt_folderName; <>Lon_UID)
						SET LIST ITEM ICON:C950($Lst_sublist; 0; <>kPic_folderIcon)
						SET LIST ITEM PARAMETER:C986($Lst_sublist; 0; "path"; $Txt_path)
						SORT LIST:C391($Lst_sublist)
						SET LIST ITEM:C385(<>Lst_resources; $Lon_reference; $Txt_element; $Lon_reference; $Lst_sublist; True:C214)
						SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_resources; <>Lon_UID)
						
						BROWSER_HANDLER("update")
						
					End if 
				End if 
			End if 
			
			//______________________________________________________
		: ($Mnu_choice="folder.open")
			
			If (Length:C16($Txt_path)#0)
				
				SHOW ON DISK:C922($Txt_path; *)
				
			End if 
			
			//______________________________________________________
		: ($Mnu_choice="folder.rename")
			
			$Txt_parentPath:=doc_Txt_Path_Handler("get.parent.path"; $Txt_path)
			$Txt_folderName:=doc_Txt_Path_Handler("get.name"; $Txt_path)
			$Txt_folderName:=Request:C163(Replace string:C233(Get localized string:C991("NewName"); "{name}"; $Txt_folderName); $Txt_folderName; Get localized string:C991("CommonRename"))
			
			If (OK=1)
				
				$Txt_targetPath:=$Txt_parentPath+$Txt_folderName+Folder separator:K24:12
				doc_DUPLICATE_FOLDER($Txt_path; $Txt_targetPath)
				
				If (OK=1)
					
					SET LIST ITEM:C385(<>Lst_resources; $Lon_reference; $Txt_folderName; $Lon_reference; $Lst_sublist; $Boo_expanded)
					SET LIST ITEM PARAMETER:C986(<>Lst_resources; $Lon_reference; "path"; $Txt_targetPath)
					doc_DELETE_FOLDER($Txt_path)
					
				End if 
			End if 
			
			//______________________________________________________
		: ($Mnu_choice="folder.delete")
			
			CONFIRM:C162(Replace string:C233(Get localized string:C991("DeleteFolder"); "{name}"; doc_Txt_Path_Handler("get.name"; $Txt_path)); Get localized string:C991("CommonDelete"))
			
			If (OK=1)
				
				doc_DELETE_FOLDER($Txt_path)
				
				If (OK=1)
					
					DELETE FROM LIST:C624(<>Lst_resources; $Lon_reference; *)
					SELECT LIST ITEMS BY POSITION:C381(<>Lst_resources; Selected list items:C379(<>Lst_resources)-1)
					BROWSER_HANDLER("update")
					
				End if 
			End if 
			
			//______________________________________________________
		: ($Mnu_choice="folder.duplicate")
			
			$Txt_parentPath:=doc_Txt_Path_Handler("get.parent.path"; $Txt_path)
			
			Repeat 
				
				$Txt_folderName:=doc_Txt_Path_Handler("get.name"; $Txt_path)
				$Txt_folderName:=$Txt_folderName+Get localized string:C991("BrowserCopy")+String:C10($Lon_x; " ##); ##);)")
				$Txt_targetPath:=$Txt_parentPath+$Txt_folderName+Folder separator:K24:12
				$Lon_x:=$Lon_x+1
				
			Until (Test path name:C476($Txt_targetPath)#Is a folder:K24:2)
			
			doc_DUPLICATE_FOLDER($Txt_path; $Txt_targetPath)
			
			If (OK=1)
				
				$Lon_x:=List item position:C629(<>Lst_resources; List item parent:C633(<>Lst_resources; *))
				GET LIST ITEM:C378(<>Lst_resources; $Lon_x; $Lon_reference; $Txt_element; $Lst_sublist; $Boo_expanded)
				<>Lon_UID:=<>Lon_UID+1
				APPEND TO LIST:C376($Lst_sublist; $Txt_folderName; <>Lon_UID)
				SET LIST ITEM ICON:C950($Lst_sublist; 0; <>kPic_folderIcon)
				SET LIST ITEM PARAMETER:C986($Lst_sublist; 0; "path"; $Txt_targetPath)
				SORT LIST:C391($Lst_sublist)
				SET LIST ITEM:C385(<>Lst_resources; $Lon_reference; $Txt_element; $Lon_reference; $Lst_sublist; True:C214)
				SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_resources; <>Lon_UID)
				BROWSER_HANDLER("update")
				
			End if 
			
			//______________________________________________________
		: ($Mnu_choice="folder.refresh")
			
			BROWSER_HANDLER("update")
			
			//______________________________________________________
		Else 
			
			TRACE:C157
			
			//______________________________________________________
	End case 
	
End if 

mnu_RELEASE_MENU($Mnu_main)