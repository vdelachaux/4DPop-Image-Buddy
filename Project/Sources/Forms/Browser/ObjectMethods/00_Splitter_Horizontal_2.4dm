C_LONGINT:C283($Lon_Bottom; $Lon_Left; $Lon_Right; $Lon_Top)

OBJECT GET COORDINATES:C663(<>Pic_display; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
OBJECT SET VISIBLE:C603(<>Pic_display; ($Lon_Bottom-$Lon_Top)>=30)

lstb_AUTOMATIC_SCROOLBARS(-><>tLstb_Picture)
obj_CENTER("_spinner"; "list_thumbnails"; Vertically centered:K39:4)
obj_CENTER("NoPicture"; "list_thumbnails"; Vertically centered:K39:4)

OBJECT GET COORDINATES:C663(*; "list_thumbnails"; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
OBJECT SET VISIBLE:C603(*; "NoPicture"; (($Lon_Bottom-$Lon_Top)>15) & (Size of array:C274(<>tPic_thumbnails)=0))
