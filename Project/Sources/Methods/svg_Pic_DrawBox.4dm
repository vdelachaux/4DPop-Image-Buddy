//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : svg_Pic_DrawBox
// Created 09/01/08 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_PICTURE:C286($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)

C_LONGINT:C283($Lon_Fill; $Lon_Height; $Lon_Parametrers; $Lon_Stroke; $Lon_Stroke_Width; $Lon_Width)
C_PICTURE:C286($Pic_Buffer)
C_TEXT:C284($Txt_Box; $Txt_Color; $Txt_Root)

If (False:C215)
	C_PICTURE:C286(svg_Pic_DrawBox; $0)
	C_LONGINT:C283(svg_Pic_DrawBox; $1)
	C_LONGINT:C283(svg_Pic_DrawBox; $2)
	C_LONGINT:C283(svg_Pic_DrawBox; $3)
	C_LONGINT:C283(svg_Pic_DrawBox; $4)
	C_LONGINT:C283(svg_Pic_DrawBox; $5)
End if 

$Lon_Stroke:=-3  //0x0000
$Lon_Stroke_Width:=1

$Lon_Parametrers:=Count parameters:C259

If ($Lon_Parametrers>=2)
	$Lon_Width:=$1
	$Lon_Height:=$2
	If ($Lon_Parametrers>=3)
		$Lon_Stroke:=$3
		If ($Lon_Parametrers>=4)
			$Lon_Fill:=$4
			If ($Lon_Parametrers>=5)
				$Lon_Stroke_Width:=$5
			End if 
		End if 
	End if 
	
	$Txt_Root:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg")
	
	$Txt_Box:=DOM Create XML element:C865($Txt_Root; "svg/rect")
	
	DOM SET XML ATTRIBUTE:C866($Txt_Box; "x"; "0")
	DOM SET XML ATTRIBUTE:C866($Txt_Box; "y"; "0")
	DOM SET XML ATTRIBUTE:C866($Txt_Box; "width"; String:C10($Lon_Width))
	DOM SET XML ATTRIBUTE:C866($Txt_Box; "height"; String:C10($Lon_Height))
	
	If ($Lon_Stroke=-1)
		$Txt_Color:="none"
	Else 
		$Txt_Color:="RGB({red},{green},{blue})"
		$Txt_Color:=Replace string:C233($Txt_Color; "{red}"; String:C10(($Lon_Stroke & 0x00FF0000) >> 16))
		$Txt_Color:=Replace string:C233($Txt_Color; "{green}"; String:C10(($Lon_Stroke & 0xFF00) >> 8))
		$Txt_Color:=Replace string:C233($Txt_Color; "{blue}"; String:C10(($Lon_Stroke & 0x00FF)))
	End if 
	
	DOM SET XML ATTRIBUTE:C866($Txt_Box; "stroke"; $Txt_Color)
	
	If ($Lon_Parametrers>=4)
		
		If ($Lon_Fill=-1)
			
			$Txt_Color:="none"
			
		Else 
			$Txt_Color:="RGB({red},{green},{blue})"
			$Txt_Color:=Replace string:C233($Txt_Color; "{red}"; String:C10(($Lon_Fill & 0x00FF0000) >> 16))
			$Txt_Color:=Replace string:C233($Txt_Color; "{green}"; String:C10(($Lon_Fill & 0xFF00) >> 8))
			$Txt_Color:=Replace string:C233($Txt_Color; "{blue}"; String:C10(($Lon_Fill & 0x00FF)))
		End if 
		
	Else 
		
		$Txt_Color:="none"
		
	End if 
	
	DOM SET XML ATTRIBUTE:C866($Txt_Box; "fill"; $Txt_Color)
	
	DOM SET XML ATTRIBUTE:C866($Txt_Box; "stroke-width"; String:C10($Lon_Stroke_Width))
	//DOM ECRIRE ATTRIBUT XML($Txt_Box;"rx";"0")
	//DOM ECRIRE ATTRIBUT XML($Txt_Box;"ry";"0")
	
	SVG EXPORT TO PICTURE:C1017($Txt_Root; $Pic_Buffer)
	
	DOM CLOSE XML:C722($Txt_Root)
	
	$0:=$Pic_Buffer
	
End if 


