//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : env_Get_Info_plist_Value
// Created 25/09/07 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// Return the value of a simple firts level key element of an info.plist file
// ----------------------------------------------------
// Modified by Vincent de Lachaux (15/03/12)
// Optimisation & Add true/false value management
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_i)
C_TEXT:C284($Dom_element; $Dom_root; $Txt_buffer; $Txt_name; $Txt_path)

If (False:C215)
	C_TEXT:C284(env_Get_InfoPlist_Value; $0)
	C_TEXT:C284(env_Get_InfoPlist_Value; $1)
End if 

$Txt_path:=Get 4D folder:C485(Database folder:K5:14)+"Info.plist"

If (Test path name:C476($Txt_path)=Is a document:K24:1)
	
	$Dom_root:=DOM Parse XML source:C719($Txt_path)
	
	If (OK=1)
		
		ARRAY TEXT:C222($tDom_keys; 0x0000)
		$Dom_element:=DOM Find XML element:C864($Dom_root; "plist/dict/key"; $tDom_keys)
		
		For ($Lon_i; 1; Size of array:C274($tDom_keys); 1)
			
			DOM GET XML ELEMENT VALUE:C731($tDom_keys{$Lon_i}; $Txt_buffer)
			
			If ($Txt_buffer=$1)
				
				$Dom_element:=DOM Get next sibling XML element:C724($tDom_keys{$Lon_i})
				
				DOM GET XML ELEMENT NAME:C730($Dom_element; $Txt_name)
				
				Case of 
						//______________________________________________________
					: ($Txt_name="string")
						
						DOM GET XML ELEMENT VALUE:C731($Dom_element; $0)
						
						//______________________________________________________
					: ($Txt_name="true") | ($Txt_name="false")
						
						$0:=$Txt_name
						
						//______________________________________________________
					Else 
						
						TRACE:C157
						
						//______________________________________________________
				End case 
				
			End if 
			
		End for 
		
		DOM CLOSE XML:C722($Dom_root)
		
	End if 
	
Else 
	
	ALERT:C41("Error 43 - File not found\r\""+$Txt_path+"\"")
	
End if 
