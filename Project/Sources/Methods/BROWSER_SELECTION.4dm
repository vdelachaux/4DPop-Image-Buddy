//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : BROWSER_SELECTION
// Created 08/12/06 by vdl
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($Boo_Unselect)
C_LONGINT:C283($Lon_Column; $Lon_Columns; $Lon_First; $Lon_i; $Lon_Line; $Lon_Lines; $Lon_Select; $Lon_Selected; $Lon_x)
C_POINTER:C301($Ptr_Array)

If (False:C215)
	C_TEXT:C284(BROWSER_SELECTION; $1)
	C_LONGINT:C283(BROWSER_SELECTION; $2)
End if 

$Lon_Columns:=LISTBOX Get number of columns:C831(<>tLstb_Picture)
$Lon_Lines:=LISTBOX Get number of rows:C915(<>tLstb_Picture)
$Lon_Selected:=Size of array:C274(<>tLon_Selected)

Case of 
		//______________________________________________________
	: (Count parameters:C259=0)
		
		Case of 
				
				//……………………………………………………………………………
			: (Shift down:C543)
				
				//……………………………………………………………………………
			: (Macintosh command down:C546) | (Windows Alt down:C563)
				
				LISTBOX GET CELL POSITION:C971(<>tLstb_Picture; $Lon_Column; $Lon_Line)
				$Lon_Select:=($Lon_Columns*($Lon_Line-1))+$Lon_Column
				$Lon_x:=Find in array:C230(<>tLon_Selected; $Lon_Select)
				
				If ($Lon_x>0)
					
					$Lon_Column:=$Lon_Select%$Lon_Columns
					$Lon_Line:=($Lon_Select\$Lon_Columns)+1
					
					If ($Lon_Column=0)
						
						$Lon_Line:=$Lon_Line-1
						$Lon_Column:=$Lon_Columns
						
					End if 
					
					$Ptr_Array:=Get pointer:C304("<>tPic_"+String:C10($Lon_Column))
					$Ptr_Array->{$Lon_Line}:=<>tPic_thumbnails{$Lon_Select}
					DELETE FROM ARRAY:C228(<>tLon_Selected; $Lon_x; 1)
					$Lon_Selected:=Size of array:C274(<>tLon_Selected)
					
					If (<>tLon_Selected{0}=$Lon_Select)
						
						<>tLon_Selected{0}:=<>tLon_Selected{$Lon_Selected}*Num:C11($Lon_Selected>0)
						
					End if 
					
					$Boo_Unselect:=True:C214
					
				End if 
				
				//……………………………………………………………………………
			: ($Lon_Selected=0)
				
				//……………………………………………………………………………
			Else 
				
				BROWSER_SELECTION("Unselect")
				<>tLon_Selected{0}:=0
				$Lon_Selected:=0
				
				//……………………………………………………………………………
		End case 
		
		If (Not:C34($Boo_Unselect))
			
			LISTBOX GET CELL POSITION:C971(<>tLstb_Picture; $Lon_Column; $Lon_Line)
			$Lon_Select:=($Lon_Columns*($Lon_Line-1))+$Lon_Column
			
			If ($Lon_Select>0) & ($Lon_Select<=<>Lon_File_Number)
				
				Case of 
						
						//……………………………………………………………………………
					: (Shift down:C543 & (Size of array:C274(<>tLon_Selected)>0) & (Find in array:C230(<>tLon_Selected; $Lon_Select)=-1))
						
						BROWSER_SELECTION("Expand"; $Lon_Select)
						
						//……………………………………………………………………………
					Else 
						
						If ($Lon_Select<=Size of array:C274(<>tPic_thumbnails))
							
							APPEND TO ARRAY:C911(<>tLon_Selected; $Lon_Select)
							<>tLon_Selected{0}:=$Lon_Select
							$Ptr_Array:=Get pointer:C304("<>tPic_"+String:C10($Lon_Column))
							
							If ($Lon_Line<=Size of array:C274($Ptr_Array->))
								
								COMBINE PICTURES:C987($Ptr_Array->{$Lon_Line}; <>kPic_Selected; Superimposition:K61:10; <>tPic_thumbnails{$Lon_Select})
								
							End if 
							
						Else 
							
							<>tLon_Selected{0}:=0
							
						End if 
						
						//……………………………………………………………………………
				End case 
				
			End if 
		End if 
		
		//______________________________________________________
	: ($1="Unselect")
		
		If ($Lon_Columns#0)
			
			For ($Lon_i; 1; $Lon_Selected; 1)
				
				$Lon_Select:=<>tLon_Selected{$Lon_i}
				$Lon_Column:=$Lon_Select%$Lon_Columns
				$Lon_Line:=($Lon_Select\$Lon_Columns)+1
				
				If ($Lon_Column=0)
					
					$Lon_Line:=$Lon_Line-1
					$Lon_Column:=$Lon_Columns
					
				End if 
				
				If ($Lon_Line>0)
					
					$Ptr_Array:=Get pointer:C304("<>tPic_"+String:C10($Lon_Column))
					
					If ($Lon_Line<=Size of array:C274($Ptr_Array->))
						
						$Ptr_Array->{$Lon_Line}:=<>tPic_thumbnails{$Lon_Select}
						
					End if 
				End if 
				
			End for 
			
		End if 
		
		DELETE FROM ARRAY:C228(<>tLon_Selected; 1; $Lon_Selected)
		
		//______________________________________________________
	: ($1="Redo") & ($Lon_Columns#0)
		
		For ($Lon_i; 1; Size of array:C274(<>tLon_Selected); 1)
			
			$Lon_Column:=<>tLon_Selected{$Lon_i}%$Lon_Columns
			$Lon_Line:=(<>tLon_Selected{$Lon_i}\$Lon_Columns)+1
			
			If ($Lon_Column=0)
				
				$Lon_Line:=$Lon_Line-1
				$Lon_Column:=$Lon_Columns
				
			End if 
			
			$Ptr_Array:=Get pointer:C304("<>tPic_"+String:C10($Lon_Column))
			
			If ($Lon_Line<=Size of array:C274($Ptr_Array->))
				
				COMBINE PICTURES:C987($Ptr_Array->{$Lon_Line}; <>kPic_Selected; Superimposition:K61:10; <>tPic_thumbnails{<>tLon_Selected{$Lon_i}})
				
			End if 
			
		End for 
		
		//______________________________________________________
	: ($1="Expand")
		
		$Lon_First:=<>tLon_Selected{0}+Num:C11(<>tLon_Selected{0}=0)
		$Lon_Select:=$2
		
		If ($Lon_Select>0)
			
			For ($Lon_i; $Lon_First; $Lon_Select; Num:C11($Lon_Select>=$Lon_First)-Num:C11($Lon_Select<$Lon_First))
				
				If (Find in array:C230(<>tLon_Selected; $Lon_i)=-1)
					
					APPEND TO ARRAY:C911(<>tLon_Selected; $Lon_i)
					$Lon_Column:=$Lon_i%$Lon_Columns
					$Lon_Line:=($Lon_i\$Lon_Columns)+1
					
					If ($Lon_Column=0)
						
						$Lon_Line:=$Lon_Line-1
						$Lon_Column:=$Lon_Columns
						
					End if 
					
					<>tLon_Selected{0}:=$Lon_i
					$Ptr_Array:=Get pointer:C304("<>tPic_"+String:C10($Lon_Column))
					
					If ($Lon_Line<=Size of array:C274($Ptr_Array->))
						
						COMBINE PICTURES:C987($Ptr_Array->{$Lon_Line}; <>kPic_Selected; Superimposition:K61:10; <>tPic_thumbnails{$Lon_i})
						
					End if 
				End if 
				
			End for 
			
			OBJECT SET SCROLL POSITION:C906(<>tLstb_Picture; $Lon_Line)
			
		End if 
		
		//______________________________________________________
	: ($1="Next")
		
		If (<>tLon_Selected{0}<<>Lon_File_Number)
			
			$Lon_Select:=<>tLon_Selected{0}+1
			
			If (Shift down:C543)
				
				BROWSER_SELECTION("Expand"; $Lon_Select)
				
			Else 
				
				BROWSER_SELECTION("Unselect")
				
				$Lon_Column:=$Lon_Select%$Lon_Columns
				$Lon_Line:=($Lon_Select\$Lon_Columns)+1
				
				If ($Lon_Column=0)
					
					$Lon_Line:=$Lon_Line-1
					$Lon_Column:=$Lon_Columns
					
				End if 
				
				$Ptr_Array:=Get pointer:C304("<>tPic_"+String:C10($Lon_Column))
				APPEND TO ARRAY:C911(<>tLon_Selected; $Lon_Select)
				<>tLon_Selected{0}:=$Lon_Select
				$Ptr_Array:=Get pointer:C304("<>tPic_"+String:C10($Lon_Column))
				
				If ($Lon_Line<=Size of array:C274($Ptr_Array->))
					
					COMBINE PICTURES:C987($Ptr_Array->{$Lon_Line}; <>kPic_Selected; Superimposition:K61:10; <>tPic_thumbnails{$Lon_Select})
					OBJECT SET SCROLL POSITION:C906(<>tLstb_Picture; $Lon_Line)
					
				End if 
			End if 
			
		Else 
			
			BEEP:C151
			
		End if 
		
		//______________________________________________________
	: ($1="Previous")
		
		If (<>tLon_Selected{0}>1)
			
			$Lon_Select:=<>tLon_Selected{0}-1
			
			If (Shift down:C543)
				
				BROWSER_SELECTION("Expand"; $Lon_Select)
				
			Else 
				
				BROWSER_SELECTION("Unselect")
				$Lon_Column:=$Lon_Select%$Lon_Columns
				$Lon_Line:=($Lon_Select\$Lon_Columns)+1
				
				If ($Lon_Column=0)
					
					$Lon_Line:=$Lon_Line-1
					$Lon_Column:=$Lon_Columns
					
				End if 
				
				$Ptr_Array:=Get pointer:C304("<>tPic_"+String:C10($Lon_Column))
				APPEND TO ARRAY:C911(<>tLon_Selected; $Lon_Select)
				<>tLon_Selected{0}:=$Lon_Select
				$Ptr_Array:=Get pointer:C304("<>tPic_"+String:C10($Lon_Column))
				
				If ($Lon_Line<=Size of array:C274($Ptr_Array->))
					
					COMBINE PICTURES:C987($Ptr_Array->{$Lon_Line}; <>kPic_Selected; Superimposition:K61:10; <>tPic_thumbnails{$Lon_Select})
					OBJECT SET SCROLL POSITION:C906(<>tLstb_Picture; $Lon_Line)
					
				End if 
			End if 
			
		Else 
			
			BEEP:C151
			
		End if 
		
		//______________________________________________________
	: ($1="Up")
		
		If ((<>tLon_Selected{0}-$Lon_Columns)>=1)
			
			$Lon_Select:=<>tLon_Selected{0}-$Lon_Columns
			
			If (Shift down:C543)
				
				BROWSER_SELECTION("Expand"; $Lon_Select)
				
			Else 
				
				BROWSER_SELECTION("Unselect")
				$Lon_Column:=$Lon_Select%$Lon_Columns
				$Lon_Line:=($Lon_Select\$Lon_Columns)+1
				
				If ($Lon_Column=0)
					
					$Lon_Line:=$Lon_Line-1
					$Lon_Column:=$Lon_Columns
					
				End if 
				
				$Ptr_Array:=Get pointer:C304("<>tPic_"+String:C10($Lon_Column))
				APPEND TO ARRAY:C911(<>tLon_Selected; $Lon_Select)
				<>tLon_Selected{0}:=$Lon_Select
				$Ptr_Array:=Get pointer:C304("<>tPic_"+String:C10($Lon_Column))
				
				If ($Lon_Line<=Size of array:C274($Ptr_Array->))
					
					COMBINE PICTURES:C987($Ptr_Array->{$Lon_Line}; <>kPic_Selected; Superimposition:K61:10; <>tPic_thumbnails{$Lon_Select})
					OBJECT SET SCROLL POSITION:C906(<>tLstb_Picture; $Lon_Line)
					
				End if 
			End if 
			
		Else 
			
			BEEP:C151
			
		End if 
		
		//______________________________________________________
	: ($1="Down")
		
		If ((<>tLon_Selected{0}+$Lon_Columns)<=<>Lon_File_Number)
			
			$Lon_Select:=Choose:C955(<>tLon_Selected{0}>0; <>tLon_Selected{0}+$Lon_Columns; 1)
			
			If (Shift down:C543)
				
				BROWSER_SELECTION("Expand"; $Lon_Select)
				
			Else 
				
				BROWSER_SELECTION("Unselect")
				$Lon_Column:=$Lon_Select%$Lon_Columns
				$Lon_Line:=($Lon_Select\$Lon_Columns)+1
				
				If ($Lon_Column=0)
					$Lon_Line:=$Lon_Line-1
					$Lon_Column:=$Lon_Columns
				End if 
				
				$Ptr_Array:=Get pointer:C304("<>tPic_"+String:C10($Lon_Column))
				APPEND TO ARRAY:C911(<>tLon_Selected; $Lon_Select)
				<>tLon_Selected{0}:=$Lon_Select
				$Ptr_Array:=Get pointer:C304("<>tPic_"+String:C10($Lon_Column))
				
				If ($Lon_Line<=Size of array:C274($Ptr_Array->))
					
					COMBINE PICTURES:C987($Ptr_Array->{$Lon_Line}; <>kPic_Selected; Superimposition:K61:10; <>tPic_thumbnails{$Lon_Select})
					OBJECT SET SCROLL POSITION:C906(<>tLstb_Picture; $Lon_Line)
					
				End if 
			End if 
			
		Else 
			
			BEEP:C151
			
		End if 
		
		//______________________________________________________
	: ($1="All")
		
		<>tLon_Selected{0}:=1
		BROWSER_SELECTION("Expand"; <>Lon_File_Number)
		
		//______________________________________________________
End case 

If (Size of array:C274(<>tLon_Selected)=1)
	
	//LIRE FICHIER IMAGE(<>tTxt_File_Paths{<>tLon_Selected{0}};<>Pic_Display)
	READ PICTURE FILE:C678(<>tTxt_filePaths{<>tLon_Selected{0}}; OBJECT Get pointer:C1124(Object named:K67:5; "preview")->)
	// Modified by Vincent de Lachaux (15/03/12)
	//<>Txt_Picture_Name:=<>tTxt_File_Names{<>tLon_Selected{0}}
	<>Txt_pictureName:="~/"+Replace string:C233(Convert path system to POSIX:C1106(<>tTxt_filePaths{<>tLon_Selected{0}}); Convert path system to POSIX:C1106(Get 4D folder:C485(Current resources folder:K5:16; *)); ""; 1)
	
	<>Txt_Picture_Size:=Tool_gTxt_BytesToString(Picture size:C356(<>Pic_display); "K"; ""; ""; 1)
	PICTURE PROPERTIES:C457(<>Pic_display; <>Lon_Picture_Width; <>Lon_Picture_Height)
	
Else 
	
	CLEAR VARIABLE:C89(<>Pic_display)
	CLEAR VARIABLE:C89(<>Txt_pictureName)
	CLEAR VARIABLE:C89(<>Txt_Picture_Size)
	CLEAR VARIABLE:C89(<>Lon_Picture_Width)
	CLEAR VARIABLE:C89(<>Lon_Picture_Height)
	
End if 