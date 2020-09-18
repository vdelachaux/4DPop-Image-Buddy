C_LONGINT:C283($Lon_Bottom; $Lon_Height; $Lon_Left; $Lon_Right; $Lon_Top; $Lon_Width; $Lon_x; $Lon_y)

Case of 
		//______________________________________________________
	: (Form event code:C388=On Data Change:K2:15)
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
		OBJECT SET VISIBLE:C603(*; "tip.scale"; True:C214)
		
		//______________________________________________________
	: (Form event code:C388=On Mouse Enter:K2:33)
		OBJECT SET VISIBLE:C603(*; "tip.scale"; True:C214)
		//______________________________________________________
	: (Form event code:C388=On Mouse Leave:K2:34)
		OBJECT SET VISIBLE:C603(*; "tip.scale"; False:C215)
		//______________________________________________________
	Else 
		SET TIMER:C645(-1)
		//______________________________________________________
End case 


