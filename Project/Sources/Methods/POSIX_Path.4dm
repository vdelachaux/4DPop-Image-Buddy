//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : POSIX_Path
// Created 06/10/06 by vdl
// ----------------------------------------------------
// Description
// A POSIX path is the location of an object specified with a POSIX (slash)-style pathname.
// This is the method commonly used in UNIX to refer to a location within a series of directories, as opposed to the (colon) pathnames often used in AppleScript and on the Classic Mac OS.
// The POSIX path is used to get the POSIX path from of an object.
//  Example: POSIX path of file "HD:Users:me:Documents:Welcome.txt" is "/Users/me/Documents/Welcome.txt"
// $1 =  path to convert
// $0 = converted (posix) path
// The first / is omited if $2 is true
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($Boo_Without_First)
C_LONGINT:C283($Lon_i; $Lon_Length; $Lon_Platform)
C_TEXT:C284($Txt_Path; $Txt_Posix_Path; $Txt_Volume)

If (False:C215)
	C_TEXT:C284(POSIX_Path; $0)
	C_TEXT:C284(POSIX_Path; $1)
	C_BOOLEAN:C305(POSIX_Path; $2)
End if 

_O_PLATFORM PROPERTIES:C365($Lon_Platform)

If (Count parameters:C259>=1)
	$Txt_Path:=$1
	If (Count parameters:C259>=2)
		$Boo_Without_First:=$2
	End if 
End if 

Case of 
		//------------------------------------------
	: (Length:C16($Txt_Path)=0)
		$Txt_Posix_Path:=""
		//------------------------------------------
	: ($Lon_Platform=Windows:K25:3)
		$Txt_Posix_Path:=Replace string:C233($Txt_Path; "\\"; "/")
		//------------------------------------------
	Else 
		// ":" is remplaced by "/"
		$Txt_Path:=Replace string:C233($Txt_Path; ":"; "/")
		//Space character must be escaped
		$Txt_Path:=Replace string:C233($Txt_Path; " "; "\\ ")
		
		// Get the boot volume
		$Txt_Volume:=System folder:C487  //"Macintosh_HD:System:"
		$Lon_Length:=Length:C16($Txt_Volume)
		For ($Lon_i; 1; $Lon_Length; 1)
			If ($Txt_Volume[[$Lon_i]]=":")
				$Txt_Volume:=Substring:C12($Txt_Volume; 1; $Lon_i-1)
				$Lon_i:=$Lon_Length+1
			End if 
		End for 
		
		If ($Txt_Path=($Txt_Volume+"/@"))
			// The path is on the boot disk
			// Macintosh_HD/Library/..." will be converted to "/Library/..."
			$Txt_Posix_Path:=Substring:C12($Txt_Path; Length:C16($Txt_Volume)+1)
		Else 
			// The path is not on the boot disk
			// Disk/work/..." will be converted to "/Volumes/Disk/work/..."
			$Txt_Posix_Path:="/Volumes/"+$Txt_Path
		End if 
		//------------------------------------------
End case 

Case of 
		//-------------------------------
	: (Not:C34($Boo_Without_First))
		//-------------------------------
	: (Length:C16($Txt_Posix_Path)=0)
		//-------------------------------
	: (Character code:C91($Txt_Posix_Path[[1]])=47)  // /
		$Txt_Posix_Path:=Substring:C12($Txt_Posix_Path; 2)
		//-------------------------------
End case 

$0:=$Txt_Posix_Path

