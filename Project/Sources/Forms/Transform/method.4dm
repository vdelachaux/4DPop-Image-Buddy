// ----------------------------------------------------
// Method : Méthode formulaire : Transform
// Created 13/02/08 by Vincent de Lachaux
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_BLOB:C604($Blb_Buffer)
C_LONGINT:C283($Lon_Bottom; $Lon_Event; $Lon_Height; $Lon_Left; $Lon_Right; $Lon_Top; $Lon_Width; $Lon_x; $Lon_y)
C_TIME:C306($Gmt_File)
C_PICTURE:C286($Pic_Buffer)
C_TEXT:C284($Txt_Extension; $Txt_Name; $Txt_Path)

$Lon_Event:=Form event code:C388

Case of 
		//______________________________________________________
	: ($Lon_Event=On Load:K2:1)
		
		PICTURE CODEC LIST:C992(<>tTxt_Codecs; <>tTxt_Names)
		
		$Txt_Extension:="."+doc_Txt_Path_Handler("get.extension"; <>Txt_fileName)
		<>tTxt_Names:=Abs:C99(Find in array:C230(<>tTxt_Codecs; $Txt_Extension))
		<>b1:=0
		<>b2:=0
		<>b3:=0
		<>b4:=0
		<>b5:=0
		<>b6:=0
		<>Lon_Scale:=100
		
		OBJECT SET VISIBLE:C603(*; "dev.@"; Shift down:C543)
		
		OBJECT GET COORDINATES:C663(*; "ruler.scale"; $Lon_x; $Lon_y; $Lon_Right; $Lon_Bottom)
		$Lon_x:=$Lon_x+((($Lon_Right-$Lon_x)/100)*<>Lon_Scale)
		OBJECT GET COORDINATES:C663(*; "tip.scale"; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
		$Lon_Width:=($Lon_Right-$Lon_Left)
		$Lon_Height:=($Lon_Bottom-$Lon_Top)
		$Lon_Left:=$Lon_x
		$Lon_Right:=$Lon_x+$Lon_Width
		$Lon_Top:=$Lon_y-$Lon_Height
		$Lon_Bottom:=$Lon_Top+$Lon_Height
		OBJECT MOVE:C664(*; "tip.scale"; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom; *)
		
		SET TIMER:C645(-1)
		
	: ($Lon_Event=On Timer:K2:25)
		SET TIMER:C645(0)
		
		BROWSER_HANDLER("Transform")
		
		If (Focus object:C278=(-><>Txt_fileName))
			HIGHLIGHT TEXT:C210(<>Txt_fileName; 1; Length:C16($Txt_Name)+1)
		End if 
		
		//______________________________________________________
	: (False:C215)
		//______________________________________________________
	Else 
		//______________________________________________________
End case 


