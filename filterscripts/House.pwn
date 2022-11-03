// House System - UNNIC RPG

#define FILTERSCRIPT
#include < a_samp >
#include < a_mysql >
#include < streamer >
#include < sscanf2 >
#include < YSI\y_iterate >
#include < cmd >

#define MAX_HOUSES          (100)
#define MAX_HOUSE_NAME      (48)
#define MAX_HOUSE_PASSWORD  (16)
#define MAX_HOUSE_ADDRESS   (48)
#define MAX_INT_NAME        (32)
#define INVALID_HOUSE_ID    (-1)
#define HOUSE_COOLDOWN      (6)
#define LIMIT_PER_PLAYER    (3)

#define SQL_HOST			"127.0.0.1"
#define	SQL_USER			"root"
#define	SQL_PASSWORD		""
#define	SQL_DBNAME			"rpg"

#define DIALOG_BUY_HOUSE 1000
#define DIALOG_HOUSE_PASSWORD 1001
#define DIALOG_HOUSE_MENU 1002
#define DIALOG_HOUSE_NAME 1003
#define DIALOG_HOUSE_NEW_PASSWORD 1004
#define DIALOG_HOUSE_LOCK 1005
#define DIALOG_SAFE_MENU 1006
#define DIALOG_SAFE_TAKE 1007
#define DIALOG_SAFE_PUT 1008
#define DIALOG_GUNS_MENU 1009
#define DIALOG_GUNS_TAKE 1010
#define DIALOG_FURNITURE_MENU 1011
#define DIALOG_FURNITURE_BUY 1012
#define DIALOG_FURNITURE_SELL 1013
#define DIALOG_VISITORS_MENU 1014
#define DIALOG_VISITORS 1015
#define DIALOG_KEYS_MENU 1016
#define DIALOG_KEYS 1017
#define DIALOG_SAFE_HISTORY 1018
#define DIALOG_MY_KEYS 1019
#define DIALOG_BUY_HOUSE_FROM_OWNER 1020
#define DIALOG_SELL_HOUSE 1021
#define DIALOG_SELLING_PRICE 1022

#define LOCK_MODE_NOLOCK 1
#define LOCK_MODE_PASSWORD 2
#define LOCK_MODE_KEYS 3
#define LOCK_MODE_OWNER 4

#define SELECT_MODE_NONE 1
#define SELECT_MODE_EDIT 2
#define SELECT_MODE_SELL 3

enum hInfo
{
	Name[MAX_HOUSE_NAME],
	Owner[MAX_PLAYER_NAME],
	Password[MAX_HOUSE_PASSWORD],
	Address[MAX_HOUSE_ADDRESS],
	Float: houseX,
	Float: houseY,
	Float: houseZ,
	Price,
	SalePrice,
	Interior,
	LockMode,
	SafeMoney,
	LastEntered,
	Text3D: HouseLabel,
	HousePickup,
	HouseIcon,
	bool: Save
};

enum hInterior
{
	IntName[MAX_INT_NAME],
	Float: intX,
	Float: intY,
	Float: intZ,
	intID,
	Text3D: intLabel,
	intPickup
};

enum fData
{
	ModelID,
	Name[32],
	Price
};

enum hFurniture
{
	SQLID,
	HouseID,
	ArrayID,
	Float: furnitureX,
	Float: furnitureY,
	Float: furnitureZ,
	Float: furnitureRX,
	Float: furnitureRY,
	Float: furnitureRZ
};

new mysql, query[500];
new HouseTimer = -1;
new HouseData[MAX_HOUSES][hInfo];
new Iterator: Houses<MAX_HOUSES>;
new Iterator: HouseKeys[MAX_PLAYERS]<MAX_HOUSES>;
new InHouse[MAX_PLAYERS] = {INVALID_HOUSE_ID, ...};
new SelectMode[MAX_PLAYERS] = {SELECT_MODE_NONE, ...};
new LastVisitedHouse[MAX_PLAYERS] = {INVALID_HOUSE_ID, ...};
new ListPage[MAX_PLAYERS] = {0, ...};
new bool: EditingFurniture[MAX_PLAYERS] = {false, ...};

new HouseInteriors[][hInterior] =
{
    // int name, x, y, z, intid
	{"Interior 1", 2233.4900, -1114.4435, 1050.8828, 5},
	{"Interior 2", 2196.3943, -1204.1359, 1049.0234, 6},
	{"Interior 3", 2318.1616, -1026.3762, 1050.2109, 9},
	{"Interior 4", 421.8333, 2536.9814, 10.0000, 10},
	{"Interior 5", 225.5707, 1240.0643, 1082.1406, 2},
	{"Interior 6", 2496.2087, -1692.3149, 1014.7422, 3},
	{"Interior 7", 226.7545, 1114.4180, 1080.9952, 5},
	{"Interior 8", 2269.9636, -1210.3275, 1047.5625, 10}
};

new HouseFurnitures[][fData] =
{
	// modelid, furniture name, price
	{3111, "Building Plan", 500},
	{2894, "Book", 20},
	{2277, "Cat Picture", 100},
	{1753, "Leather Couch", 150},
	{1703, "Black Couch", 200},
	{1255, "Lounger", 75},
	{19581, "Frying Pan", 10},
	{19584, "Sauce Pan", 12},
	{19590, "Woozie's Sword", 1000},
	{19525, "Wedding Cake", 50},
	{1742, "Bookshelf", 80},
	{1518, "TV 1", 130},
	{19609, "Drum Kit", 500},
	{19787, "Small LCD TV", 2000},
	{19786, "Big LCD TV", 4000},
	{2627, "Treadmill", 130}
};

new LockNames[4][32] =
{
	"{2ECC71}Not Locked",
	"{E74C3C}Password Locked",
	"{E74C3C}Requires Keys",
	"{E74C3C}Owner Only"
};
new TransactionNames[2][16] =
{
	"{E74C3C}Taken",
	"{2ECC71}Added"
};

forward ResetAndSaveHouses();
forward LoadHouses();
forward LoadFurnitures();
forward GiveHouseKeys(playerid);
forward HouseSaleMoney(playerid);

public ResetAndSaveHouses()
{
	foreach(new i : Houses)
	{
	    if(HouseData[i][LastEntered] > 0 && gettime()-HouseData[i][LastEntered] > 604800) ResetHouse(i);
	    if(HouseData[i][Save]) SaveHouse(i);
	}

	return 1;
}

public LoadHouses()
{
	new rows = cache_num_rows();
 	if(rows)
  	{
   		new id, loaded, for_sale, label[256];
		while(loaded < rows)
		{
  			id = cache_get_field_content_int(loaded, "ID");
	    	cache_get_field_content(loaded, "HouseName", HouseData[id][Name], .max_len = MAX_HOUSE_NAME);
		    cache_get_field_content(loaded, "HouseOwner", HouseData[id][Owner], .max_len = MAX_PLAYER_NAME);
		    cache_get_field_content(loaded, "HousePassword", HouseData[id][Password], .max_len = MAX_HOUSE_PASSWORD);
		    HouseData[id][houseX] = cache_get_field_content_float(loaded, "HouseX");
		    HouseData[id][houseY] = cache_get_field_content_float(loaded, "HouseY");
		    HouseData[id][houseZ] = cache_get_field_content_float(loaded, "HouseZ");
		    HouseData[id][Price] = cache_get_field_content_int(loaded, "HousePrice");
		    HouseData[id][SalePrice] = cache_get_field_content_int(loaded, "HouseSalePrice");
		    HouseData[id][Interior] = cache_get_field_content_int(loaded, "HouseInterior");
		    HouseData[id][LockMode] = cache_get_field_content_int(loaded, "HouseLock");
		    HouseData[id][SafeMoney] = cache_get_field_content_int(loaded, "HouseMoney");
		    HouseData[id][LastEntered] = cache_get_field_content_int(loaded, "LastEntered");

	        if(strcmp(HouseData[id][Owner], "-"))
			{
	            if(HouseData[id][SalePrice] > 0)
				{
	                for_sale = 1;
				    format(label, sizeof(label), "{FFFF00}%s's House - De vanzare (ID: %d)\n{FFFFFF}%s\n{F1C40F}Price: {2ECC71}$%s", HouseData[id][Owner], id, HouseData[id][Name], convertNumber(HouseData[id][SalePrice]));
				}
				else
				{
				    for_sale = 0;
					format(label, sizeof(label), "{E67E22}%s's House (ID: %d)\n\n{FFFFFF}%s\n{FFFFFF}%s\n{FFFFFF}Type /enter to join in this house.", HouseData[id][Owner], id, HouseData[id][Name], LockNames[ HouseData[id][LockMode] ]);
				}
			}
			else
			{
			    for_sale = 1;
         		format(label, sizeof(label), "{FFFF00}House For Sale (ID: %d)\n{FFFFFF}Price: {33AA33}$%s\n{FFFFFF}Type /buyhouse to buy this house.", id, convertNumber(HouseData[id][Price]));
	        }

			HouseData[id][HousePickup] = CreateDynamicPickup((!for_sale) ? 19522 : 1273, 1, HouseData[id][houseX], HouseData[id][houseY], HouseData[id][houseZ]);
			HouseData[id][HouseIcon] = CreateDynamicMapIcon(HouseData[id][houseX], HouseData[id][houseY], HouseData[id][houseZ], (!for_sale) ? 32 : 31, 0);
			HouseData[id][HouseLabel] = CreateDynamic3DTextLabel(label, 0xFFFFFFFF, HouseData[id][houseX], HouseData[id][houseY], HouseData[id][houseZ]+0.35, 15.0, .testlos = 1);
			Iter_Add(Houses, id);
		    loaded++;
	    }
	    printf(" * Load Houses: %d", loaded);
	}
	return 1;
}

public LoadFurnitures()
{
	new rows = cache_num_rows();
 	if(rows)
  	{
   		new id, loaded, data[hFurniture];
     	while(loaded < rows)
      	{
       		data[SQLID] = cache_get_field_content_int(loaded, "ID");
         	data[HouseID] = cache_get_field_content_int(loaded, "HouseID");
         	data[ArrayID] = cache_get_field_content_int(loaded, "FurnitureID");
          	data[furnitureX] = cache_get_field_content_float(loaded, "FurnitureX");
           	data[furnitureY] = cache_get_field_content_float(loaded, "FurnitureY");
            data[furnitureZ] = cache_get_field_content_float(loaded, "FurnitureZ");
            data[furnitureRX] = cache_get_field_content_float(loaded, "FurnitureRX");
            data[furnitureRY] = cache_get_field_content_float(loaded, "FurnitureRY");
            data[furnitureRZ] = cache_get_field_content_float(loaded, "FurnitureRZ");

			id = CreateDynamicObject(HouseFurnitures[ data[ArrayID] ][ModelID], data[furnitureX], data[furnitureY], data[furnitureZ], data[furnitureRX], data[furnitureRY], data[furnitureRZ], cache_get_field_content_int(loaded, "FurnitureVW"), cache_get_field_content_int(loaded, "FurnitureInt"));

			Streamer_SetArrayData(STREAMER_TYPE_OBJECT, id, E_STREAMER_EXTRA_ID, data);
   			loaded++;
 		}
 		printf(" * Load Furnitures: %d", loaded);
   	}
	return 1;
}

public GiveHouseKeys(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	new rows = cache_num_rows();
 	if(rows)
  	{
   		new loaded;
     	while(loaded < rows)
      	{
       		Iter_Add(HouseKeys[playerid], cache_get_field_content_int(loaded, "HouseID"));
   			loaded++;
 		}
   	}

	return 1;
}

public HouseSaleMoney(playerid)
{
    new rows = cache_num_rows();
 	if(rows)
  	{
   		new new_owner[MAX_PLAYER_NAME], price, string[128];
		for(new i; i < rows; i++)
		{
	    	cache_get_field_content(i, "NewOwner", new_owner);
		    price = cache_get_field_content_int(i, "Price");

			format(string, sizeof(string), "You sold a house to %s for $%s. (Transaction ID: #%d)", new_owner, convertNumber(price), cache_get_field_content_int(i, "ID"));
			SendClientMessage(playerid, -1, string);
			GivePlayerMoney(playerid, price);
	    }
		query[0] = EOS;
	    mysql_format(mysql, query, sizeof(query), "DELETE FROM house_sales WHERE OldOwner='%e'", Player_GetName(playerid));
	    mysql_tquery(mysql, query, "", "");
	}

	return 1;
}

public OnFilterScriptInit()
{
	for(new i; i < MAX_HOUSES; ++i)
	{
		HouseData[i][HouseLabel] = Text3D: INVALID_3DTEXT_ID;
		HouseData[i][HousePickup] = -1;
		HouseData[i][HouseIcon] = -1;
		HouseData[i][Save] = false;
	}

	for(new i; i < sizeof(HouseInteriors); ++i)
	{
	    HouseInteriors[i][intLabel] = CreateDynamic3DTextLabel("Leave House", 0xE67E22FF, HouseInteriors[i][intX], HouseInteriors[i][intY], HouseInteriors[i][intZ]+0.35, 10.0, .testlos = 1, .interiorid = HouseInteriors[i][intID]);
		HouseInteriors[i][intPickup] = CreateDynamicPickup(1318, 1, HouseInteriors[i][intX], HouseInteriors[i][intY], HouseInteriors[i][intZ], .interiorid = HouseInteriors[i][intID]);
	}

	Iter_Init(HouseKeys);
	DisableInteriorEnterExits();
	mysql = mysql_connect(SQL_HOST, SQL_USER, SQL_DBNAME, SQL_PASSWORD);
	mysql_log(LOG_ERROR | LOG_WARNING, LOG_TYPE_HTML);
	if(mysql_errno() != 0) return print(" [House System] Can't connect to MySQL.");

	query[0] = EOS;
	strcat(query, "CREATE TABLE IF NOT EXISTS `houses` (\
	  `ID` int(11) NOT NULL,\
	  `HouseName` varchar(48) NOT NULL default 'House For Sale',\
	  `HouseOwner` varchar(24) NOT NULL default '-',\
	  `HousePassword` varchar(16) NOT NULL default '-',\
	  `HouseX` float NOT NULL,\
	  `HouseY` float NOT NULL,\
	  `HouseZ` float NOT NULL,\
	  `HousePrice` int(11) NOT NULL,\
	  `HouseInterior` tinyint(4) NOT NULL default '0',\
	  `HouseLock` tinyint(4) NOT NULL default '0',\
	  `HouseMoney` int(11) NOT NULL default '0',"
 	);

 	strcat(query, "`LastEntered` int(11) NOT NULL,\
		  PRIMARY KEY  (`ID`),\
		  UNIQUE KEY `ID_2` (`ID`),\
		  KEY `ID` (`ID`)\
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;"
	);

	mysql_tquery(mysql, query, "", "");

	mysql_tquery(mysql, "CREATE TABLE IF NOT EXISTS `furniture` (\
	  `ID` int(11) NOT NULL auto_increment,\
	  `HouseID` int(11) NOT NULL,\
	  `FurnitureID` tinyint(11) NOT NULL,\
	  `FurnitureX` float NOT NULL,\
	  `FurnitureY` float NOT NULL,\
	  `FurnitureZ` float NOT NULL,\
	  `FurnitureRX` float NOT NULL,\
	  `FurnitureRY` float NOT NULL,\
	  `FurnitureRZ` float NOT NULL,\
	  `FurnitureVW` int(11) NOT NULL,\
	  `FurnitureInt` int(11) NOT NULL,\
	  PRIMARY KEY  (`ID`)\
	) ENGINE=MyISAM DEFAULT CHARSET=utf8;", "", "");

	mysql_tquery(mysql, "CREATE TABLE IF NOT EXISTS `houseguns` (\
	  `HouseID` int(11) NOT NULL,\
	  `WeaponID` tinyint(4) NOT NULL,\
	  `Ammo` int(11) NOT NULL,\
	  UNIQUE KEY `HouseID_2` (`HouseID`,`WeaponID`),\
	  KEY `HouseID` (`HouseID`),\
	  CONSTRAINT `houseguns_ibfk_1` FOREIGN KEY (`HouseID`) REFERENCES `houses` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE\
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;", "", "");

	mysql_tquery(mysql, "CREATE TABLE IF NOT EXISTS `house_visitors` (\
	  `HouseID` int(11) NOT NULL,\
	  `Visitor` varchar(24) NOT NULL,\
	  `Date` int(11) NOT NULL\
	) ENGINE=MyISAM DEFAULT CHARSET=utf8;", "", "");

	mysql_tquery(mysql, "CREATE TABLE IF NOT EXISTS `house_keys` (\
	  `HouseID` int(11) NOT NULL,\
	  `Player` varchar(24) NOT NULL,\
	  `Date` int(11) NOT NULL\
	) ENGINE=MyISAM DEFAULT CHARSET=utf8;", "", "");

	mysql_tquery(mysql, "CREATE TABLE IF NOT EXISTS `log_house` (\
	  `HouseID` int(11) NOT NULL,\
	  `Type` int(11) NOT NULL,\
	  `Amount` int(11) NOT NULL,\
	  `Date` int(11) NOT NULL\
	) ENGINE=MyISAM DEFAULT CHARSET=utf8;", "", "");
	
	mysql_tquery(mysql, "CREATE TABLE IF NOT EXISTS `house_sales` (\
	  `ID` int(11) NOT NULL AUTO_INCREMENT,\
	  `OldOwner` varchar(24) NOT NULL,\
	  `NewOwner` varchar(24) NOT NULL,\
	  `Price` int(11) NOT NULL,\
	  PRIMARY KEY (`ID`)\
	) ENGINE=MyISAM DEFAULT CHARSET=utf8;", "", "");

	// 1.3 update, add HouseSalePrice to the houses table
	if(!fexist("house_updated.txt"))
	{
		mysql_tquery(mysql, "ALTER TABLE houses ADD HouseSalePrice INT(11) NOT NULL AFTER HousePrice");
		
		new File: updateFile = fopen("house_updated.txt", io_append);
		if(updateFile)
		{
		    fwrite(updateFile, "Don't remove this file.");
			fclose(updateFile);
		}
	}
	
	mysql_tquery(mysql, "SELECT * FROM houses", "LoadHouses", "");
	mysql_tquery(mysql, "SELECT * FROM furniture", "LoadFurnitures", "");
	foreach(new i : Player) House_PlayerInit(i);

	HouseTimer = SetTimer("ResetAndSaveHouses", 10 * 60000, true);
	return 1;
}

public OnFilterScriptExit()
{
	foreach(new i : Houses) if(HouseData[i][Save]) SaveHouse(i);
	KillTimer(HouseTimer);
	return 1;
}

public OnPlayerConnect(playerid)
{
    House_PlayerInit(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	InHouse[playerid] = INVALID_HOUSE_ID;
	
	query[0] = EOS;
	mysql_format(mysql, query, sizeof(query), "SELECT * FROM house_sales WHERE OldOwner='%e'", Player_GetName(playerid));
	mysql_tquery(mysql, query, "HouseSaleMoney", "i", playerid);
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	if(GetPVarInt(playerid, "HousePickupCooldown") < gettime())
	{
	    if(InHouse[playerid] == INVALID_HOUSE_ID)
		{
			foreach(new i : Houses)
			{
			    if(pickupid == HouseData[i][HousePickup])
			    {
			        SetPVarInt(playerid, "HousePickupCooldown", gettime() + HOUSE_COOLDOWN);
			        SetPVarInt(playerid, "PickupHouseID", i);
			        
					if(!strcmp(HouseData[i][Owner], "-"))
					{
						new string[64];
						format(string, sizeof(string), "This house is for sale!\n\nPrice: {2ECC71}$%s", convertNumber(HouseData[i][Price]));
						ShowPlayerDialog(playerid, DIALOG_BUY_HOUSE, DIALOG_STYLE_MSGBOX, "House For Sale", string, "Buy", "Close");
					}
					else
					{
					    if(HouseData[i][SalePrice] > 0 && strcmp(HouseData[i][Owner], Player_GetName(playerid)))
					    {
                            new string[64];
							format(string, sizeof(string), "This house is for sale!\n\nPrice: {2ECC71}$%s", convertNumber(HouseData[i][SalePrice]));
							ShowPlayerDialog(playerid, DIALOG_BUY_HOUSE_FROM_OWNER, DIALOG_STYLE_MSGBOX, "House For Sale", string, "Buy", "Close");
							return 1;
					    }
					    switch(HouseData[i][LockMode])
					    {
					        case LOCK_MODE_NOLOCK: SendToHouse(playerid, i);
					        case LOCK_MODE_PASSWORD: ShowPlayerDialog(playerid, DIALOG_HOUSE_PASSWORD, DIALOG_STYLE_INPUT, "House Password", "This house is password protected.\n\nEnter house password:", "Done", "Close");
							case LOCK_MODE_KEYS:
							{
							    new gotkeys = Iter_Contains(HouseKeys[playerid], i);
							    if(!gotkeys) if(!strcmp(HouseData[i][Owner], Player_GetName(playerid))) gotkeys = 1;

								if(gotkeys)
								{
									SendToHouse(playerid, i);
								}
								else
								{
								    SendClientMessage(playerid, 0xE74C3CFF, "You don't have keys for this house, you can't enter.");
								}
							}

					        case LOCK_MODE_OWNER:
					        {
								if(!strcmp(HouseData[i][Owner], Player_GetName(playerid)))
								{
								    SetPVarInt(playerid, "HousePickupCooldown", gettime() + HOUSE_COOLDOWN);
						            SendToHouse(playerid, i);
								}
								else SendClientMessage(playerid, 0xE74C3CFF, "Sorry, only the owner can enter this house.");
					        }
					    }
					}

			        return 1;
			    }
			}
		}
		else
		{
			for(new i; i < sizeof(HouseInteriors); ++i)
			{
			    if(pickupid == HouseInteriors[i][intPickup])
			    {
			        SetPVarInt(playerid, "HousePickupCooldown", gettime() + HOUSE_COOLDOWN);
			        SetPlayerVirtualWorld(playerid, 0);
			        SetPlayerInterior(playerid, 0);
			        SetPlayerPos(playerid, HouseData[ InHouse[playerid] ][houseX], HouseData[ InHouse[playerid] ][houseY], HouseData[ InHouse[playerid] ][houseZ]);
			        InHouse[playerid] = INVALID_HOUSE_ID;
			        return 1;
			    }
			}
		}
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_BUY_HOUSE)
	{
		if(!response) return 1;
		new id = GetPVarInt(playerid, "PickupHouseID");
		if(!IsPlayerInRangeOfPoint(playerid, 2.0, HouseData[id][houseX], HouseData[id][houseY], HouseData[id][houseZ])) return SendClientMessage(playerid, 0xE74C3CFF, "You're not near any house.");
        #if LIMIT_PER_PLAYER > 0
		if(OwnedHouses(playerid) + 1 > LIMIT_PER_PLAYER) return SendClientMessage(playerid, 0xE74C3CFF, "You can't buy any more houses.");
		#endif
		if(HouseData[id][Price] > GetPlayerMoney(playerid)) return SendClientMessage(playerid, 0xE74C3CFF, "You can't afford this house.");
		if(strcmp(HouseData[id][Owner], "-")) return SendClientMessage(playerid, 0xE74C3CFF, "Someone already owns this house.");
		GivePlayerMoney(playerid, -HouseData[id][Price]);
		GetPlayerName(playerid, HouseData[id][Owner], MAX_PLAYER_NAME);
		HouseData[id][LastEntered] = gettime();
		HouseData[id][Save] = true;

		UpdateHouseLabel(id);
		Streamer_SetIntData(STREAMER_TYPE_PICKUP, HouseData[id][HousePickup], E_STREAMER_MODEL_ID, 19522);
		Streamer_SetIntData(STREAMER_TYPE_MAP_ICON, HouseData[id][HouseIcon], E_STREAMER_TYPE, 32);
		SendToHouse(playerid, id);
		return 1;
	}

	if(dialogid == DIALOG_HOUSE_PASSWORD)
	{
	    if(!response) return 1;
	    new id = GetPVarInt(playerid, "PickupHouseID");
		if(!IsPlayerInRangeOfPoint(playerid, 2.0, HouseData[id][houseX], HouseData[id][houseY], HouseData[id][houseZ])) return SendClientMessage(playerid, 0xE74C3CFF, "You're not near any house.");
		if(!(1 <= strlen(inputtext) <= MAX_HOUSE_PASSWORD)) return ShowPlayerDialog(playerid, DIALOG_HOUSE_PASSWORD, DIALOG_STYLE_INPUT, "House Password", "This house is password protected.\n\nEnter house password:\n\n{E74C3C}The password you entered is either too short or too long.", "Try Again", "Close");
		if(strcmp(HouseData[id][Password], inputtext)) return ShowPlayerDialog(playerid, DIALOG_HOUSE_PASSWORD, DIALOG_STYLE_INPUT, "House Password", "This house is password protected.\n\nEnter house password:\n\n{E74C3C}Wrong password.", "Try Again", "Close");
		SendToHouse(playerid, id);
		return 1;
	}

	if(dialogid == DIALOG_HOUSE_MENU)
	{
	    if(!response) return 1;
	    new id = InHouse[playerid];
	    if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");

		if(listitem == 0) ShowPlayerDialog(playerid, DIALOG_HOUSE_NAME, DIALOG_STYLE_INPUT, "House Name", "Write a new name for this house:", "Change", "Back");
		if(listitem == 1) ShowPlayerDialog(playerid, DIALOG_HOUSE_NEW_PASSWORD, DIALOG_STYLE_INPUT, "House Password", "Write a new password for this house:", "Change", "Back");
		if(listitem == 2) ShowPlayerDialog(playerid, DIALOG_HOUSE_LOCK, DIALOG_STYLE_LIST, "House Lock", "Not Locked\nPassword Lock\nKeys\nOwner Only", "Change", "Back");
		if(listitem == 3)
		{
		    if(HouseData[id][SalePrice] > 0)
			{
				SendClientMessage(playerid, 0xE74C3CFF, "You can't use this feature while the house is for sale.");
				return ShowHouseMenu(playerid);
			}
			
		    new string[144];
		    format(string, sizeof(string), "Take Money From Safe {2ECC71}($%s)\nPut Money To Safe {2ECC71}($%s)\nView Safe History\nClear Safe History", convertNumber(HouseData[id][SafeMoney]), convertNumber(GetPlayerMoney(playerid)));
			ShowPlayerDialog(playerid, DIALOG_SAFE_MENU, DIALOG_STYLE_LIST, "House Safe", string, "Choose", "Back");
		}

		if(listitem == 4)
		{
		    if(HouseData[id][SalePrice] > 0)
			{
				SendClientMessage(playerid, 0xE74C3CFF, "You can't use this feature while the house is for sale.");
				return ShowHouseMenu(playerid);
			}
			
			ShowPlayerDialog(playerid, DIALOG_FURNITURE_MENU, DIALOG_STYLE_LIST, "Furnitures", "Buy Furniture\nEdit Furniture\nSell Furniture\nSell All Furnitures", "Choose", "Back");
		}
		
		if(listitem == 5) ShowPlayerDialog(playerid, DIALOG_GUNS_MENU, DIALOG_STYLE_LIST, "Guns", "Put Gun\nTake Gun", "Choose", "Back");
        if(listitem == 6)
		{
		    ListPage[playerid] = 0;
			ShowPlayerDialog(playerid, DIALOG_VISITORS_MENU, DIALOG_STYLE_LIST, "Visitors", "Look Visitor History\nClear Visitor History", "Choose", "Back");
		}

		if(listitem == 7)
		{
		    ListPage[playerid] = 0;
			ShowPlayerDialog(playerid, DIALOG_KEYS_MENU, DIALOG_STYLE_LIST, "Keys", "View Key Owners\nChange Locks", "Choose", "Back");
		}

		if(listitem == 8)
		{
		    new string[128];
		    format(string, sizeof(string), "House owner %s kicked everybody from the house.", HouseData[id][Owner]);

			foreach(new i : Player)
			{
			    if(i == playerid) continue;
			    if(InHouse[i] == id)
			    {
		            SetPVarInt(i, "HousePickupCooldown", gettime() + HOUSE_COOLDOWN);
		        	SetPlayerVirtualWorld(i, 0);
			        SetPlayerInterior(i, 0);
			        SetPlayerPos(i, HouseData[id][houseX], HouseData[id][houseY], HouseData[id][houseZ]);
			        InHouse[i] = INVALID_HOUSE_ID;
			        SendClientMessage(i, -1, string);
			    }
			}

			SendClientMessage(playerid, -1, "You kicked everybody from your house.");
		}

		if(listitem == 9)
		{
		    new string[128];
		    format(string, sizeof(string), "Sell Instantly\t{2ECC71}$%s\n%s", convertNumber(floatround(HouseData[id][Price]*0.85)), (HouseData[id][SalePrice] > 0) ? ("Remove From Sale") : ("Put For Sale"));
			ShowPlayerDialog(playerid, DIALOG_SELL_HOUSE, DIALOG_STYLE_TABLIST, "Sell House", string, "Choose", "Back");
		}

		return 1;
	}

	if(dialogid == DIALOG_HOUSE_NAME)
	{
	    if(!response) return ShowHouseMenu(playerid);
        new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
		if(!(1 <= strlen(inputtext) <= MAX_HOUSE_NAME)) return ShowPlayerDialog(playerid, DIALOG_HOUSE_NAME, DIALOG_STYLE_INPUT, "House Name", "Write a new name for this house:\n\n{E74C3C}The name you entered is either too short or too long.", "Change", "Back");
        format(HouseData[id][Name], MAX_HOUSE_NAME, "%s", inputtext);
        HouseData[id][Save] = true;

        UpdateHouseLabel(id);
        ShowHouseMenu(playerid);
	    return 1;
	}

	if(dialogid == DIALOG_HOUSE_NEW_PASSWORD)
	{
	    if(!response) return ShowHouseMenu(playerid);
        new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
		if(!(1 <= strlen(inputtext) <= MAX_HOUSE_PASSWORD)) return ShowPlayerDialog(playerid, DIALOG_HOUSE_NAME, DIALOG_STYLE_INPUT, "House Name", "Write a new name for this house:\n\n{E74C3C}The name you entered is either too short or too long.", "Change", "Back");
        format(HouseData[id][Password], MAX_HOUSE_PASSWORD, "%s", inputtext);
        HouseData[id][Save] = true;
        ShowHouseMenu(playerid);
	    return 1;
	}

	if(dialogid == DIALOG_HOUSE_LOCK)
	{
	    if(!response) return ShowHouseMenu(playerid);
        new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
		HouseData[id][LockMode] = listitem;
		HouseData[id][Save] = true;

		UpdateHouseLabel(id);
        ShowHouseMenu(playerid);
	    return 1;
	}

	if(dialogid == DIALOG_SAFE_MENU)
	{
	    if(!response) return ShowHouseMenu(playerid);
	    new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
		if(HouseData[id][SalePrice] > 0) return SendClientMessage(playerid, 0xE74C3CFF, "You can't use this feature while the house is for sale.");
		if(listitem == 0) ShowPlayerDialog(playerid, DIALOG_SAFE_TAKE, DIALOG_STYLE_INPUT, "Safe: Take Money", "Write the amount you want to take from safe:", "Take", "Back");
		if(listitem == 1) ShowPlayerDialog(playerid, DIALOG_SAFE_PUT, DIALOG_STYLE_INPUT, "Safe: Put Money", "Write the amount you want to put to safe:", "Put", "Back");
        if(listitem == 2)
        {
			ListPage[playerid] = 0;

            new Cache: safelog;
            query[0] = EOS;
		    mysql_format(mysql, query, sizeof(query), "SELECT Type, Amount, FROM_UNIXTIME(Date, '%%d/%%m/%%Y %%H:%%i') as TransactionDate FROM log_house WHERE HouseID=%d ORDER BY Date DESC LIMIT 0, 15", id);
			safelog = mysql_query(mysql, query);
			new rows = cache_num_rows();
			if(rows)
			{
			    new list[1024], date[20];
			    format(list, sizeof(list), "Action\tDate\n");
			    for(new i; i < rows; ++i)
			    {
		        	cache_get_field_content(i, "TransactionDate", date);
			        format(list, sizeof(list), "%s%s $%s\t{FFFFFF}%s\n", list, TransactionNames[ cache_get_field_content_int(i, "Type") ], convertNumber(cache_get_field_content_int(i, "Amount")), date);
			    }

			    ShowPlayerDialog(playerid, DIALOG_SAFE_HISTORY, DIALOG_STYLE_TABLIST_HEADERS, "Safe History (Page 1)", list, "Next", "Previous");
			}
			else SendClientMessage(playerid, 0xE74C3CFF, "Can't find any safe history.");

		    cache_delete(safelog);
        }

        if(listitem == 3)
		{
		    query[0] = EOS;
		    mysql_format(mysql, query, sizeof(query), "DELETE FROM log_house WHERE HouseID=%d", id);
    		mysql_tquery(mysql, query, "", "");
    		ShowHouseMenu(playerid);
		}
		return 1;
	}
	if(dialogid == DIALOG_SAFE_TAKE)
	{
	    if(!response) return ShowHouseMenu(playerid);
        new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
		if(HouseData[id][SalePrice] > 0) return SendClientMessage(playerid, 0xE74C3CFF, "You can't use this feature while the house is for sale.");
        new amount = strval(inputtext);
		if(!(1 <= amount <= 10000000)) return ShowPlayerDialog(playerid, DIALOG_SAFE_TAKE, DIALOG_STYLE_INPUT, "Safe: Take Money", "Write the amount you want to take from safe:\n\n{E74C3C}Invalid amount. You can take between $1 - $10,000,000 at a time.", "Take", "Back");
		if(amount > HouseData[id][SafeMoney]) return ShowPlayerDialog(playerid, DIALOG_SAFE_TAKE, DIALOG_STYLE_INPUT, "Safe: Take Money", "Write the amount you want to take from safe:\n\n{E74C3C}You don't have that much money in your safe.", "Take", "Back");
        query[0] = EOS;
		mysql_format(mysql, query, sizeof(query), "INSERT INTO log_house SET HouseID=%d, Type=0, Amount=%d, Date=UNIX_TIMESTAMP()", id, amount);
		mysql_tquery(mysql, query, "", "");

		GivePlayerMoney(playerid, amount);
		HouseData[id][SafeMoney] -= amount;
		HouseData[id][Save] = true;
		ShowHouseMenu(playerid);
	    return 1;
	}
	if(dialogid == DIALOG_SAFE_PUT)
	{
	    if(!response) return ShowHouseMenu(playerid);
        new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
        new amount = strval(inputtext);
		if(!(1 <= amount <= 10000000)) return ShowPlayerDialog(playerid, DIALOG_SAFE_PUT, DIALOG_STYLE_INPUT, "Safe: Put Money", "Write the amount you want to put to safe:\n\n{E74C3C}Invalid amount. You can put between $1 - $10,000,000 at a time.", "Put", "Back");
		if(amount > GetPlayerMoney(playerid)) return ShowPlayerDialog(playerid, DIALOG_SAFE_PUT, DIALOG_STYLE_INPUT, "Safe: Put Money", "Write the amount you want to put to safe:\n\n{E74C3C}You don't have that much money on you.", "Put", "Back");
        query[0] = EOS;
		mysql_format(mysql, query, sizeof(query), "INSERT INTO log_house SET HouseID=%d, Type=1, Amount=%d, Date=UNIX_TIMESTAMP()", id, amount);
		mysql_tquery(mysql, query, "", "");

		GivePlayerMoney(playerid, -amount);
		HouseData[id][SafeMoney] += amount;
		HouseData[id][Save] = true;
		ShowHouseMenu(playerid);
	    return 1;
	}
	if(dialogid == DIALOG_GUNS_MENU)
	{
		if(!response) return ShowHouseMenu(playerid);
		new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
		if(listitem == 0)
		{
			if(GetPlayerWeapon(playerid) == 0) return SendClientMessage(playerid, 0xE74C3CFF, "You can't put your fists in your house.");
			new weapon = GetPlayerWeapon(playerid), ammo = GetPlayerAmmo(playerid);
			query[0] = EOS;
            RemovePlayerWeapon(playerid, weapon);
			mysql_format(mysql, query, sizeof(query), "INSERT INTO houseguns VALUES (%d, %d, %d) ON DUPLICATE KEY UPDATE Ammo=Ammo+%d", id, weapon, ammo, ammo);
			mysql_tquery(mysql, query, "", "");
			ShowHouseMenu(playerid);
		}

		if(listitem == 1)
		{
		    new Cache: weapons;
		    query[0] = EOS;
		    mysql_format(mysql, query, sizeof(query), "SELECT WeaponID, Ammo FROM houseguns WHERE HouseID=%d ORDER BY WeaponID ASC", id);
			weapons = mysql_query(mysql, query);
			new rows = cache_num_rows();
			if(rows)
			{
			    new list[512], weapname[32];
			    format(list, sizeof(list), "#\tWeapon Name\tAmmo\n");
			    for(new i; i < rows; ++i)
			    {
			        GetWeaponName(cache_get_field_content_int(i, "WeaponID"), weapname, sizeof(weapname));
			        format(list, sizeof(list), "%s%d\t%s\t%s\n", list, i+1, weapname, convertNumber(cache_get_field_content_int(i, "Ammo")));
			    }

			    ShowPlayerDialog(playerid, DIALOG_GUNS_TAKE, DIALOG_STYLE_TABLIST_HEADERS, "House Guns", list, "Take", "Back");
			}
			else
			{
				SendClientMessage(playerid, 0xE74C3CFF, "You don't have any guns in your house.");
			}

		    cache_delete(weapons);
		}
		return 1;
	}
	if(dialogid == DIALOG_GUNS_TAKE)
	{
		if(!response) return ShowHouseMenu(playerid);
		new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
  		new Cache: weapon;
  		query[0] = EOS;
    	mysql_format(mysql, query, sizeof(query), "SELECT WeaponID, Ammo FROM houseguns WHERE HouseID=%d ORDER BY WeaponID ASC LIMIT %d, 1", id, listitem);
		weapon = mysql_query(mysql, query);
		new rows = cache_num_rows();
		if(rows)
		{
  			new string[64], weapname[32], weaponid = cache_get_field_content_int(0, "WeaponID");
  			GetWeaponName(weaponid, weapname, sizeof(weapname));
  			GivePlayerWeapon(playerid, weaponid, cache_get_field_content_int(0, "Ammo"));
			format(string, sizeof(string), "You've taken a %s from your house.", weapname);
			SendClientMessage(playerid, 0xFFFFFFFF, string);
			mysql_format(mysql, query, sizeof(query), "DELETE FROM houseguns WHERE HouseID=%d AND WeaponID=%d", id, weaponid);
			mysql_tquery(mysql, query, "", "");
		}
		else SendClientMessage(playerid, 0xE74C3CFF, "Can't find that weapon.");

		cache_delete(weapon);
		return 1;
	}
    if(dialogid == DIALOG_FURNITURE_MENU)
	{
	    if(!response) return ShowHouseMenu(playerid);
        new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
		if(HouseData[id][SalePrice] > 0) return SendClientMessage(playerid, 0xE74C3CFF, "You can't use this feature while the house is for sale.");

		if(listitem == 0)
		{
		    new list[512];
		    format(list, sizeof(list), "#\tFurniture Name\tPrice\n");
		    for(new i; i < sizeof(HouseFurnitures); ++i)
		    {
		        format(list, sizeof(list), "%s%d\t%s\t$%s\n", list, i+1, HouseFurnitures[i][Name], convertNumber(HouseFurnitures[i][Price]));
		    }
		    ShowPlayerDialog(playerid, DIALOG_FURNITURE_BUY, DIALOG_STYLE_TABLIST_HEADERS, "Buy Furniture", list, "Buy", "Back");
		}
		if(listitem == 1)
		{
			SelectMode[playerid] = SELECT_MODE_EDIT;
		    SelectObject(playerid);
		    SendClientMessage(playerid, 0xFFFFFFFF, "Click on the furniture you want to edit.");
		}
		if(listitem == 2)
		{
		    SelectMode[playerid] = SELECT_MODE_SELL;
		    SelectObject(playerid);
		    SendClientMessage(playerid, 0xFFFFFFFF, "Click on the furniture you want to sell.");
		}
		if(listitem == 3)
		{
		    new money, sold, data[hFurniture];
		    query[0] = EOS;
		    
		    for(new i; i < Streamer_GetUpperBound(STREAMER_TYPE_OBJECT); ++i)
		    {
		        if(!IsValidDynamicObject(i)) continue;
				Streamer_GetArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, data);
				if(data[SQLID] > 0 && data[HouseID] == id)
				{
				    sold++;
				    money += HouseFurnitures[ data[ArrayID] ][Price];
					DestroyDynamicObject(i);
				}
		    }

		    new string[64];
		    format(string, sizeof(string), "Sold %d furnitures for $%s.", sold, convertNumber(money));
		    SendClientMessage(playerid, -1, string);
		    GivePlayerMoney(playerid, money);

		    mysql_format(mysql, query, sizeof(query), "DELETE FROM furniture WHERE HouseID=%d", id);
		    mysql_tquery(mysql, query, "", "");
		}
	    return 1;
	}
	if(dialogid == DIALOG_FURNITURE_BUY)
	{
	    if(!response) return ShowHouseMenu(playerid);
        new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
		if(HouseData[id][SalePrice] > 0) return SendClientMessage(playerid, 0xE74C3CFF, "You can't use this feature while the house is for sale.");
		if(HouseFurnitures[listitem][Price] > GetPlayerMoney(playerid)) return SendClientMessage(playerid, 0xE74C3CFF, "You can't afford this furniture.");
		GivePlayerMoney(playerid, -HouseFurnitures[listitem][Price]);
		new Float: x, Float: y, Float: z;
		GetPlayerPos(playerid, x, y, z);
        GetXYInFrontOfPlayer(playerid, x, y, 3.0);
        new objectid = CreateDynamicObject(HouseFurnitures[listitem][ModelID], x, y, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
        query[0] = EOS;
        
		mysql_format(mysql, query, sizeof(query), "INSERT INTO furniture SET HouseID=%d, FurnitureID=%d, FurnitureX=%f, FurnitureY=%f, FurnitureZ=%f, FurnitureVW=%d, FurnitureInt=%d", id, listitem, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
        new Cache: add = mysql_query(mysql, query), data[hFurniture];
        data[SQLID] = cache_insert_id();
		data[HouseID] = id;
        data[ArrayID] = listitem;
		data[furnitureX] = x;
		data[furnitureY] = y;
		data[furnitureZ] = z;
		data[furnitureRX] = 0.0;
		data[furnitureRY] = 0.0;
		data[furnitureRZ] = 0.0;
		cache_delete(add);
		Streamer_SetArrayData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_EXTRA_ID, data);
		
		EditingFurniture[playerid] = true;
		EditDynamicObject(playerid, objectid);
		return 1;
	}
	if(dialogid == DIALOG_FURNITURE_SELL)
	{
	    if(!response) return 1;
        new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
		if(HouseData[id][SalePrice] > 0) return SendClientMessage(playerid, 0xE74C3CFF, "You can't use this feature while the house is for sale.");
		new objectid = GetPVarInt(playerid, "SelectedFurniture"), data[hFurniture];
		query[0] = EOS;
		
		Streamer_GetArrayData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_EXTRA_ID, data);
		GivePlayerMoney(playerid, HouseFurnitures[ data[ArrayID] ][Price]);
		mysql_format(mysql, query, sizeof(query), "DELETE FROM furniture WHERE ID=%d", data[SQLID]);
		mysql_tquery(mysql, query, "", "");
		DestroyDynamicObject(objectid);
		DeletePVar(playerid, "SelectedFurniture");
		return 1;
	}
	if(dialogid == DIALOG_VISITORS_MENU)
	{
		if(!response) return ShowHouseMenu(playerid);
		new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
		if(listitem == 0)
		{
		    new Cache: visitors;
		    query[0] = EOS;
		    mysql_format(mysql, query, sizeof(query), "SELECT Visitor, FROM_UNIXTIME(Date, '%%d/%%m/%%Y %%H:%%i') as VisitDate FROM house_visitors WHERE HouseID=%d ORDER BY Date DESC LIMIT 0, 15", id);
			visitors = mysql_query(mysql, query);
			new rows = cache_num_rows();
			if(rows)
			{
			    new list[1024], visitor_name[MAX_PLAYER_NAME], visit_date[20];
			    format(list, sizeof(list), "Visitor Name\tDate\n");
			    for(new i; i < rows; ++i)
			    {
			        cache_get_field_content(i, "Visitor", visitor_name);
			        cache_get_field_content(i, "VisitDate", visit_date);
			        format(list, sizeof(list), "%s%s\t%s\n", list, visitor_name, visit_date);
			    }
			    ShowPlayerDialog(playerid, DIALOG_VISITORS, DIALOG_STYLE_TABLIST_HEADERS, "House Visitors (Page 1)", list, "Next", "Previous");
			}
			else
			{
				SendClientMessage(playerid, 0xE74C3CFF, "You didn't had any visitors.");
			}

		    cache_delete(visitors);
		}
		if(listitem == 1)
		{
		    query[0] = '\0';
		    mysql_format(mysql, query, sizeof(query), "DELETE FROM house_visitors WHERE HouseID=%d", id);
    		mysql_tquery(mysql, query, "", "");
    		ShowHouseMenu(playerid);
		}
		return 1;
	}

	if(dialogid == DIALOG_VISITORS)
	{
		if(!response)
		{
			ListPage[playerid]--;
			if(ListPage[playerid] < 0)
			{
			    ListPage[playerid] = 0;
			    ShowHouseMenu(playerid);
			    return 1;
			}
		}
		else
		{
		    ListPage[playerid]++;
		}

		new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");

		new Cache: visitors;
		query[0] = '\0';
    	mysql_format(mysql, query, sizeof(query), "SELECT Visitor, FROM_UNIXTIME(Date, '%%d/%%m/%%Y %%H:%%i') as VisitDate FROM house_visitors WHERE HouseID=%d ORDER BY Date DESC LIMIT %d, 15", id, ListPage[playerid]*15);
		visitors = mysql_query(mysql, query);
		new rows = cache_num_rows();
		if(rows)
		{
  			new list[1024], visitor_name[MAX_PLAYER_NAME], visit_date[20];
	    	format(list, sizeof(list), "Visitor Name\tDate\n");
		    for(new i; i < rows; ++i)
		    {
      			cache_get_field_content(i, "Visitor", visitor_name);
	        	cache_get_field_content(i, "VisitDate", visit_date);
		        format(list, sizeof(list), "%s%s\t%s\n", list, visitor_name, visit_date);
		    }

			new title[32];
			format(title, sizeof(title), "House Visitors (Page %d)", ListPage[playerid]+1);
			ShowPlayerDialog(playerid, DIALOG_VISITORS, DIALOG_STYLE_TABLIST_HEADERS, title, list, "Next", "Previous");
		}
		else
		{
			SendClientMessage(playerid, 0xE74C3CFF, "Can't find any more visitors.");
			ListPage[playerid] = 0;
   			ShowHouseMenu(playerid);
		}

		cache_delete(visitors);
		return 1;
	}

	if(dialogid == DIALOG_KEYS_MENU)
	{
		if(!response) return ShowHouseMenu(playerid);
		new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
		if(listitem == 0)
		{
		    new Cache: keyowners;
		    query[0] = '\0';
		    mysql_format(mysql, query, sizeof(query), "SELECT Player, FROM_UNIXTIME(Date, '%%d/%%m/%%Y %%H:%%i') as KeyDate FROM house_keys WHERE HouseID=%d ORDER BY Date DESC LIMIT %d, 15", id, ListPage[playerid]*15);
			keyowners = mysql_query(mysql, query);
			new rows = cache_num_rows();
			if(rows)
			{
			    new list[1024], key_name[MAX_PLAYER_NAME], key_date[20];
			    format(list, sizeof(list), "Key Owner\tKey Given On\n");
			    for(new i; i < rows; ++i)
			    {
			        cache_get_field_content(i, "Player", key_name);
			        cache_get_field_content(i, "KeyDate", key_date);
			        format(list, sizeof(list), "%s%s\t%s\n", list, key_name, key_date);
			    }

			    ShowPlayerDialog(playerid, DIALOG_KEYS, DIALOG_STYLE_TABLIST_HEADERS, "Key Owners (Page 1)", list, "Next", "Previous");
			}
			else
			{
				SendClientMessage(playerid, 0xE74C3CFF, "Can't find any key owners.");
			}
		    cache_delete(keyowners);
		}
		if(listitem == 1)
		{
		    foreach(new i : Player)
		    {
		        if(Iter_Contains(HouseKeys[i], id)) Iter_Remove(HouseKeys[i], id);
		    }
		    
		    query[0] = '\0';
		    mysql_format(mysql, query, sizeof(query), "DELETE FROM house_keys WHERE HouseID=%d", id);
    		mysql_tquery(mysql, query, "", "");
    		ShowHouseMenu(playerid);
		}
		return 1;
	}
	if(dialogid == DIALOG_KEYS)
	{
	    if(!response)
		{
			ListPage[playerid]--;
			if(ListPage[playerid] < 0)
			{
			    ListPage[playerid] = 0;
			    ShowHouseMenu(playerid);
			    return 1;
			}
		}
		else
		{
		    ListPage[playerid]++;
		}

		new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
        new Cache: keyowners;
        query[0] = '\0';
  		mysql_format(mysql, query, sizeof(query), "SELECT Player, FROM_UNIXTIME(Date, '%%d/%%m/%%Y %%H:%%i') as KeyDate FROM house_keys WHERE HouseID=%d ORDER BY Date DESC LIMIT %d, 15", id, ListPage[playerid]*15);
		keyowners = mysql_query(mysql, query);
		new rows = cache_num_rows();
		if(rows)
		{
  			new list[1024], key_name[MAX_PLAYER_NAME], key_date[20];
	    	format(list, sizeof(list), "Key Owner\tKey Given On\n");
		    for(new i; i < rows; ++i)
		    {
      			cache_get_field_content(i, "Player", key_name);
	        	cache_get_field_content(i, "KeyDate", key_date);
		        format(list, sizeof(list), "%s%s\t%s\n", list, key_name, key_date);
		    }

            new title[32];
			format(title, sizeof(title), "Key Owners (Page %d)", ListPage[playerid]+1);
			ShowPlayerDialog(playerid, DIALOG_KEYS, DIALOG_STYLE_TABLIST_HEADERS, title, list, "Next", "Previous");
		}
		else
		{
		    ListPage[playerid] = 0;
   			ShowHouseMenu(playerid);
			SendClientMessage(playerid, 0xE74C3CFF, "Can't find any more key owners.");
		}

		cache_delete(keyowners);
	    return 1;
	}
	if(dialogid == DIALOG_SAFE_HISTORY)
	{
	    if(!response)
		{
			ListPage[playerid]--;
			if(ListPage[playerid] < 0)
			{
			    ListPage[playerid] = 0;
			    ShowHouseMenu(playerid);
			    return 1;
			}
		}
		else
		{
		    ListPage[playerid]++;
		}

		new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
        new Cache: safelog;
        query[0] = '\0';
  		mysql_format(mysql, query, sizeof(query), "SELECT Type, Amount, FROM_UNIXTIME(Date, '%%d/%%m/%%Y %%H:%%i') as TransactionDate FROM log_house WHERE HouseID=%d ORDER BY Date DESC LIMIT %d, 15", id, ListPage[playerid]*15);
		safelog = mysql_query(mysql, query);
		new rows = cache_num_rows();
		if(rows)
		{
  			new list[1024], date[20];
	    	format(list, sizeof(list), "Action\tDate\n");
		    for(new i; i < rows; ++i)
		    {
	        	cache_get_field_content(i, "TransactionDate", date);
		        format(list, sizeof(list), "%s%s $%s\t{FFFFFF}%s\n", list, TransactionNames[ cache_get_field_content_int(i, "Type") ], convertNumber(cache_get_field_content_int(i, "Amount")), date);
		    }

            new title[32];
			format(title, sizeof(title), "Safe History (Page %d)", ListPage[playerid]+1);
			ShowPlayerDialog(playerid, DIALOG_SAFE_HISTORY, DIALOG_STYLE_TABLIST_HEADERS, title, list, "Next", "Previous");
		}
		else
		{
			SendClientMessage(playerid, 0xE74C3CFF, "Can't find any more safe history.");
		}
		cache_delete(safelog);
	    return 1;
	}
	if(dialogid == DIALOG_MY_KEYS)
	{
	    if(!response)
		{
			ListPage[playerid]--;
			if(ListPage[playerid] < 0)
			{
			    ListPage[playerid] = 0;
			    return 1;
			}
		}
		else
		{
		    ListPage[playerid]++;
		}

        new Cache: mykeys;
        query[0] = '\0';
	    mysql_format(mysql, query, sizeof(query), "SELECT HouseID, FROM_UNIXTIME(Date, '%%d/%%m/%%Y %%H:%%i') as KeyDate FROM house_keys WHERE Player='%e' ORDER BY Date DESC LIMIT %d, 15", Player_GetName(playerid), ListPage[playerid]*15);
		mykeys = mysql_query(mysql, query);

		new rows = cache_num_rows();
		if(rows)
		{
  			new list[1024], id, key_date[20];
	   		format(list, sizeof(list), "House Info\tKey Given On\n");
		    for(new i; i < rows; ++i)
		    {
		        id = cache_get_field_content_int(i, "HouseID");
	       		cache_get_field_content(i, "KeyDate", key_date);
		        format(list, sizeof(list), "%s%s's %s\t%s\n", list, HouseData[id][Owner], HouseData[id][Name], key_date);
		    }

            new title[32];
			format(title, sizeof(title), "My Keys (Page %d)", ListPage[playerid]+1);
			ShowPlayerDialog(playerid, DIALOG_MY_KEYS, DIALOG_STYLE_TABLIST_HEADERS, title, list, "Next", "Previous");
		}
		else
		{
		    ListPage[playerid] = 0;
			SendClientMessage(playerid, 0xE74C3CFF, "Can't find any more keys.");
		}
		cache_delete(mykeys);
	    return 1;
	}
	if(dialogid == DIALOG_BUY_HOUSE_FROM_OWNER)
	{
		if(!response) return 1;
		new id = GetPVarInt(playerid, "PickupHouseID");
		if(!IsPlayerInRangeOfPoint(playerid, 2.0, HouseData[id][houseX], HouseData[id][houseY], HouseData[id][houseZ])) return SendClientMessage(playerid, 0xE74C3CFF, "You're not near any house.");
        #if LIMIT_PER_PLAYER > 0
		if(OwnedHouses(playerid) + 1 > LIMIT_PER_PLAYER) return SendClientMessage(playerid, 0xE74C3CFF, "You can't buy any more houses.");
		#endif
		if(HouseData[id][SalePrice] > GetPlayerMoney(playerid)) return SendClientMessage(playerid, 0xE74C3CFF, "You can't afford this house.");
		if(HouseData[id][SalePrice] < 1) return SendClientMessage(playerid, 0xE74C3CFF, "Someone already owns this house.");
  		new old_owner[MAX_PLAYER_NAME], price = HouseData[id][SalePrice], owner_id = INVALID_PLAYER_ID;
  		format(old_owner, MAX_PLAYER_NAME, "%s", HouseData[id][Owner]);
  		
		foreach(new i : Player)
		{
			if(!strcmp(HouseData[id][Owner], Player_GetName(i)))
			{
				owner_id = i;
				break;
			}
		}
		
		GivePlayerMoney(playerid, -HouseData[id][SalePrice]);
		GetPlayerName(playerid, HouseData[id][Owner], MAX_PLAYER_NAME);
  		HouseData[id][LastEntered] = gettime();
  		HouseData[id][SalePrice] = 0;
		HouseData[id][Save] = true;

		UpdateHouseLabel(id);
		Streamer_SetIntData(STREAMER_TYPE_PICKUP, HouseData[id][HousePickup], E_STREAMER_MODEL_ID, 19522);
		Streamer_SetIntData(STREAMER_TYPE_MAP_ICON, HouseData[id][HouseIcon], E_STREAMER_TYPE, 32);
		SendToHouse(playerid, id);
		
		foreach(new i : Player)
	    {
	        if(i == playerid) continue;
	        if(InHouse[i] == id)
	        {
	            SetPVarInt(i, "HousePickupCooldown", gettime() + HOUSE_COOLDOWN);
	        	SetPlayerVirtualWorld(i, 0);
		        SetPlayerInterior(i, 0);
		        SetPlayerPos(i, HouseData[id][houseX], HouseData[id][houseY], HouseData[id][houseZ]);
		        InHouse[i] = INVALID_HOUSE_ID;
	        }

	        if(Iter_Contains(HouseKeys[i], id)) Iter_Remove(HouseKeys[i], id);
	   	}

	    query[0] = EOS;
	    if(IsPlayerConnected(owner_id))
		{
	        GivePlayerMoney(owner_id, price);

			new string[128];
			format(string, sizeof(string), "%s(%d) has bought your house for $%s.", HouseData[id][Owner], playerid, convertNumber(price));
			SendClientMessage(owner_id, -1, string);
	    }
		else
		{
	        mysql_format(mysql, query, sizeof(query), "INSERT INTO house_sales SET OldOwner='%e', NewOwner='%e', Price=%d", old_owner, HouseData[id][Owner], price);
	    	mysql_tquery(mysql, query, "", "");
	    }
	    
	    mysql_format(mysql, query, sizeof(query), "DELETE FROM house_visitors WHERE HouseID=%d", id);
	    mysql_tquery(mysql, query, "", "");

	    mysql_format(mysql, query, sizeof(query), "DELETE FROM house_keys WHERE HouseID=%d", id);
	    mysql_tquery(mysql, query, "", "");

	    mysql_format(mysql, query, sizeof(query), "DELETE FROM log_house WHERE HouseID=%d", id);
	    mysql_tquery(mysql, query, "", "");
		return 1;
	}
	if(dialogid == DIALOG_SELL_HOUSE)
	{
	    if(!response) return ShowHouseMenu(playerid);
        new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
		if(listitem == 0)
		{
		    new money = floatround(HouseData[id][Price] * 0.85) + HouseData[id][SafeMoney];
		    GivePlayerMoney(playerid, money);
			ResetHouse(id);
		}
		
		if(listitem == 1)
		{
		    if(HouseData[id][SalePrice] > 0)
			{
			    HouseData[id][SalePrice] = 0;
			    HouseData[id][Save] = true;

			    UpdateHouseLabel(id);
				Streamer_SetIntData(STREAMER_TYPE_PICKUP, HouseData[id][HousePickup], E_STREAMER_MODEL_ID, 19522);
				Streamer_SetIntData(STREAMER_TYPE_MAP_ICON, HouseData[id][HouseIcon], E_STREAMER_TYPE, 32);
			    SendClientMessage(playerid, -1, "Your house is no longer for sale.");
			}
			else
			{
				if(HouseData[id][SafeMoney] > 0) return SendClientMessage(playerid, 0xE74C3CFF, "You can't put your house for sale if there's money in the safe.");
				ShowPlayerDialog(playerid, DIALOG_SELLING_PRICE, DIALOG_STYLE_INPUT, "Sell House", "How much do you want for your house?", "Put For Sale", "Cancel");
			}
		}
		
	    return 1;
	}
	if(dialogid == DIALOG_SELLING_PRICE)
	{
	    if(!response) return ShowHouseMenu(playerid);
        new id = InHouse[playerid];
        if(id == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
		if(strcmp(HouseData[id][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
        new amount = strval(inputtext);
		if(!(1 <= amount <= 10000000)) return ShowPlayerDialog(playerid, DIALOG_SELLING_PRICE, DIALOG_STYLE_INPUT, "Sell House", "{E74C3C}You can't put your house for sale for less than $1 or more than $100,000,000.\n\n{FFFFFF}How much do you want for your house?", "Put For Sale", "Cancel");
		HouseData[id][SalePrice] = amount;
		HouseData[id][Save] = true;
		
		UpdateHouseLabel(id);
		Streamer_SetIntData(STREAMER_TYPE_PICKUP, HouseData[id][HousePickup], E_STREAMER_MODEL_ID, 1273);
		Streamer_SetIntData(STREAMER_TYPE_MAP_ICON, HouseData[id][HouseIcon], E_STREAMER_TYPE, 31);
		
		new string[128];
		format(string, sizeof(string), "You put your house for sale for $%s.", convertNumber(amount));
		SendClientMessage(playerid, -1, string);
	    return 1;
	}
	return 0;
}

public OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float: x, Float: y, Float: z)
{
	switch(SelectMode[playerid])
	{
	    case SELECT_MODE_EDIT:
		{
			EditingFurniture[playerid] = true;
			EditDynamicObject(playerid, objectid);
		}
	    case SELECT_MODE_SELL:
	    {
	        CancelEdit(playerid);
			
			new data[hFurniture], string[128];
			SetPVarInt(playerid, "SelectedFurniture", objectid);
			Streamer_GetArrayData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_EXTRA_ID, data);
			format(string, sizeof(string), "Do you want to sell your %s?\nYou'll get {2ECC71}$%s.", HouseFurnitures[ data[ArrayID] ][Name], convertNumber(HouseFurnitures[ data[ArrayID] ][Price]));
			ShowPlayerDialog(playerid, DIALOG_FURNITURE_SELL, DIALOG_STYLE_MSGBOX, "Confirm Sale", string, "Sell", "Close");
		}
	}
    SelectMode[playerid] = SELECT_MODE_NONE;
	return 1;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz)
{
	if(EditingFurniture[playerid])
	{
		switch(response)
		{
		    case EDIT_RESPONSE_CANCEL:
		    {
		        new data[hFurniture];
		        Streamer_GetArrayData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_EXTRA_ID, data);
		        SetDynamicObjectPos(objectid, data[furnitureX], data[furnitureY], data[furnitureZ]);
		        SetDynamicObjectRot(objectid, data[furnitureRX], data[furnitureRY], data[furnitureRZ]);
		        
		        EditingFurniture[playerid] = false;
		    }

			case EDIT_RESPONSE_FINAL:
			{
			    new data[hFurniture];
			    query[0] = '\0';
			    Streamer_GetArrayData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_EXTRA_ID, data);
			    data[furnitureX] = x;
			    data[furnitureY] = y;
			    data[furnitureZ] = z;
	            data[furnitureRX] = rx;
	            data[furnitureRY] = ry;
	            data[furnitureRZ] = rz;
	            SetDynamicObjectPos(objectid, data[furnitureX], data[furnitureY], data[furnitureZ]);
		        SetDynamicObjectRot(objectid, data[furnitureRX], data[furnitureRY], data[furnitureRZ]);
		        Streamer_SetArrayData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_EXTRA_ID, data);

		        mysql_format(mysql, query, sizeof(query), "UPDATE furniture SET FurnitureX=%f, FurnitureY=%f, FurnitureZ=%f, FurnitureRX=%f, FurnitureRY=%f, FurnitureRZ=%f WHERE ID=%d", data[furnitureX], data[furnitureY], data[furnitureZ], data[furnitureRX], data[furnitureRY], data[furnitureRZ], data[SQLID]);
		        mysql_tquery(mysql, query, "", "");
		        
		        EditingFurniture[playerid] = false;
			}
		}
	}
	return 1;
}

CMD:house(playerid, params[])
{
	if(InHouse[playerid] == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
	ShowHouseMenu(playerid);
	return 1;
}

CMD:myhousekeys(playerid, params[])
{
    new Cache: mykeys;
    query[0] = '\0';
    mysql_format(mysql, query, sizeof(query), "SELECT HouseID, FROM_UNIXTIME(Date, '%%d/%%m/%%Y %%H:%%i') as KeyDate FROM house_keys WHERE Player='%e' ORDER BY Date DESC LIMIT 0, 15", Player_GetName(playerid));
	mykeys = mysql_query(mysql, query);
	ListPage[playerid] = 0;

	new rows = cache_num_rows();
	if(rows)
	{
 		new list[1024], id, key_date[20];
   		format(list, sizeof(list), "House Info\tKey Given On\n");
	    for(new i; i < rows; ++i)
	    {
	        id = cache_get_field_content_int(i, "HouseID");
       		cache_get_field_content(i, "KeyDate", key_date);
	        format(list, sizeof(list), "%s%s's %s\t%s\n", list, HouseData[id][Owner], HouseData[id][Name], key_date);
	    }

		ShowPlayerDialog(playerid, DIALOG_MY_KEYS, DIALOG_STYLE_TABLIST_HEADERS, "My Keys (Page 1)", list, "Next", "Close");
	}
	else SendClientMessage(playerid, 0xE74C3CFF, "You don't have any keys for any houses.");

	cache_delete(mykeys);
	return 1;
}

CMD:givehousekeys(playerid, params[])
{
    if(InHouse[playerid] == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
    new id, houseid = InHouse[playerid];
	if(strcmp(HouseData[houseid][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, 0xE74C3CFF, "USAGE: /givehousekeys [player id]");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, 0xE74C3CFF, "Invalid player ID.");
	if(id == playerid) return SendClientMessage(playerid, 0xE74C3CFF, "You're the owner, you don't need keys.");
	if(Iter_Contains(HouseKeys[id], houseid)) return SendClientMessage(playerid, 0xE74C3CFF, "That player has keys for this house.");
	Iter_Add(HouseKeys[id], houseid);
	
	query[0] = EOS;
	mysql_format(mysql, query, sizeof(query), "INSERT INTO house_keys SET HouseID=%d, Player='%e', Date=UNIX_TIMESTAMP()", houseid, Player_GetName(id));
	mysql_tquery(mysql, query, "", "");

	format(query, sizeof(query), "You've given keys to %s for this house.", Player_GetName(id));
	SendClientMessage(playerid, -1, query);
	format(query, sizeof(query), "Now you have keys for %s's house, %s.", HouseData[houseid][Owner], HouseData[houseid][Name]);
	SendClientMessage(id, -1, query);
	return 1;
}

CMD:takehousekeys(playerid, params[])
{
    if(InHouse[playerid] == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
    new id, houseid = InHouse[playerid];
	if(strcmp(HouseData[houseid][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, 0xE74C3CFF, "USAGE: /takehousekeys [player id]");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, 0xE74C3CFF, "Invalid player ID.");
	if(id == playerid) return SendClientMessage(playerid, 0xE74C3CFF, "You're the owner, you can't take your keys.");
	if(!Iter_Contains(HouseKeys[id], houseid)) return SendClientMessage(playerid, 0xE74C3CFF, "That player doesn't have keys for this house.");
	Iter_Remove(HouseKeys[id], houseid);
	
	query[0] = EOS;
	mysql_format(mysql, query, sizeof(query), "DELETE FROM house_keys WHERE HouseID=%d AND Player='%e'", houseid, Player_GetName(id));
	mysql_tquery(mysql, query, "", "");

	format(query, sizeof(query), "You've taken keys from %s for this house.", Player_GetName(id));
	SendClientMessage(playerid, -1, query);
	format(query, sizeof(query), "House owner %s has taken your keys for their house %s.", HouseData[houseid][Owner], HouseData[houseid][Name]);
	SendClientMessage(id, -1, query);
	return 1;
}

CMD:kickfromhouse(playerid, params[])
{
    if(InHouse[playerid] == INVALID_HOUSE_ID) return SendClientMessage(playerid, 0xE74C3CFF, "You're not in a house.");
    new id, houseid = InHouse[playerid];
	if(strcmp(HouseData[houseid][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, 0xE74C3CFF, "USAGE: /kickfromhouse [player id]");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, 0xE74C3CFF, "Invalid player ID.");
	if(id == playerid) return SendClientMessage(playerid, 0xE74C3CFF, "You can't kick yourself from your house.");
	if(InHouse[id] != houseid) return SendClientMessage(playerid, 0xE74C3CFF, "That player isn't in your house.");
    SendClientMessage(playerid, -1, "Player kicked.");
	SendClientMessage(id, -1, "You got kicked by the house owner.");
	SetPVarInt(id, "HousePickupCooldown", gettime() + HOUSE_COOLDOWN);
	SetPlayerVirtualWorld(id, 0);
 	SetPlayerInterior(id, 0);
 	SetPlayerPos(id, HouseData[houseid][houseX], HouseData[houseid][houseY], HouseData[houseid][houseZ]);
 	InHouse[id] = INVALID_HOUSE_ID;
	return 1;
}

/* ============ Admin Commands ============ */
CMD:createhouse(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xE74C3CFF, "You can't use this command.");
	new interior, price;
	if(sscanf(params, "ii", price, interior)) return SendClientMessage(playerid, 0xE74C3CFF, "USAGE: /createhouse [price] [interior id]");
    if(!(0 <= interior <= sizeof(HouseInteriors)-1)) return SendClientMessage(playerid, 0xE74C3CFF, "Interior ID you entered does not exist.");
	new id = Iter_Free(Houses);
	if(id == -1) return SendClientMessage(playerid, 0xE74C3CFF, "You can't create more houses.");
	SetPVarInt(playerid, "HousePickupCooldown", gettime() + HOUSE_COOLDOWN);
	format(HouseData[id][Name], MAX_HOUSE_NAME, "House For Sale");
	format(HouseData[id][Owner], MAX_PLAYER_NAME, "-");
	format(HouseData[id][Password], MAX_HOUSE_PASSWORD, "-");
	GetPlayerPos(playerid, HouseData[id][houseX], HouseData[id][houseY], HouseData[id][houseZ]);
	HouseData[id][Price] = price;
	HouseData[id][Interior] = interior;
	HouseData[id][LockMode] = LOCK_MODE_NOLOCK;
	HouseData[id][SalePrice] = HouseData[id][SafeMoney] = HouseData[id][LastEntered] = 0;
    HouseData[id][Save] = true;

    new label[200];
    format(label, sizeof(label), "{2ECC71}House For Sale (ID: %d)\n{FFFFFF}%s\n{F1C40F}Price: {2ECC71}$%s", id, HouseInteriors[interior][IntName], convertNumber(price));
	HouseData[id][HouseLabel] = CreateDynamic3DTextLabel(label, 0xFFFFFFFF, HouseData[id][houseX], HouseData[id][houseY], HouseData[id][houseZ]+0.35, 15.0, .testlos = 1);
	HouseData[id][HousePickup] = CreateDynamicPickup(1273, 1, HouseData[id][houseX], HouseData[id][houseY], HouseData[id][houseZ]);
	HouseData[id][HouseIcon] = CreateDynamicMapIcon(HouseData[id][houseX], HouseData[id][houseY], HouseData[id][houseZ], 31, 0);

	query[0] = '\0';
	mysql_format(mysql, query, sizeof(query), "INSERT INTO houses SET ID=%d, HouseX=%f, HouseY=%f, HouseZ=%f, HousePrice=%d, HouseInterior=%d", id, HouseData[id][houseX], HouseData[id][houseY], HouseData[id][houseZ], price, interior);
	mysql_tquery(mysql, query, "", "");
	Iter_Add(Houses, id);
	return 1;
}

CMD:gotohouse(playerid, params[])
{
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xE74C3CFF, "You can't use this command.");
	new id;
	if(sscanf(params, "i", id)) return SendClientMessage(playerid, 0xE74C3CFF, "USAGE: /gotohouse [house id]");
	if(!Iter_Contains(Houses, id)) return SendClientMessage(playerid, 0xE74C3CFF, "House ID you entered does not exist.");
	SetPVarInt(playerid, "HousePickupCooldown", gettime() + HOUSE_COOLDOWN);
	SetPlayerPos(playerid, HouseData[id][houseX], HouseData[id][houseY], HouseData[id][houseZ]);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	return 1;
}

CMD:hsetinterior(playerid, params[])
{
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xE74C3CFF, "You can't use this command.");
	new id, interior;
	if(sscanf(params, "ii", id, interior)) return SendClientMessage(playerid, 0xE74C3CFF, "USAGE: /hsetinterior [house id] [interior id]");
	if(!Iter_Contains(Houses, id)) return SendClientMessage(playerid, 0xE74C3CFF, "House ID you entered does not exist.");
	if(!(0 <= interior <= sizeof(HouseInteriors)-1)) return SendClientMessage(playerid, 0xE74C3CFF, "Interior ID you entered does not exist.");
	HouseData[id][Interior] = interior;

	query[0] = '\0';
	mysql_format(mysql, query, sizeof(query), "UPDATE houses SET HouseInterior=%d WHERE ID=%d", interior, id);
	mysql_tquery(mysql, query, "", "");

	UpdateHouseLabel(id);
	SendClientMessage(playerid, -1, "Interior updated.");
	return 1;
}

CMD:hsetprice(playerid, params[])
{
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xE74C3CFF, "You can't use this command.");
	new id, price;
	if(sscanf(params, "ii", id, price)) return SendClientMessage(playerid, 0xE74C3CFF, "USAGE: /hsetprice [house id] [price]");
	if(!Iter_Contains(Houses, id)) return SendClientMessage(playerid, 0xE74C3CFF, "House ID you entered does not exist.");
	HouseData[id][Price] = price;

	query[0] = '\0';
	mysql_format(mysql, query, sizeof(query), "UPDATE houses SET HousePrice=%d WHERE ID=%d", price, id);
	mysql_tquery(mysql, query, "", "");

	UpdateHouseLabel(id);
	SendClientMessage(playerid, -1, "Price updated.");
	return 1;
}

CMD:resethouse(playerid, params[])
{
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xE74C3CFF, "You can't use this command.");
	new id;
	if(sscanf(params, "i", id)) return SendClientMessage(playerid, 0xE74C3CFF, "USAGE: /resethouse [house id]");
	if(!Iter_Contains(Houses, id)) return SendClientMessage(playerid, 0xE74C3CFF, "House ID you entered does not exist.");
	ResetHouse(id);
	SendClientMessage(playerid, -1, "House reset.");
	return 1;
}

CMD:deletehouse(playerid, params[])
{
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xE74C3CFF, "You can't use this command.");
	new id;
	if(sscanf(params, "i", id)) return SendClientMessage(playerid, 0xE74C3CFF, "USAGE: /deletehouse [house id]");
	if(!Iter_Contains(Houses, id)) return SendClientMessage(playerid, 0xE74C3CFF, "House ID you entered does not exist.");
	ResetHouse(id);
	DestroyDynamic3DTextLabel(HouseData[id][HouseLabel]);
	DestroyDynamicPickup(HouseData[id][HousePickup]);
	DestroyDynamicMapIcon(HouseData[id][HouseIcon]);
	Iter_Remove(Houses, id);
	HouseData[id][HouseLabel] = Text3D: INVALID_3DTEXT_ID;
	HouseData[id][HousePickup] = HouseData[id][HouseIcon] = -1;
	HouseData[id][Save] = false;

	query[0] = '\0';
	mysql_format(mysql, query, sizeof(query), "DELETE FROM houses WHERE ID=%d", id);
	mysql_tquery(mysql, query, "", "");
	SendClientMessage(playerid, -1, "House deleted.");
	return 1;
}

stock LoadHouseKeys(playerid)
{
    Iter_Clear(HouseKeys[playerid]);

    query[0] = '\0';
    mysql_format(mysql, query, sizeof(query), "SELECT * FROM house_keys WHERE Player='%e'", Player_GetName(playerid));
	mysql_tquery(mysql, query, "GiveHouseKeys", "i", playerid);
	return 1;
}

stock convertNumber(value)
{
	// http://forum.sa-mp.com/showthread.php?p=843781#post843781
    new string[24];
    format(string, sizeof(string), "%d", value);

    for(new i = (strlen(string) - 3); i > (value < 0 ? 1 : 0) ; i -= 3)
    {
        strins(string[i], ",", 0);
    }

    return string;
}

stock RemovePlayerWeapon(playerid, weapon)
{
    new weapons[13], ammo[13];
    for(new i; i < 13; i++) GetPlayerWeaponData(playerid, i, weapons[i], ammo[i]);
    ResetPlayerWeapons(playerid);
    for(new i; i < 13; i++)
    {
        if(weapons[i] == weapon) continue;
        GivePlayerWeapon(playerid, weapons[i], ammo[i]);
    }

    return 1;
}

stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float: a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

stock Player_GetName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	return name;
}

stock SendToHouse(playerid, id)
{
    if(!Iter_Contains(Houses, id)) return 0;
    SetPVarInt(playerid, "HousePickupCooldown", gettime() + HOUSE_COOLDOWN);
    InHouse[playerid] = id;
	SetPlayerVirtualWorld(playerid, id);
 	SetPlayerInterior(playerid, HouseInteriors[ HouseData[id][Interior] ][intID]);
  	SetPlayerPos(playerid, HouseInteriors[ HouseData[id][Interior] ][intX], HouseInteriors[ HouseData[id][Interior] ][intY], HouseInteriors[ HouseData[id][Interior] ][intZ]);

	new string[128];
	format(string, sizeof(string), "Welcome to %s's house, %s{FFFFFF}!", HouseData[id][Owner], HouseData[id][Name]);
	SendClientMessage(playerid, 0xFFFFFFFF, string);

	if(!strcmp(HouseData[id][Owner], Player_GetName(playerid)))
	{
		HouseData[id][LastEntered] = gettime();
		HouseData[id][Save] = true;
		SendClientMessage(playerid, 0xFFFFFFFF, "Use {3498DB}/house {FFFFFF}to open the house menu.");
	}

	if(HouseData[id][LockMode] == LOCK_MODE_NOLOCK && LastVisitedHouse[playerid] != id)
	{
	    query[0] = EOS;
	    mysql_format(mysql, query, sizeof(query), "INSERT INTO house_visitors SET HouseID=%d, Visitor='%e', Date=UNIX_TIMESTAMP()", id, Player_GetName(playerid));
		mysql_tquery(mysql, query, "", "");
		LastVisitedHouse[playerid] = id;
	}

	return 1;
}

stock ShowHouseMenu(playerid)
{
	if(strcmp(HouseData[ InHouse[playerid] ][Owner], Player_GetName(playerid))) return SendClientMessage(playerid, 0xE74C3CFF, "You're not the owner of this house.");

	new string[256], id = InHouse[playerid];
	format(string, sizeof(string), "House Name: %s\nPassword: %s\nLock: %s\nHouse Safe {2ECC71}($%s)\nFurnitures\nGuns\nVisitors\nKeys\nKick Everybody\nSell House", HouseData[id][Name], HouseData[id][Password], LockNames[ HouseData[id][LockMode] ], convertNumber(HouseData[id][SafeMoney]));
	ShowPlayerDialog(playerid, DIALOG_HOUSE_MENU, DIALOG_STYLE_LIST, HouseData[id][Name], string, "Select", "Close");
	return 1;
}

stock ResetHouse(id)
{
    if(!Iter_Contains(Houses, id)) return 0;
	format(HouseData[id][Name], MAX_HOUSE_NAME, "House For Sale");
	format(HouseData[id][Owner], MAX_PLAYER_NAME, "-");
	format(HouseData[id][Password], MAX_HOUSE_PASSWORD, "-");
	HouseData[id][LockMode] = LOCK_MODE_NOLOCK;
	HouseData[id][SalePrice] = HouseData[id][SafeMoney] = HouseData[id][LastEntered] = 0;
    HouseData[id][Save] = true;

    new label[200];
    format(label, sizeof(label), "{2ECC71}House For Sale (ID: %d)\n{FFFFFF}%s\n{F1C40F}Price: {2ECC71}$%s", id, HouseInteriors[ HouseData[id][Interior] ][IntName], convertNumber(HouseData[id][Price]));
	UpdateDynamic3DTextLabelText(HouseData[id][HouseLabel], 0xFFFFFFFF, label);
	Streamer_SetIntData(STREAMER_TYPE_PICKUP, HouseData[id][HousePickup], E_STREAMER_MODEL_ID, 1273);
	Streamer_SetIntData(STREAMER_TYPE_MAP_ICON, HouseData[id][HouseIcon], E_STREAMER_TYPE, 31);

    foreach(new i : Player)
    {
        if(InHouse[i] == id)
        {
            SetPVarInt(i, "HousePickupCooldown", gettime() + HOUSE_COOLDOWN);
        	SetPlayerVirtualWorld(i, 0);
	        SetPlayerInterior(i, 0);
	        SetPlayerPos(i, HouseData[id][houseX], HouseData[id][houseY], HouseData[id][houseZ]);
	        InHouse[i] = INVALID_HOUSE_ID;
        }

        if(Iter_Contains(HouseKeys[i], id)) Iter_Remove(HouseKeys[i], id);
   	}

    new data[hFurniture];
    query[0] = '\0';
    mysql_format(mysql, query, sizeof(query), "DELETE FROM houseguns WHERE HouseID=%d", id);
    mysql_tquery(mysql, query, "", "");

    for(new i, maxval = Streamer_GetUpperBound(STREAMER_TYPE_OBJECT); i <= maxval; ++i)
    {
        if(!IsValidDynamicObject(i)) continue;
		Streamer_GetArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, data);
		if(data[SQLID] > 0 && data[HouseID] == id) DestroyDynamicObject(i);
    }

    mysql_format(mysql, query, sizeof(query), "DELETE FROM furniture WHERE HouseID=%d", id);
    mysql_tquery(mysql, query, "", "");

    mysql_format(mysql, query, sizeof(query), "DELETE FROM house_visitors WHERE HouseID=%d", id);
    mysql_tquery(mysql, query, "", "");

    mysql_format(mysql, query, sizeof(query), "DELETE FROM house_keys WHERE HouseID=%d", id);
    mysql_tquery(mysql, query, "", "");

    mysql_format(mysql, query, sizeof(query), "DELETE FROM log_house WHERE HouseID=%d", id);
    mysql_tquery(mysql, query, "", "");
	return 1;
}

stock SaveHouse(id)
{
    if(!Iter_Contains(Houses, id)) return 0;
	query[0] = '\0';
	mysql_format(mysql, query, sizeof(query), "UPDATE houses SET HouseName='%e', HouseOwner='%e', HousePassword='%e', HouseSalePrice=%d, HouseLock=%d, HouseMoney=%d, LastEntered=%d WHERE ID=%d",
	HouseData[id][Name], HouseData[id][Owner], HouseData[id][Password], HouseData[id][SalePrice], HouseData[id][LockMode], HouseData[id][SafeMoney], HouseData[id][LastEntered], id);
	mysql_tquery(mysql, query, "", "");
	HouseData[id][Save] = false;
	return 1;
}

stock UpdateHouseLabel(id)
{
	if(!Iter_Contains(Houses, id)) return 0;
	new label[256];
	if(!strcmp(HouseData[id][Owner], "-"))
	{
		format(label, sizeof(label), "{FFFF00}House For Sale (ID: %d)\n{FFFFFF}Price: {33AA33}$%s\n{FFFFFF}Type /buyhouse to buy this house.", id, convertNumber(HouseData[id][Price]));
	}
	else
	{
		if(HouseData[id][SalePrice] > 0)
		{
		    format(label, sizeof(label), "{FFFF00}%s's House - De vanzare (ID: %d)\n{FFFFFF}%s\n{F1C40F}Price: {2ECC71}$%s", HouseData[id][Owner], id, HouseData[id][Name], convertNumber(HouseData[id][SalePrice]));
		}
		else
		{
			format(label, sizeof(label), "{E67E22}%s's House (ID: %d)\n\n{FFFFFF}%s\n{FFFFFF}%s\n{FFFFFF}Type /enter to join in this house.", HouseData[id][Owner], id, HouseData[id][Name], LockNames[ HouseData[id][LockMode] ]);
		}
	}

	UpdateDynamic3DTextLabelText(HouseData[id][HouseLabel], 0xFFFFFFFF, label);
	return 1;
}

stock House_PlayerInit(playerid)
{
    InHouse[playerid] = LastVisitedHouse[playerid] = INVALID_HOUSE_ID;
    ListPage[playerid] = SelectMode[playerid] = SELECT_MODE_NONE;
    EditingFurniture[playerid] = false;
    LoadHouseKeys(playerid);
	return 1;
}

stock OwnedHouses(playerid)
{
	#if LIMIT_PER_PLAYER != 0
    new count;

	foreach(new i : Houses) if(!strcmp(HouseData[i][Owner], Player_GetName(playerid), true)) count++;
	return count;
	#else
	return 0;
	#endif
}
