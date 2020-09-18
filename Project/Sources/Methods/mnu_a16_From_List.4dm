//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : MNU_a16_From_List
// Created 24/08/06 by vdl
// ----------------------------------------------------
// Description
// Create a Menu from a hierarchical list
// ----------------------------------------------------
_O_C_STRING:C293(16; $0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($Boo_Expanded)
C_LONGINT:C283($Lon_Buffer; $Lon_i; $Lon_List; $Lon_Reference; $Lon_Sublist)
C_PICTURE:C286($Pic_Buffer)
C_TEXT:C284($Txt_Buffer; $Txt_Element)
_O_C_STRING:C293(16; $a16_Menu)
_O_C_STRING:C293(255; $a16_Submenu)

If (False:C215)
	_O_C_STRING:C293(mnu_a16_From_List; 16; $0)
	C_LONGINT:C283(mnu_a16_From_List; $1)
End if 

$Lon_List:=Copy list:C626($1)

$a16_Menu:=Create menu:C408

For ($Lon_i; 1; Count list items:C380($Lon_List); 1)
	
	$Lon_Sublist:=0
	
	GET LIST ITEM:C378($Lon_List; $Lon_i; $Lon_Reference; $Txt_Element; $Lon_Sublist; $Boo_Expanded)
	
	If (Is a list:C621($Lon_Sublist))  //Menu hiérarchique
		
		$a16_Submenu:=mnu_a16_From_List($Lon_Sublist)  //<- Recursive
		INSERT MENU ITEM:C412($a16_Submenu; 0; $Txt_Element)
		SET MENU ITEM ICON:C984($a16_Submenu; -1; 2101)
		SET MENU ITEM PARAMETER:C1004($a16_Submenu; -1; String:C10($Lon_Reference))
		INSERT MENU ITEM:C412($a16_Submenu; 1; "(-")
		APPEND MENU ITEM:C411($a16_Menu; $Txt_Element; $a16_Submenu)
		
		If ($Boo_Expanded)
			$Lon_i:=$Lon_i+Count list items:C380($Lon_Sublist)
		End if 
		
		CLEAR LIST:C377($Lon_Sublist; *)
		
	Else   //Item
		
		APPEND MENU ITEM:C411($a16_Menu; $Txt_Element)
		SET MENU ITEM PARAMETER:C1004($a16_Menu; -1; $Txt_Element)
		SET MENU ITEM ICON:C984($a16_Menu; -1; 2101)
		SET MENU ITEM PARAMETER:C1004($a16_Menu; -1; String:C10($Lon_Reference))
		
	End if 
	
End for 

CLEAR LIST:C377($Lon_List; *)

$0:=$a16_Menu
