//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Method : Pictures_Tool_Ondrop
// Created 14/02/08 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_LONGINT:C283($Lon_Drop_Position; $Lon_Index)
C_PICTURE:C286($Pic_Buffer)
C_TEXT:C284($Txt_File_Name; $Txt_Folder_Dest; $Txt_Path_Source)

If (False:C215)
	C_POINTER:C301(Pictures_Tool_Ondrop; $1)
End if 

$Txt_Folder_Dest:=Get 4D folder:C485(Current resources folder:K5:16; *)

//Get a path in the drag container 
$Txt_Path_Source:=Get file from pasteboard:C976(1)

Case of 
		//______________________________________________________
	: (Length:C16($Txt_Path_Source)=0)  //No path : try an image
		
		$Lon_Drop_Position:=1
		
		ARRAY TEXT:C222($tTxt_4Dsignatures; 0x0000)
		ARRAY TEXT:C222($tTxt_nativeTypes; 0x0000)
		GET PASTEBOARD DATA TYPE:C958($tTxt_4Dsignatures; $tTxt_nativeTypes)
		
		If (Find in array:C230($tTxt_4Dsignatures; "com.4d.private.picture.4dpicture")>0)
			GET PICTURE FROM PASTEBOARD:C522($Pic_Buffer)
			
			If (OK=1)
				$Txt_File_Name:=Get localized string:C991("NewImage")
				$Txt_File_Name:=Request:C163(Get localized string:C991("Name"); $Txt_File_Name; Get localized string:C991("CommonCreate"))
				
				If (OK=1)
					
					$Txt_File_Name:=$Txt_Folder_Dest+doc_Txt_Path_Handler("set.extension"; $Txt_File_Name; "4pct")
					WRITE PICTURE FILE:C680($Txt_File_Name; $Pic_Buffer; ".4pct")
					
				End if 
			End if 
			
		Else 
			BEEP:C151
			
		End if 
		
		//______________________________________________________
	Else 
		
		$Lon_Index:=1
		
		Repeat 
			
			If (Test path name:C476($Txt_Path_Source)=Is a document:K24:1)
				
				<>Lon_Error:=0
				ON ERR CALL:C155("No_Error")
				READ PICTURE FILE:C678($Txt_Path_Source; $Pic_Buffer)
				ON ERR CALL:C155("")
				
				Case of 
						//.....................................................    
					: (OK=0)
						
						//.....................................................    
					: (<>Lon_Error#0)
						ALERT:C41(".Error Nº "+String:C10(<>Lon_Error)+" reading file \""+doc_Txt_Path_Handler("get.name"; $Txt_Path_Source)+"\"")
						
						//.....................................................   
					: (Picture size:C356($Pic_Buffer)=0)
						
						//.....................................................   
					Else 
						COPY DOCUMENT:C541($Txt_Path_Source; $Txt_Folder_Dest+doc_Txt_Path_Handler("get.name"; $Txt_Path_Source); *)
						
						//.....................................................    
				End case 
				
			End if 
			
			$Lon_Index:=$Lon_Index+1
			$Txt_Path_Source:=Get file from pasteboard:C976($Lon_Index)
			
		Until ($Txt_Path_Source="")
		
		//______________________________________________________
End case 

