//%attributes = {}
// ----------------------------------------------------
// Method : Pictures_Tool_Ondrop
// Created 14/02/08 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($data : Object)

var $name; $pathname : Text
var $picture : Picture
var $dropPosition; $indx : Integer
var $file : 4D:C1709.File
var $resources : 4D:C1709.Folder

$resources:=Folder:C1567("/RESOURCES/"; *)
$indx:=1

// Get a path in the drag container
$pathname:=Get file from pasteboard:C976($indx)

Case of 
		
		//______________________________________________________
	: (Length:C16($pathname)=0)  // No path : try an image
		
		$dropPosition:=1
		
		ARRAY TEXT:C222($signatures; 0x0000)
		ARRAY TEXT:C222($nativeTypes; 0x0000)
		GET PASTEBOARD DATA TYPE:C958($signatures; $nativeTypes)
		
		If (Find in array:C230($signatures; "com.4d.private.picture.4dpicture")=-1)
			
			BEEP:C151
			return 
			
		End if 
		
		$name:=Get localized string:C991("NewImage")
		$name:=Request:C163(Get localized string:C991("Name"); $name+".png"; Get localized string:C991("CommonCreate"))
		
		If (Bool:C1537(OK))
			
			// TODO:Create the picture into the resources folder
			
		End if 
		
		//______________________________________________________
	Else 
		
		$file:=File:C1566($pathname; fk platform path:K87:2)
		
		ON ERR CALL:C155(Formula:C1597(No_Error).source)
		
		Repeat 
			
			If (Not:C34($file.exists))  // It could be a folder
				
				continue
				
			End if 
			
			ERROR:=0
			READ PICTURE FILE:C678($file.platformPath; $picture)
			
			Case of 
					
					//.....................................................
				: (OK=0)
					
					//.....................................................
				: (ERROR#0)
					
					ALERT:C41(".Error Nº "+String:C10(ERROR)+" reading file \""+$file.fullName+"\"")
					
					//.....................................................
				: (Picture size:C356($picture)=0)
					
					//.....................................................
				Else 
					
					$file.copyTo($resources; fk overwrite:K87:5)
					
					//.....................................................
			End case 
			
			$indx+=1
			$pathname:=Get file from pasteboard:C976($indx)
			
			If (Length:C16($pathname)=0)
				
				break
				
			End if 
			
			$file:=File:C1566($pathname; fk platform path:K87:2)
			
		Until ($pathname="")
		
		ON ERR CALL:C155("")
		
		//______________________________________________________
End case 