//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : svg_Pic_DrawText
// Created 23/01/08 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// Draw a text in a picture
// ----------------------------------------------------
C_PICTURE:C286($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
C_LONGINT:C283($6)
C_TEXT:C284($7)
C_LONGINT:C283($8)
C_LONGINT:C283($9)
C_LONGINT:C283($10)
C_LONGINT:C283($11)

C_LONGINT:C283($Lon_Aligment; $Lon_Font_Size; $Lon_i; $Lon_Parameters; $Lon_Picture_Height; $Lon_Picture_Width; $Lon_Rotate; $Lon_Styles; $Lon_Text_hOffset; $Lon_Text_vOffset)
C_LONGINT:C283($Lon_x)
C_PICTURE:C286($Pic_Buffer)
C_TEXT:C284($Txt_Color; $Txt_Font_Name; $Txt_Root; $Txt_Span; $Txt_Style; $Txt_Text; $Txt_TextBox)

If (False:C215)
	C_PICTURE:C286(svg_Pic_DrawText; $0)
	C_TEXT:C284(svg_Pic_DrawText; $1)
	C_LONGINT:C283(svg_Pic_DrawText; $2)
	C_TEXT:C284(svg_Pic_DrawText; $3)
	C_LONGINT:C283(svg_Pic_DrawText; $4)
	C_LONGINT:C283(svg_Pic_DrawText; $5)
	C_LONGINT:C283(svg_Pic_DrawText; $6)
	C_TEXT:C284(svg_Pic_DrawText; $7)
	C_LONGINT:C283(svg_Pic_DrawText; $8)
	C_LONGINT:C283(svg_Pic_DrawText; $9)
	C_LONGINT:C283(svg_Pic_DrawText; $10)
	C_LONGINT:C283(svg_Pic_DrawText; $11)
End if 

$Lon_Parameters:=Count parameters:C259
$Txt_Color:="black"

If ($Lon_Parameters>=1)
	$Txt_Text:=$1  //String
	If ($Lon_Parameters>=2)
		$Lon_Font_Size:=$2
		If ($Lon_Parameters>=3)
			$Txt_Font_Name:=$3
			If ($Lon_Parameters>=4)
				$Lon_Styles:=$4
				If ($Lon_Parameters>=5)
					$Lon_Picture_Width:=$5  //in Pixels
					If ($Lon_Parameters>=6)
						$Lon_Picture_Height:=$6  //in Pixels
						If ($Lon_Parameters>=7)
							$Txt_Color:=$7
							If ($Lon_Parameters>=8)
								$Lon_Text_hOffset:=$8  //Offset between the left side and the text 
								If ($Lon_Parameters>=9)
									$Lon_Text_vOffset:=$9  //Offset between the bottom side and the text 
									If ($Lon_Parameters>=10)
										$Lon_Aligment:=$10
										If ($Lon_Parameters>=11)
											$Lon_Rotate:=$11
										End if 
									End if 
								End if 
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
	End if 
	
	If ($Lon_Font_Size=0)
		$Lon_Font_Size:=12
	End if 
	
	If (Length:C16($Txt_Font_Name)>0)
		ARRAY TEXT:C222($tTxt_FontNames; 0x0000)
		FONT LIST:C460($tTxt_FontNames)
		$Txt_Font_Name:=$Txt_Font_Name*Num:C11(Find in array:C230($tTxt_FontNames; $Txt_Font_Name)>0)
	End if 
	
	If (Length:C16($Txt_Font_Name)=0) | True:C214
		//TABLEAU TEXTE($tTxt_FontNames;0x0000)
		//AJOUTER A TABLEAU($tTxt_FontNames;"Lucida Grande")
		//AJOUTER A TABLEAU($tTxt_FontNames;"Segoe UI")
		//AJOUTER A TABLEAU($tTxt_FontNames;"Tahoma")
		//AJOUTER A TABLEAU($tTxt_FontNames;"Verdana")
		//AJOUTER A TABLEAU($tTxt_FontNames;"MS Sans Serif")
		//Boucle ($Lon_i;1;Taille tableau($tTxt_FontNames);1)
		//$Lon_x:=Numero de police($tTxt_FontNames{$Lon_i})
		//Si ($Lon_x>0)
		//$Txt_Font_Name:=$tTxt_FontNames{$Lon_i}
		//$Lon_i:=MAXLONG-1
		//Fin de si 
		//Fin de boucle 
		
		$Txt_Font_Name:="'"+OBJECT Get font:C1069(*; "automatic_font")+"'"
		
	End if 
	
	$Txt_Root:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg")
	DOM SET XML ATTRIBUTE:C866($Txt_Root; "text-rendering"; "geometricPrecision")
	
	If ($Lon_Picture_Width>0)
		DOM SET XML ATTRIBUTE:C866($Txt_Root; "width"; String:C10($Lon_Picture_Width)+"px")
		$Lon_Text_vOffset:=$Lon_Text_vOffset+($Lon_Font_Size*Num:C11($Lon_Text_vOffset=0))
		$Lon_Picture_Height:=$Lon_Picture_Height+(($Lon_Font_Size*1.2)*Num:C11($Lon_Picture_Height=0))
		If ($Lon_Aligment#0)
			If ($Lon_Text_hOffset=0)
				Case of 
						//.....................................................    
					: ($Lon_Aligment=Align center:K42:3)
						$Lon_Text_hOffset:=$Lon_Picture_Width/2
						//.....................................................    
					: ($Lon_Aligment=Align right:K42:4)
						$Lon_Text_hOffset:=$Lon_Picture_Width
						//.....................................................    
					: ($Lon_Aligment=Align left:K42:2)
						$Lon_Text_hOffset:=0
						//.....................................................    
					: ($Lon_Aligment=Align default:K42:1)
						$Lon_Text_hOffset:=0
						//.....................................................    
				End case 
				
			End if 
		End if 
	End if 
	
	
	If ($Lon_Picture_Height>0)
		DOM SET XML ATTRIBUTE:C866($Txt_Root; "height"; String:C10($Lon_Picture_Height)+"px")
		$Lon_Text_vOffset:=$Lon_Text_vOffset+($Lon_Font_Size*Num:C11($Lon_Text_vOffset=0))
	End if 
	
	$Txt_TextBox:=DOM Create XML element:C865($Txt_Root; "svg/text")
	
	DOM SET XML ATTRIBUTE:C866($Txt_TextBox; "x"; String:C10($Lon_Text_hOffset))
	DOM SET XML ATTRIBUTE:C866($Txt_TextBox; "y"; String:C10($Lon_Text_vOffset))
	
	If (Length:C16($Txt_Color)>0)
		$Txt_Style:="fill:"+$Txt_Color+"; "
	End if 
	
	$Txt_Style:=$Txt_Style+"font-size:"+String:C10($Lon_Font_Size)+"px; "
	
	If ($Lon_Styles>0)
		If ($Lon_Styles>Bold:K14:2)
			$Txt_Style:=$Txt_Style+"font-style:italic; "
			$Lon_Styles:=$Lon_Styles-Italic:K14:3
		End if 
		If ($Lon_Styles=Bold:K14:2)
			$Txt_Style:=$Txt_Style+"font-weight:bold; "
		End if 
	End if 
	$Txt_Style:=$Txt_Style+"font-family:"+$Txt_Font_Name
	
	If ($Lon_Aligment#0)
		$Txt_Style:=$Txt_Style+"; "+"text-anchor:"
		Case of 
				//.....................................................    
			: ($Lon_Aligment=Align center:K42:3)
				$Txt_Style:=$Txt_Style+"middle"
				//.....................................................    
			: ($Lon_Aligment=Align right:K42:4)
				$Txt_Style:=$Txt_Style+"end"
				//.....................................................    
			: ($Lon_Aligment=Align left:K42:2)
				$Txt_Style:=$Txt_Style+"start"
				//.....................................................    
			: ($Lon_Aligment=Align default:K42:1)
				$Txt_Style:=$Txt_Style+"start"
				//.....................................................    
		End case 
	End if 
	
	DOM SET XML ATTRIBUTE:C866($Txt_TextBox; "style"; $Txt_Style)
	
	If ($Lon_Rotate#0)
		DOM SET XML ATTRIBUTE:C866($Txt_TextBox; "transform"; "rotate("+String:C10($Lon_Rotate)+")")
	End if 
	
	
	$Lon_x:=Position:C15("\r"; $Txt_Text)
	If ($Lon_x>0)
		$Txt_Span:=DOM Create XML element:C865($Txt_TextBox; "tspan"; "x"; String:C10($Lon_Text_hOffset); "y"; String:C10($Lon_Text_vOffset))
		DOM SET XML ELEMENT VALUE:C868($Txt_Span; Substring:C12($Txt_Text; 1; $Lon_x-1))
		$Txt_Span:=DOM Create XML element:C865($Txt_TextBox; "tspan"; "x"; String:C10($Lon_Text_hOffset); "y"; String:C10($Lon_Text_vOffset+($Lon_Font_Size*1.2)))
		DOM SET XML ELEMENT VALUE:C868($Txt_Span; Substring:C12($Txt_Text; $Lon_x+1))
	Else 
		DOM SET XML ELEMENT VALUE:C868($Txt_TextBox; $Txt_Text)
	End if 
	
	SVG EXPORT TO PICTURE:C1017($Txt_Root; $Pic_Buffer)
	
	DOM CLOSE XML:C722($Txt_Root)
	
	$0:=$Pic_Buffer
	
Else 
	
	TRACE:C157
	
End if 
