//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : env_CREATE_ON_SERVER
// Created 20/06/08 by vdl
// ----------------------------------------------------
// Description
// Put the file on the server
// ----------------------------------------------------
C_TEXT:C284($1)

C_BLOB:C604($Blb_buffer; $Blb_send)
C_BOOLEAN:C305($Boo_remote)
C_LONGINT:C283($Lon_state)
C_TEXT:C284($Txt_path; $Txt_structureFolderPath)

If (False:C215)
	C_TEXT:C284(env_CREATE_ON_SERVER; $1)
End if 

DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_resources; "remote"; $Boo_remote)

If ($Boo_remote)
	
	$Txt_structureFolderPath:=Get 4D folder:C485(Database folder:K5:14; *)
	
	$Txt_path:=$1
	
	//We don't want to be synchronized :
	// Get the actual configuration of the resources' folder update...
	$Lon_state:=Get database parameter:C643(48)
	//… and set the configuration to None (0).
	SET DATABASE PARAMETER:C642(48; 0)
	
	//Put file into a buffer blob
	If (Test path name:C476($Txt_path)=Is a document:K24:1)
		
		DOCUMENT TO BLOB:C525($Txt_path; $Blb_buffer)
		
	End if 
	
	If (OK=1)
		
		//Convert path {to relative...
		$Txt_path:=Replace string:C233($Txt_path; $Txt_structureFolderPath; ""; 1)
		// ... & posix.
		$Txt_path:=Replace string:C233($Txt_path; Folder separator:K24:12; "/")
		
		//Put path and document into a blob. {
		VARIABLE TO BLOB:C532($Txt_path; $Blb_send)
		
		If (BLOB size:C605($Blb_buffer)>0)
			
			VARIABLE TO BLOB:C532($Blb_buffer; $Blb_send; *)
			
		End if 
		//}
		
		SET BLOB SIZE:C606($Blb_buffer; 0)
		
		COMPRESS BLOB:C534($Blb_send)
		If (OK=1)
			
			//execute update on the server
			server_CREATE_RESOURCES($Blb_send)
			SET BLOB SIZE:C606($Blb_send; 0)
			
		End if 
	End if 
	
	// Restore the previous configuration of the resources' folder update.
	SET DATABASE PARAMETER:C642(48; $Lon_state)
	
End if 
