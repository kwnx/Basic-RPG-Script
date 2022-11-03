#define FILTERSCRIPT

#include < a_samp >
#include < file >
#include < cmd >
#include < sscanf2 >

#define SCM SendClientMessage
#define SPD ShowPlayerDialog

#define DIALOG_TEXT 1

new Object;
new Text[200];
new MaterialSize;
new FontFace[20];
new FontSize;
new FontColor;
new Agliment;

public OnFilterScriptInit()
{
    print("\n");
	print(" ----------------------------------");
	print("  Text Object Creator");
	print(" ----------------------------------");
	print("  Author: KnowN");
	print("  Site: www.sa-mp.ro");
	print("  Version: 0.1 [14/07/2016]");
	print(" ----------------------------------");
	print("\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DIALOG_TEXT:
	    {
	        if(!response) return 1;
	        if(!strlen(inputtext)) return SPD(playerid, DIALOG_TEXT, DIALOG_STYLE_INPUT, "Text Name", "Introdu textul dorit de tine mai jos:", "Ok", "Cancel");
	        
	        new Float:X, Float:Y, Float:Z, Float:A;
	        GetPlayerPos(playerid, X, Y, Z);
	        GetPlayerFacingAngle(playerid, A);
	        
	        strmid(Text, inputtext, 0, strlen(inputtext), 255);
	        MaterialSize = OBJECT_MATERIAL_SIZE_512x64;
	        FontFace = "Arial";
	        FontSize = 10;
	        FontColor = 0xFFFFFFAA;
	        Agliment = 0;
	        
	        Object = CreateObject(19353, X + 3, Y, Z + 1, 0.0, 0.0, A, 300.0);
	        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
	        EditObject(playerid, Object);
	    }
	    case DIALOG_TEXT + 1:
	    {
			switch(listitem)
			{
			    case 0:
			    {
			        SPD(playerid, DIALOG_TEXT + 7, DIALOG_STYLE_INPUT, "Text Name", "{FFFFFF}Introdu textul dorit de tine mai jos:", "Ok", "Cancel");
			    }
			    case 1:
			    {
			    	SPD(playerid, DIALOG_TEXT + 2, DIALOG_STYLE_INPUT, "Text Size", "{FFFFFF}Introdu marimea textului:\n\nFoloseste valorile de la {FF0000}1 {FFFFFF}la {FF0000}14{FFFFFF}.", "Ok", "Back");
			    }
			    case 2:
			    {
			        SPD(playerid, DIALOG_TEXT + 3, DIALOG_STYLE_LIST, "Text Agliment", "Left\nCenter\nRight", "Ok", "Back");
			    }
			    case 3:
			    {
			        SPD(playerid, DIALOG_TEXT + 4, DIALOG_STYLE_INPUT, "Text Font", "Font 1\nFont 2\nFont 3\nFotn 4\nFont 5\nFont 6", "Select", "Back");
			    }
			    case 4:
			    {
			        SPD(playerid, DIALOG_TEXT + 5, DIALOG_STYLE_INPUT, "Text Color", "{FFFFFF}Introdu culoarea dorita de tine.\n\nExemplu: {FF0000}FF0000 {FFFFFF}| {80FF00}80FF00 {FFFFFF}| {00FF00}00FF00", "Ok", "Cancel");
			    }
			    case 5:
			    {
			        EditObject(playerid, Object);
			    }
			    case 6:
				{
				    SPD(playerid, DIALOG_TEXT + 6, DIALOG_STYLE_INPUT, "Save", "Textul va aparea intr-un fisier cu extensia .txt!\nPentru a-l gasi acceseaza folderul \"scriptfiles\".", "Ok", "Cancel");
				}
				case 7:
				{
				    return 1;
				}
			}
	    }
	    case DIALOG_TEXT + 2:
	    {
	        if(!response) return SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
	        
			switch(strval(inputtext))
			{
			    case 1:
			    {
			        MaterialSize = OBJECT_MATERIAL_SIZE_512x512;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			    case 2:
			    {
			        MaterialSize = OBJECT_MATERIAL_SIZE_512x256;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			    case 3:
			    {
			        MaterialSize = OBJECT_MATERIAL_SIZE_512x128;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			    case 4:
			    {
			        MaterialSize = OBJECT_MATERIAL_SIZE_512x64;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			    case 5:
			    {
			        MaterialSize = OBJECT_MATERIAL_SIZE_256x256;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			    case 6:
			    {
			        MaterialSize = OBJECT_MATERIAL_SIZE_256x128;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			    case 7:
			    {
			        MaterialSize = OBJECT_MATERIAL_SIZE_256x64;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			    case 8:
			    {
			        MaterialSize = OBJECT_MATERIAL_SIZE_256x32;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			    case 9:
			    {
			        MaterialSize = OBJECT_MATERIAL_SIZE_128x128;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			    case 10:
			    {
			        MaterialSize = OBJECT_MATERIAL_SIZE_128x64;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			    case 11:
			    {
			        MaterialSize = OBJECT_MATERIAL_SIZE_128x32;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			    case 12:
			    {
			        MaterialSize = OBJECT_MATERIAL_SIZE_64x64;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			    case 13:
			    {
			        MaterialSize = OBJECT_MATERIAL_SIZE_64x32;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			    case 14:
			    {
			        MaterialSize = OBJECT_MATERIAL_SIZE_32x32;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			    default: SPD(playerid, DIALOG_TEXT + 2, DIALOG_STYLE_INPUT, "Text Size", "{FFFFFF}Introdu marimea textului:\n\nFoloseste valorile de la {FF0000}1 {FFFFFF}la {FF0000}14{FFFFFF}.", "Ok", "Back");
			}
	    }
	    case DIALOG_TEXT + 3:
	    {
	        if(!response) return SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");

			switch(listitem)
			{
			    case 0:
			    {
			        Agliment = 0;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			    case 1:
			    {
			        Agliment = 1;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			    case 2:
			    {
			        Agliment = 2;
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
			    }
			}
	    }
	    case DIALOG_TEXT + 4:
	    {
	        if(!response) return SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
	        
	        switch(listitem)
	        {
	            case 0:
	            {
	                FontFace = "Arial";
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
	            }
	            case 1:
	            {
	            	FontFace = "Times New Roman";
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
	            }
	            case 2:
	            {
	            	FontFace = "Comic Sans MS";
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
	            }
	            case 3:
	            {
	            	FontFace = "Impact";
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
	            }
	            case 4:
	            {
	            	FontFace = "Lucida Console";
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
	            }
	            case 5:
	            {
	            	FontFace = "Arial Black";
			        SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
			        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
	            }
	        }
	    }
	    case DIALOG_TEXT + 5:
	    {
	        if(!response) return SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");

			new kStr[50];
			format(kStr, sizeof(kStr), "0x%sAA", strlen(inputtext));
			FontColor = strlen(kStr);
			
			SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
	    }
	    case DIALOG_TEXT + 6:
	    {
	        if(!response) return SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");

			new Float:X, Float:Y, Float:Z;
			GetObjectPos(Object, X, Y, Z);
			SaveTextObject(Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment, X, Y, Z);
	    }
	    case DIALOG_TEXT + 7:
	    {
	        if(!response) return SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");

            strmid(Text, inputtext, 0, strlen(inputtext), 255);
	        SetObjectMaterialText(Object, Text, MaterialSize, FontFace, FontSize, FontColor, Agliment, X, Y, Z);
	    }
	}
	return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
    new Float:X, Float:Y, Float:Z, Float:RX, Float:RY, Float:RZ;
    GetObjectPos(objectid, X, Y, Z);
    GetObjectRot(objectid, RX, RY, RZ);
    
    if(!playerobject) 
    {
        if(!IsValidObject(objectid)) return 1;
            
        MoveObject(objectid, fX, fY, fZ, 10.0, fRotX, fRotY, fRotZ);
    }
	if(response == EDIT_RESPONSE_FINAL)
 	{
        SPD(playerid, DIALOG_TEXT + 1, DIALOG_STYLE_LIST, "Menu", "Text Name\nText Size\nText Agliment\nText Font\nText Color\nText Position\nSave\nExit", "Select", "");
    }
    if(response == EDIT_RESPONSE_CANCEL)
    {
        if(!playerobject) 
        {
            SetObjectPos(objectid, X, Y, Z);
            SetObjectRot(objectid, RX, RY, RZ);
        }
        else
        {
            SetPlayerObjectPos(playerid, objectid, X, Y, Z);
            SetPlayerObjectRot(playerid, objectid, RX, RY, RZ);
        }
    }
	return 1;
}

CMD:text(playerid, params[])
{
 	SPD(playerid, DIALOG_TEXT, DIALOG_STYLE_INPUT, "Text Name", "Introdu textul dorit de tine mai jos:", "Ok", "Cancel");
	return 1;
}

stock SaveTextObject(text[], materialsize, fontface, fontsize, color, agliment, oX, oY, oZ)
{
    new file[116], File:ftw = fopen("known_system.txt", io_write);

	format(file, sizeof(file), "new yourobject = CreateObject(19353, %f, %f, %f, 0.0, 0.0, 0.0, 300.0);\nSetObjectMaterialText(yourobject, %s, 0, %d, %s, %d, 1, %d, 0, %d);", oX, oY, oZ, text, materialsize, fontface, fontsize, fontcolor, agliment);
	fwrite(ftw, );
	
	SetObjectMaterialText(Object, Text, 0, MaterialSize, FontFace, FontSize, 1, FontColor, 0, Agliment);
	
	return 1;
}
