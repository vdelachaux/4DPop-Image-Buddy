//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : BROWSER_HANDLER
// Created 08/12/06 by vdl
// ----------------------------------------------------
// Modified by vdl (01/03/08)
// Give the opportunity to  host database (or component) of giving the path of the folder "resources" through a dedicated method
// ----------------------------------------------------
// Modified by vdl (07/05/08)
// Bug fix : The dialogue could be displayed 2 times, one time in a new process & the second time in the 4DPop process
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_BLOB:C604($Blb_Buffer)
C_BOOLEAN:C305($Boo_remote)
C_LONGINT:C283($kLon_celluleWidth; $kLon_offset; $kLon_thumbnailWidth; $Lon_Blue; $Lon_Bottom; $Lon_Green; $Lon_Height; $Lon_i)
C_LONGINT:C283($Lon_Left; $Lon_Length; $Lon_Level; $Lon_Position; $Lon_Red; $Lon_Right; $Lon_Top; $Lon_Width)
C_LONGINT:C283($Lon_Window)
C_TIME:C306($Gmt_File)
C_PICTURE:C286($Pic_Buffer; $Pic_Cellule; $Pic_Folder; $Pic_Title)
C_POINTER:C301($Ptr_Array)
C_TEXT:C284($Dom_parameters; $Txt_Current_Method; $Txt_Entrypoint; $Txt_Extension; $Txt_Method_Error; $Txt_Name; $Txt_Path; $Txt_resourcesFolder_Path)
C_TEXT:C284($Txt_resourcesFoldrPath)

If (False:C215)
	C_TEXT:C284(BROWSER_HANDLER; $1)
	C_TEXT:C284(BROWSER_HANDLER; $2)
	C_LONGINT:C283(BROWSER_HANDLER; $3)
End if 

$Txt_Current_Method:=Current method name:C684

If (Process number:C372("$"+$Txt_Current_Method)=0)
	
	BRING TO FRONT:C326(New process:C317($Txt_Current_Method; 0; "$"+$Txt_Current_Method; "run"; *))
	
Else 
	
	If (Count parameters:C259>=1)
		
		$Txt_Entrypoint:=$1
		
	End if 
	
	$kLon_celluleWidth:=130
	$kLon_offset:=8
	$kLon_thumbnailWidth:=96
	
	Case of 
			
			//______________________________________________________
		: (Length:C16($Txt_Entrypoint)=0)
			
			BRING TO FRONT:C326(Process number:C372("$"+$Txt_Current_Method))
			
			//______________________________________________________
			// Modified by vdl (07/05/08) {
			//: (Longueur($Txt_Entrypoint)=0)
		: ($Txt_Entrypoint="run")  //Display the browser
			// }
			
			COMPILER
			
			$Dom_parameters:=DOM Create XML Ref:C861("imageBuddy")
			<>Dom_thumb:=DOM Create XML element:C865($Dom_parameters; "thumb"; \
				"max-column"; 40; \
				"cellule-width"; $kLon_celluleWidth; \
				"thumb-width"; $kLon_thumbnailWidth; \
				"offset"; $kLon_offset)
			
			// Modified by vdl (01/03/08) {
			// A dedicated method can give the target path
			$Txt_Method_Error:=Method called on error:C704
			ON ERR CALL:C155("No_Error")
			EXECUTE METHOD:C1007("Resources_Target_Path"; $Txt_resourcesFoldrPath)
			ON ERR CALL:C155($Txt_Method_Error)
			// }
			
			$Boo_remote:=((Application type:C494=4D Remote mode:K5:5) & (Length:C16($Txt_resourcesFoldrPath)=0))
			
			If (Length:C16($Txt_resourcesFoldrPath)=0)
				
				$Txt_resourcesFoldrPath:=Get 4D folder:C485(Current resources folder:K5:16; *)
				
			End if 
			
			<>Dom_resources:=DOM Create XML element:C865($Dom_parameters; "res"; \
				"path"; $Txt_resourcesFoldrPath; \
				"remote"; $Boo_remote)
			
			//Construct the constants images of the interface {
			$Lon_Red:=179
			$Lon_Green:=213
			$Lon_Blue:=255
			<>kPic_Cellule:=svg_Pic_DrawBox($kLon_thumbnailWidth; $kLon_thumbnailWidth; -1; -1)
			<>kPic_Selected:=svg_Pic_DrawBox($kLon_thumbnailWidth; $kLon_thumbnailWidth; ($Lon_Red << 16)+($Lon_Green << 8)+$Lon_Blue; -1; 2)
			
			$Txt_resourcesFolder_Path:=Get 4D folder:C485(Current resources folder:K5:16)
			READ PICTURE FILE:C678($Txt_resourcesFolder_Path+"genericFolder.png"; <>kPic_folderIcon)
			
			//Don't forget to Transform SVG in PNG if the xml code is no more necessary (It's good for the memory)
			CONVERT PICTURE:C1002(<>kPic_Cellule; ".png")
			CONVERT PICTURE:C1002(<>kPic_Selected; ".png")
			CONVERT PICTURE:C1002(<>kPic_Copyright; ".png")
			//}
			
			//Fills main list with the folder hierarchy of the folder resources {
			<>Lst_resources:=New list:C375
			<>Lon_File_Number:=0
			<>Lon_UID:=1
			APPEND TO LIST:C376(<>Lst_resources; "Resources"; <>Lon_UID; Browser_Lon_Folder_List($Txt_resourcesFoldrPath; -><>Lon_UID; <>kPic_folderIcon); True:C214)
			DOCUMENT LIST:C474($Txt_resourcesFoldrPath; $tTxt_Files)
			READ PICTURE FILE:C678($Txt_resourcesFolder_Path+"resources.png"; $Pic_Folder)
			SET LIST ITEM ICON:C950(<>Lst_resources; 0; $Pic_Folder)
			SET LIST ITEM PARAMETER:C986(<>Lst_resources; 0; "path"; $Txt_resourcesFoldrPath)
			//& select the first folder
			SELECT LIST ITEMS BY POSITION:C381(<>Lst_resources; 1)
			//}
			
			// Added by vdl (09/06/08)  {
			// The window position is now stored
			preferences("editorWindowPosition.get"; ->$Lon_Left; ->$Lon_Top; ->$Lon_Right; ->$Lon_Bottom)
			If ($Lon_Left=-1)  //| Vrai
				
				$Lon_Window:=Open form window:C675("Browser"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)  //;*)
				
			Else 
				
				$Lon_Window:=Open window:C153($Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom; Plain window:K34:13+Texture appearance:K34:17; Get localized string:C991("WindowTitle"); "No_Error")
				RECOVER_WINDOW
				
			End if 
			//}
			
			DIALOG:C40("Browser")
			
			// Added by vdl (09/06/08) {
			// The window position is now stored
			GET WINDOW RECT:C443($Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom; $Lon_Window)
			preferences("editorWindowPosition.set"; ->$Lon_Left; ->$Lon_Top; ->$Lon_Right; ->$Lon_Bottom)
			//}
			
			CLOSE WINDOW:C154
			
			//Cleanup {
			CLEAR LIST:C377(<>Lst_resources; *)
			
			For ($Lon_i; 1; 40; 1)
				
				$Ptr_Array:=Get pointer:C304("<>tPic_"+String:C10($Lon_i))
				DELETE FROM ARRAY:C228($Ptr_Array->; 1; Size of array:C274($Ptr_Array->))
				
			End for 
			
			DOM CLOSE XML:C722($Dom_parameters)
			
			CLEAR VARIABLE:C89(<>tTxt_filePaths)
			CLEAR VARIABLE:C89(<>tTxt_fileNames)
			CLEAR VARIABLE:C89(<>tPic_thumbnails)
			CLEAR VARIABLE:C89(<>tLon_Selected)
			CLEAR VARIABLE:C89(<>tLstb_Picture)
			
			CLEAR VARIABLE:C89(<>kPic_Cellule)
			CLEAR VARIABLE:C89(<>kPic_Selected)
			CLEAR VARIABLE:C89(<>kPic_folderIcon)
			CLEAR VARIABLE:C89(<>Pic_display)
			
			CLEAR VARIABLE:C89(<>Txt_SearchBox)
			//EFFACER VARIABLE(<>kTxt_resourcesFolderPath)
			CLEAR VARIABLE:C89(<>Txt_pictureName)
			CLEAR VARIABLE:C89(<>Txt_Picture_Size)
			//}
			
			//______________________________________________________
		: ($Txt_Entrypoint="BeginDragOver")
			
			$Txt_Path:=$2
			
			CLEAR PASTEBOARD:C402
			
			If (Macintosh option down:C545 | Windows Alt down:C563)
				
				DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_resources; "path"; $Txt_resourcesFoldrPath)
				SET TEXT TO PASTEBOARD:C523("\"file:"+Replace string:C233(Replace string:C233($Txt_Path; $Txt_resourcesFoldrPath; ""); Folder separator:K24:12; "/")+"\"")
				
			Else 
				
				SET FILE TO PASTEBOARD:C975($Txt_Path)
				
			End if 
			
			//______________________________________________________
		: ($Txt_Entrypoint="Transform")
			
			<>Pic_Preview:=<>Pic_display
			If (<>b1=1)
				
				TRANSFORM PICTURE:C988(<>Pic_Preview; Flip horizontally:K61:4)
				
			End if 
			
			If (<>b2=1)
				
				TRANSFORM PICTURE:C988(<>Pic_Preview; Flip vertically:K61:5)
				
			End if 
			
			If (<>b3=1)
				
				TRANSFORM PICTURE:C988(<>Pic_Preview; Fade to grey scale:K61:6)
				
			End if 
			
			If (<>b4=1)
				
				$Txt_Path:=Temporary folder:C486+String:C10(Milliseconds:C459)
				$Gmt_File:=_O_Create resource file:C496($Txt_Path)
				
				If (OK=1)
					
					$Pic_Buffer:=<>Pic_Preview
					_O_SET PICTURE RESOURCE:C503(15000; <>Pic_Preview; $Gmt_File)
					TRANSFORM PICTURE:C988($Pic_Buffer; Fade to grey scale:K61:6)
					PICTURE TO BLOB:C692($Pic_Buffer; $Blb_Buffer; "PICT")
					_O_SET RESOURCE:C509("MASK"; 15000; $Blb_Buffer; $Gmt_File)
					GET PICTURE RESOURCE:C502(15000; <>Pic_Preview; $Gmt_File)
					CLOSE RESOURCE FILE:C498($Gmt_File)
					DELETE DOCUMENT:C159($Txt_Path)
					
				End if 
			End if 
			
			If (<>b5=1)
				
				TRANSFORM PICTURE:C988(<>Pic_Preview; Scale:K61:2; <>Lon_Scale/100; <>Lon_Scale/100)
				
			End if 
			
			$Txt_Extension:=<>tTxt_Codecs{<>tTxt_Names}
			CONVERT PICTURE:C1002(<>Pic_Preview; $Txt_Extension)
			
			$Txt_Name:=doc_Txt_Path_Handler("get.name.short"; <>Txt_fileName)
			
			If ($Txt_Extension=".@")
				
				<>Txt_fileName:=$Txt_Name+$Txt_Extension
				
			Else 
				
				<>Txt_fileName:=$Txt_Name
				
			End if 
			
			HIGHLIGHT TEXT:C210(<>Txt_fileName; 1; Length:C16(doc_Txt_Path_Handler("get.name.short"; <>Txt_fileName))+1)
			
			//______________________________________________________
		: ($Txt_Entrypoint="ListPictures")
			
			$Txt_Path:=$2
			If (Count parameters:C259>=3)
				
				$Lon_Level:=$3
				
			End if 
			
			If ($Lon_Level=0)
				
				ARRAY TEXT:C222(<>tTxt_filePaths; 0)
				ARRAY TEXT:C222(<>tTxt_fileNames; 0)
				ARRAY PICTURE:C279(<>tPic_thumbnails; 0)
				ARRAY LONGINT:C221(<>tLon_Selected; 0)
				<>Lon_File_Number:=0
				
			End if 
			
			If (Length:C16($Txt_Path)>0)
				
				If ($Txt_Path[[Length:C16($Txt_Path)]]#Folder separator:K24:12)
					
					$Txt_Path:=$Txt_Path+Folder separator:K24:12
					
				End if 
				
				// Added by Vincent de Lachaux (07/11/08)  {
				ARRAY TEXT:C222($tTxt_codecs; 0x0000)
				PICTURE CODEC LIST:C992($tTxt_codecs)
				//}
				
				ARRAY TEXT:C222($tTxt_Files; 0x0000)
				
				If (Test path name:C476($Txt_Path)=Is a folder:K24:2)
					
					DOCUMENT LIST:C474($Txt_Path; $tTxt_Files)
					
					For ($Lon_i; 1; Size of array:C274($tTxt_Files); 1)
						
						// Modiied by Vincent de Lachaux (07/11/08) {
						$Txt_extension:=""
						
						If (Match regex:C1019("\\..*$"; $tTxt_Files{$Lon_i}; 1; $Lon_Position; $Lon_Length))
							
							$Txt_extension:=Substring:C12($tTxt_Files{$Lon_i}; $Lon_Position)
							
						End if 
						
						If (Find in array:C230($tTxt_codecs; $Txt_extension)>0)
							
							//Au cas ou
							//  ` ----------------------------------------------------
							//: ($tTxt_Files{$Lon_i}=".@")
							//  ` ----------------------------------------------------
							//: ($tTxt_Files{$Lon_i}="Thumbs.db")
							//  ` ----------------------------------------------------
							//: ($tTxt_Files{$Lon_i}="icon_") | ($tTxt_Files{$Lon_i}="Icon") | ($tTxt_Files{$Lon_i}="Icon\r")
							//  ` ----------------------------------------------------
							//: ($tTxt_Files{$Lon_i}="@.ico") | ($tTxt_Files{$Lon_i}="@.icns")
							//  ` ----------------------------------------------------
							//: ($tTxt_Files{$Lon_i}="@.doc")
							//  ` ----------------------------------------------------
							//: ($tTxt_Files{$Lon_i}="@.txt")
							//  ` ----------------------------------------------------
							//: ($tTxt_Files{$Lon_i}="@.xml") | ($tTxt_Files{$Lon_i}="@.xlf") | ($tTxt_Files{$Lon_i}="@.xslt")
							//  ` ----------------------------------------------------
							//: ($tTxt_Files{$Lon_i}="@.htm") | ($tTxt_Files{$Lon_i}="@.html") | ($tTxt_Files{$Lon_i}="@.js")
							//  ` ----------------------------------------------------
							//: ($tTxt_Files{$Lon_i}="@.swf") | ($tTxt_Files{$Lon_i}="@.shtml") | ($tTxt_Files{$Lon_i}="@.php")
							//  ` ----------------------------------------------------
							//: ($tTxt_Files{$Lon_i}="@.asp") | ($tTxt_Files{$Lon_i}="@.cfc") | ($tTxt_Files{$Lon_i}="@.cfm")
							//  ` ----------------------------------------------------
							//Sinon
							
							<>Lon_Error:=0
							ON ERR CALL:C155("No_Error")
							READ PICTURE FILE:C678($Txt_Path+$tTxt_Files{$Lon_i}; $Pic_Buffer; *)
							ON ERR CALL:C155("")
							
							Case of 
									//.....................................................
								: (OK=0)
									
									//.....................................................
								: (<>Lon_Error#0)
									
									ALERT:C41(".Error Nº "+String:C10(<>Lon_Error)+" reading file \""+$tTxt_Files{$Lon_i}+"\"")
									SET TEXT TO PASTEBOARD:C523($tTxt_Files{$Lon_i})
									
									//.....................................................
								: (Picture size:C356($Pic_Buffer)=0)
									
									//.....................................................
								Else 
									
									PICTURE PROPERTIES:C457($Pic_Buffer; $Lon_Width; $Lon_Height)
									
									If (($Lon_Width+$Lon_Height)>0)
										
										APPEND TO ARRAY:C911(<>tTxt_filePaths; $Txt_Path+$tTxt_Files{$Lon_i})
										APPEND TO ARRAY:C911(<>tTxt_fileNames; $tTxt_Files{$Lon_i})
										
										APPEND TO ARRAY:C911(<>tPic_thumbnails; $Pic_Buffer)
										<>Lon_File_Number:=Size of array:C274(<>tPic_thumbnails)
										
										CREATE THUMBNAIL:C679(<>tPic_thumbnails{<>Lon_File_Number}; <>tPic_thumbnails{<>Lon_File_Number}; $kLon_thumbnailWidth-$kLon_offset; $kLon_thumbnailWidth-$kLon_offset; Scaled to fit prop centered:K6:6)
										
										$Txt_Name:=$tTxt_Files{$Lon_i}
										If (Length:C16($Txt_Name)>14)
											
											$Txt_Name:=Substring:C12($tTxt_Files{$Lon_i}; 1; 13)+"\r"+Substring:C12($tTxt_Files{$Lon_i}; 14)
											
										End if 
										
										$Pic_Title:=svg_Pic_DrawText($Txt_Name; 10; ""; 0; $kLon_thumbnailWidth; 24; ""; 0; 10; Align center:K42:3; 0; 0)
										
										COMBINE PICTURES:C987($Pic_Cellule; <>kPic_Cellule; Superimposition:K61:10; $Pic_Title; 0; $kLon_celluleWidth-$kLon_offset-20)
										COMBINE PICTURES:C987(<>tPic_thumbnails{<>Lon_File_Number}; $Pic_Cellule; Superimposition:K61:10; <>tPic_thumbnails{<>Lon_File_Number}; $kLon_offset; $kLon_offset)
										CONVERT PICTURE:C1002(<>tPic_thumbnails{<>Lon_File_Number}; ".png")
										
										IDLE:C311
										
									End if 
									
									//.....................................................
							End case 
							// ----------------------------------------------------
							//Fin de cas
							//}
							
						End if 
						
					End for 
					
					If (Shift down:C543)
						
						ARRAY TEXT:C222($tTxt_Folders; 0x0000)
						FOLDER LIST:C473($Txt_Path; $tTxt_Folders)
						
						For ($Lon_i; 1; Size of array:C274($tTxt_Folders); 1)
							
							BROWSER_HANDLER("ListPictures"; $Txt_Path+$tTxt_Folders{$Lon_i}; $Lon_Level+1)  // <- RECURSIVE !!!!!!!!!
							IDLE:C311
							
						End for 
						
					End if 
				End if 
				
			End if 
			//______________________________________________________
		: ($Txt_Entrypoint="update")
			
			SET TIMER:C645(0)
			LISTBOX DELETE COLUMN:C830(<>tLstb_Picture; 1; LISTBOX Get number of columns:C831(<>tLstb_Picture))
			OBJECT SET VISIBLE:C603(*; "NoPicture"; False:C215)
			OBJECT GET COORDINATES:C663(*; "list_thumbnails"; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
			OBJECT SET VISIBLE:C603(*; "_spinner"; ($Lon_Bottom-$Lon_Top)>15)
			<>Lon_Timer_Event_Event:=1
			SET TIMER:C645(-1)
			
			//______________________________________________________
		Else 
			
			TRACE:C157
			
			//______________________________________________________
	End case 
	
End if 