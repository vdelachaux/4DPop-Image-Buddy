C_LONGINT:C283($Lon_Reference)
C_TEXT:C284($Txt_Element)
_O_C_STRING:C293(16; $a16_Menu)

$a16_Menu:=mnu_a16_From_List(<>Lst_resources)

$Lon_Reference:=Num:C11(Dynamic pop up menu:C1006($a16_Menu))

mnu_RELEASE_MENU($a16_Menu)

If ($Lon_Reference#0)
	
	GET LIST ITEM:C378(<>Lst_resources; List item position:C629(<>Lst_resources; $Lon_Reference); $Lon_Reference; $Txt_Element)
	OBJECT SET TITLE:C194(Self:C308->; $Txt_Element)
	
	SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_resources; $Lon_Reference)
	
	BROWSER_HANDLER("update")
	
	SET TIMER:C645(0)
	SET TIMER:C645(5)
	
End if 
