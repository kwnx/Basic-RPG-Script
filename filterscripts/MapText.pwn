#define FILTERSCRIPT

#include <a_samp>
#include <cmd>

/*#pragma tabsize     0
#pragma dynamic 145000*/

new myzobject;

#if !defined isnull
    #define isnull(%1) \
                ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

#define COLOR_RED 0xAA3333AA


#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
        print("\n--------------------------------------");
        print(" Text New SetObjectMaterialText Feature");
        print("--------------------------------------\n");
        return 1;
}

public OnFilterScriptExit()
{
        return 1;
}

#endif
//------------------------------------------------------------------------------------------------------
public OnPlayerCommandText(playerid, cmdtext[])
{
    return 0;
}
//------------------------------------------------------------------------------------------------------
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
        if(dialogid == 1)
        {
                if(response)
                {
                        if(!strlen(inputtext)) return SendClientMessage(playerid, COLOR_RED, "ERROR: You must enter the ID");
                        myzobject = strval(inputtext);
                        if(IsValidObject(myzobject)) return SendClientMessage(playerid, COLOR_RED, "ERROR: Invalid Object");
                        ShowPlayerDialog(playerid,2, DIALOG_STYLE_INPUT, "Enter Text", "Enter Text\nFor Colour use:\n {FF0000}{ FF0000 } -  Red\n{00FF00}{ 00FF00 } -  Green\n{FF9933}{ FF9933 } - Orange\n{00FF33}{ 00FF33 } - Lime Green\n{33FFFF}{ 33FFFF } - Cyan\n{FF66CC}{ FF66CC }Pink\n", "Enter", "Cancel");

                }
        }     // Add the rest of your dialogs here
    	if(dialogid == 2)
        {
                if(response)
                {
                        		new Float:X, Float:Y, Float:Z, Float:A;
                        		GetPlayerFacingAngle(playerid, A);
                        		GetPlayerPos(playerid, X, Y, Z);
                                if(!strlen(inputtext)) return SendClientMessage(playerid, COLOR_RED, "ERROR: You must enter the some text");
                				new myrobject = CreateObject(myzobject,  X+3, Y, Z+1, 0.0, 0.0, A, 300.0); //create the object
                                SetObjectMaterialText(myrobject, inputtext, 0, OBJECT_MATERIAL_SIZE_256x128,\
                                "Arial", 28, 0, COLOR_RED, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
                                new result[128];
                                format(result,sizeof(result), "The Object is been created with ID %d", myrobject);  //-> The number is 42.
                                SendClientMessage(playerid, COLOR_RED, result);
                }
        }
    	return 0; // If you put return 1 here the callback will not continue to be called in other scripts (filterscripts, etc.).
}


//------------------------------------------------------------------------------------------------------

CMD:createtext(playerid,params[])
{
    #pragma unused params
    ShowPlayerDialog(playerid,1, DIALOG_STYLE_INPUT, "Texture", "Enter Object ID\nDon't know Object id?\nUse Following\n19353", "Enter", "Cancel");
    return 1;
}

CMD:editobj(playerid,params[])
{
    if(isnull(params)) return SendClientMessage(playerid, COLOR_RED, "ERROR: Invalid Object");
    new obje = strval(params);
    EditObject(playerid, obje);
    new result[128];
    format(result,sizeof(result), "SERVER: You now edit the object with ID %d", obje);  //-> The number is 42.
    SendClientMessage(playerid, COLOR_RED, result);
    return 1;
}

CMD:deleteobject(playerid,params[])
{
    if(isnull(params)) return SendClientMessage(playerid, COLOR_RED, "ERROR: You must enter Object ID");
    new obj = strval(params);
    DestroyObject(obj);
    new result[128];
    format(result,sizeof(result), "SERVER: You deleted object the with ID %d", obj);  //-> The number is 42.
    SendClientMessage(playerid, COLOR_RED, result);
    return 1;
}
//------------------------------------------------------------------------------------------------------
public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
        new Float:oldX, Float:oldY, Float:oldZ,
            Float:oldRotX, Float:oldRotY, Float:oldRotZ;
        GetObjectPos(objectid, oldX, oldY, oldZ);
        GetObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
        if(!playerobject) // If this is a global object, move it for other players
        {
            if(!IsValidObject(objectid)) return;
            MoveObject(objectid, fX, fY, fZ, 10.0, fRotX, fRotY, fRotZ);
        }

        if(response == EDIT_RESPONSE_FINAL)
        {
                // The player clicked on the save icon
                // Do anything here to save the updated object position (and rotation)
        }

        if(response == EDIT_RESPONSE_CANCEL)
        {
                //The player cancelled, so put the object back to it's old position
                if(!playerobject) //Object is not a playerobject
                {
                        SetObjectPos(objectid, oldX, oldY, oldZ);
                        SetObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
                }
                else
                {
                        SetPlayerObjectPos(playerid, objectid, oldX, oldY, oldZ);
                        SetPlayerObjectRot(playerid, objectid, oldRotX, oldRotY, oldRotZ);
                }
        }
}
