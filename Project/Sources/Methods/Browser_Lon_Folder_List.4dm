//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : Browser_Lon_Folder_List
// Created 09/01/08 by Vincent de Lachaux
// ----------------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_POINTER:C301($2)
C_PICTURE:C286($3)

C_BOOLEAN:C305($Boo_remote)
C_LONGINT:C283($Lon_i; $Lst_files)
C_PICTURE:C286($Pic_folder)
C_POINTER:C301($Ptr_id)
C_TEXT:C284($Txt_currentPath; $Txt_path)

ARRAY TEXT:C222($tTxt_folders; 0)

If (False:C215)
	C_LONGINT:C283(Browser_Lon_Folder_List; $0)
	C_TEXT:C284(Browser_Lon_Folder_List; $1)
	C_POINTER:C301(Browser_Lon_Folder_List; $2)
	C_PICTURE:C286(Browser_Lon_Folder_List; $3)
End if 

$Txt_path:=$1
$Ptr_id:=$2
$Pic_folder:=$3

DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_resources; "remote"; $Boo_remote)

//Append separator if necessary
If ($Txt_path[[Length:C16($Txt_path)]]#Folder separator:K24:12)
	
	$Txt_path:=$Txt_path+Folder separator:K24:12
	
End if 

FOLDER LIST:C473($Txt_path; $tTxt_folders)

$Lst_files:=New list:C375

For ($Lon_i; 1; Size of array:C274($tTxt_folders); 1)
	
	Case of 
			//……………………………………………………………………
		: ($Boo_remote & ($tTxt_folders{$Lon_i}="Cache"))
			
			//exclude
			
			//……………………………………………………………………
		Else 
			
			$Txt_currentPath:=$Txt_path+$tTxt_folders{$Lon_i}+Folder separator:K24:12
			$Ptr_id->:=$Ptr_id->+1
			
			APPEND TO LIST:C376($Lst_files; $tTxt_folders{$Lon_i}; $Ptr_id->; Browser_Lon_Folder_List($Txt_currentPath; $Ptr_id; $Pic_folder); False:C215)
			SET LIST ITEM ICON:C950($Lst_files; 0; $Pic_folder)
			SET LIST ITEM PARAMETER:C986($Lst_files; 0; "path"; $Txt_currentPath)
			
			//……………………………………………………………………
	End case 
End for 

If (Count list items:C380($Lst_files)>0)
	
	$0:=$Lst_files
	
Else 
	
	CLEAR LIST:C377($Lst_files)
	
End if 
