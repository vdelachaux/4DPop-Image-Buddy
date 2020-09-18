//%attributes = {"invisible":true}
ARRAY PICTURE:C279(<>tPic_1; 0)
ARRAY PICTURE:C279(<>tPic_2; 0)
ARRAY PICTURE:C279(<>tPic_3; 0)
ARRAY PICTURE:C279(<>tPic_4; 0)
ARRAY PICTURE:C279(<>tPic_5; 0)
ARRAY PICTURE:C279(<>tPic_6; 0)
ARRAY PICTURE:C279(<>tPic_7; 0)
ARRAY PICTURE:C279(<>tPic_8; 0)
ARRAY PICTURE:C279(<>tPic_9; 0)
ARRAY PICTURE:C279(<>tPic_10; 0)
ARRAY PICTURE:C279(<>tPic_11; 0)
ARRAY PICTURE:C279(<>tPic_12; 0)
ARRAY PICTURE:C279(<>tPic_13; 0)
ARRAY PICTURE:C279(<>tPic_14; 0)
ARRAY PICTURE:C279(<>tPic_15; 0)
ARRAY PICTURE:C279(<>tPic_16; 0)
ARRAY PICTURE:C279(<>tPic_17; 0)
ARRAY PICTURE:C279(<>tPic_18; 0)
ARRAY PICTURE:C279(<>tPic_19; 0)
ARRAY PICTURE:C279(<>tPic_20; 0)
ARRAY PICTURE:C279(<>tPic_21; 0)
ARRAY PICTURE:C279(<>tPic_22; 0)
ARRAY PICTURE:C279(<>tPic_23; 0)
ARRAY PICTURE:C279(<>tPic_24; 0)
ARRAY PICTURE:C279(<>tPic_25; 0)
ARRAY PICTURE:C279(<>tPic_26; 0)
ARRAY PICTURE:C279(<>tPic_27; 0)
ARRAY PICTURE:C279(<>tPic_28; 0)
ARRAY PICTURE:C279(<>tPic_29; 0)
ARRAY PICTURE:C279(<>tPic_30; 0)
ARRAY PICTURE:C279(<>tPic_31; 0)
ARRAY PICTURE:C279(<>tPic_32; 0)
ARRAY PICTURE:C279(<>tPic_33; 0)
ARRAY PICTURE:C279(<>tPic_34; 0)
ARRAY PICTURE:C279(<>tPic_35; 0)
ARRAY PICTURE:C279(<>tPic_36; 0)
ARRAY PICTURE:C279(<>tPic_37; 0)
ARRAY PICTURE:C279(<>tPic_38; 0)
ARRAY PICTURE:C279(<>tPic_39; 0)
ARRAY PICTURE:C279(<>tPic_40; 0)

//C_ENTIER LONG(<>Lon_Header_1;<>Lon_Header_2;<>Lon_Header_3;<>Lon_Header_4;<>Lon_Header_5;<>Lon_Header_6;<>Lon_Header_7;<>Lon_Header_8;<>Lon_Header_9;<>Lon_Header_10)
//C_ENTIER LONG(<>Lon_Header_11;<>Lon_Header_12;<>Lon_Header_13;<>Lon_Header_14;<>Lon_Header_15;<>Lon_Header_16;<>Lon_Header_17;<>Lon_Header_18;<>Lon_Header_19;<>Lon_Header_20)
//C_ENTIER LONG(<>Lon_Header_21;<>Lon_Header_22;<>Lon_Header_23;<>Lon_Header_24;<>Lon_Header_25;<>Lon_Header_26;<>Lon_Header_27;<>Lon_Header_28;<>Lon_Header_29;<>Lon_Header_30)
//C_ENTIER LONG(<>Lon_Header_31;<>Lon_Header_32;<>Lon_Header_33;<>Lon_Header_34;<>Lon_Header_35;<>Lon_Header_36;<>Lon_Header_37;<>Lon_Header_38;<>Lon_Header_39;<>Lon_Header_40)

ARRAY TEXT:C222(<>tTxt_filePaths; 0)
ARRAY TEXT:C222(<>tTxt_fileNames; 0)
ARRAY PICTURE:C279(<>tPic_thumbnails; 0)
ARRAY LONGINT:C221(<>tLon_Selected; 0)

ARRAY TEXT:C222(<>tTxt_File_Paths_Back; 0)
ARRAY TEXT:C222(<>tTxt_File_Names_Back; 0)
ARRAY PICTURE:C279(<>tPic_Thumbnails_Back; 0)

ARRAY BOOLEAN:C223(<>tLstb_Picture; 0)

//C_ENTIER LONG(<>bUtil;<>bUtil_2;<>bAction;<>bFolderMenu)
C_LONGINT:C283(<>bSplitter_1; <>bSplitter_2)

C_LONGINT:C283(<>Lon_Error)

C_LONGINT:C283(<>Lon_Timer_Event_Event)
C_LONGINT:C283(<>Lon_UID; <>Lon_File_Number)
//C_ENTIER LONG(<>kMax_Column_Number)
C_LONGINT:C283(<>Lst_resources)
//C_ENTIER LONG(<>kLon_Cellule_Width;<>kLon_Thumbnail_Width;<>kLon_Offset)
C_LONGINT:C283(<>Lon_Picture_Width; <>Lon_Picture_Height)

C_PICTURE:C286(<>kPic_Cellule; <>kPic_Selected; <>kPic_folderIcon; <>Pic_display; <>kPic_Copyright)

//C_TEXTE(<>kTxt_resourcesFolderPath;<>Txt_pictureName;<>Txt_Picture_Size;<>Txt_SearchBox)
C_TEXT:C284(<>Txt_pictureName; <>Txt_Picture_Size; <>Txt_SearchBox)

//C_BOOLEEN(<>Boo_Remote_Mode)

//Convert
ARRAY TEXT:C222(<>tTxt_Codecs; 0)
ARRAY TEXT:C222(<>tTxt_Names; 0)

C_TEXT:C284(<>Txt_fileName)
C_LONGINT:C283(<>bCancel)
C_LONGINT:C283(<>b1; <>b2; <>b3; <>b4; <>b5; <>b6)
C_LONGINT:C283(<>Lon_Scale)
C_PICTURE:C286(<>Pic_Preview)


C_TEXT:C284(<>Dom_thumb; <>Dom_resources)


If (False:C215)  //Public
	
	C_POINTER:C301(Pictures_Browser; $1)  //4DPop tool EntryPoint
	
	C_POINTER:C301(Pictures_Tool_Ondrop; $1)
	
End if 

If (False:C215)  //Private
	
	C_POINTER:C301(BROWSER_FILL; $1)
	C_POINTER:C301(BROWSER_FILL; $2)
	//C_ENTIER LONG(BROWSER_FILL ;$3)
	
	C_TEXT:C284(BROWSER_HANDLER; $1)
	C_TEXT:C284(BROWSER_HANDLER; $2)
	C_LONGINT:C283(BROWSER_HANDLER; $3)
	
	C_LONGINT:C283(Browser_Lon_Folder_List; $0)
	C_TEXT:C284(Browser_Lon_Folder_List; $1)
	C_POINTER:C301(Browser_Lon_Folder_List; $2)
	C_PICTURE:C286(Browser_Lon_Folder_List; $3)
	
	C_TEXT:C284(BROWSER_MENUS; $1)
	
	C_TEXT:C284(BROWSER_SELECTION; $1)
	C_LONGINT:C283(BROWSER_SELECTION; $2)
	
	C_TEXT:C284(doc_DELETE_FOLDER; $1)
	
	C_TEXT:C284(doc_DUPLICATE_FOLDER; $1)
	C_TEXT:C284(doc_DUPLICATE_FOLDER; $2)
	
	C_TEXT:C284(doc_Txt_Path_Handler; $0)
	C_TEXT:C284(doc_Txt_Path_Handler; $1)
	C_TEXT:C284(doc_Txt_Path_Handler; $2)
	C_TEXT:C284(doc_Txt_Path_Handler; $3)
	
	C_TEXT:C284(env_CREATE_ON_SERVER; $1)
	
	C_TEXT:C284(env_DELETE_ON_SERVER; $1)
	
	C_TEXT:C284(env_Get_InfoPlist_Value; $0)
	C_TEXT:C284(env_Get_InfoPlist_Value; $1)
	
	C_POINTER:C301(lstb_AUTOMATIC_SCROOLBARS; $1)
	
	C_LONGINT:C283(lsth_Lon_CountFirstLevelItems; $0)
	C_POINTER:C301(lsth_Lon_CountFirstLevelItems; $1)
	
	_O_C_STRING:C293(mnu_a16_From_List; 16; $0)
	C_LONGINT:C283(mnu_a16_From_List; $1)
	
	_O_C_STRING:C293(mnu_APPEND_SEPARATION_LINE; 16; $1)
	
	_O_C_STRING:C293(mnu_RELEASE_MENU; 16; $1)
	
	C_TEXT:C284(obj_CENTER; $1)
	C_TEXT:C284(obj_CENTER; $2)
	C_LONGINT:C283(obj_CENTER; $3)
	
	C_TEXT:C284(POSIX_Path; $0)
	C_TEXT:C284(POSIX_Path; $1)
	C_BOOLEAN:C305(POSIX_Path; $2)
	
	C_TEXT:C284(preferences; $1)
	C_POINTER:C301(preferences; ${2})
	
	C_PICTURE:C286(svg_Pic_DrawBox; $0)
	C_LONGINT:C283(svg_Pic_DrawBox; $1)
	C_LONGINT:C283(svg_Pic_DrawBox; $2)
	C_LONGINT:C283(svg_Pic_DrawBox; $3)
	C_LONGINT:C283(svg_Pic_DrawBox; $4)
	C_LONGINT:C283(svg_Pic_DrawBox; $5)
	
	C_PICTURE:C286(svg_Pic_DrawText; $0)
	C_TEXT:C284(svg_Pic_DrawText; $1)
	C_LONGINT:C283(svg_Pic_DrawText; $2)
	C_TEXT:C284(svg_Pic_DrawText; $3)
	C_LONGINT:C283(svg_Pic_DrawText; $4)
	C_LONGINT:C283(svg_Pic_DrawText; $5)
	C_LONGINT:C283(svg_Pic_DrawText; $6)
	C_TEXT:C284(svg_Pic_DrawText; $7)
	C_LONGINT:C283(svg_Pic_DrawText; $8)
	C_LONGINT:C283(svg_Pic_DrawText; $9)
	C_LONGINT:C283(svg_Pic_DrawText; $10)
	C_LONGINT:C283(svg_Pic_DrawText; $11)
	
	C_PICTURE:C286(svg_Pic_copyright; $0)
	C_TEXT:C284(svg_Pic_copyright; $1)
	
	C_TEXT:C284(Tool_gTxt_BytesToString; $0)
	C_REAL:C285(Tool_gTxt_BytesToString; $1)
	C_TEXT:C284(Tool_gTxt_BytesToString; $2)
	C_TEXT:C284(Tool_gTxt_BytesToString; $3)
	C_TEXT:C284(Tool_gTxt_BytesToString; $4)
	C_LONGINT:C283(Tool_gTxt_BytesToString; $5)
	
	C_BLOB:C604(server_CREATE_RESOURCES; ${1})
	
	C_TEXT:C284(server_DELETE_FILE; $1)
	
End if 
