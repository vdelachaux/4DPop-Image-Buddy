//%attributes = {}
// ----------------------------------------------------
// Method : Pictures_Tool_Ondrop
// Created 14/02/08 by Vincent de Lachaux
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
#DECLARE($data : Object)

var $dest; $name; $src : Text
var $dropPosition; $indx : Integer
var $pic : Picture

$dest:=Get 4D folder:C485(Current resources folder:K5:16; *)

// Get a path in the drag container
$src:=Get file from pasteboard:C976(1)

Case of 
		
		//______________________________________________________
	: (Length:C16($src)=0)  // No path : try an image
		
		$dropPosition:=1
		
		ARRAY TEXT:C222($signatures; 0x0000)
		ARRAY TEXT:C222($nativeTypes; 0x0000)
		GET PASTEBOARD DATA TYPE:C958($signatures; $nativeTypes)
		
		If (Find in array:C230($signatures; "com.4d.private.picture.4dpicture")>0)
			
			If (OK=1)
				
				$name:=Get localized string:C991("NewImage")
				$name:=Request:C163(Get localized string:C991("Name"); $name; Get localized string:C991("CommonCreate"))
				
				If (OK=1)
					
				End if 
			End if 
			
		Else 
			
			BEEP:C151
			
		End if 
		
		//______________________________________________________
	Else 
		
		$indx:=1
		
		Repeat 
			
			If (Test path name:C476($src)=Is a document:K24:1)
				
				ERROR:=0
				ON ERR CALL:C155("No_Error")
				READ PICTURE FILE:C678($src; $pic)
				ON ERR CALL:C155("")
				
				Case of 
						
						//.....................................................
					: (OK=0)
						
						//.....................................................
					: (ERROR#0)
						
						ALERT:C41(".Error Nº "+String:C10(ERROR)+" reading file \""+doc_Txt_Path_Handler("get.name"; $src)+"\"")
						
						//.....................................................
					: (Picture size:C356($pic)=0)
						
						//.....................................................
					Else 
						
						COPY DOCUMENT:C541($src; $dest+doc_Txt_Path_Handler("get.name"; $src); *)
						
						//.....................................................
				End case 
				
			End if 
			
			$indx:=$indx+1
			$src:=Get file from pasteboard:C976($indx)
			
		Until ($src="")
		
		//______________________________________________________
End case 