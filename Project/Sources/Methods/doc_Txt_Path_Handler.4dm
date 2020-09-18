//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : doc_Txt_Path_Handler
// Created 03/11/06 by vdl
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_LONGINT:C283($Lon_i; $Lon_Length; $Lon_Parameters; $Lon_Platform; $Lon_Position; $Lon_x)
C_TIME:C306($Gmt_)
C_TEXT:C284($kTxt_Separator; $Txt_Buffer; $Txt_Entrypoint; $Txt_file; $Txt_Path; $Txt_Result; $Txt_Volume)

If (False:C215)
	C_TEXT:C284(doc_Txt_Path_Handler; $0)
	C_TEXT:C284(doc_Txt_Path_Handler; $1)
	C_TEXT:C284(doc_Txt_Path_Handler; $2)
	C_TEXT:C284(doc_Txt_Path_Handler; $3)
End if 

$Lon_Parameters:=Count parameters:C259

If ($Lon_Parameters>0)
	$Txt_Entrypoint:=$1
	If ($Lon_Parameters>1)
		$Txt_Path:=$2
		If ($Lon_Parameters>2)
			$Txt_file:=$3
		End if 
	End if 
End if 

$kTxt_Separator:=Get 4D folder:C485[[Length:C16(Get 4D folder:C485)]]

Case of 
		//______________________________________________________
	: ($Txt_Entrypoint="get.parent@")
		
		//Delete final separator if any
		If ($Txt_Path[[Length:C16($Txt_Path)]]=$kTxt_Separator)
			$Txt_Path:=Delete string:C232($Txt_Path; Length:C16($Txt_Path); 1)
		End if 
		
		Case of 
				//…………………………………………………
			: (Position:C15(".path"; $Txt_Entrypoint)>0)
				If (Match regex:C1019("\\"+$kTxt_Separator+"[^"+$kTxt_Separator+"]*$"; $Txt_Path; 1; $Lon_Position; $Lon_Length))
					$Txt_Result:=Substring:C12($Txt_Path; 1; $Lon_Position)
				End if 
				//…………………………………………………
			: (Position:C15(".name"; $Txt_Entrypoint)>0)
				If (Match regex:C1019("\\"+$kTxt_Separator+"[^"+$kTxt_Separator+"]*$"; $Txt_Path; 1; $Lon_Position; $Lon_Length))
					$Txt_Result:=Substring:C12($Txt_Path; 1; $Lon_Position)
				End if 
				//Delete final separator if any
				If (Match regex:C1019("\\"+$kTxt_Separator+"$"; $Txt_Result; 1))
					$Txt_Result:=Delete string:C232($Txt_Result; Length:C16($Txt_Result); 1)
				End if 
				If (Match regex:C1019("\\"+$kTxt_Separator+"[^"+$kTxt_Separator+"]*$"; $Txt_Result; 1; $Lon_Position; $Lon_Length))
					$Txt_Result:=Substring:C12($Txt_Result; $Lon_Position+1)
				End if 
				//…………………………………………………
		End case 
		//______________________________________________________
	: ($Txt_Entrypoint="get.extension")  //singular = last
		If (Match regex:C1019("\\.[^.]*$"; $Txt_Path; 1; $Lon_Position; $Lon_Length))
			$Txt_Result:=Substring:C12($Txt_Path; $Lon_Position+1)
		End if 
		//______________________________________________________
	: ($Txt_Entrypoint="set.extension")
		If (Not:C34(Match regex:C1019("\\."+$Txt_file+"$"; $Txt_Path; 1)))
			$Txt_Result:=$Txt_Path+"."+$Txt_file
		Else 
			$Txt_Result:=$Txt_Path
		End if 
		//______________________________________________________
	: ($Txt_Entrypoint="get.extensions")  //plural = all
		If (Match regex:C1019("\\..*$"; $Txt_Path; 1; $Lon_Position; $Lon_Length))
			$Txt_Result:=Substring:C12($Txt_Path; $Lon_Position+1)
		End if 
		//______________________________________________________
	: ($Txt_Entrypoint="get.name@")
		//Delete final separator if any
		If ($Txt_Path[[Length:C16($Txt_Path)]]=$kTxt_Separator)
			$Txt_Path:=Delete string:C232($Txt_Path; Length:C16($Txt_Path); 1)
		End if 
		
		If (Match regex:C1019("\\"+$kTxt_Separator+"[^"+$kTxt_Separator+"]*$"; $Txt_Path; 1; $Lon_Position; $Lon_Length))
			$Txt_Result:=Substring:C12($Txt_Path; $Lon_Position+1)
		Else 
			$Txt_Result:=$Txt_Path
		End if 
		
		If ($Txt_Entrypoint="@.short")  //Without extension
			If (Match regex:C1019("\\.[^\\.]*$"; $Txt_Result; 1; $Lon_Position; $Lon_Length))
				$Txt_Result:=Delete string:C232($Txt_Result; $Lon_Position; $Lon_Length)
			End if 
		End if 
		//______________________________________________________
	: ($Txt_Entrypoint="append@")
		
		If ($Txt_Entrypoint#"@.extension")
			//Append separator if necessary
			If ($Txt_Path[[Length:C16($Txt_Path)]]#$kTxt_Separator)
				$Txt_Path:=$Txt_Path+$kTxt_Separator
			End if 
		End if 
		
		Case of 
				//…………………………………………………
			: (Position:C15(".file"; $Txt_Entrypoint)>0)
				$Txt_Result:=$Txt_Path+$Txt_file
				//…………………………………………………
			: (Position:C15(".folder"; $Txt_Entrypoint)>0)
				//Append separator if necessary
				If ($Txt_file[[Length:C16($Txt_file)]]#$kTxt_Separator)
					$Txt_file:=$Txt_file+$kTxt_Separator
				End if 
				$Txt_Result:=$Txt_Path+$Txt_file
				//…………………………………………………
			: (Position:C15(".extension"; $Txt_Entrypoint)>0)
				If (Not:C34(Match regex:C1019("\\."+$Txt_file+"$"; $Txt_Path; 1)))
					$Txt_Result:=$Txt_Path+"."+$Txt_file
				Else 
					$Txt_Result:=$Txt_Path
				End if 
				//…………………………………………………
		End case 
		//______________________________________________________
	: ($Txt_Entrypoint="format.filename")
		$Txt_Result:=$Txt_Path
		$Txt_Result:=Replace string:C233($Txt_Result; "  "; "")
		$Txt_Result:=Replace string:C233($Txt_Result; "\r"; "")
		$Txt_Result:=Replace string:C233($Txt_Result; "\\"; "")
		$Txt_Result:=Replace string:C233($Txt_Result; ":"; "")
		//______________________________________________________
	: ($Txt_Entrypoint="format.folder")  //Append separator if necessary
		//Append separator if necessary
		If ($Txt_Path[[Length:C16($Txt_Path)]]#$kTxt_Separator)
			$Txt_Path:=$Txt_Path+$kTxt_Separator
		End if 
		$Txt_Result:=$Txt_Path
		//______________________________________________________
	: ($Txt_Entrypoint="test.folder")  //Is the folder exist?
		//Append separator if necessary
		If ($Txt_Path[[Length:C16($Txt_Path)]]#$kTxt_Separator)
			$Txt_Path:=$Txt_Path+$kTxt_Separator
		End if 
		$Txt_Path:=$Txt_Path+$Txt_file
		If (Test path name:C476($Txt_Path)=Is a folder:K24:2)
			$Txt_Result:=$Txt_Path
		End if 
		//______________________________________________________
	: ($Txt_Entrypoint="validate.path")  //Is the path valid?
		If (Test path name:C476($Txt_Result)=Is a folder:K24:2) | (Test path name:C476($Txt_Result)=Is a document:K24:1)
			$Txt_Result:=$Txt_Path
		End if 
		//______________________________________________________
	: ($Txt_Entrypoint="create.folder")
		//Append separator if necessary
		If ($Txt_Path[[Length:C16($Txt_Path)]]#$kTxt_Separator)
			$Txt_Path:=$Txt_Path+$kTxt_Separator
		End if 
		If (Test path name:C476($Txt_Path)#Is a folder:K24:2)
			CREATE FOLDER:C475($Txt_Path)
			If (OK=1)
				$Txt_Result:=$Txt_Path
			End if 
		End if 
		//______________________________________________________
	: ($Txt_Entrypoint="create.file")
		If (Test path name:C476($Txt_Path)=Is a folder:K24:2)
			$Txt_Result:=$Txt_Path+$Txt_file
			If (Test path name:C476($Txt_Result)#Is a document:K24:1)
				$Gmt_:=Create document:C266($Txt_Result)
				$Txt_Result:=$Txt_Result*Num:C11(OK=1)
				If (OK=1)
					CLOSE DOCUMENT:C267($Gmt_)
				End if 
			End if 
		End if 
		//______________________________________________________
	: ($Txt_Entrypoint="create.hierarchy")
		If (Test path name:C476($Txt_Path)=Is a folder:K24:2)
			$Txt_Result:=$Txt_Path
		Else 
			$Txt_Volume:=doc_Txt_Path_Handler("get.volume"; $Txt_Path)
			While (Length:C16($Txt_Path)>0)
				$Lon_x:=Position:C15($kTxt_Separator; $Txt_Path)
				If ($Lon_x#0)
					$Txt_Result:=$Txt_Result+Substring:C12($Txt_Path; 1; $Lon_x)
					$Txt_Path:=Substring:C12($Txt_Path; $Lon_x+1)
				Else 
					$Txt_Result:=$Txt_Result+$Txt_Path
					$Txt_Path:=""
				End if 
				If ($Txt_Result#$Txt_Volume)
					doc_Txt_Path_Handler("create.folder"; $Txt_Result)
				End if 
			End while 
		End if 
		//______________________________________________________
	: ($Txt_Entrypoint="structure@")
		
		If (Position:C15(".component"; $Txt_Entrypoint)>0)
			$Txt_Path:=Structure file:C489  //Component target
		Else 
			$Txt_Path:=Structure file:C489(*)  //Database target
		End if 
		Case of 
				//…………………………………………………
			: (Position:C15(".file"; $Txt_Entrypoint)>0)  //Structure file name
				If (Match regex:C1019("\\"+$kTxt_Separator+"[^"+$kTxt_Separator+"]*$"; $Txt_Path; 1; $Lon_Position; $Lon_Length))
					$Txt_Result:=Substring:C12($Txt_Path; $Lon_Position+1)
				End if 
				//…………………………………………………
			: (Position:C15(".folder"; $Txt_Entrypoint)>0)  //Structure folder path
				If (Match regex:C1019("\\"+$kTxt_Separator+"[^"+$kTxt_Separator+"]*$"; $Txt_Path; 1; $Lon_Position; $Lon_Length))
					$Txt_Result:=Substring:C12($Txt_Path; 1; $Lon_Position)
				End if 
				//…………………………………………………
			Else 
				$Txt_Result:=$Txt_Path
				//…………………………………………………
		End case 
		//______________________________________________________
	: ($Txt_Entrypoint="database@")
		If (Position:C15(".component"; $Txt_Entrypoint)>0)
			$Txt_Path:=Structure file:C489  //Component target
		Else 
			$Txt_Path:=Structure file:C489(*)  //Database target
		End if 
		
		If (Match regex:C1019("\\"+$kTxt_Separator+"[^"+$kTxt_Separator+"]*$"; $Txt_Path; 1; $Lon_Position; $Lon_Length))
			$Txt_Result:=Substring:C12($Txt_Path; $Lon_Position+1)
		Else 
			$Txt_Result:=$Txt_Path
		End if 
		
		Case of 
				//…………………………………………………
			: (Position:C15(".name"; $Txt_Entrypoint)>0)  //Database name
				If (Match regex:C1019("\\"+$kTxt_Separator+"[^"+$kTxt_Separator+"]*$"; $Txt_Result; 1; $Lon_Position; $Lon_Length))
					$Txt_Result:=Substring:C12($Txt_Result; $Lon_Position+1)
				End if 
				If (Match regex:C1019("\\.[^\\.]*$"; $Txt_Result; 1; $Lon_Position; $Lon_Length))
					$Txt_Result:=Delete string:C232($Txt_Result; $Lon_Position; $Lon_Length)
				End if 
				//…………………………………………………
		End case 
		//______________________________________________________
	: ($Txt_Entrypoint="get.volume")
		
		If (Length:C16($Txt_Path)>0)
			
			_O_PLATFORM PROPERTIES:C365($Lon_Platform)
			
			If (Match regex:C1019("\\"+$kTxt_Separator; $Txt_Path; 1; $Lon_Position; $Lon_Length))
				//Local hardrive
				//   - MAC : HardDrive:Folder:File
				//   - PC : C:\Folder\File
				$Txt_Result:=Substring:C12($Txt_Path; 1; $Lon_Position)+("\\"*Num:C11($Lon_Platform=Windows:K25:3))  //"HardDrive:"  ou C:\ 
			Else 
				
				//volume distant PC ? (vu d'un pc)
				//exemple :     \\serveur\tempo\test\folder\    renverra    \\serveur\tempo\ 
				
				$Lon_x:=Position:C15("\\\\"; $Txt_Path)  //seulement deux \ 
				If ($Lon_x=1)
					//c'est bien un volume distant PC
					$Txt_Buffer:="••"+Substring:C12($Txt_Path; 3)  //remplace les deux premiers \ par "••"                   ••serveur\tempo\test\ 
					$Lon_x:=Position:C15("\\"; $Txt_Buffer)  //recherche le "\" suivant
					If ($Lon_x>0)
						$Txt_Buffer[[$Lon_x]]:="•"  //remplace le premier \ par une •                  ••serveur•tempo\test\ 
						$Lon_x:=Position:C15("\\"; $Txt_Buffer)  //recherche le "\" suivant
						If ($Lon_x>0)
							$Txt_Result:=Substring:C12($Txt_Path; 1; $Lon_x)
						Else 
							//???
						End if 
					Else 
						//???
					End if 
				Else 
					
					If ($Lon_Platform=Windows:K25:3)  //on est sur Win
						$Txt_Result:=$Txt_Path+":\\"  //directement la chaine passée +:\ 
					Else 
						$Txt_Result:=$Txt_Path+":"  //directement la chaine passée +:
					End if 
					
				End if 
				
			End if 
		End if 
		//______________________________________________________
	Else 
		$Txt_Result:=$Txt_Path
		TRACE:C157
		//______________________________________________________
End case 

$0:=$Txt_Result
