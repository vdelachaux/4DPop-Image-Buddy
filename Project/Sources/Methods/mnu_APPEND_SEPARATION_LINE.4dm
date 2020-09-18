//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : mnu_APPEND_SEPARATION_LINE
// Created 29/01/08 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
_O_C_STRING:C293(16; $1)

_O_C_INTEGER:C282($Lon_x)
C_LONGINT:C283($Lon_Lines)
C_TEXT:C284($Txt_Buffer)

If (False:C215)
	_O_C_STRING:C293(mnu_APPEND_SEPARATION_LINE; 16; $1)
End if 

$Lon_Lines:=Count menu items:C405($1)
$Txt_Buffer:=Get menu item:C422($1; $Lon_Lines)

Case of 
	: ($Lon_Lines=0)
	: ($Txt_Buffer="(-@")
	: ($Txt_Buffer="-@")
	Else 
		GET MENU ITEM PROPERTY:C972($1; $Lon_Lines; "4D_separator"; $Lon_x)
		If ($Lon_x=0)
			APPEND MENU ITEM:C411($1; "(-")
		End if 
End case 
