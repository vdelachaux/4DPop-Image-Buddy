//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : BROWSER_FILL
// Created 07/12/06 by vdl
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)

C_BOOLEAN:C305($Boo_Refill)
C_LONGINT:C283($kLon_columnNumber; $Lon_BarWidth; $Lon_Bottom; $Lon_Cells; $Lon_Column; $Lon_ColumnNumber; $Lon_ColumnWidth; $Lon_i; $Lon_Left; $Lon_Line)
C_LONGINT:C283($Lon_ListHeight; $Lon_ListWidth; $Lon_NewColumnNumbers; $Lon_Right; $Lon_Top; $Lon_Values; $Lon_x)
C_POINTER:C301($Ptr_Head; $Ptr_Col)
C_TEXT:C284($Txt_ColName)

ARRAY BOOLEAN:C223($tBoo_Visible; 0)
ARRAY PICTURE:C279($Lon_LineNumber; 0)
ARRAY POINTER:C280($tPtr_Styles; 0)
ARRAY POINTER:C280($tPtr_VarCols; 0)
ARRAY POINTER:C280($tPtr_VarHeaders; 0)
ARRAY TEXT:C222($tTxt_ColumnNames; 0)
ARRAY TEXT:C222($tTxt_HeaderNames; 0)

If (False:C215)
	C_POINTER:C301(BROWSER_FILL; $1)
	C_POINTER:C301(BROWSER_FILL; $2)
End if 

$Lon_Values:=Size of array:C274($2->)

DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_thumb; "cellule-width"; $Lon_ColumnWidth)
DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_thumb; "max-column"; $kLon_columnNumber)

//LISTBOX GET ARRAYS($1->;$tTxt_ColumnNames;$tTxt_HeaderNames;$tPtr_VarCols;$tPtr_VarHeaders;$tBoo_Visible;$tPtr_Styles)

If (LISTBOX Get property:C917($1->; _o_lk display ver scrollbar:K53:8)=1)
	
	$Lon_BarWidth:=LISTBOX Get property:C917($1->; lk ver scrollbar width:K53:9)
	
Else 
	
	$Lon_BarWidth:=0
	
End if 

OBJECT GET COORDINATES:C663($1->; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
$Lon_ListWidth:=$Lon_Right-$Lon_Left-$Lon_BarWidth

$Lon_ColumnNumber:=LISTBOX Get number of columns:C831($1->)

If ($Lon_Values>0)
	
	$Lon_NewColumnNumbers:=Int:C8($Lon_ListWidth/$Lon_ColumnWidth)
	$Lon_NewColumnNumbers:=$Lon_NewColumnNumbers+Num:C11($Lon_NewColumnNumbers<1)
	$Lon_LineNumber:=Int:C8($Lon_Values/$Lon_NewColumnNumbers)+Num:C11(Mod:C98($Lon_Values; $Lon_NewColumnNumbers)#0)
	$Lon_Cells:=$Lon_NewColumnNumbers*$Lon_LineNumber
	
	$Lon_ListHeight:=$Lon_Bottom-$Lon_Top
	
	If ($Lon_BarWidth=0)
		
		If (($Lon_LineNumber*$Lon_ColumnWidth)>$Lon_ListHeight)
			
			$Lon_ListWidth:=$Lon_ListWidth-15
			$Lon_NewColumnNumbers:=Int:C8($Lon_ListWidth/$Lon_ColumnWidth)
			$Lon_NewColumnNumbers:=$Lon_NewColumnNumbers+Num:C11($Lon_NewColumnNumbers<1)
			$Lon_LineNumber:=Int:C8($Lon_Values/$Lon_NewColumnNumbers)+Num:C11(Mod:C98($Lon_Values; $Lon_NewColumnNumbers)#0)
			$Lon_Cells:=$Lon_NewColumnNumbers*$Lon_LineNumber
			
		End if 
		
	Else 
		
		If (($Lon_LineNumber*$Lon_ColumnWidth)<=$Lon_ListHeight)
			
			$Lon_ListWidth:=$Lon_ListWidth+15
			$Lon_NewColumnNumbers:=Int:C8($Lon_ListWidth/$Lon_ColumnWidth)
			$Lon_NewColumnNumbers:=$Lon_NewColumnNumbers+Num:C11($Lon_NewColumnNumbers<1)
			$Lon_LineNumber:=Int:C8($Lon_Values/$Lon_NewColumnNumbers)+Num:C11(Mod:C98($Lon_Values; $Lon_NewColumnNumbers)#0)
			$Lon_Cells:=$Lon_NewColumnNumbers*$Lon_LineNumber
			
		End if 
	End if 
	
	If ($Lon_NewColumnNumbers>$kLon_columnNumber)
		
		$Lon_NewColumnNumbers:=$kLon_columnNumber
		
	End if 
	
	OBJECT SET VISIBLE:C603(*; "NoPicture"; False:C215)
	
Else 
	
	OBJECT GET COORDINATES:C663(*; "list_thumbnails"; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
	OBJECT SET VISIBLE:C603(*; "NoPicture"; ($Lon_Bottom-$Lon_Top)>15)
	
End if 

$Boo_Refill:=True:C214

Case of 
		
		//________________________________________
	: ($Lon_NewColumnNumbers=0)
		
		LISTBOX DELETE COLUMN:C830($1->; 1; $Lon_ColumnNumber)
		$Boo_Refill:=False:C215
		
		//________________________________________
	: ($Lon_NewColumnNumbers=$Lon_ColumnNumber)
		
		$Boo_Refill:=False:C215
		
		//________________________________________
	: ($Lon_NewColumnNumbers>$Lon_ColumnNumber)
		
		For ($Lon_i; 1; $Lon_NewColumnNumbers; 1)
			
			$Ptr_Col:=Get pointer:C304("<>tPic_"+String:C10($Lon_i))
			ARRAY PICTURE:C279($Ptr_Col->; $Lon_LineNumber)
			
			If ($Lon_i>$Lon_ColumnNumber)
				
				$Txt_ColName:="Column_"+String:C10($Lon_i)
				
				//$Ptr_Head:=Pointeur vers("<>Lon_Header_"+Chaine($Lon_i))
				//LISTBOX INSERER COLONNE($1->;$Lon_i+1;$Txt_ColName;$Ptr_Col->;"Head_"+Chaine($Lon_i);$Ptr_Head->)
				LISTBOX INSERT COLUMN:C829($1->; $Lon_i+1; $Txt_ColName; $Ptr_Col->; "Head_"+String:C10($Lon_i); $Ptr_Head)
				OBJECT SET FORMAT:C236(*; $Txt_ColName; Char:C90(Scaled to fit prop centered:K6:6))
				LISTBOX SET COLUMN WIDTH:C833(*; $Txt_ColName; $Lon_ColumnWidth)
				
			End if 
		End for 
		
		//________________________________________
	: ($Lon_NewColumnNumbers<$Lon_ColumnNumber)
		
		For ($Lon_i; 1; $Lon_ColumnNumber; 1)
			
			$Ptr_Col:=Get pointer:C304("<>tPic_"+String:C10($Lon_i))
			
			If ($Lon_i>$Lon_NewColumnNumbers)
				
				LISTBOX DELETE COLUMN:C830($1->; $Lon_i; 1)
				
			Else 
				
				$Txt_ColName:="Column_"+String:C10($Lon_i)
				ARRAY PICTURE:C279($Ptr_Col->; $Lon_LineNumber)
				LISTBOX SET COLUMN WIDTH:C833(*; $Txt_ColName; $Lon_ColumnWidth)
				
			End if 
		End for 
		
		//________________________________________
End case 

If ($Boo_Refill)
	
	$Lon_Line:=1
	$Lon_Column:=1
	$Ptr_Col:=Get pointer:C304("<>tPic_"+String:C10($Lon_Column))
	OBJECT SET FORMAT:C236($Ptr_Col->; Char:C90(22))
	
	For ($Lon_i; 1; $Lon_Cells; 1)
		
		If ($Lon_Column>$Lon_NewColumnNumbers)
			
			$Lon_Line:=$Lon_Line+1
			$Lon_Column:=1
			
		End if 
		
		$Ptr_Col:=Get pointer:C304("<>tPic_"+String:C10($Lon_Column))
		
		If ($Lon_i>$Lon_Values)
			
			$Ptr_Col->{$Lon_Line}:=$Ptr_Col->{$Lon_Line}*0
			
		Else 
			
			$Ptr_Col->{$Lon_Line}:=$2->{$Lon_i}
			OBJECT SET FORMAT:C236($Ptr_Col->{$Lon_Line}; Char:C90(22))
			
		End if 
		
		$Lon_Column:=$Lon_Column+1
		
	End for 
	
	LISTBOX SET ROWS HEIGHT:C835($1->; $Lon_ColumnWidth)
	
Else 
	
	If ($Lon_ColumnNumber>0)
		
		$Lon_x:=Choose:C955($Lon_ColumnNumber>1; $Lon_ListWidth\$Lon_ColumnNumber; $Lon_ColumnWidth)
		
		For ($Lon_i; 1; $Lon_ColumnNumber; 1)
			
			$Txt_ColName:="Column_"+String:C10($Lon_i)
			LISTBOX SET COLUMN WIDTH:C833(*; $Txt_ColName; $Lon_x)
			
		End for 
		
		LISTBOX SET ROWS HEIGHT:C835($1->; $Lon_x)
		
	Else 
		
		LISTBOX SET ROWS HEIGHT:C835($1->; 1; lk lines:K53:23)
		
	End if 
End if 

OBJECT SET SCROLLBAR:C843($1->; False:C215; False:C215)