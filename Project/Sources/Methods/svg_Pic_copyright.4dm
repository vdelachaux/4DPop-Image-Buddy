//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : svg_Pic_copyright
// ----------------------------------------------------
C_PICTURE:C286($0)
C_TEXT:C284($1)

C_PICTURE:C286($Pic_Buffer)
C_TEXT:C284($Dom_root; $Txt_SVG)

If (False:C215)
	C_PICTURE:C286(svg_Pic_copyright; $0)
	C_TEXT:C284(svg_Pic_copyright; $1)
End if 

$Txt_SVG:=$Txt_SVG+"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\" ?>\r"
$Txt_SVG:=$Txt_SVG+"<svg xmlns=\"http://www.w3.org/2000/svg\">\r"
$Txt_SVG:=$Txt_SVG+" <textArea fill=\"#5084C2\" font-family=\"'"
$Txt_SVG:=$Txt_SVG+OBJECT Get font:C1069(*; "")
$Txt_SVG:=$Txt_SVG+"'\" font-size=\"10\" height=\"auto\" stroke=\"#5084C2\" transform=\"rotate(-90) translate(-125,0)\" width=\"auto\">"
$Txt_SVG:=$Txt_SVG+$1
$Txt_SVG:=$Txt_SVG+"</textArea>\r"
$Txt_SVG:=$Txt_SVG+"</svg>"

$Dom_root:=DOM Parse XML variable:C720($Txt_SVG)

If (OK=1)
	
	SVG EXPORT TO PICTURE:C1017($Dom_root; $Pic_Buffer)
	
	DOM CLOSE XML:C722($Dom_root)
	
End if 

$0:=$Pic_Buffer