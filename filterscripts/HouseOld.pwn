#define FILTERSCRIPT

#include <a_samp>
#include <a_mysql>
#include <cmd>
#include <sscanf2>
#include <mSelection>
#include <streamer>

#define MYSQL_HOST "93.119.26.250"
#define MYSQL_USER "zp_Rhid1001243"
#define MYSQL_DB "zp_Rhid1001243"
#define MYSQL_PASS "zp_Rhid1001243"

#define MAX_HOUSES 500

#define function%0(%1) forward%0(%1); public%0(%1)
#define SCM SendClientMessage
#define SPD ShowPlayerDialog

#define DIALOG_HOUSE 1000

#define DIALOG_SELECT_PART1 1

new mysql;
new query[1800];
new TotalHouses;
new InHouse[MAX_PLAYERS];
new Text3D:HouseLabel[MAX_HOUSES];
new FObject[MAX_PLAYERS];
new furnitureID;

new Part1[] =
{
	1491,
	1502,
	19535,
	19426,
	19445,
};
new Part2 = mS_INVALID_LISTID;
new Tables = mS_INVALID_LISTID;
new Lights = mS_INVALID_LISTID;
new Beds = mS_INVALID_LISTID;
new Sofas = mS_INVALID_LISTID;
new Rugs = mS_INVALID_LISTID;
new Plants = mS_INVALID_LISTID;
new Pictures = mS_INVALID_LISTID;
new Chairs = mS_INVALID_LISTID;
new Pool = mS_INVALID_LISTID;
new Kitchen = mS_INVALID_LISTID;
new Food = mS_INVALID_LISTID;
new Electrical = mS_INVALID_LISTID;
new Music = mS_INVALID_LISTID;
new Others = mS_INVALID_LISTID;

enum hData
{
	ID,
	HouseName[100],
	Owner[40],
	Owned,
	Float:EnterX,
	Float:EnterY,
	Float:EnterZ,
	Float:EnterA,
	Float:ExitX,
	Float:ExitY,
	Float:ExitZ,
	Float:ExitA,
	Price,
	Icon,
	Rent,
	Rentable,
	Level,
	VW,
	W1,
	W2,
	W3,
	W4,
	W5,
	W6,
	W7,
	W8,
	W9,
	W10,
	Status
};

enum hFurniture
{
	ID,
	HouseID,
	Model,
	Float:X,
	Float:Y,
	Float:Z,
	Float:RX,
	Float:RY,
	Float:RZ
};

new HouseInfo[MAX_HOUSES][hData];
new FInfo[MAX_HOUSES][hFurniture];
new hObject[23];

public OnFilterScriptInit()
{
	mysql = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DB, MYSQL_PASS);
	
  	TotalHouses = 0;
  	
  	//Part1 = LoadModelSelectionMenu("Part1.txt");
	Part2 = LoadModelSelectionMenu("Part2.txt");
	Tables = LoadModelSelectionMenu("Tables.txt");
	Lights = LoadModelSelectionMenu("Lights.txt");
	Beds = LoadModelSelectionMenu("Beds.txt");
	Sofas = LoadModelSelectionMenu("Sofas.txt");
	Rugs = LoadModelSelectionMenu("Rugs.txt");
	Plants = LoadModelSelectionMenu("Plants.txt");
	Pictures = LoadModelSelectionMenu("Pictures.txt");
	Chairs = LoadModelSelectionMenu("Chairs.txt");
	Pool = LoadModelSelectionMenu("Pool.txt");
	Kitchen = LoadModelSelectionMenu("Kitchen.txt");
	Food = LoadModelSelectionMenu("Food.txt");
	Electrical = LoadModelSelectionMenu("Electrical.txt");
	Music = LoadModelSelectionMenu("Music.txt");
	Others = LoadModelSelectionMenu("Others.txt");
  
	mysql_tquery(mysql, "SELECT * FROM `houses`", "LoadHouses", "");
	return 1;
}

public OnFilterScriptExit()
{
	mysql_close(mysql);
	return 1;
}

public OnPlayerConnect(playerid)
{
	InHouse[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerModelSelectionEx(playerid, response, extraid, modelid)
{
    new Float:pX, Float:pY, Float:pZ;
	GetPlayerPos(playerid, pX, pY, pZ);
	
	if(extraid == DIALOG_SELECT_PART1)
	{
	    if(!response) return SPD(playerid, DIALOG_HOUSE + 4, DIALOG_STYLE_LIST, "House Objects", "{33AA33}Add\n{FFFFFF}Change\n{FF0000}Remove", "Select", "Back");
	    
	    FObject[playerid] = CreateDynamicObject(modelid, pX + 3, pY, pZ, 0.000, 0.000, 0.000, GetPlayerVirtualWorld(playerid));
	    Streamer_UpdateEx(playerid, pX + 3, pY, pZ, GetPlayerVirtualWorld(playerid));
	    EditPlayerObject(playerid, FObject[playerid]);
	}
	return 1;
}

public OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
	if(type == SELECT_OBJECT_GLOBAL_OBJECT)
	{
	    EditObject(playerid, objectid);
	}
	else
	{
	    EditPlayerObject(playerid, objectid);
	}
	return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	new Float:oldX, Float:oldY, Float:oldZ, Float:oldRotX, Float:oldRotY, Float:oldRotZ;
	GetObjectPos(objectid, oldX, oldY, oldZ);
	GetObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
	
	if(!playerobject)
	{
	    if(!IsValidObject(objectid)) return 1;
	    SetObjectPos(objectid, fX, fY, fZ);
        SetObjectRot(objectid, fRotX, fRotY, fRotZ);
	}
	if(response == EDIT_RESPONSE_FINAL)
	{
		GameTextForPlayer(playerid, "~w~~h~FINISHED!", 3000, 4);
		
		query[0] = EOS;
		mysql_format(mysql, query, sizeof(query), "INSERT INTO `furniture` (`HouseID`, `Model`, `X`, `Y`, `Z`, `RX`, `RY`, `RZ`) VALUES ('%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f')", InHouse[playerid], objectid, fX, fY, fZ, fRotX, fRotY, fRotZ);
		mysql_query(mysql, query);
	}
	if(response == EDIT_RESPONSE_CANCEL)
	{
		if(!playerobject)
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
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DIALOG_HOUSE:
	    {
	        if(!response) return 1;
	        
	        switch(listitem)
	        {
	            case 0: //House Help
	            {
					new knStr[1500];
					format(knStr, sizeof(knStr), "{FFFFFF}Pe acest server sunt {FF0000}%d {FFFFFF}case in total.\n\n", ServerHouses());
					strcat(knStr, "{FFFFFF}Pentru a cumpara o casa trebuie sa ai minim nivel {AFAFAF}5{FFFFFF}!\n\
								   {FFFFFF}Casele dispun de un sistem avansat de mobila care poate fi accesat prin comanda \"{AFAFAF}/housemenu{FFFFFF}\" - \"{AFAFAF}House Objects{FFFFFF}\".\n\
								   {FFFFFF}Pe masura ce detii mai multe obiecte in casa, aceasta va deveni mai scumpa astfel incat atunci cand o vinzi sa obtii un pret mai mare.\n");
					strcat(knStr, "{FFFFFF}Poti adauga pana in {AFAFAF}400 {FFFFFF}obiecte in casa ta, poti depasi limita doar avand un cont Premium.\n\n\
								   {FFFFFF}Pentru mai multe detalii accesati site-ul nostru: {085A90}www.testserver.ro");
					SPD(playerid, DIALOG_HOUSE + 1, DIALOG_STYLE_MSGBOX, "House Help", knStr, "Ok", "Back");
	            }
	            case 1: //House Name
	            {
	                SPD(playerid, DIALOG_HOUSE + 2, DIALOG_STYLE_INPUT, "House Name", "{FFFFFF}Introdu noul nume pe care doresti sa il pui casei tale:", "Ok", "Close");
	            }
	            case 2: //Sell House
	            {
	            }
	            case 3: //House Status
	            {
	                if(HouseInfo[InHouse[playerid]][Status] == 0)
	                {
	                    HouseInfo[InHouse[playerid]][Status] = 1;
	                }
	                else if(HouseInfo[InHouse[playerid]][Status] == 1)
	                {
	                    HouseInfo[InHouse[playerid]][Status] = 0;
	                }
	            }
	            case 4: //House Object
	            {
	                SPD(playerid, DIALOG_HOUSE + 4, DIALOG_STYLE_LIST, "House Objects", "{33AA33}Add\n{FFFFFF}Change\n{FF0000}Remove", "Select", "Back");
	            }
	        }
	    }
	    case DIALOG_HOUSE + 1:
	    {
	        if(response)
			{
				return 1;
			}
	        else if(!response)
	        {
	        	new hStr[500], hStatus[20];

				if(HouseInfo[InHouse[playerid]][Status] == 0) hStatus = "{33AA33}OPENED";
				else if(HouseInfo[InHouse[playerid]][Status] == 1) hStatus = "{FF0000}LOCKED";

				format(hStr, sizeof(hStr), "{FF0000}House Help\n{FFFFFF}House Name\nSell House\nHouse Status: %s\nHouse Items (%d objects)", hStatus, GetHouseFurnitures(InHouse[playerid]));
				SPD(playerid, DIALOG_HOUSE, DIALOG_STYLE_TABLIST, "House Menu", hStr, "Select", "Cancel");
			}
		}
		case DIALOG_HOUSE + 2:
		{
		    if(!response) return 1;
		    if(!strlen(inputtext)) return 1;
		    
		    if(strlen(inputtext) < 6 || strlen(inputtext) > 100) return SPD(playerid, DIALOG_HOUSE + 2, DIALOG_STYLE_INPUT, "House Name", "{FFFFFF}Introdu noul nume pe care doresti sa il pui casei tale:\n\n{AFAFAF}Numele casei trebuie sa fie cuprins intre 6 - 100 caractere.", "Ok", "Close");
		    
		    new Security[100];
		    new hStr[200];
		    
		    query[0] = EOS;
		    mysql_escape_string(inputtext, Security);
		    mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `HouseName` = '%s' WHERE `ID` = '%d'", Security, HouseInfo[InHouse[playerid]][ID]);
		    mysql_query(mysql, query);
		    
		    strmid(HouseInfo[InHouse[playerid]][HouseName], inputtext, 0, strlen(inputtext), 255);
		    
			format(hStr, sizeof(hStr), "{FFFFFF}Numele casei a fost schimbat in: {AFAFAF}%s", HouseInfo[InHouse[playerid]][HouseName]);
			SPD(playerid, 0, DIALOG_STYLE_MSGBOX, "House name: Changed", hStr, "Ok", "");
		}
		case DIALOG_HOUSE + 4:
		{
		    if(!response)
		    {
		        new hStr[500], hStatus[20];

				if(HouseInfo[InHouse[playerid]][Status] == 0) hStatus = "{33AA33}OPENED";
				else if(HouseInfo[InHouse[playerid]][Status] == 1) hStatus = "{FF0000}LOCKED";

				format(hStr, sizeof(hStr), "{FF0000}House Help\n{FFFFFF}House Name\nSell House\nHouse Status: %s\nHouse Items (%d objects)", hStatus, GetHouseFurnitures(InHouse[playerid]));
				SPD(playerid, DIALOG_HOUSE, DIALOG_STYLE_TABLIST, "House Menu", hStr, "Select", "Cancel");
				return 1;
		    }
		    switch(listitem)
		    {
		        case 0: //Add
		        {
		            SPD(playerid, DIALOG_HOUSE + 5, DIALOG_STYLE_LIST, "House objects: Add", "Construction: Part 1\nConstruction: Part 2\nTables\nLights\nBeds\nSofas\nRugs\nPlants\nPictures\nChairs\nPool\nKitchen\nFood\nElectrical\nMusic\nOthers\n", "Select", "Back");
		        }
		        case 1: //Change
		        {
		            SCM(playerid, -1, "{AFAFAF}HOUSE: {FFFFFF}Selecteaza obiectul pe care vrei sa il modifici.");
		            
		            SelectObject(playerid);
		        }
		        case 2: //Remove
		        {
		        
		        }
		    }
		}
		case DIALOG_HOUSE + 5:
		{
		    if(!response) return SPD(playerid, DIALOG_HOUSE + 4, DIALOG_STYLE_LIST, "House Objects", "{33AA33}Add\n{FFFFFF}Change\n{FF0000}Remove", "Select", "Back");
		    
		    switch(listitem)
		    {
		        case 0: ShowModelSelectionMenuEx(playerid, Part1, sizeof(Part1), "Construction: Part 1", DIALOG_SELECT_PART1, 0.0, 0.0, 50.0, 1.0, 0x00000099, 0x000000EE, 0xACCBF1FF);
				case 1: ShowModelSelectionMenu(playerid, Part2, "Construction: Part 2");
				case 2: ShowModelSelectionMenu(playerid, Tables, "Tables");
				case 3: ShowModelSelectionMenu(playerid, Lights, "Lights");
				case 4: ShowModelSelectionMenu(playerid, Beds, "Beds");
				case 5: ShowModelSelectionMenu(playerid, Sofas, "Sofas");
				case 6: ShowModelSelectionMenu(playerid, Rugs, "Rugs");
				case 7: ShowModelSelectionMenu(playerid, Plants, "Plants");
				case 8: ShowModelSelectionMenu(playerid, Pictures, "Pictures");
				case 9: ShowModelSelectionMenu(playerid, Chairs, "Chairs");
				case 10: ShowModelSelectionMenu(playerid, Pool, "Pool");
				case 11: ShowModelSelectionMenu(playerid, Kitchen, "Kitchen");
				case 12: ShowModelSelectionMenu(playerid, Food, "Food");
				case 13: ShowModelSelectionMenu(playerid, Electrical, "Electrical");
				case 14: ShowModelSelectionMenu(playerid, Music, "Music");
				case 15: ShowModelSelectionMenu(playerid, Others, "Others");
		    }
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

//House Commands
CMD:createhouse(playerid, params[])
{
	if(sscanf(params, "dd", params[0], params[1])) return SCM(playerid, -1, "USAGE: /createhouse [price] [request level]");
	
	TotalHouses++;
	new hID = TotalHouses, hStr[1800];
	new Float:pX, Float:pY, Float:pZ, Float:pA;
	
	GetPlayerPos(playerid, pX, pY, pZ);
	GetPlayerFacingAngle(playerid, pA);
	
	query[0] = EOS;
	mysql_format(mysql, query, sizeof(query), "INSERT INTO `houses` (`HouseName`, `Owner`, `Price`, `Icon`, `Level`, `EnterX`, `EnterY`, `EnterZ`, `EnterA`, `ExitX`, `ExitY`, `ExitZ`, `ExitA`, `VW`) VALUES ('Without Name', 'None', '%d', '%d', '%d', '%f', '%f', '%f', '%f', '1256.8850', '-2043.8328', '59.9856', '355.6876', '%d')", params[0], 0, params[1], pX, pY, pZ, pA, TotalHouses);
	mysql_query(mysql, query);
	
	HouseInfo[hID][Price] = params[0];
	HouseInfo[hID][Icon] = 0;
	HouseInfo[hID][Owned] = 0;
	HouseInfo[hID][Level] = params[1];
	HouseInfo[hID][EnterX] = pX;
	HouseInfo[hID][EnterY] = pY;
	HouseInfo[hID][EnterZ] = pZ;
	HouseInfo[hID][EnterA] = pA;
	HouseInfo[hID][VW] = TotalHouses;
	HouseInfo[hID][ExitX] = 1256.8850;
	HouseInfo[hID][ExitY] = -2043.8328;
	HouseInfo[hID][ExitZ] = 59.9856;
	HouseInfo[hID][ExitA] = 355.6876;
	
	CreateDynamicPickup(1273, 1, pX, pY, pZ);
	CreateDynamicMapIcon(pX, pY, pZ, 31, 0, -1, -1, -1, 100.0);

	format(hStr, sizeof(hStr), "House ID: %d\nOwner: %s\nRequest Level: %d\nPrice: %d$\n\nType /enter to join in this house!", HouseInfo[hID][ID], HouseInfo[hID][Owner], HouseInfo[hID][Level], HouseInfo[hID][Price]);
	HouseLabel[hID] = CreateDynamic3DTextLabel(hStr, -1, pX, pY, pZ+0.3, 15.0);
	return 1;
}

CMD:enter(playerid, params[])
{
	if(InHouse[playerid] != 0) return SCM(playerid, -1, "Te aflii deja intr-o casa!");

	for(new i = 1; i < sizeof(HouseInfo); i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][EnterX], HouseInfo[i][EnterY], HouseInfo[i][EnterZ])) 
		{
		    new pVW = HouseInfo[i][VW];
			
			hObject[0] = CreateDynamicObject(19377, 1252.10938, -2040.66418, 58.89970,   0.00000, 90.00000, -1.00000, pVW);
			Streamer_UpdateEx(playerid, 1252.10938, -2040.66418, 58.89970, pVW);
			hObject[1] = CreateDynamicObject(19377, 1262.57275, -2040.85669, 58.89970,   0.00000, 90.00000, -1.00000, pVW);
			Streamer_UpdateEx(playerid, 1262.57275, -2040.85669, 58.89970, pVW);
			hObject[2] = CreateDynamicObject(19377, 1262.72864, -2031.29443, 58.89970,   0.00000, 90.00000, -1.00000, pVW);
			Streamer_UpdateEx(playerid, 1262.72864, -2031.29443, 58.89970, pVW);
			hObject[3] = CreateDynamicObject(19377, 1252.24988, -2031.10950, 58.89970,   0.00000, 90.00000, -1.00000, pVW);
			Streamer_UpdateEx(playerid, 1252.24988, -2031.10950, 58.89970, pVW);
			hObject[4] = CreateDynamicObject(19450, 1267.81335, -2040.94067, 60.64445,   0.00000, 0.00000, -0.54000, pVW);
			Streamer_UpdateEx(playerid, 1267.81335, -2040.94067, 60.64445, pVW);
			hObject[5] = CreateDynamicObject(19450, 1267.90283, -2031.33313, 60.64445,   0.00000, 0.00000, -0.54000, pVW);
			Streamer_UpdateEx(playerid, 1267.90283, -2031.33313, 60.64445, pVW);
			hObject[6] = CreateDynamicObject(19450, 1263.12683, -2026.55164, 60.64445,   0.00000, 0.00000, 89.04001, pVW);
			Streamer_UpdateEx(playerid, 1263.12683, -2026.55164, 60.64445, pVW);
			hObject[7] = CreateDynamicObject(19450, 1253.49402, -2026.39087, 60.64445,   0.00000, 0.00000, 89.04001, pVW);
			Streamer_UpdateEx(playerid, 1253.49402, -2026.39087, 60.64445, pVW);
			hObject[8] = CreateDynamicObject(19450, 1248.72778, -2031.07532, 60.64445,   0.00000, 0.00000, -0.54000, pVW);
			Streamer_UpdateEx(playerid, 1248.72778, -2031.07532, 60.64445, pVW);
			hObject[9] = CreateDynamicObject(19450, 1248.63782, -2040.70471, 60.64445,   0.00000, 0.00000, -0.54000, pVW);
			Streamer_UpdateEx(playerid, 1248.63782, -2040.70471, 60.64445, pVW);
			hObject[10] = CreateDynamicObject(19450, 1247.33240, -2045.25854, 60.64445,   0.00000, 0.00000, 89.04001, pVW);
			Streamer_UpdateEx(playerid, 1247.33240, -2045.25854, 60.64445, pVW);
			hObject[11] = CreateDynamicObject(19404, 1253.74011, -2045.38159, 60.63889,   0.00000, 0.00000, 88.79999, pVW);
			Streamer_UpdateEx(playerid, 1253.74011, -2045.38159, 60.63889, pVW);
			hObject[12] = CreateDynamicObject(19388, 1256.89038, -2045.46082, 60.64155,   0.00000, 0.00000, 88.38003, pVW);
			Streamer_UpdateEx(playerid, 1256.89038, -2045.46082, 60.64155, pVW);
			hObject[13] = CreateDynamicObject(19404, 1260.09229, -2045.54846, 60.63889,   0.00000, 0.00000, 88.79999, pVW);
			Streamer_UpdateEx(playerid, 1260.09229, -2045.54846, 60.63889, pVW);
			hObject[14] = CreateDynamicObject(19450, 1266.49866, -2045.65491, 60.64445,   0.00000, 0.00000, 89.04001, pVW);
			Streamer_UpdateEx(playerid, 1266.49866, -2045.65491, 60.64445, pVW);
			hObject[15] = CreateDynamicObject(19466, 1253.60522, -2045.39917, 60.71215,   0.00000, 0.00000, 88.79995, pVW);
			Streamer_UpdateEx(playerid, 1253.60522, -2045.39917, 60.71215, pVW);
			hObject[16] = CreateDynamicObject(19466, 1260.12891, -2045.53113, 60.71215,   0.00000, 0.00000, 88.79995, pVW);
			Streamer_UpdateEx(playerid, 1260.12891, -2045.53113, 60.71215, pVW);
			hObject[17] = CreateDynamicObject(1505, 1256.11755, -2045.45593, 58.89073,   0.00000, 0.00000, -1.14000, pVW);
			Streamer_UpdateEx(playerid, 1256.11755, -2045.45593, 58.89073, pVW);
			hObject[18] = CreateDynamicObject(1505, 1255.78943, -2045.49438, 58.89073,   0.00000, 0.00000, -1.14000, pVW);
			Streamer_UpdateEx(playerid, 1255.78943, -2045.49438, 58.89073, pVW);
			hObject[19] = CreateDynamicObject(19377, 1262.72864, -2031.29443, 62.33289,   0.00000, 90.00000, -1.00000, pVW);
			Streamer_UpdateEx(playerid, 1262.72864, -2031.29443, 62.33289, pVW);
			hObject[20] = CreateDynamicObject(19377, 1252.24988, -2031.10950, 62.33600,   0.00000, 90.00000, -1.00000, pVW);
			Streamer_UpdateEx(playerid, 1252.24988, -2031.10950, 62.33600, pVW);
			hObject[21] = CreateDynamicObject(19377, 1252.10938, -2040.66418, 62.33412,   0.00000, 90.00000, -1.00000, pVW);
			Streamer_UpdateEx(playerid, 1252.10938, -2040.66418, 62.33412, pVW);
			hObject[22] = CreateDynamicObject(19377, 1262.57275, -2040.85669, 62.34385,   0.00000, 90.00000, -1.00000, pVW);
			Streamer_UpdateEx(playerid, 1262.57275, -2040.85669, 62.34385, pVW);
		
		    SetPlayerVirtualWorld(playerid, pVW);
		    InHouse[playerid] = i;
		    
		    new Float:PX, Float:PY, Float:PZ, Float:PA;
		    GetPlayerPos(playerid, PX, PY, PZ);
		    GetPlayerFacingAngle(playerid, PA);
		    
		    HouseInfo[InHouse[playerid]][EnterX] = PX;
		    HouseInfo[InHouse[playerid]][EnterY] = PY;
		    HouseInfo[InHouse[playerid]][EnterZ] = PZ;
		    HouseInfo[InHouse[playerid]][EnterA] = PA;
		    
			SetPlayerPos(playerid, HouseInfo[i][ExitX], HouseInfo[i][ExitY], HouseInfo[i][ExitZ]);
			SetPlayerFacingAngle(playerid, HouseInfo[i][ExitA]);
			
			if(strcmp(HouseInfo[InHouse[playerid]][Owner], GetName(playerid), false))
			{
				SPD(playerid, 0, DIALOG_STYLE_MSGBOX, "House Menu", "{FFFFFF}Scrie \"{AFAFAF}/housemenu{FFFFFF}\" pentru a vedea optiunile disponibile.", "OK", "");
			}
		}
	}
	return 1;
}

CMD:exit(playerid, params[])
{
	if(InHouse[playerid] == 0) return 1;

	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
		
	SetPlayerPos(playerid, HouseInfo[InHouse[playerid]][EnterX], HouseInfo[InHouse[playerid]][EnterY], HouseInfo[InHouse[playerid]][EnterZ]);
	SetPlayerFacingAngle(playerid, HouseInfo[InHouse[playerid]][EnterA]);

	InHouse[playerid] = 0;
	
	for(new x = 0; x < sizeof(hObject); x++)
	{
		DestroyObject(hObject[x]);
	}
	return 1;
}

CMD:buyhouse(playerid, params[])
{
	for(new i = 0; i < sizeof(HouseInfo); i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][EnterX], HouseInfo[i][EnterY], HouseInfo[i][EnterZ]))
		{
		    if(HouseInfo[i][Owned] == 1) return SCM(playerid, -1, "Aceasta casa este detinuta deja de un jucator!");
		    if(GetPlayerMoney(playerid) < HouseInfo[i][Price]) return SCM(playerid, -1, "Nu ai destui bani pentru a cumpara aceasta casa!");
		    
		    query[0] = EOS;
		    mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Owner` = '%s' AND `Icon` = '1' WHERE `ID` = '%d'", GetName(playerid), i);
		    mysql_query(mysql, query);
		    
		    HouseInfo[i][Owner] = strlen(GetName(playerid));
		    HouseInfo[i][Icon] = 1;
		    HouseInfo[i][Owned] = 1;
		    
			GivePlayerMoney(playerid, - HouseInfo[i][Price]);
			
			new pVW = HouseInfo[i][ID];

			hObject[0] = CreateDynamicObject(19377, 1252.10938, -2040.66418, 58.89970,   0.00000, 90.00000, -1.00000, pVW);
			hObject[1] = CreateDynamicObject(19377, 1262.57275, -2040.85669, 58.89970,   0.00000, 90.00000, -1.00000, pVW);
			hObject[2] = CreateDynamicObject(19377, 1262.72864, -2031.29443, 58.89970,   0.00000, 90.00000, -1.00000, pVW);
			hObject[3] = CreateDynamicObject(19377, 1252.24988, -2031.10950, 58.89970,   0.00000, 90.00000, -1.00000, pVW);
			hObject[4] = CreateDynamicObject(19450, 1267.81335, -2040.94067, 60.64445,   0.00000, 0.00000, -0.54000, pVW);
			hObject[5] = CreateDynamicObject(19450, 1267.90283, -2031.33313, 60.64445,   0.00000, 0.00000, -0.54000, pVW);
			hObject[6] = CreateDynamicObject(19450, 1263.12683, -2026.55164, 60.64445,   0.00000, 0.00000, 89.04001, pVW);
			hObject[7] = CreateDynamicObject(19450, 1253.49402, -2026.39087, 60.64445,   0.00000, 0.00000, 89.04001, pVW);
			hObject[8] = CreateDynamicObject(19450, 1248.72778, -2031.07532, 60.64445,   0.00000, 0.00000, -0.54000, pVW);
			hObject[9] = CreateDynamicObject(19450, 1248.63782, -2040.70471, 60.64445,   0.00000, 0.00000, -0.54000, pVW);
			hObject[10] = CreateDynamicObject(19450, 1247.33240, -2045.25854, 60.64445,   0.00000, 0.00000, 89.04001, pVW);
			hObject[11] = CreateDynamicObject(19404, 1253.74011, -2045.38159, 60.63889,   0.00000, 0.00000, 88.79999, pVW);
			hObject[12] = CreateDynamicObject(19388, 1256.89038, -2045.46082, 60.64155,   0.00000, 0.00000, 88.38003, pVW);
			hObject[13] = CreateDynamicObject(19404, 1260.09229, -2045.54846, 60.63889,   0.00000, 0.00000, 88.79999, pVW);
			hObject[14] = CreateDynamicObject(19450, 1266.49866, -2045.65491, 60.64445,   0.00000, 0.00000, 89.04001, pVW);
			hObject[15] = CreateDynamicObject(19466, 1253.60522, -2045.39917, 60.71215,   0.00000, 0.00000, 88.79995, pVW);
			hObject[16] = CreateDynamicObject(19466, 1260.12891, -2045.53113, 60.71215,   0.00000, 0.00000, 88.79995, pVW);
			hObject[17] = CreateDynamicObject(1505, 1256.11755, -2045.45593, 58.89073,   0.00000, 0.00000, -1.14000, pVW);
			hObject[18] = CreateDynamicObject(1505, 1255.78943, -2045.49438, 58.89073,   0.00000, 0.00000, -1.14000, pVW);
			hObject[19] = CreateDynamicObject(19377, 1262.72864, -2031.29443, 62.33289,   0.00000, 90.00000, -1.00000, pVW);
			hObject[20] = CreateDynamicObject(19377, 1252.24988, -2031.10950, 62.33600,   0.00000, 90.00000, -1.00000, pVW);
			hObject[21] = CreateDynamicObject(19377, 1252.10938, -2040.66418, 62.33412,   0.00000, 90.00000, -1.00000, pVW);
			hObject[22] = CreateDynamicObject(19377, 1262.57275, -2040.85669, 62.34385,   0.00000, 90.00000, -1.00000, pVW);
			
			UpdateHouse(1, i);

		    SetPlayerVirtualWorld(playerid, pVW);
			SetPlayerPos(playerid, HouseInfo[i][ExitX], HouseInfo[i][ExitY], HouseInfo[i][ExitZ]);
			SetPlayerFacingAngle(playerid, HouseInfo[i][ExitA]);
			InHouse[playerid] = i;

			SPD(playerid, 0, DIALOG_STYLE_MSGBOX, "House Menu", "{FFFFFF}Scrie \"{AFAFAF}/housemenu{FFFFFF}\" pentru a vedea optiunile disponibile.", "OK", "");
		}
	}
	return 1;
}

CMD:housemenu(playerid, params[])
{
	if(InHouse[playerid] == 0) return SCM(playerid, -1, "Nu te aflii intr-o casa!");
	
	new hStr[500], hStatus[20];
	
	if(HouseInfo[InHouse[playerid]][Status] == 0) hStatus = "{33AA33}OPENED";
	else if(HouseInfo[InHouse[playerid]][Status] == 1) hStatus = "{FF0000}LOCKED";
	
	format(hStr, sizeof(hStr), "{FF0000}House Help\n{FFFFFF}House Name\nSell House\nHouse Status: %s\nHouse Items (%d objects)", hStatus, GetHouseFurnitures(InHouse[playerid]));
	SPD(playerid, DIALOG_HOUSE, DIALOG_STYLE_TABLIST, "House Menu", hStr, "Select", "Cancel");
	return 1;
}

//Functions
function LoadHouses()
{
	new hStr[500], Rows, Fields, sts[500];
	cache_get_data(Rows, Fields, mysql);
	
	for(new i = 0; i < Rows; i++)
	{
	    HouseInfo[i][ID] = cache_get_field_content_int(i, "ID");
	    
	    cache_get_field_content(i, "HouseName", HouseInfo[i][HouseName], mysql, 100);
	    cache_get_field_content(i, "Owner", HouseInfo[i][Owner], mysql, 100);
	    
	    HouseInfo[i][Owned] = cache_get_field_content_int(i, "Owned");
	    HouseInfo[i][EnterX] = cache_get_field_content_float(i, "EnterX");
	    HouseInfo[i][EnterY] = cache_get_field_content_float(i, "EnterY");
	    HouseInfo[i][EnterZ] = cache_get_field_content_float(i, "EnterZ");
	    HouseInfo[i][EnterA] = cache_get_field_content_float(i, "EnterA");
	    HouseInfo[i][ExitX] = cache_get_field_content_float(i, "ExitX");
	    HouseInfo[i][ExitY] = cache_get_field_content_float(i, "ExitY");
	    HouseInfo[i][ExitZ] = cache_get_field_content_float(i, "ExitZ");
	    HouseInfo[i][ExitA] = cache_get_field_content_float(i, "ExitA");
	    HouseInfo[i][Price] = cache_get_field_content_int(i, "Price");
	    HouseInfo[i][Icon] = cache_get_field_content_int(i, "Icon");
	    HouseInfo[i][Rent] = cache_get_field_content_int(i, "Rent");
	    HouseInfo[i][Rentable] = cache_get_field_content_int(i, "Rentable");
	    HouseInfo[i][Level] = cache_get_field_content_int(i, "Level");
	    HouseInfo[i][VW] = cache_get_field_content_int(i, "VW");
	    HouseInfo[i][W1] = cache_get_field_content_int(i, "W1");
	    HouseInfo[i][W2] = cache_get_field_content_int(i, "W2");
	    HouseInfo[i][W3] = cache_get_field_content_int(i, "W3");
	    HouseInfo[i][W4] = cache_get_field_content_int(i, "W4");
	    HouseInfo[i][W5] = cache_get_field_content_int(i, "W5");
	    HouseInfo[i][W6] = cache_get_field_content_int(i, "W6");
	    HouseInfo[i][W7] = cache_get_field_content_int(i, "W7");
	    HouseInfo[i][W8] = cache_get_field_content_int(i, "W8");
	    HouseInfo[i][W9] = cache_get_field_content_int(i, "W9");
	    HouseInfo[i][W10] = cache_get_field_content_int(i, "W10");
	    HouseInfo[i][Status] = cache_get_field_content_int(i, "Status");
	    
	    TotalHouses++;
	}
	
	for(new x = 0; x < MAX_HOUSES; x++)
	{
	    if(HouseInfo[x][Owned] == 0)
	    {
			format(hStr, sizeof(hStr), "House ID: %d\nOwner: %s\nRequest Level: %d\nPrice: %d$\n\nType /enter to join in this house!", HouseInfo[x][ID], HouseInfo[x][Owner], HouseInfo[x][Level], HouseInfo[x][Price]);
			HouseLabel[x] = CreateDynamic3DTextLabel(hStr, -1, HouseInfo[x][EnterX], HouseInfo[x][EnterY], HouseInfo[x][EnterZ]+0.3, 15.0);

			CreateDynamicPickup(1273, 1, HouseInfo[x][EnterX], HouseInfo[x][EnterY], HouseInfo[x][EnterZ]);
			CreateDynamicMapIcon(HouseInfo[x][EnterX], HouseInfo[x][EnterY], HouseInfo[x][EnterZ], 31, 0, -1, -1, -1, 100.0);
	    }
	    else
	    {
	        if(HouseInfo[x][Status] == 1) sts = "{33AAFF}Unlocked";
	        else if(HouseInfo[x][Status] == 2) sts = "{FF0000}Locked";

	        format(hStr, sizeof(hStr), "House Name: %s\nHouse ID: %d\nOwner: %s\nRent: %d$\nStats: %s\n\n{FFFFFF}Type /enter to join in this house!", HouseInfo[x][HouseName], HouseInfo[x][ID], HouseInfo[x][Owner], HouseInfo[x][Rent], sts);
			HouseLabel[x] = CreateDynamic3DTextLabel(hStr, -1, HouseInfo[x][EnterX], HouseInfo[x][EnterY], HouseInfo[x][EnterZ]+0.3, 15.0);

			CreateDynamicPickup(19522, 1, HouseInfo[x][EnterX], HouseInfo[x][EnterY], HouseInfo[x][EnterZ]);
			CreateDynamicMapIcon(HouseInfo[x][EnterX], HouseInfo[x][EnterY], HouseInfo[x][EnterZ], 32, 0, -1, -1, -1, 100.0);
	    }
	}
	
	printf(" * Load Houses: %d", Rows);
	mysql_tquery(mysql, "SELECT * FROM `furniture`", "LoadFurniture", "");
	return 1;
}

function LoadFurniture()
{
	new Rows, Fields;
	cache_get_data(Rows, Fields, mysql);
	
	for(new i = 0; i < Rows; i++)
	{
	    FInfo[i][ID] = cache_get_field_content_int(i, "ID");
	    FInfo[i][HouseID] = cache_get_field_content_int(i, "HouseID");
	    FInfo[i][Model] = cache_get_field_content_int(i, "Model");
	    FInfo[i][X] = cache_get_field_content_float(i, "X");
	    FInfo[i][Y] = cache_get_field_content_float(i, "Y");
	    FInfo[i][Z] = cache_get_field_content_float(i, "Z");
	    FInfo[i][RX] = cache_get_field_content_float(i, "RX");
	    FInfo[i][RY] = cache_get_field_content_float(i, "RY");
	    FInfo[i][RZ] = cache_get_field_content_float(i, "RZ");
	    
	    CreateDynamicObject(FInfo[i][Model], FInfo[i][X], FInfo[i][Y], FInfo[i][Z], FInfo[i][RX], FInfo[i][RY], FInfo[i][RZ], FInfo[i][HouseID]);
	}
	
	printf(" * Load Furnitures: %d", Rows);
	return 1;
}

function UpdateHouse(type, x)
{
	new hStr[1800];
	if(type == 1)
	{
		if(HouseInfo[x][Icon] == 0)
		{
		    DestroyDynamic3DTextLabel(HouseLabel[x]);
		    
		    format(hStr, sizeof(hStr), "House ID: %d\nOwner: %s\nInterior: %d\nRequest Level: %d\nPrice: %d$\n\nType /enter to join in this house!", HouseInfo[x][ID], HouseInfo[x][Owner], HouseInfo[x][Level], HouseInfo[x][Price]);
			HouseLabel[x] = CreateDynamic3DTextLabel(hStr, -1, HouseInfo[x][EnterX], HouseInfo[x][EnterY], HouseInfo[x][EnterZ]+0.3, 15.0);
		}
		else
		{
		    DestroyDynamic3DTextLabel(HouseLabel[x]);

			new sts[100];
		    if(HouseInfo[x][Status] == 1) sts = "{33AAFF}Unlocked";
	        else if(HouseInfo[x][Status] == 2) sts = "{FF0000}Locked";

	        format(hStr, sizeof(hStr), "House Name: %s\nHouse ID: %d\nOwner: %s\nRent: %d$\nStats: %s\n\n{FFFFFF}Type /enter to join in this house!", HouseInfo[x][HouseName], HouseInfo[x][ID], HouseInfo[x][Owner], HouseInfo[x][Rent], sts);
			HouseLabel[x] = CreateDynamic3DTextLabel(hStr, -1, HouseInfo[x][EnterX], HouseInfo[x][EnterY], HouseInfo[x][EnterZ]+0.3, 15.0);
		}
	}
	return 1;
}

stock GetName(playerid)
{
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, sizeof(pName));
	return pName;
}

stock GetHouseFurnitures(houseid)
{
	new Rows, Fields, str[500];
	
	mysql_format(mysql, str, sizeof(str), "SELECT * FROM `furniture` WHERE `HouseID` = '%d'", houseid);
	mysql_query(mysql, str);
	cache_get_data(Rows, Fields, mysql);
	
	return Rows;
}

stock ServerHouses()
{
	new Rows, Fields;
	
	mysql_query(mysql, "SELECT * FROM `houses`");
	cache_get_data(Rows, Fields, mysql);
	
	return Rows;
}
