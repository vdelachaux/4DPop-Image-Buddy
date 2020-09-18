//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : Obj_CENTER
// Created 13/10/06 by vdl
// ----------------------------------------------------
// Description
// Centre la position d'un objet par rapport à un autre
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_LONGINT:C283($Lon_Bottom; $Lon_Left; $Lon_Middle; $Lon_Mode; $Lon_Right; $Lon_Top)

If (False:C215)
	C_TEXT:C284(obj_CENTER; $1)
	C_TEXT:C284(obj_CENTER; $2)
	C_LONGINT:C283(obj_CENTER; $3)
End if 

If (Count parameters:C259>2)
	$Lon_Mode:=$3
End if 

If ($Lon_Mode=0) | ($Lon_Mode>=Vertically centered:K39:4)
	OBJECT GET COORDINATES:C663(*; $2; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
	$Lon_Middle:=$Lon_Top+(($Lon_Bottom-$Lon_Top)/2)
	OBJECT GET COORDINATES:C663(*; $1; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
	OBJECT MOVE:C664(*; $1; 0; ($Lon_Middle-(($Lon_Bottom-$Lon_Top)/2))-$Lon_Top)
	If ($Lon_Mode#0)
		$Lon_Mode:=$Lon_Mode-Vertically centered:K39:4
	End if 
End if 

If ($Lon_Mode=0) | ($Lon_Mode=Horizontally centered:K39:1)
	OBJECT GET COORDINATES:C663(*; $2; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
	$Lon_Middle:=$Lon_Left+(($Lon_Right-$Lon_Left)/2)
	OBJECT GET COORDINATES:C663(*; $1; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
	OBJECT MOVE:C664(*; $1; ($Lon_Middle-(($Lon_Right-$Lon_Left)/2))-$Lon_Left; 0)
End if 
