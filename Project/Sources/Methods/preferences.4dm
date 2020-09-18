//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : preferences
// Created 21/05/07 by Vincent de Lachaux
// ----------------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301(${2})

C_BOOLEAN:C305($Boo_Set)
C_LONGINT:C283($Lon_Buffer)
C_TEXT:C284($kTxt_Tool; $Txt_EntryPoint; $Txt_Error_Method; $Txt_Path; $Txt_Value; $Txt_Xpath)
_O_C_STRING:C293(16; $a16_element; $a16_Root)

If (False:C215)
	C_TEXT:C284(preferences; $1)
	C_POINTER:C301(preferences; ${2})
End if 

$Txt_EntryPoint:=$1

$Txt_Path:=Get 4D folder:C485+"4dPop v11 preference.xml"  //"4dPop quizz preference.xml"

$kTxt_Tool:="ImageBuddy"

If (Test path name:C476($Txt_Path)#Is a document:K24:1)
	$a16_Root:=DOM Create XML Ref:C861("preference")
Else 
	$a16_Root:=DOM Parse XML source:C719($Txt_Path)
End if 

If (OK=1)
	
	If ($Txt_EntryPoint="@.set")
		$Boo_Set:=True:C214
		$Txt_EntryPoint:=Replace string:C233($Txt_EntryPoint; ".set"; "")
	Else 
		$Txt_EntryPoint:=Replace string:C233($Txt_EntryPoint; ".get"; "")
	End if 
	
	$Txt_Xpath:="preference/"+$kTxt_Tool+"/"+$Txt_EntryPoint
	$a16_element:=DOM Find XML element:C864($a16_Root; $Txt_Xpath)
	
	Case of 
			//______________________________________________________
		: ($Txt_EntryPoint="spliter_1")
			If ($Boo_Set)
				
				If (OK=0)
					$a16_element:=DOM Create XML element:C865($a16_Root; $Txt_Xpath; "value"; $2->)
				Else 
					DOM SET XML ATTRIBUTE:C866($a16_element; "value"; $2->)
				End if 
				
			Else 
				
				
				If (OK=1)
					DOM GET XML ATTRIBUTE BY NAME:C728($a16_element; "value"; $Lon_Buffer)
				End if 
				
				If (OK=1)
					$2->:=$Lon_Buffer
				Else 
					$2->:=155
				End if 
				
			End if 
			//______________________________________________________
		: ($Txt_EntryPoint="spliter_2")
			If ($Boo_Set)
				
				If (OK=0)
					$a16_element:=DOM Create XML element:C865($a16_Root; $Txt_Xpath; "value"; $2->)
				Else 
					DOM SET XML ATTRIBUTE:C866($a16_element; "value"; $2->)
				End if 
				
			Else 
				
				
				If (OK=1)
					DOM GET XML ATTRIBUTE BY NAME:C728($a16_element; "value"; $Lon_Buffer)
				End if 
				
				If (OK=1)
					$2->:=$Lon_Buffer
				Else 
					$2->:=461
				End if 
				
			End if 
			//______________________________________________________
		: ($Txt_EntryPoint="editorWindowPosition")
			If ($Boo_Set)
				
				If (OK=0)
					$a16_element:=DOM Create XML element:C865($a16_Root; $Txt_Xpath; "left"; String:C10($2->); "top"; String:C10($3->); "right"; String:C10($4->); "bottom"; String:C10($5->))
				Else 
					DOM SET XML ATTRIBUTE:C866($a16_element; "left"; String:C10($2->); "top"; String:C10($3->); "right"; String:C10($4->); "bottom"; String:C10($5->))
				End if 
				
			Else 
				
				If (OK=1)
					DOM GET XML ATTRIBUTE BY NAME:C728($a16_element; "left"; $2->)
					DOM GET XML ATTRIBUTE BY NAME:C728($a16_element; "top"; $3->)
					DOM GET XML ATTRIBUTE BY NAME:C728($a16_element; "right"; $4->)
					DOM GET XML ATTRIBUTE BY NAME:C728($a16_element; "bottom"; $5->)
				End if 
				
				If (OK=0)
					$2->:=-1
					$3->:=-1
					$4->:=-1
					$5->:=-1
				End if 
			End if 
	End case 
	
	If ($Boo_Set)
		DOM SET XML DECLARATION:C859($a16_Root; "UTF-8"; True:C214; True:C214)
		DOM EXPORT TO FILE:C862($a16_Root; $Txt_Path)
	End if 
	
	DOM CLOSE XML:C722($a16_Root)
	
End if 

