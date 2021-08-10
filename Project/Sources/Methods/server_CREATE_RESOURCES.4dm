//%attributes = {"invisible":true,"executedOnServer":true}
// ----------------------------------------------------
// Method : server_CREATE_RESOURCES
// Created 28/05/08 by vdl
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
var $1 : Blob

If (False:C215)
	C_BLOB:C604(server_CREATE_RESOURCES; $1)
End if 

var $folderSeparator; $pathname; $structureFolder : Text
var $isFile : Boolean
var $compressed; $i; $offset : Integer
var $x : Blob

If (Count parameters:C259>0)
	
	$structureFolder:=Get 4D folder:C485(Database folder:K5:14; *)
	$folderSeparator:=$structureFolder[[Length:C16($structureFolder)]]
	
	For ($i; 1; Count parameters:C259; 1)
		
		CLEAR VARIABLE:C89($offset)
		
		BLOB PROPERTIES:C536($1; $compressed)
		
		If ($compressed#Is not compressed:K22:11)
			
			EXPAND BLOB:C535($1)
			
		End if 
		
		BLOB TO VARIABLE:C533($1; $pathname; $offset)
		
		If (OK=1)
			
			$pathname:=Replace string:C233($pathname; "/"; $folderSeparator)
			$pathname:=$structureFolder+$pathname
			$isFile:=($pathname[[Length:C16($pathname)]]#$folderSeparator)
			
			If ($isFile)
				
				BLOB TO VARIABLE:C533($1; $x; $offset)
				
			End if 
		End if 
		
		If (OK=1)
			
			If (Test path name:C476($pathname)=Is a document:K24:1)
				
				DELETE DOCUMENT:C159($pathname)
				
			Else 
				
				If ($isFile)
					
				Else 
					
				End if 
			End if 
			
			If ((OK=1) & $isFile)
				
				BLOB TO DOCUMENT:C526($pathname; $x)
				
			End if 
		End if 
	End for 
	
	NOTIFY RESOURCES FOLDER MODIFICATION:C1052
	
End if 