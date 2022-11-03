#if defined About
--------------------------------------------------------------------------------
												  _ _  _ _  _ _  _  ___
	Authors: KnowN & ImpulsE - Copyright @ 2016  | | || \ || \ || ||  _|
	RPG Project - version 1.3 - 08/08/2016       | | ||   ||   || || |_
	Started Date: 14/05/2016 - 20:34 PM          |___||_\_||_\_||_||___|
			
--------------------------------------------------------------------------------
						   UNNIC RPG - www.unnic.ro
--------------------------------------------------------------------------------
#endif
#include < a_samp > 		//Author: SA-MP Team
#include < fixes > 			//Author: Y_Less & Others
#include < a_mysql > 		//Author: BlueG
#include < cmd > 			//Author: urShadow
#include < crashdetect > 	//Author: Zeex
#include < streamer > 		//Author: Incognito
#include < sscanf2 > 		//Author: Y_Less
#include < mSelection > 	//Author: d0
#include < foreach > 		//Author: Y_Less
#include < fadescreen > 	//Author: Joe Staff
#include < gangzones > 		//Author: Gammix
#include < timerfix > 		//Author: Slice
#include < strlib > 		//Author: Slice

//Settings
#define SERVER_NAME "UNNIC"
#define SERVER_LANG "RO/EN"
#define SERVER_MAPN "Los Santos"
#define SERVER_GMOD "RPG "SERVER_VERS""
#define SERVER_VERS "v1.3"

//MySQL - Connection
#define MYSQL_HOST "localhost"
#define MYSQL_USER "root"
#define MYSQL_DB   "rpg"
#define MYSQL_PASS ""

#define MYSQL_HOST_LINUX "93.119.26.250"
#define MYSQL_USER_LINUX "zp_hid12230"
#define MYSQL_DB_LINUX 	 "zp_hid12230"
#define MYSQL_PASS_LINUX "aE4G5QrxcMERmHca"

//Others
#define SCM SendClientMessage
#define SPD ShowPlayerDialog

#define MAX_VEHICLES_BUYED 	(25000)
#define MAX_ZONE_NAME 		(28)
#define WAR_TIME 			(720)

//Dialogs
#define DIALOG_REGISTER 	(1)
#define DIALOG_LOGIN 		(10)
#define DIALOG_JOBS 		(20)
#define DIALOG_SERVERNAME 	(30)
#define DIALOG_MODE 		(40)
#define DIALOG_DMV 			(50)
#define DIALOG_TUTORIAL 	(60)
#define DIALOG_DS 			(70)
#define DIALOG_CHANGEMAIL 	(80)
#define DIALOG_CHANGEPASS 	(90)
#define DIALOG_CLAN 		(100)
#define DIALOG_GOTOINT 		(110)
#define DIALOG_SHOP 		(120)
#define DIALOG_VEH          (130)

//Colors
#define COLOR_SERVER 	(0xA9C4E4AA)
#define COLOR_FADE1  	(0xE6E6E6E6)
#define COLOR_FADE2  	(0xC8C8C8C8)
#define COLOR_FADE3  	(0xAAAAAAAA)
#define COLOR_FADE4  	(0x8C8C8C8C)
#define COLOR_FADE5 	(0x6E6E6E6E)
#define COLOR_WHITE  	(0xFFFFFFAA)
#define COLOR_PURPLE 	(0xC2A2DAAA)
#define COLOR_YELLOW 	(0xFFFF00AA)
#define COLOR_OR     	(0xFF6347AA)
#define COLOR_ERROR  	(0x9ACD32AA)
#define COLOR_GREEN  	(0x4DAD2BAA)
#define COLOR_CYAN   	(0x00FFFFFF)
#define COLOR_DARKCYAN 	(0x008B8BFF)
#define COLOR_LIGHTCYAN (0xE0FFFFFF)
#define COLOR_DARKGOLD 	(0xA87C0DFF)
#define COLOR_BLUE 		(0x5273A9AA)
#define COLOR_CREAM 	(0xDBB47FAA)
#define COLOR_LBLUE 	(0x89D6F0AA)

#define D 	"{9EADCB}"
#define R 	"{FF0000}"
#define B 	"{0080FF}"
#define W 	"{FFFFFF}"
#define GR 	"{AFAFAF}"
#define G 	"{4DAD2B}"
#define S 	"{A9C4E4}"
#define OR 	"{FF6347}"

#define MAX_JOBS 	 (20)
#define MAX_FACTIONS (21)
#define MAX_CLANS    (51)

#define function%0(%1) forward%0(%1); public%0(%1)
#define SpeedCheck(%0,%1,%2,%3,%4) floatround(floatsqroot(%4?(%0*%0+%1*%1+%2*%2):(%0*%0+%1*%1) ) *%3*1.6)
#pragma dynamic 15000

//MySQL - Save Progress
#define IDx 				(1)
#define Namex 				(2)
#define Passwordx 			(3)
#define Gendrex 			(4)
#define Agex 				(5)
#define Emailx 				(6)
#define Langx 				(7)
#define Adminx 				(8)
#define Helperx 			(9)
#define Levelx 				(10)
#define Premiumx 			(11)
#define Registeredx 		(12)
#define Respectx 			(13)
#define Moneyx 				(14)
#define Bankx 				(15)
#define Killsx 				(16)
#define Deathsx 			(17)
#define Wantedx 			(18)
#define Jobx 				(19)
#define Tutorialx 			(20)
#define PPointsx 			(21)
#define Paydaysx 			(22)
#define Mutedx 				(23)
#define MuteTimex 			(24)
#define Freezex 			(25)
#define FreezeTimex 		(26)
#define Jailedx 			(27)
#define JailTimex 			(28)
#define Skinx 				(29)
#define PINx 				(30)
#define CarLx 				(31)
#define GunLx 				(32)
#define FlyLx 				(33)
#define BoatLx 				(34)
#define LastLx 				(35)
#define FarmerSkillx 		(36)
#define BusDriverSkillx 	(37)
#define SpawnXx 			(38)
#define SpawnYx 			(39)
#define SpawnZx 			(40)
#define SpawnAx 			(41)
#define Factionx 			(42)
#define Rankx 				(43)
#define Leaderx 			(44)
#define Materialsx 			(45)
#define Drugsx 				(46)
#define cLeaderx 			(47)
#define cRankx 				(48)
#define Clanx 				(49)
#define FWarnsx 			(50)
#define FPunishx 			(51)
#define CWarnsx 			(52)
#define PremiumDaysx 		(53)
#define VehicleSlotsx 		(54)
#define Vehiclesx 			(55)
#define PizzaBoySkillx      (56)
#define TruckerSkillx       (57)

//MySQL - Save Vehicles
#define IDx 				(1)
#define Modelx 				(2)
#define Color1x 			(3)
#define Color2x 			(4)
#define Pricex 				(5)
#define Ownerx 				(6)
#define PosXx 				(7)
#define PosYx 				(8)
#define PosZx 				(9)
#define PosAx 				(10)
#define Platex 				(11)
#define PaintJx 			(12)
#define Lockedx 			(13)
#define Spawnedx 			(14)
#define Destroyedx 			(15)
#define KMx 				(16)
#define Neonx 				(17)
#define Fuelx 				(18)
#define Typex 				(19)
#define mod1x 				(20)
#define mod2x 				(21)
#define mod3x 				(22)
#define mod4x 				(23)
#define mod5x 				(24)
#define mod6x 				(25)
#define mod7x 				(26)
#define mod8x 				(27)
#define mod9x 				(28)
#define mod10x 				(29)
#define mod11x 				(30)
#define mod12x 				(31)
#define mod13x 				(32)
#define mod14x 				(33)
#define mod15x 				(34)
#define mod16x 				(35)
#define mod17x 				(36)
#define dsStockx 			(37)
#define CarIDx 				(38)

//MYSQL save faction
#define Rank1x 				(52)
#define Rank2x 				(53)
#define Rank3x 				(54)
#define Rank4x 				(55)
#define Rank5x 				(56)
#define Rank6x 				(57)
#define Skin1x 				(59)
#define Skin2x 				(60)
#define Skin3x 				(61)
#define Skin4x 				(62)
#define Skin5x 				(63)
#define Skin6x 				(64)
#define Skin7x 				(65)
#define fIntXx 				(66)
#define fIntYx 				(67)
#define fIntZx 				(68)
#define fExtXx 				(69)
#define fExtYx 				(70)
#define fExtZx 				(71)
#define fIntx 				(72)
#define fVWx 				(73)
#define Slotsx 				(74)
#define Membersx 			(75)
#define fMoneyx 			(76)
#define fDrugsx 			(77)
#define fMatsx 				(78)
#define fMinLevelx 			(89)
#define Applicationsx 		(90)
#define Motdx 				(91)
#define CommandRankx 		(92)
#define fTypex 				(93)
#define fColorx 			(94)
#define fOrder1x 			(95)
#define fOrder2x 			(96)
#define fOrder3x 			(98)
#define fOrder4x 			(99)
#define Tagx 				(100)
#define Daysx               (101)

enum pInfo
{
	ID, Name[24], Password[40], Gendre, Age, Email[100], Lang, Admin, Helper,
	Level, Premium, PremiumDays, Registered, Respect, Money, Bank, Kills,
	Deaths, Wanted, Job, Tutorial, PPoints, Paydays, Muted, MuteTime, Freeze,
	FreezeTime, Jailed, JailTime, Skin, PIN, CarL, GunL, FlyL, BoatL,
	LastL[100], FarmerSkill, BusDriverSkill, Float:SpawnX, Float:SpawnY,
	Float:SpawnZ, Float:SpawnA, VehicleSlots, Faction, Rank, Leader, Materials,
	Drugs, tView, tTime, tKills, tDeaths, Clan, cRank, cLeader, FWarns, FPunish,
	CWarns, bool:gradTag, breakTime, hasTazer, isTazed, Vehicles[21], VehCount,
	PizzaBoySkill, TruckerSkill
};
enum tInfo
{
	ID, MysqlID, Name[32], Float:MinX, Float:MinY, Float:MaxX, Float:MaxY,
	Color[12], Faction, isAttacked, Attacker, AttackTime, tTime
};
enum sInfo
{
	Hostname[100], Language[50], Mode[100], Map[50], Record, RecordDate[50],
	LastAccount[40], LastID, WarMinHour, WarMaxHour
};
enum DS
{
	ID, Model, Price, Stock, Type, TypeID
};
enum vInfo
{
	ID, CarID, Model, Color1, Color2, Price, Owner, Float:PosX, Float:PosY,
	Float:PosZ, Float:PosA, Plate[32], PaintJ, Locked, Spawned, Destroyed,
	Float:KM, Neon, Fuel, Type, mod1, mod2, mod3, mod4, mod5, mod6, mod7, mod8,
	mod9, mod10, mod11, mod12, mod13, mod14, mod15, mod16, mod17, Faction, Rank,
	Clan, Spawnable
};
enum FactionData
{
	fID, fName[64], fRank1[32], fRank2[32], fRank3[32], fRank4[32], fRank5[32],
	fRank6[32], fLeader[32], fSkin1, fSkin2, fSkin3, fSkin4, fSkin5, fSkin6,
	fSkin7, fMotd[128], Float:fExtX, Float:fExtY, Float:fExtZ, Float:fIntX,
	Float:fIntY, Float:fIntZ, fInt, fVW, fSlots, fMembers, fApplications,
	fMoney, fDrugs, fMats, fMinLevel, fCommandRank, fType, fColor, fOrder1[5],
	fOrder2[5], fOrder3[5], fOrder4[5], fPickup, Text3D:fText3D, fInWar,
	fAttackedTurf, fOnTurf, fScore
};
enum cInfo
{
	ID, Name[64], Tag[6], Rank1[32], Rank2[32], Rank3[32], Rank4[32], Rank5[32],
	Rank6[32], Leader[32], Motd[128], Slots, Members, Applications, CommandRank,
	Type, Days
};
enum pickInfo
{
	ID, Type, Value, Amount
};
enum bInfo
{
	ID, Name[40], IP[40], Admin[40], Days, Date[100], Reason[100]
};

new MySQLType = 1;
new mysql;
new kStr[500];
new query[200];
new LStr[500];
new FirstPress[MAX_PLAYERS];
new SpawnChoose[MAX_PLAYERS];
new vw[MAX_PLAYERS];
new neon1[MAX_VEHICLES];
new neon2[MAX_VEHICLES];
new OwnedVeh[MAX_VEHICLES];
new IsPlayerLogged[MAX_PLAYERS];
new InfoBoxTimer[MAX_PLAYERS];
new TagTimer[MAX_PLAYERS];
new ClanCarBreakTimer[MAX_PLAYERS];
new ClanInfo[MAX_FACTIONS][cInfo];
new FactionInfo[MAX_FACTIONS][FactionData];
new PlayerInfo[MAX_PLAYERS][pInfo];
new ServerInfo[sInfo];
new DInfo[100][DS];
new VehInfo[MAX_VEHICLES_BUYED][vInfo];
new Total_Veh_Created;
new BigEar[MAX_PLAYERS];
new CP[MAX_PLAYERS];
new InExam[MAX_PLAYERS];
new DMVObj[50];
new DMVObj2[107];
new DMVCar[MAX_PLAYERS];
new PickupInfo[MAX_PICKUPS][pickInfo];
new Speedlimit[MAX_PLAYERS];
new BanInfo[MAX_PLAYERS][bInfo];
new ClanDays = 0;
new JobStep[MAX_PLAYERS];
new Working[MAX_PLAYERS];
new PBVeh[15];
new pizzaprize[MAX_PLAYERS];
new TVeh[21];
new TruckerCash[MAX_PLAYERS];
new truckerprize[MAX_PLAYERS];
new trucktrailer[MAX_PLAYERS];

//Texts
new PlayerText:Logo[2];
new Text:Background[2];
new Text:AdminTextdraw[1];
new PlayerText:WarTD[MAX_PLAYERS][7];
new PlayerText:Jobs[5];
new PlayerText:Jobs2[2];
new PlayerText:EventTD[3];
new PlayerText:EngineTD;
new PlayerText:InfoTD;
new PlayerText:DSTD[12];
new PlayerText:Info_TD;

//Jobs
new FarmVeh[17];
new FTimer[MAX_PLAYERS];
new FarmSec[MAX_PLAYERS];
new FarmOut[MAX_PLAYERS];
new FarmerMoney[MAX_PLAYERS];
new BDVeh[16];
new Statii[MAX_PLAYERS];
new BusDriverCash[MAX_PLAYERS];

//Other
new EngineVehicle[MAX_VEHICLES];
new Centura[MAX_PLAYERS];
new Speedometer[MAX_PLAYERS];

new Turfs[MAX_ZONES][tInfo];

new VehicleNames[212][] =
{
	{"Landstalker"},{"Bravura"},{"Buffalo"},{"Linerunner"},{"Perrenial"},{"Sentinel"},{"Dumper"},
	{"Firetruck"},{"Trashmaster"},{"Stretch"},{"Manana"},{"Infernus"},{"Voodoo"},{"Pony"},{"Mule"},
	{"Cheetah"},{"Ambulance"},{"Leviathan"},{"Moonbeam"},{"Esperanto"},{"Taxi"},{"Washington"},
	{"Bobcat"},{"Mr Whoopee"},{"BF Injection"},{"Hunter"},{"Premier"},{"Enforcer"},{"Securicar"},
	{"Banshee"},{"Predator"},{"Bus"},{"Rhino"},{"Barracks"},{"Hotknife"},{"Trailer 1"},{"Previon"},
	{"Coach"},{"Cabbie"},{"Stallion"},{"Rumpo"},{"RC Bandit"},{"Romero"},{"Packer"},{"Monster"},
	{"Admiral"},{"Squalo"},{"Seasparrow"},{"Pizzaboy"},{"Tram"},{"Trailer 2"},{"Turismo"},
	{"Speeder"},{"Reefer"},{"Tropic"},{"Flatbed"},{"Yankee"},{"Caddy"},{"Solair"},{"Berkley's RC Van"},
	{"Skimmer"},{"PCJ-600"},{"Faggio"},{"Freeway"},{"RC Baron"},{"RC Raider"},{"Glendale"},{"Oceanic"},
	{"Sanchez"},{"Sparrow"},{"Patriot"},{"Quad"},{"Coastguard"},{"Dinghy"},{"Hermes"},{"Sabre"},
	{"Rustler"},{"ZR-350"},{"Walton"},{"Regina"},{"Comet"},{"BMX"},{"Burrito"},{"Camper"},{"Marquis"},
	{"Baggage"},{"Dozer"},{"Maverick"},{"News Chopper"},{"Rancher"},{"FBI Rancher"},{"Virgo"},{"Greenwood"},
	{"Jetmax"},{"Hotring"},{"Sandking"},{"Blista Compact"},{"Police Maverick"},{"Boxville"},{"Benson"},
	{"Mesa"},{"RC Goblin"},{"Hotring Racer A"},{"Hotring Racer B"},{"Bloodring Banger"},{"Rancher"},
	{"Super GT"},{"Elegant"},{"Journey"},{"Bike"},{"Mountain Bike"},{"Beagle"},{"Cropdust"},{"Stunt"},
	{"Tanker"}, {"Roadtrain"},{"Nebula"},{"Majestic"},{"Buccaneer"},{"Shamal"},{"Hydra"},{"FCR-900"},
	{"NRG-500"},{"HPV1000"},{"Cement Truck"},{"Tow Truck"},{"Fortune"},{"Cadrona"},{"FBI Truck"},
	{"Willard"},{"Forklift"},{"Tractor"},{"Combine"},{"Feltzer"},{"Remington"},{"Slamvan"},
	{"Blade"},{"Freight"},{"Streak"},{"Vortex"},{"Vincent"},{"Bullet"},{"Clover"},{"Sadler"},
	{"Firetruck LA"},{"Hustler"},{"Intruder"},{"Primo"},{"Cargobob"},{"Tampa"},{"Sunrise"},{"Merit"},
	{"Utility"},{"Nevada"},{"Yosemite"},{"Windsor"},{"Monster A"},{"Monster B"},{"Uranus"},{"Jester"},
	{"Sultan"},{"Stratum"},{"Elegy"},{"Raindance"},{"RC Tiger"},{"Flash"},{"Tahoma"},{"Savanna"},
	{"Bandito"},{"Freight Flat"},{"Streak Carriage"},{"Kart"},{"Mower"},{"Duneride"},{"Sweeper"},
	{"Broadway"},{"Tornado"},{"AT-400"},{"DFT-30"},{"Huntley"},{"Stafford"},{"BF-400"},{"Newsvan"},
	{"Tug"},{"Trailer 3"},{"Emperor"},{"Wayfarer"},{"Euros"},{"Hotdog"},{"Club"},{"Freight Carriage"},
	{"Trailer 3"},{"Andromada"},{"Dodo"},{"RC Cam"},{"Launch"},{"Police Car (LSPD)"},{"Police Car (SFPD)"},
	{"Police Car (LVPD)"},{"Police Ranger"},{"Picador"},{"S.W.A.T. Van"},{"Alpha"},{"Phoenix"},{"Glendale"},
	{"Sadler"},{"Luggage Trailer A"},{"Luggage Trailer B"},{"Stair Trailer"},{"Boxville"},{"Farm Plow"},
	{"Utility Trailer"}
};
enum SAZONE_MAIN
{
	SAZONE_NAME[28], Float:SAZONE_AREA[6], Float:zzX, Float:zzY, Float:zzZ,
	Float:MX, Float:MY, Float:MZ
};
static const gSAZones[][SAZONE_MAIN] =
{
	//	NAME                            AREA (Xmin,Ymin,Zmin,Xmax,Ymax,Zmax)
	{"The Big Ear",	                {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
	{"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
	{"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
	{"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
	{"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
	{"Avispa Country Club",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
	{"Avispa Country Club",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
	{"Avispa Country Club",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
	{"Avispa Country Club",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
	{"Avispa Country Club",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
	{"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
	{"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
	{"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
	{"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
	{"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
	{"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
	{"Blackfield",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
	{"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
	{"Blackfield Chapel",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
	{"Blackfield Intersection",     {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
	{"Blackfield Intersection",     {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
	{"Blackfield Intersection",     {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
	{"Blackfield Intersection",     {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
	{"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
	{"Blueberry",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
	{"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
	{"Caligula's Palace",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
	{"Caligula's Palace",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
	{"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
	{"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
	{"City Hall",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
	{"Come-A-Lot",                  {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
	{"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
	{"Commerce",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
	{"Commerce",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
	{"Commerce",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
	{"Commerce",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
	{"Commerce",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
	{"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
	{"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
	{"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
	{"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
	{"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
	{"Doherty",                     {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
	{"Doherty",                     {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
	{"Downtown",                    {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
	{"Downtown",                    {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
	{"Downtown",                    {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
	{"Downtown",                    {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
	{"Downtown",                    {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
	{"Downtown",                    {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
	{"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
	{"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
	{"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
	{"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
	{"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
	{"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
	{"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
	{"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
	{"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
	{"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
	{"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
	{"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
	{"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
	{"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
	{"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
	{"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
	{"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
	{"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
	{"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
	{"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
	{"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
	{"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
	{"Easter Bay Chemicals",        {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
	{"Easter Bay Chemicals",        {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
	{"El Castillo del Diablo",      {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
	{"El Castillo del Diablo",      {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
	{"El Castillo del Diablo",      {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
	{"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
	{"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
	{"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
	{"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
	{"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
	{"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
	{"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
	{"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
	{"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
	{"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
	{"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
	{"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
	{"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
	{"Fisher's Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
	{"Flint Intersection",          {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
	{"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
	{"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
	{"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
	{"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
	{"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
	{"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
	{"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
	{"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
	{"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
	{"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
	{"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
	{"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
	{"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
	{"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
	{"Glen Park",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
	{"Glen Park",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
	{"Glen Park",                   {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
	{"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
	{"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
	{"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
	{"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
	{"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
	{"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
	{"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
	{"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
	{"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
	{"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
	{"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
	{"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
	{"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
	{"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
	{"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
	{"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
	{"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
	{"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
	{"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
	{"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
	{"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
	{"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
	{"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
	{"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
	{"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
	{"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
	{"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
	{"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
	{"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
	{"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
	{"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
	{"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
	{"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
	{"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
	{"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
	{"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
	{"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
	{"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
	{"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
	{"K.A.C.C. Military Fuels",     {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
	{"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
	{"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
	{"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
	{"King's",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
	{"King's",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
	{"King's",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
	{"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
	{"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
	{"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
	{"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
	{"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
	{"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
	{"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
	{"Las Colinas",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
	{"Las Colinas",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
	{"Las Colinas",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
	{"Las Colinas",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
	{"Las Colinas",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
	{"Las Colinas",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
	{"Las Colinas",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
	{"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
	{"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
	{"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
	{"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
	{"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
	{"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
	{"Lil' Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
	{"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
	{"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
	{"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
	{"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
	{"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
	{"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
	{"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
	{"Los Santos International",    {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
	{"Los Santos International",    {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
	{"Los Santos International",    {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
	{"Los Santos International",    {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
	{"Los Santos International",    {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
	{"Los Santos International",    {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
	{"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
	{"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
	{"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
	{"Market",                      {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
	{"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
	{"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
	{"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
	{"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
	{"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
	{"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
	{"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
	{"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
	{"Montgomery Intersection",     {1546.60,208.10,0.00,1745.80,347.40,200.00}},
	{"Montgomery Intersection",     {1582.40,347.40,0.00,1664.60,401.70,200.00}},
	{"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
	{"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
	{"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
	{"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
	{"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
	{"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
	{"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
	{"Mulholland",                  {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
	{"Mulholland",                  {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
	{"Mulholland",                  {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
	{"Mulholland",                  {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
	{"Mulholland",                  {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
	{"Mulholland",                  {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
	{"Mulholland Intersection",     {1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
	{"North Rock",                  {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
	{"Ocean Docks",                 {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
	{"Ocean Docks",                 {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
	{"Ocean Docks",                 {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
	{"Ocean Docks",                 {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
	{"Ocean Docks",                 {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
	{"Ocean Docks",                 {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
	{"Ocean Docks",                 {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
	{"Ocean Flats",                 {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
	{"Octane Springs",              {338.60,1228.50,0.00,664.30,1655.00,200.00}},
	{"Old Venturas Strip",          {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
	{"Palisades",                   {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
	{"Palomino Creek",              {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
	{"Paradiso",                    {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
	{"Pershing Square",             {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
	{"Pilgrim",                     {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
	{"Pilgrim",                     {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
	{"Pilson Intersection",         {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
	{"Pirates in Men's Pants",      {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
	{"Playa del Seville",           {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
	{"Prickle Pine",                {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
	{"Prickle Pine",                {1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
	{"Prickle Pine",                {1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
	{"Prickle Pine",                {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
	{"Queens",                      {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
	{"Queens",                      {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
	{"Queens",                      {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
	{"Randolph Industrial Estate",  {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
	{"Redsands East",               {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
	{"Redsands East",               {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
	{"Redsands East",               {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
	{"Redsands West",               {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
	{"Redsands West",               {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
	{"Redsands West",               {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
	{"Redsands West",               {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
	{"Regular Tom",                 {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
	{"Richman",                     {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
	{"Richman",                     {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
	{"Richman",                     {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
	{"Richman",                     {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
	{"Richman",                     {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
	{"Richman",                     {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
	{"Richman",                     {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
	{"Richman",                     {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
	{"Richman",                     {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
	{"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
	{"Robada Intersection",         {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
	{"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
	{"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
	{"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
	{"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
	{"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
	{"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
	{"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
	{"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
	{"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
	{"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
	{"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
	{"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
	{"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
	{"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
	{"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
	{"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
	{"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
	{"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
	{"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
	{"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
	{"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
	{"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
	{"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
	{"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
	{"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
	{"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
	{"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
	{"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
	{"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
	{"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
	{"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
	{"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
	{"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
	{"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
	{"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
	{"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
	{"The Camel's Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
	{"The Clown's Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
	{"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
	{"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
	{"The Four Dragons Casino",     {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
	{"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
	{"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
	{"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
	{"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
	{"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
	{"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
	{"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
	{"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
	{"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
	{"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
	{"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
	{"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
	{"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
	{"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
	{"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
	{"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
	{"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
	{"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
	{"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
	{"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
	{"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
	{"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
	{"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
	{"Vinewood",                    {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
	{"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
	{"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
	{"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
	{"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
	{"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
	{"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
	{"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
	{"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
	{"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
	{"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
	{"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
	{"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
	// Main Zones
	{"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};

new OrTeleports[][] =
{
    {"24/7 1"}, {"24/7 2"}, {"24/7 3"}, {"24/7 4"}, {"24/7 5"}, {"24/7 6"},
    {"Airport Ticket Desk"}, {"Airport Baggage Reclaim"}, {"Shamal"},
	{"Andromada"}, {"Ammunation 1"}, {"Ammunation 2"}, {"Ammunation 3"},
    {"Ammunation 4"}, {"Ammunation 5"}, {"Ammunation Booths"},
	{"Ammunation Range"}, {"Blastin Fools Hallway"}, {"Budget Inn Motel Room"},
    {"Jefferson Motel"}, {"Off Track Betting Shop"}, {"Sex Shop"},
	{"Meat Factory"}, {"Zero's RC Shop"}, {"Dillmore Gas Station"},
    {"Caligula's Basement"}, {"FDC Janitors Room"}, {"Woozie's Office"},
	{"Binco"}, {"Didier Sachs"}, {"Prolaps"}, {"Suburban"}, {"Victim"}, {"ZIP"},
    {"Alhambra"}, {"Ten Bottles"}, {"Lil' Probe Inn"}, {"Jay's Dinner"},
    {"Gant Bridge Dinner"}, {"Secret Valley Dinner"}, {"World of Coq"},
	{"Welcome Pump"}, {"Burger Shot"}, {"Cluckin' Bell"}, {"Well Stacked Pizza"},
    {"Jimmy's Sticky Ring"}, {"Denise Room"}, {"Katie Room"}, {"Helena Room"},
    {"Michelle Room"}, {"Barbara Room"}, {"Mille Room"}, {"Sherman Dam"},
    {"Planning Dept."}, {"Area 51"}, {"LS Gym"}, {"SF Gym"}, {"LV Gym"},
    {"B Dup's House"}, {"B Dup's Crack Pad"}, {"CJ's House"},
	{"Madd Dogg's Mansion"}, {"OG Loc's House"}, {"Ryder's House"},
	{"Sweet's House"}, {"Crack Factory"}, {"Big Spread Ranch"},
	{"Fanny Batters"}, {"Strip Club"}, {"Strip Club Private Room"},
    {"Unnamed Brothel"}, {"Tiger Skin Brothel"}, {"Pleasure Domes"},
    {"Liberty City Outside"}, {"Liverty City Inside"}, {"Gang House"},
    {"Colonel Furhberger's House"}, {"Crack Den"}, {"Warehouse 1"},
    {"Warehouse 2"}, {"Sweet's Garage"}, {"Lil' Probe Inn Toilet"},
    {"Unused Safe House"}, {"RC Battlefield"}, {"Barber 1"}, {"Barber 2"},
    {"Barber 3"}, {"Tatoo parlour 1"}, {"Tatoo parlour 2"}, {"Tatoo parlour 3"},
    {"LS Police HQ"}, {"SF Police HQ"}, {"LV Police HQ"}, {"Car School"},
    {"8-Track"}, {"Bloodbowl"}, {"Dirt Track"}, {"Kickstart"}, {"Vice Stadium"},
    {"SF Garage"}, {"LS Garage"}, {"SF Bomb Shop"}, {"Blueberry Warehouse"},
    {"LV Warehouse 1"}, {"LV Warehouse 2"}, {"Catigula's Hidden Room"}, {"Bank"},
    {"Bank - Behind Desk"}, {"LS Atruim"}, {"Bike School"}
};

new Float:RandomPizza[30][3] =
{
	{1886.8344,-1116.9644,25.2734},
	{2435.8706,-1303.3206,24.7403},
	{2330.0266,-1681.6777,14.4268},
	{2807.9863,-1179.1047,25.3741},
	{2192.8167,-1003.7396,62.6182},
	{2015.1249,-1703.4521,13.6904},
	{256.2383,-1365.6805,53.1094},
	{1496.9115,-690.0555,94.7500},
	{1181.7395,-1074.4592,31.6719},
	{206.7339,-1771.1189,4.2873},
	{298.8037,-1155.8375,80.9099},
	{1033.7893,-809.8940,101.8516},
	{2483.3259,-1997.9877,13.8343},
	{1873.7358,-2020.6090,13.5469},
	{650.3296,-1619.5085,15.0000},
	{2257.5620,733.0655,11.4609},
	{1935.6852,739.5255,10.8203},
	{2787.9856,2223.3850,14.6615},
	{2625.0615,2016.8232,10.8203},
	{1599.3604,2147.3357,11.4609},
	{1025.9944,1975.8160,11.3449},
	{1703.6294,2694.0879,10.8203},
	{1972.5380,927.4847,10.8203},
	{1938.6154,2184.8523,10.8203},
	{1682.1293,1913.6169,10.8203},
	{988.3104,1879.0475,11.3594},
	{1458.3400,2523.8979,10.8203},
	{2484.4036,1528.7244,10.9017},
	{2225.0576,2520.0786,10.8203},
	{1531.1907,2357.5469,10.8203}
};

new Float:RandomTrucker[18][3] =
{
	{-99.2558,-1168.3788,2.5964},
	{1315.7880,-867.2107,39.5781},
	{2116.6514,-1771.4202,13.3937},
	{2816.3660,-1698.8490,9.9504},
	{2651.2346,-2390.4055,13.6328},
	{2115.3047,-1723.7944,13.5502},
	{2165.3979,2746.7004,10.8203},
	{2046.1804,2244.4304,10.8203},
	{2447.6467,1999.7650,10.8203},
	{2503.0703,1531.9418,10.6749},
	{2032.2845,1516.1019,10.8203},
	{1483.8053,1046.6919,10.8203},
	{-1728.6168,-119.5973,3.5547},
	{-1694.2990,399.9545,7.1797},
	{-1672.8090,1322.6425,7.1853},
	{-2110.9172,816.9711,69.5625},
	{-2533.0513,1227.8401,37.4219},
	{-2142.6599,-442.6247,35.3359}
};

main(){}

public OnGameModeInit()
{
	SendRconCommand("hostname "SERVER_NAME"");
	SendRconCommand("language "SERVER_LANG"");
	SendRconCommand("mapname "SERVER_MAPN"");
	SetGameModeText(""SERVER_GMOD"");

	ManualVehicleEngineAndLights();
	UsePlayerPedAnims();
	EnableStuntBonusForAll(0);
    DisableInteriorEnterExits();
    ShowPlayerMarkers(2);
    FadeInit();
    AntiDeAMX();

	printf("\n - UNNIC "SERVER_VERS" -");
	printf(" (!) Server Loaded.\n");
	MySQLConnect();

    LoadSystems();
    
    SetTimer("CheckClans", 1000, true);

    AddStaticVehicleEx(411, 1729.2877, -1854.2356, 13.0635, 0.0000, -1, -1, 100);

	//Pickups - Jobs
	AddStaticPickup(1275, 1, -373.7780,-1427.8170,25.7266);
	CreateDynamic3DTextLabel("JOB: Fermier\nTasteaza /getjob pentru a te angaja!\n\nPentru a incepe munca, urca intr-un tractor.", COLOR_WHITE, -373.7780, -1427.8170, 25.7266, 10.0);

	AddStaticPickup(1275, 1, 1642.3353,-2238.9849,13.4969);
	CreateDynamic3DTextLabel("JOB: Bus Driver\nTasteaza /getjob pentru a te angaja!\n\nPentru a incepe munca, urca intr-un autocar.", COLOR_WHITE, 1642.3353, -2238.9849, 13.4969, 10.0);

	AddStaticPickup(1275, 1, 2107.5979,-1788.2808,13.5608);
	CreateDynamic3DTextLabel("JOB: Pizza Boy\nTasteaza /getjob pentru a te angaja!\n\nPentru a incepe munca, tasteaza /pizza.", COLOR_WHITE, 2107.5979, -1788.2808, 13.5608, 10.0);

	AddStaticPickup(1275, 1, 2433.3757,-2115.3381,13.5469);
	CreateDynamic3DTextLabel("JOB: Trucker\nTasteaza /getjob pentru a te angaja!\n\nPentru a incepe munca, urca intr-un tir.", COLOR_WHITE, 2433.3757,-2115.3381,13.5469, 10.0);

	//Pickups - Other
	AddStaticPickup(1581, 1, 1219.2212,-1813.0067,16.5938);
	CreateDynamic3DTextLabel("{FFFF00}Driving School\n\n{FFFFFF}Pentru a sustine examenul tasteaza /exam.\nDaca doresti sa sustii examenul, trebuie sa platesti 1.500$.", COLOR_WHITE, 1219.2212,-1813.0067,16.5938, 10.0);

	AddStaticPickup(1277, 1, 1139.3975,-1761.5178,13.5952);
	CreateDynamic3DTextLabel("Dealership\n\nScrie /buyvehicle pentru a vedea vehiculele valabile in stoc.\nPentru a putea intra in dealership, ai nevoie de level 3.", COLOR_WHITE, 1139.3975,-1761.5178,13.5952, 10.0);

	//Vehicles
	FarmVeh[0] = AddStaticVehicleEx(531, -363.9438, -1413.4921, 25.6992, -0.9600, -1, -1, 100);
	FarmVeh[1] = AddStaticVehicleEx(531, -383.7084, -1418.1156, 25.6992, 270.4799, -1, -1, 100);
	FarmVeh[2] = AddStaticVehicleEx(531, -391.8371, -1418.0153, 25.6992, 91.3800, -1, -1, 100);
	FarmVeh[3] = AddStaticVehicleEx(531, -369.4858, -1437.0107, 25.6992, 91.3800, -1, -1, 100);
	FarmVeh[4] = AddStaticVehicleEx(531, -369.3737, -1439.7416, 25.6992, 91.3800, -1, -1, 100);
	FarmVeh[5] = AddStaticVehicleEx(531, -369.3215, -1442.4656, 25.6992, 91.3800, -1, -1, 100);
	FarmVeh[6] = AddStaticVehicleEx(531, -394.1895, -1436.4912, 25.6992, 179.5200, -1, -1, 100);
	FarmVeh[7] = AddStaticVehicleEx(531, -398.6718, -1436.4170, 25.6992, 179.5200, -1, -1, 100);
	FarmVeh[8] = AddStaticVehicleEx(531, -384.8373, -1451.7800, 25.6992, 270.0602, -1, -1, 100);
	FarmVeh[9] = AddStaticVehicleEx(531, -389.3593, -1451.8546, 25.6992, 270.0602, -1, -1, 100);
	FarmVeh[10] = AddStaticVehicleEx(531, -402.8636, -1436.3770, 25.6992, 179.5200, -1, -1, 100);
	FarmVeh[11] = AddStaticVehicleEx(531, -405.7335, -1436.3177, 25.6992, 179.5200, -1, -1, 100);
	FarmVeh[12] = AddStaticVehicleEx(531, -409.1388, -1426.3120, 25.8139, 91.3800, -1, -1, 100);
	FarmVeh[13] = AddStaticVehicleEx(531, -409.4746, -1430.7653, 25.6172, 91.3800, -1, -1, 100);
	FarmVeh[14] = AddStaticVehicleEx(531, -409.2388, -1422.0444, 25.6172, 91.3800, -1, -1, 100);
	FarmVeh[15] = AddStaticVehicleEx(531, -366.4548, -1413.4717, 25.6992, -0.9600, -1, -1, 100);
	FarmVeh[16] = AddStaticVehicleEx(531, -369.0654, -1413.4315, 25.6992, -0.9600, -1, -1, 100);

	BDVeh[0] = AddStaticVehicleEx(437, 1573.8649, -2221.8882, 13.4217, 0.0000, -1, -1, 100);
	BDVeh[1] = AddStaticVehicleEx(437, 1616.0164, -2248.7380, 13.4217, 90.5400, -1, -1, 100);
	BDVeh[2] = AddStaticVehicleEx(437, 1598.2604, -2249.0325, 13.4217, 90.5400, -1, -1, 100);
	BDVeh[3] = AddStaticVehicleEx(437, 1603.6167, -2258.8564, 13.4217, 90.5400, -1, -1, 100);
	BDVeh[4] = AddStaticVehicleEx(437, 1621.0692, -2258.5771, 13.4217, 90.5400, -1, -1, 100);
	BDVeh[5] = AddStaticVehicleEx(437, 1638.3052, -2258.3416, 13.4217, 90.5400, -1, -1, 100);
	BDVeh[6] = AddStaticVehicleEx(437, 1656.4941, -2258.3328, 13.4217, 90.5400, -1, -1, 100);
	BDVeh[7] = AddStaticVehicleEx(437, 1580.6748, -2270.3958, 13.4217, 0.0000, -1, -1, 100);
	BDVeh[8] = AddStaticVehicleEx(437, 1580.5815, -2286.9851, 13.4217, 0.0000, -1, -1, 100);
	BDVeh[9] = AddStaticVehicleEx(437, 1580.7988, -2302.2820, 13.4217, 0.0000, -1, -1, 100);
	BDVeh[10] = AddStaticVehicleEx(437, 1594.6360, -2314.2883, 13.4217, 90.5400, -1, -1, 100);
	BDVeh[11] = AddStaticVehicleEx(437, 1610.6002, -2314.5842, 13.4217, 90.5400, -1, -1, 100);
	BDVeh[12] = AddStaticVehicleEx(437, 1627.7478, -2314.8584, 13.4217, 90.5400, -1, -1, 100);
	BDVeh[13] = AddStaticVehicleEx(437, 1585.5381, -2323.9578, 13.4217, 90.5400, -1, -1, 100);
	BDVeh[14] = AddStaticVehicleEx(437, 1599.7045, -2323.6504, 13.4217, 90.5400, -1, -1, 100);
	BDVeh[15] = AddStaticVehicleEx(437, 1646.3199, -2314.7742, 13.4217, 90.5400, -1, -1, 100);
	
	PBVeh[1] = AddStaticVehicleEx(448,2121.6047, -1785.0217, 12.8712, 0.0000,-1,-1,300);
	PBVeh[2] = AddStaticVehicleEx(448,2118.7844, -1785.0411, 12.8712, 0.0000,-1,-1,300);
	PBVeh[3] = AddStaticVehicleEx(448,2115.9109, -1785.0051, 12.8712, 0.0000,-1,-1,300);
	PBVeh[4] = AddStaticVehicleEx(448,2112.5642, -1784.9452, 12.8712, 0.0000,-1,-1,300);
	PBVeh[5] = AddStaticVehicleEx(448,2109.4675, -1784.8478, 12.8712, 0.0000,-1,-1,300);
	PBVeh[6] = AddStaticVehicleEx(448,2106.0376, -1784.9371, 12.8712, 0.0000,-1,-1,300);
	PBVeh[7] = AddStaticVehicleEx(448,2102.1960, -1784.8618, 12.8712, 0.0000,-1,-1,300);
	PBVeh[8] = AddStaticVehicleEx(448,2122.4009, -1780.5249, 12.8712, 90.3000,-1,-1,300);
	PBVeh[9] = AddStaticVehicleEx(448,2092.4058, -1812.4491, 12.8712, 90.3000,-1,-1,300);
	PBVeh[10] = AddStaticVehicleEx(448,2092.4268, -1814.1829, 12.8712, 90.3000,-1,-1,300);
	PBVeh[11] = AddStaticVehicleEx(448,2092.3889, -1815.8123, 12.8712, 90.3000,-1,-1,300);
	PBVeh[12] = AddStaticVehicleEx(448,2092.4170, -1817.3027, 12.8712, 90.3000,-1,-1,300);
	PBVeh[13] = AddStaticVehicleEx(448,2092.4138, -1819.1460, 12.8712, 90.3000,-1,-1,300);
	PBVeh[14] = AddStaticVehicleEx(448,2092.4617, -1820.7538, 12.8712, 90.3000,-1,-1,300);
	
	TVeh[0] = AddStaticVehicleEx(514, 2452.5361, -2104.7209, 13.9718, 0.0000, -1, -1, 100);
	TVeh[1] = AddStaticVehicleEx(514, 2460.8403, -2104.6902, 13.9718, 0.0000, -1, -1, 100);
	TVeh[2] = AddStaticVehicleEx(514, 2468.6123, -2104.8472, 13.9718, 0.0000, -1, -1, 100);
	TVeh[3] = AddStaticVehicleEx(514, 2475.3376, -2104.5720, 13.9718, 0.0000, -1, -1, 100);
	TVeh[4] = AddStaticVehicleEx(514, 2483.1309, -2104.4812, 13.9718, 0.0000, -1, -1, 100);
	TVeh[5] = AddStaticVehicleEx(514, 2490.8591, -2104.4500, 13.9718, 0.0000, -1, -1, 100);
	TVeh[6] = AddStaticVehicleEx(514, 2499.3926, -2104.5205, 13.9718, 0.0000, -1, -1, 100);
	TVeh[7] = AddStaticVehicleEx(514, 2506.6594, -2104.5151, 13.9718, 0.0000, -1, -1, 100);
	TVeh[8] = AddStaticVehicleEx(514, 2514.2356, -2104.4529, 13.9718, 0.0000, -1, -1, 100);
	TVeh[9] = AddStaticVehicleEx(514, 2448.1821, -2077.8235, 13.9718, 179.7600, -1, -1, 100);
	TVeh[10] = AddStaticVehicleEx(514, 2437.8401, -2077.9753, 13.9718, 179.7600, -1, -1, 100);
	TVeh[11] = AddStaticVehicleEx(514, 2458.3198, -2078.1282, 13.9718, 179.7600, -1, -1, 100);
	TVeh[12] = AddStaticVehicleEx(514, 2468.1416, -2078.1458, 13.9718, 179.7600, -1, -1, 100);
	TVeh[13] = AddStaticVehicleEx(514, 2394.5498, -2095.4639, 13.9718, 269.0398, -1, -1, 100);
	TVeh[14] = AddStaticVehicleEx(514, 2394.4148, -2105.0828, 13.9718, 269.0398, -1, -1, 100);
	TVeh[15] = AddStaticVehicleEx(514, 2394.3953, -2115.5750, 13.9718, 269.0398, -1, -1, 100);
	TVeh[16] = AddStaticVehicleEx(514, 2394.6365, -2125.7043, 13.9718, 269.0398, -1, -1, 100);
	TVeh[17] = AddStaticVehicleEx(514, 2394.6008, -2136.3677, 13.9718, 269.0398, -1, -1, 100);
	TVeh[18] = AddStaticVehicleEx(514, 2394.5186, -2085.5332, 13.9718, 269.0398, -1, -1, 100);
	TVeh[19] = AddStaticVehicleEx(514, 2394.4480, -2075.1511, 13.9718, 269.0398, -1, -1, 100);
	TVeh[20] = AddStaticVehicleEx(514, 2394.2290, -2065.1699, 13.9718, 269.0398, -1, -1, 100);


	Total_Veh_Created = LastCarID();

	//TextDraws
	Background[0] = TextDrawCreate(644.000000, -2.000000, "_");					TextDrawBackgroundColor(Background[0], 255);
	TextDrawFont(Background[0], 1); 											TextDrawLetterSize(Background[0], 0.500000, 11.100004);
	TextDrawColor(Background[0], -1); 											TextDrawSetOutline(Background[0], 0);
	TextDrawSetProportional(Background[0], 1); 									TextDrawSetShadow(Background[0], 1);
	TextDrawUseBox(Background[0], 1); 											TextDrawBoxColor(Background[0], 255);
	TextDrawTextSize(Background[0], -3.000000, 0.000000); 						TextDrawSetSelectable(Background[0], 0);

	Background[1] = TextDrawCreate(644.000000, 340.000000, "_"); 				TextDrawBackgroundColor(Background[1], 255);
	TextDrawFont(Background[1], 1); 											TextDrawLetterSize(Background[1], 0.500000, 12.500005);
	TextDrawColor(Background[1], -1); 											TextDrawSetOutline(Background[1], 0);
	TextDrawSetProportional(Background[1], 1); 									TextDrawSetShadow(Background[1], 1);
	TextDrawUseBox(Background[1], 1); 											TextDrawBoxColor(Background[1], 255);
	TextDrawTextSize(Background[1], -3.000000, 0.000000); 						TextDrawSetSelectable(Background[1], 0);
	
	AdminTextdraw[0] = TextDrawCreate(1.000000,433.000000,"Tickrate"); 			TextDrawAlignment(AdminTextdraw[0],0);
	TextDrawBackgroundColor(AdminTextdraw[0],0x000000ff); 						TextDrawFont(AdminTextdraw[0],3);
	TextDrawLetterSize(AdminTextdraw[0],0.499999,1.100000); 					TextDrawColor(AdminTextdraw[0],0xffffffff);
	TextDrawSetOutline(AdminTextdraw[0],1); 									TextDrawSetProportional(AdminTextdraw[0],1);
	TextDrawSetShadow(AdminTextdraw[0],1);
	return 1;
}

public OnGameModeExit()
{
    FadeExit();
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
    if(ConnectedPlayers() > ServerInfo[Record])
	{
	    ServerInfo[Record] = ConnectedPlayers();

	    new str1[500];
	    mysql_format(mysql, str1, sizeof(str1), "UPDATE `server` SET `Record` = '%d'", ConnectedPlayers());
	    mysql_query(mysql, str1);

	    new hour, mins, secs, d, m, y, str2[100];
	    getdate(y, m, d);
	    gettime(hour, mins, secs);

	    format(str2, sizeof(str2), "%02d.%02d.%d %02d:%02d", d, m, y, hour, mins);
	    strmid(ServerInfo[RecordDate], str2, 0, strlen(str2));

	    mysql_format(mysql, str1, sizeof(str1), "UPDATE `server` SET `RecordDate` = '%s'", str2);
	    mysql_query(mysql, str1);
	}

	TogglePlayerSpectating(playerid, 1);
	FadePlayerConnect(playerid);

    query[0] = '\0';
	mysql_format(mysql, query, sizeof(query), "SELECT * FROM `bans` WHERE `IP` = '%s'", GetIP(playerid));
	mysql_tquery(mysql, query, "LoadBanDetalis", "i", playerid);

	InterpolateCameraPos(playerid, 980.072143, -960.567077, 99.725479, 1400.930297, -870.748352, 83.779884, 30000);
	InterpolateCameraLookAt(playerid, 984.804748, -962.165954, 99.940254, 1401.416503, -865.772155, 83.748634, 30000);

	TextDrawShowForPlayer(playerid, Background[0]);
	TextDrawShowForPlayer(playerid, Background[1]);

	PlayerTextdraws(playerid);

    PlayerInfo[playerid][ID] = 0;
	PlayerInfo[playerid][Name] = 0;
	PlayerInfo[playerid][Password] = 0;
	PlayerInfo[playerid][Gendre] = 0;
	PlayerInfo[playerid][Age] = 0;
	PlayerInfo[playerid][Email] = 0;
	PlayerInfo[playerid][Lang] = 0;
	PlayerInfo[playerid][Admin] = 0;
	PlayerInfo[playerid][Helper] = 0;
	PlayerInfo[playerid][Level] = 0;
	PlayerInfo[playerid][Premium] = 0;
	PlayerInfo[playerid][Registered] = 0;
	PlayerInfo[playerid][Respect] = 0;
	PlayerInfo[playerid][Money] = 0;
	PlayerInfo[playerid][Bank] = 0;
	PlayerInfo[playerid][Kills] = 0;
	PlayerInfo[playerid][Deaths] = 0;
	PlayerInfo[playerid][Wanted] = 0;
	PlayerInfo[playerid][Job] = 0;
	PlayerInfo[playerid][Tutorial] = 0;
	PlayerInfo[playerid][PPoints] = 0;
	PlayerInfo[playerid][Paydays] = 0;
	PlayerInfo[playerid][Muted] = 0;
	PlayerInfo[playerid][MuteTime] = 0;
	PlayerInfo[playerid][Freeze] = 0;
	PlayerInfo[playerid][FreezeTime] = 0;
	PlayerInfo[playerid][Jailed] = 0;
	PlayerInfo[playerid][JailTime] = 0;
	PlayerInfo[playerid][Skin] = 0;
	PlayerInfo[playerid][PIN] = 0;
	PlayerInfo[playerid][CarL] = 0;
	PlayerInfo[playerid][FlyL] = 0;
	PlayerInfo[playerid][GunL] = 0;
	PlayerInfo[playerid][BoatL] = 0;
	PlayerInfo[playerid][hasTazer] = 0;
	PlayerInfo[playerid][isTazed] = 0;
	PlayerInfo[playerid][VehicleSlots] = 0;
	BigEar[playerid] = 0;
	Centura[playerid] = 0;
	FirstPress[playerid] = 0;
	SpawnChoose[playerid] = 0;
	InExam[playerid] = 0;

	RemoveBuildings(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(InExam[playerid] == 1)
	{
	    DisablePlayerCheckpoint(playerid);
	    DestroyVehicle(DMVCar[playerid]);

    	for(new i = 0; i < sizeof(DMVObj); i++) DestroyDynamicObject(DMVObj[i]);
		for(new i = 0; i < sizeof(DMVObj2); i++) DestroyDynamicObject(DMVObj2[i]);
	}
	if(Working[playerid] == 1)
	{
	    DestroyVehicle(PBVeh[playerid]);
	    DisablePlayerCheckpoint(playerid);
	    Working[playerid] = 0;
	}
	
    PlayerInfo[playerid][ID] = 0;
	PlayerInfo[playerid][Name] = 0;
	PlayerInfo[playerid][Password] = 0;
	PlayerInfo[playerid][Gendre] = 0;
	PlayerInfo[playerid][Age] = 0;
	PlayerInfo[playerid][Email] = 0;
	PlayerInfo[playerid][Lang] = 0;
	PlayerInfo[playerid][Admin] = 0;
	PlayerInfo[playerid][Helper] = 0;
	PlayerInfo[playerid][Level] = 0;
	PlayerInfo[playerid][Premium] = 0;
	PlayerInfo[playerid][Registered] = 0;
	PlayerInfo[playerid][Respect] = 0;
	PlayerInfo[playerid][Money] = 0;
	PlayerInfo[playerid][Bank] = 0;
	PlayerInfo[playerid][Kills] = 0;
	PlayerInfo[playerid][Deaths] = 0;
	PlayerInfo[playerid][Wanted] = 0;
	PlayerInfo[playerid][Job] = 0;
	PlayerInfo[playerid][Tutorial] = 0;
	PlayerInfo[playerid][PPoints] = 0;
	PlayerInfo[playerid][Paydays] = 0;
	PlayerInfo[playerid][Muted] = 0;
	PlayerInfo[playerid][MuteTime] = 0;
	PlayerInfo[playerid][Freeze] = 0;
	PlayerInfo[playerid][FreezeTime] = 0;
	PlayerInfo[playerid][Jailed] = 0;
	PlayerInfo[playerid][JailTime] = 0;
	PlayerInfo[playerid][Skin] = 0;
	PlayerInfo[playerid][PIN] = 0;
	PlayerInfo[playerid][CarL] = 0;
	PlayerInfo[playerid][FlyL] = 0;
	PlayerInfo[playerid][GunL] = 0;
	PlayerInfo[playerid][BoatL] = 0;

	FadePlayerDisconnect(playerid);

	new LastLogin[100], h, mins, s, y, m, d;
	getdate(y, m, d);
	gettime(h, mins, s);

	format(LastLogin, 100, "%02d/%02d/%d - %02d:%02d", d, m, y, h, mins);

	query[0] = EOS;
	mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `LastLogin` = '%s' WHERE `Name` = '%s'", LastLogin, GetCleanName(playerid));
	mysql_query(mysql, query);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	TextDrawHideForPlayer(playerid, Background[0]);
	TextDrawHideForPlayer(playerid, Background[1]);

	PlayerTextDrawShow(playerid, Logo[0]);
	PlayerTextDrawShow(playerid, Logo[1]);

	new fid = PlayerInfo[playerid][Faction];
	if(fid > 0 && FactionInfo[fid][fID] > 0 && IsPlayerLogged[playerid] == 1)
	{
		SetPlayerColor(playerid, FactionInfo[fid][fColor]);
		SetPlayerInterior(playerid, FactionInfo[fid][fInt]);
		SetPlayerVirtualWorld(playerid, FactionInfo[fid][fVW]);
		new string[128];
		if(strcmp(FactionInfo[fid][fMotd], "") && strcmp(FactionInfo[fid][fMotd], "_"))
		{
			format(string, sizeof(string), "MOTD: %s", FactionInfo[fid][fMotd]);
			SCM(playerid, COLOR_DARKCYAN, string);
		}
		IsTurfAttacked(playerid);
	}
	else SetPlayerColor(playerid, 0xFFFFFFFF);

	new cid = PlayerInfo[playerid][Clan];
	if(cid > 0 && IsValidClan(cid) && IsPlayerLogged[playerid] == 1)
	{
		new string[128];
		if(strcmp(ClanInfo[cid][Motd], "") && strcmp(ClanInfo[cid][Motd], "_"))
		{
			format(string, sizeof(string), "CLAN MOTD: %s", ClanInfo[cid][Motd]);
			SCM(playerid, COLOR_DARKGOLD, string);
		}
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new turf, fid, kfid, string[50], Float:x, Float:y, Float:z, weap, Float:dist, rand, str[128], wName[32];
	weap = GetPlayerWeapon(killerid);
	turf = GetTurfID(GetPlayerGangZone(playerid));
	if(IsPlayerConnected(playerid))
	{
		fid = PlayerInfo[playerid][Faction];
		
		if(IsPlayerConnected(killerid)) kfid = PlayerInfo[killerid][Faction];

		if(IsPlayerInGangZone(playerid, Turfs[FactionInfo[fid][fAttackedTurf]][ID]) && IsPlayerInGangZone(killerid, Turfs[FactionInfo[kfid][fAttackedTurf]][ID]) && Turfs[turf][isAttacked] == 2)
		{
		    rand = random(100) + 1;
		    if(rand > PlayerInfo[playerid][Money])
		    {
		    	rand = PlayerInfo[playerid][Money];
		    }
		    PlayerInfo[playerid][Money] = PlayerInfo[playerid][Money] - rand;
			Update(playerid, Moneyx);
			ResetPlayerMoney(playerid);
		    GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);
		    GivePlayerMoney(killerid, rand);
			Update(killerid, Moneyx);
			GetPlayerPos(killerid, x, y, z);
			dist = floatround(GetPlayerDistanceFromPoint(playerid, x, y, z));
			GetWeaponName(weap, wName, sizeof(wName));
			format(str, sizeof(str), "L-ai omorat pe %s de la distanta de %fm cu un %s si ai primit $%d.", GetName(playerid), dist, wName, rand);
			SCM(killerid, COLOR_CYAN, str);
			format(str, sizeof(str), "%s te-a omorat cu un %s de la distanta de %fm si ti-a luat $%d.", GetName(killerid), wName, dist, rand);
			SCM(playerid, COLOR_CYAN, str);
		    FactionInfo[kfid][fScore]++;
		    PlayerInfo[killerid][tKills]++;
		    format(string, sizeof(string), "Your kills: %d", PlayerInfo[killerid][tKills]);
		    PlayerTextDrawSetString(killerid, WarTD[killerid][4], string);
		    PlayerInfo[playerid][tDeaths]++;
		    format(string, sizeof(string), "Your deaths: %d", PlayerInfo[playerid][tDeaths]);
		    PlayerTextDrawSetString(playerid, WarTD[playerid][5], string);
		}
		RespawnPlayer(playerid);
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	if(VehInfo[vehicleid][Spawnable] == 1)
	{
 		DestroyVehicle(vehicleid);
		CreateVehicle(VehInfo[vehicleid][Model], VehInfo[vehicleid][PosX], VehInfo[vehicleid][PosY], VehInfo[vehicleid][PosZ], VehInfo[vehicleid][PosA], VehInfo[vehicleid][Color1], VehInfo[vehicleid][Color2], 500000);
		new engine, lights, alarm, doors, bonnet, boot, objective;

	    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	    SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);
		if(FactionInfo[VehInfo[vehicleid][Faction]][fInWar] == 2) SetVehicleVirtualWorld(vehicleid, FactionInfo[VehInfo[vehicleid][Faction]][fAttackedTurf] + 999);
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[ ])
{
	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "%s says: %s", GetName(playerid), text);
	ProxDetector(20.0, playerid, kStr, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[ ])
{
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(IsFarmerVeh(vehicleid))
	{
	    if(PlayerInfo[playerid][Job] != 1)
		{
			SCM(playerid, COLOR_WHITE, "Nu poti conduce acest vehicul daca nu esti fermier!");

			RemovePlayerFromVehicle(playerid);
			SetVehicleToRespawn(vehicleid);
	    }
	    else
		{
		    PlayerTextDrawShow(playerid, Jobs[0]);
		    PlayerTextDrawShow(playerid, Jobs[1]);
		    PlayerTextDrawShow(playerid, Jobs[2]);

		    FarmSec[playerid] = 120;
		    FarmOut[playerid] = 30;

			FTimer[playerid] = SetTimerEx("FarmerTimer", 1000, true, "i", playerid);
		}
	}
	if(IsBusDriverVeh(vehicleid))
	{
	    if(PlayerInfo[playerid][Job] != 2)
		{
			SCM(playerid, COLOR_WHITE, "Nu poti conduce acest vehicul daca nu esti sofer de bus!");
			RemovePlayerFromVehicle(playerid);
	    }
	    else
	    {
	        Statii[playerid] = 0;
	        BusDriverCash[playerid] = 0;

	        new skill, remain, forup;
	        GetBusDriverSkill(playerid, skill, remain, forup);

	        SetPlayerRaceCheckpoint(playerid, 0, 1693.2972,-2197.6602,13.4714,1941.3706,-2169.2083,13.4851,4.0);
	        CP[playerid] = 100;
	        JobStep[playerid] = 0;

	        new str[1800];
	    	format(str, sizeof(str), "Skill: %d (%d/%d runde efectuate)~n~Bani castigati: %d$~n~Opriri la statii: %d", skill, remain, forup, BusDriverCash[playerid], Statii);
	    	PlayerTextDrawSetString(playerid, Jobs2[1], str);

	        PlayerTextDrawShow(playerid, Jobs2[0]);
	        PlayerTextDrawShow(playerid, Jobs2[1]);
	    }
	}
	if(IsPizzaBoyVeh(vehicleid))
	{
	    if(PlayerInfo[playerid][Job] != 3)
	    {
	        SCM(playerid, COLOR_WHITE, "Nu poti conduce acest vehicul daca nu esti pizza boy!");
			RemovePlayerFromVehicle(playerid);
	    }
	    else SCM(playerid, COLOR_WHITE, "Tasteaza /pizza pentru a incepe munca!");
	}
	if(IsTruckerVeh(vehicleid))
	{
	    if(PlayerInfo[playerid][Job] != 4)
		{
			SCM(playerid, COLOR_WHITE, "Nu poti conduce acest vehicul daca nu esti sofer de tir!");
			RemovePlayerFromVehicle(playerid);
	    }
	    else
	    {
	        TruckerCash[playerid] = 0;
	        
	        SetPlayerCheckpoint(playerid, 2261.1777,-1750.9807,13.9678, 5.0);
	        CP[playerid] = 400;
	    }
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(IsFarmerVeh(vehicleid))
	{
	    SetVehicleToRespawn(GetPlayerVehicleID(playerid));

		PlayerTextDrawHide(playerid, Jobs[0]);
		PlayerTextDrawHide(playerid, Jobs[1]);
		PlayerTextDrawHide(playerid, Jobs[2]);
		PlayerTextDrawHide(playerid, Jobs[3]);
		PlayerTextDrawHide(playerid, Jobs[4]);

		KillTimer(FTimer[playerid]);
	}
	if(IsBusDriverVeh(vehicleid))
	{
	    SetVehicleToRespawn(GetPlayerVehicleID(playerid));

	    PlayerTextDrawHide(playerid, Jobs2[0]);
	    PlayerTextDrawHide(playerid, Jobs2[1]);
	}
	if(IsPizzaBoyVeh(vehicleid))
	{
	    SCM(playerid, COLOR_WHITE, "Pentru a inceta sa mai muncesti poti folosi comanda /stopwork.");
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
		new string[128];
	    if(PlayerInfo[playerid][CarL] == 0 && InExam[playerid] == 0)
		{
			SCM(playerid, COLOR_ERROR, "Nu poti conduce nici-un vehicul deoarece nu ai un permis auto!");
			RemovePlayerFromVehicle(playerid);
			return 1;
		}
		
        PlayerTextDrawShow(playerid, EngineTD);

		Centura[playerid] = 0;
		Speedometer[playerid] = SetTimerEx("CheckSpeedometer", 800, true, "i", playerid);

        new vehicleid = GetPlayerVehicleID(playerid);
		if(IsFactionVeh(vehicleid))
		{
			new fid = VehInfo[vehicleid][Faction];
			if(fid != PlayerInfo[playerid][Faction])
			{
				RemovePlayerFromVehicle(playerid);
				format(string, sizeof(string), "Nu faci parte din factiunea %s!", FactionInfo[fid][fName]);
				SCM(playerid, COLOR_ERROR, string);
			}
			else if(PlayerInfo[playerid][Faction] == fid && PlayerInfo[playerid][Rank] < VehInfo[vehicleid][Rank])
			{
				RemovePlayerFromVehicle(playerid);
				format(string, sizeof(string), "Nu ai rank-ul necesar pentru a urca in masina!", FactionInfo[fid][fName]);
				SCM(playerid, COLOR_ERROR, string);
			}
		}
		if(IsClanVeh(vehicleid))
		{
			new cid = VehInfo[vehicleid][Clan];
			if(cid != PlayerInfo[playerid][Clan])
			{
				RemovePlayerFromVehicle(playerid);
				format(string, sizeof(string), "Nu faci parte din clanul %s!", ClanInfo[cid][Name]);
				SCM(playerid, COLOR_ERROR, string);
			}
		}
		if(VehInfo[vehicleid][Owner] > 0) format(string, sizeof(string), "Aceasta masina ii apartine lui %s.", GetOfflineInfo(VehInfo[vehicleid][Owner], Namex)), SCM(playerid, COLOR_WHITE, string);
	}
	else
	{
	    Centura[playerid] = 0;
		KillTimer(Speedometer[playerid]);

		PlayerTextDrawHide(playerid, EngineTD);
	}
	return 1;
}

forward OnCheatDetected(playerid, ip_address[], type, code);
public OnCheatDetected(playerid, ip_address[], type, code)
{

	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(CP[playerid] == 1)
	{
	    FadeColorForPlayer(playerid,0,0,0,255,0,0,0,0,100,3);
	    HideInfoTD(playerid);
	    DisablePlayerCheckpoint(playerid);

	    for(new i = 0; i < sizeof(DMVObj); i++)
	    {
	    	DestroyDynamicObject(DMVObj[i]);
		}
		DestroyVehicle(DMVCar[playerid]);

		SetPlayerCheckpoint(playerid, -2062.7380,-235.8687,35.1639, 4.0);
		CP[playerid] = 2;

		DMVCar[playerid] = AddStaticVehicleEx(411, -2086.7927,-127.8677,35.1339,179.5432, 140, 140, 0);
		PutPlayerInVehicle(playerid, DMVCar[playerid], 0);

		DMVObj2[0] = CreateDynamicObject(978, -2081.40796, -128.62608, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[1] = CreateDynamicObject(978, -2081.40991, -138.57573, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[2] = CreateDynamicObject(978, -2076.55933, -143.31760, 35.11174,   0.00000, 0.00000, 179.58000, vw[playerid]);
		DMVObj2[3] = CreateDynamicObject(978, -2061.69702, -138.49118, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[4] = CreateDynamicObject(978, -2056.69824, -123.61343, 35.11174,   0.00000, 0.00000, 179.58000, vw[playerid]);
		DMVObj2[5] = CreateDynamicObject(978, -2071.66016, -128.49571, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[6] = CreateDynamicObject(978, -2071.62744, -138.43481, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[7] = CreateDynamicObject(978, -2091.72266, -128.66040, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[8] = CreateDynamicObject(978, -2091.71191, -138.42050, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[9] = CreateDynamicObject(978, -2091.74854, -148.48759, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[10] = CreateDynamicObject(978, -2086.52783, -153.63678, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[11] = CreateDynamicObject(978, -2076.67871, -153.69606, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[12] = CreateDynamicObject(978, -2066.69287, -153.55864, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[13] = CreateDynamicObject(978, -2061.65234, -148.54958, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[14] = CreateDynamicObject(978, -2066.50342, -123.56950, 35.11174,   0.00000, 0.00000, 179.58000, vw[playerid]);
		DMVObj2[15] = CreateDynamicObject(978, -2056.61890, -133.85565, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[16] = CreateDynamicObject(978, -2046.57825, -123.75565, 35.11174,   0.00000, 0.00000, 179.58000, vw[playerid]);
		DMVObj2[17] = CreateDynamicObject(978, -2041.52429, -129.13408, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[18] = CreateDynamicObject(978, -2041.51868, -138.84650, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[19] = CreateDynamicObject(978, -2041.50842, -148.80305, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[20] = CreateDynamicObject(978, -2051.60107, -138.97162, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[21] = CreateDynamicObject(978, -2051.57935, -148.95599, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[22] = CreateDynamicObject(978, -2056.24341, -156.45987, 35.11174,   0.00000, 0.00000, 204.96002, vw[playerid]);
		DMVObj2[23] = CreateDynamicObject(978, -2065.26489, -160.72847, 35.11174,   0.00000, 0.00000, 205.14001, vw[playerid]);
		DMVObj2[24] = CreateDynamicObject(978, -2074.34180, -165.15015, 35.11174,   0.00000, 0.00000, 205.14001, vw[playerid]);
		DMVObj2[25] = CreateDynamicObject(978, -2083.36328, -169.51277, 35.11174,   0.00000, 0.00000, 207.12012, vw[playerid]);
		DMVObj2[26] = CreateDynamicObject(978, -2088.06274, -176.87653, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[27] = CreateDynamicObject(978, -2088.11572, -187.30829, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[28] = CreateDynamicObject(978, -2084.71997, -196.29424, 35.11174,   0.00000, 0.00000, 309.00003, vw[playerid]);
		DMVObj2[29] = CreateDynamicObject(978, -2037.24109, -156.99515, 35.11174,   0.00000, 0.00000, 142.98000, vw[playerid]);
		DMVObj2[30] = CreateDynamicObject(978, -2029.36450, -162.93890, 35.11174,   0.00000, 0.00000, 142.98000, vw[playerid]);
		DMVObj2[31] = CreateDynamicObject(978, -2021.39929, -168.70230, 35.11174,   0.00000, 0.00000, 142.98000, vw[playerid]);
		DMVObj2[32] = CreateDynamicObject(978, -2017.31006, -176.67050, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[33] = CreateDynamicObject(978, -2017.19861, -186.60564, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[34] = CreateDynamicObject(978, -2017.07971, -196.63141, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[35] = CreateDynamicObject(978, -2022.54810, -201.38292, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[36] = CreateDynamicObject(978, -2032.51721, -201.43996, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[37] = CreateDynamicObject(978, -2042.45117, -201.39819, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[38] = CreateDynamicObject(978, -2081.79004, -205.14954, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[39] = CreateDynamicObject(978, -2081.80981, -215.07265, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[40] = CreateDynamicObject(978, -2081.75415, -224.98335, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[41] = CreateDynamicObject(978, -2038.82629, -167.50845, 35.11174,   0.00000, 0.00000, 322.97992, vw[playerid]);
		DMVObj2[42] = CreateDynamicObject(978, -2031.74805, -172.81567, 35.11174,   0.00000, 0.00000, 322.97992, vw[playerid]);
		DMVObj2[43] = CreateDynamicObject(978, -2027.71704, -180.65311, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[44] = CreateDynamicObject(978, -2027.66907, -188.05298, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[45] = CreateDynamicObject(978, -2032.79492, -192.64297, 35.11174,   0.00000, 0.00000, 179.58000, vw[playerid]);
		DMVObj2[46] = CreateDynamicObject(978, -2037.92163, -187.82874, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[47] = CreateDynamicObject(978, -2037.98914, -177.75873, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[48] = CreateDynamicObject(978, -2043.18884, -172.64444, 35.11174,   0.00000, 0.00000, 179.58000, vw[playerid]);
		DMVObj2[49] = CreateDynamicObject(978, -2053.13013, -172.58023, 35.11174,   0.00000, 0.00000, 179.58000, vw[playerid]);
		DMVObj2[50] = CreateDynamicObject(978, -2058.28442, -177.41969, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[51] = CreateDynamicObject(978, -2058.37012, -187.25436, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[52] = CreateDynamicObject(978, -2058.29663, -197.13322, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[53] = CreateDynamicObject(978, -2047.56140, -186.23787, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[54] = CreateDynamicObject(978, -2047.60571, -196.35608, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[55] = CreateDynamicObject(978, -2058.17456, -206.95609, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[56] = CreateDynamicObject(978, -2053.02515, -212.02708, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[57] = CreateDynamicObject(978, -2043.04626, -212.12686, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[58] = CreateDynamicObject(978, -2038.29248, -217.23808, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[59] = CreateDynamicObject(978, -2028.80457, -206.43121, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[60] = CreateDynamicObject(978, -2028.77039, -216.47504, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[61] = CreateDynamicObject(978, -2028.70740, -226.49530, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[62] = CreateDynamicObject(978, -2033.57886, -231.91296, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[63] = CreateDynamicObject(978, -2043.52441, -231.90878, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[64] = CreateDynamicObject(978, -2043.40869, -222.33659, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[65] = CreateDynamicObject(978, -2053.25781, -222.24554, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[66] = CreateDynamicObject(978, -2063.32520, -222.19005, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[67] = CreateDynamicObject(978, -2053.47144, -231.88463, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[68] = CreateDynamicObject(978, -2068.14966, -227.18665, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[69] = CreateDynamicObject(978, -2068.06250, -236.98468, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[70] = CreateDynamicObject(978, -2058.01733, -236.93520, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[71] = CreateDynamicObject(978, -2063.08447, -242.34299, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[72] = CreateDynamicObject(978, -2056.01465, -166.64848, 35.11174,   0.00000, 0.00000, 384.96030, vw[playerid]);
		DMVObj2[73] = CreateDynamicObject(978, -2047.16870, -164.74008, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[74] = CreateDynamicObject(978, -2064.99609, -170.82510, 35.11174,   0.00000, 0.00000, 384.96030, vw[playerid]);
		DMVObj2[75] = CreateDynamicObject(978, -2073.74219, -174.91006, 35.11174,   0.00000, 0.00000, 384.96030, vw[playerid]);
		DMVObj2[76] = CreateDynamicObject(978, -2078.18774, -182.00133, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[77] = CreateDynamicObject(978, -2075.18799, -190.97313, 35.11174,   0.00000, 0.00000, 488.69995, vw[playerid]);
		DMVObj2[78] = CreateDynamicObject(978, -2072.19434, -200.06085, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[79] = CreateDynamicObject(978, -2072.11914, -210.25185, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[80] = CreateDynamicObject(978, -2071.97119, -220.56320, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[81] = CreateDynamicObject(978, -2071.85986, -230.93642, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[82] = CreateDynamicObject(978, -2084.36426, -234.03818, 35.11174,   0.00000, 0.00000, 236.70033, vw[playerid]);
		DMVObj2[83] = CreateDynamicObject(978, -2074.40747, -240.43535, 35.11174,   0.00000, 0.00000, 416.64020, vw[playerid]);
		DMVObj2[84] = CreateDynamicObject(978, -2087.18091, -243.30127, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[85] = CreateDynamicObject(978, -2077.04810, -249.69824, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[86] = CreateDynamicObject(978, -2087.12109, -253.62080, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[87] = CreateDynamicObject(978, -2087.14624, -263.93439, 35.11174,   0.00000, 0.00000, 270.18002, vw[playerid]);
		DMVObj2[88] = CreateDynamicObject(978, -2082.04785, -268.99466, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[89] = CreateDynamicObject(978, -2072.24219, -269.03497, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[90] = CreateDynamicObject(978, -2062.52124, -269.07700, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[91] = CreateDynamicObject(978, -2052.89795, -269.10077, 35.11174,   0.00000, 0.00000, 359.82001, vw[playerid]);
		DMVObj2[92] = CreateDynamicObject(978, -2043.31274, -267.83554, 35.11174,   0.00000, 0.00000, 375.29987, vw[playerid]);
		DMVObj2[93] = CreateDynamicObject(978, -2072.03442, -254.59802, 35.11174,   0.00000, 0.00000, 179.58000, vw[playerid]);
		DMVObj2[94] = CreateDynamicObject(978, -2062.30884, -254.69289, 35.11174,   0.00000, 0.00000, 179.58000, vw[playerid]);
		DMVObj2[95] = CreateDynamicObject(978, -2052.57031, -254.72313, 35.11174,   0.00000, 0.00000, 179.58000, vw[playerid]);
		DMVObj2[96] = CreateDynamicObject(978, -2042.92163, -255.69432, 35.11174,   0.00000, 0.00000, 166.44019, vw[playerid]);
		DMVObj2[97] = CreateDynamicObject(978, -2038.33447, -261.80359, 35.11174,   0.00000, 0.00000, 90.53996, vw[playerid]);
		DMVObj2[98] = CreateDynamicObject(1237, -2091.82764, -123.32573, 34.31804,   0.00000, 0.00000, 0.00000, vw[playerid]);
		DMVObj2[99] = CreateDynamicObject(1237, -2090.66699, -123.29137, 34.31804,   0.00000, 0.00000, 0.00000, vw[playerid]);
		DMVObj2[100] = CreateDynamicObject(1237, -2089.46802, -123.27760, 34.31804,   0.00000, 0.00000, 0.00000, vw[playerid]);
		DMVObj2[101] = CreateDynamicObject(1237, -2088.18921, -123.28418, 34.31804,   0.00000, 0.00000, 0.00000, vw[playerid]);
		DMVObj2[102] = CreateDynamicObject(1237, -2086.88940, -123.31178, 34.31804,   0.00000, 0.00000, 0.00000, vw[playerid]);
		DMVObj2[103] = CreateDynamicObject(1237, -2085.52881, -123.34143, 34.31804,   0.00000, 0.00000, 0.00000, vw[playerid]);
		DMVObj2[104] = CreateDynamicObject(1237, -2084.30737, -123.33003, 34.31804,   0.00000, 0.00000, 0.00000, vw[playerid]);
		DMVObj2[105] = CreateDynamicObject(1237, -2082.94385, -123.18533, 34.31804,   0.00000, 0.00000, 0.00000, vw[playerid]);
		DMVObj2[106] = CreateDynamicObject(1237, -2081.62256, -123.21689, 34.31804,   0.00000, 0.00000, 0.00000, vw[playerid]);

		Info(playerid, "~y~DMV INSTRUCTOR: ~w~~h~Trebuie sa ajungi la ~r~punctul rosu ~w~~h~de pe harta.~n~Incearca sa nu avariezi masina pe parcursul acestui examen.", 999);
	}
	else if(CP[playerid] == 2)
	{
	    DisablePlayerCheckpoint(playerid);
	    DestroyVehicle(DMVCar[playerid]);

		for(new i = 0; i < sizeof(DMVObj2); i++)
		{
			DestroyDynamicObject(DMVObj2[i]);
		}

	    SetPlayerPos(playerid, 1219.2212,-1813.0067,16.5938);
		Info(playerid, "Felicitari, ai luat permisul auto valabil pentru 100 zile.", 5000);
		PlayerInfo[playerid][CarL] = 100;
		Update(playerid, CarLx);
		SetPlayerVirtualWorld(playerid, 0);
		InExam[playerid] = 0;

		SPD(playerid, 0, DIALOG_STYLE_MSGBOX, "Tutorial 1: DMV License - Finished", "Felicitari, ai parcurs primul tutorial. Ai primit o licenta de condus valabila 100 de zile.\n\n\
																					 In cazul in care veti incalca legea folosind un vehicul, licenta va va fi suspendata de catre politisti.", "OK", "");
	}
	else if(CP[playerid] == 5)
	{
	    if(PlayerInfo[playerid][Lang] == 1)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SPD(playerid, 0, DIALOG_STYLE_MSGBOX, "Tutorial 1: DMV License", "Felicitari, ai ajuns la DMV.\n\
																 			  Foloseste comanda /exam in chat pentru a-ti incepe examenul auto.", "OK", "");

			Info(playerid, "Scrie ~y~/exam ~w~~h~pentru a sustine examenul auto.", 999);
	    }
	    else if(PlayerInfo[playerid][Lang] == 2)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SPD(playerid, 0, DIALOG_STYLE_MSGBOX, "Tutorial 1: DMV License", "Congratulations, you are at the DMV place.\n\
																 		  	  Use /exam command in chat to take the car license.", "OK", "");

			Info(playerid, "Type ~y~/exam ~w~~h~to start the auto exam.", 999);
	    }
	}
	else if(CP[playerid] == 300)
	{
	    kStr[0] = EOS;

		format(kStr, sizeof(kStr), "JOB INFO: Ai livrat pizza cu succes si ai castigat %d$.", pizzaprize[playerid]);
	    SCM(playerid, COLOR_WHITE, kStr);
	    
	    GivePlayerMoney(playerid, pizzaprize[playerid]);
	    
	    DisablePlayerCheckpoint(playerid);
	    
	    new rand = random(sizeof(RandomPizza));
		SetPlayerCheckpoint(playerid, RandomPizza[rand][0], RandomPizza[rand][1], RandomPizza[rand][2], 3.0);
		CP[playerid] = 300;
		
		PlayerInfo[playerid][PizzaBoySkill]++;
		Update(playerid, PizzaBoySkillx);
		
		new Float:Position[3];
		GetPlayerPos(playerid, Position[0], Position[1], Position[2]);

		new distance = floatround(GetDistanceBetweenPoints(Position[0],Position[1], Position[2], RandomPizza[rand][0], RandomPizza[rand][1], RandomPizza[rand][2]), floatround_round);

		new skill, remain, forup;
		GetPizzaBoySkill(playerid, skill, remain, forup);

		if(skill == 1) pizzaprize[playerid] = distance*8;
		if(skill == 2) pizzaprize[playerid] = distance*8 + (distance*8)*(10/100);
		if(skill == 3) pizzaprize[playerid] = distance*8 + (distance*8)*(20/100);
		if(skill == 4) pizzaprize[playerid] = distance*8 + (distance*8)*(30/100);
		if(skill == 5) pizzaprize[playerid] = distance*8 + (distance*8)*(40/100);
		if(skill == 6) pizzaprize[playerid] = distance*8 + (distance*8)*(50/100);
	}
	else if(CP[playerid] == 400)
	{
	    kStr[0] = EOS;

		format(kStr, sizeof(kStr), "JOB INFO: Ai preluat remorca, transporta marfa pana la punctul rosu de pe harta.");
	    SCM(playerid, COLOR_WHITE, kStr);
	    
	    trucktrailer[playerid] = AddStaticVehicleEx(591, 0.0, 0.0, 0.0, 0.0, 25, -1, 100);
	    SetTimerEx("AttachTrailer", 500, false, "ii", trucktrailer[playerid], GetPlayerVehicleID(playerid));

	    DisablePlayerCheckpoint(playerid);

	    new rand = random(sizeof(RandomTrucker));
		SetPlayerCheckpoint(playerid, RandomTrucker[rand][0], RandomTrucker[rand][1], RandomTrucker[rand][2], 3.0);
		CP[playerid] = 450;

		new Float:Position[3];
		GetPlayerPos(playerid, Position[0], Position[1], Position[2]);

		new distance = floatround(GetDistanceBetweenPoints(Position[0],Position[1], Position[2], RandomTrucker[rand][0], RandomTrucker[rand][1], RandomTrucker[rand][2]), floatround_round);

		new skill, remain, forup;
		GetTruckerSkill(playerid, skill, remain, forup);

		if(skill == 1) truckerprize[playerid] = distance*8;
		if(skill == 2) truckerprize[playerid] = distance*8 + (distance*8)*(10/100);
		if(skill == 3) truckerprize[playerid] = distance*8 + (distance*8)*(20/100);
		if(skill == 4) truckerprize[playerid] = distance*8 + (distance*8)*(30/100);
		if(skill == 5) truckerprize[playerid] = distance*8 + (distance*8)*(40/100);
		if(skill == 6) truckerprize[playerid] = distance*8 + (distance*8)*(50/100);
		
		new str[1800];
	    format(str, sizeof(str), "Skill: %d (%d/%d runde efectuate)~n~Bani castigati: %d$~n~Place: %s", skill, remain, forup, TruckerCash[playerid], GetPlayerZone(RandomTrucker[rand][0], RandomTrucker[rand][1], RandomTrucker[rand][2]));
	    PlayerTextDrawSetString(playerid, Jobs2[1], str);
	    PlayerTextDrawShow(playerid, Jobs2[0]);
	    PlayerTextDrawShow(playerid, Jobs2[1]);
	}
	else if(CP[playerid] == 450)
	{
	    GivePlayerMoney(playerid, truckerprize[playerid]);
	    
	    kStr[0] = EOS;

		format(kStr, sizeof(kStr), "JOB INFO: Ai transportat marfa in siguranta si ai castigat %d$. Du-te la urmatorul checkpoint.", truckerprize[playerid]);
	    SCM(playerid, COLOR_WHITE, kStr);
	    
	    DisablePlayerCheckpoint(playerid);

	    new rand = random(sizeof(RandomTrucker));
		SetPlayerCheckpoint(playerid, RandomTrucker[rand][0], RandomTrucker[rand][1], RandomTrucker[rand][2], 3.0);
		CP[playerid] = 450;

		TruckerCash[playerid] += truckerprize[playerid];
		PlayerInfo[playerid][TruckerSkill]++;
		Update(playerid, TruckerSkillx);

		new Float:Position[3];
		GetPlayerPos(playerid, Position[0], Position[1], Position[2]);

		new distance = floatround(GetDistanceBetweenPoints(Position[0],Position[1], Position[2], RandomTrucker[rand][0], RandomTrucker[rand][1], RandomTrucker[rand][2]), floatround_round);

		new skill, remain, forup;
		GetTruckerSkill(playerid, skill, remain, forup);

		if(skill == 1) truckerprize[playerid] = distance*8;
		if(skill == 2) truckerprize[playerid] = distance*8 + (distance*8)*(10/100);
		if(skill == 3) truckerprize[playerid] = distance*8 + (distance*8)*(20/100);
		if(skill == 4) truckerprize[playerid] = distance*8 + (distance*8)*(30/100);
		if(skill == 5) truckerprize[playerid] = distance*8 + (distance*8)*(40/100);
		if(skill == 6) truckerprize[playerid] = distance*8 + (distance*8)*(50/100);
		
		new str[1800];
	    format(str, sizeof(str), "Skill: %d (%d/%d runde efectuate)~n~Bani castigati: %d$~n~Place: %s", skill, remain, forup, TruckerCash[playerid], GetPlayerZone(RandomTrucker[rand][0], RandomTrucker[rand][1], RandomTrucker[rand][2]));
	    PlayerTextDrawSetString(playerid, Jobs2[1], str);
	}
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if(result == -1)
	{
		InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~This command has not found!~n~~w~~h~Please try ~y~~h~/help~w~~h~ or ask an admin/helper for support!");
		return 0;
	}
    return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	new skill, remain, forup;
	GetBusDriverSkill(playerid, skill, remain, forup);

	if(CP[playerid] == 100)
	{
	    if(skill == 1)
	    {
	        new randmoney = random(3000);
	        new randpersons = random(5);
	        switch(randpersons)
	        {
	            case 0: randpersons = 6;
	            case 1: randpersons = 15;
	            case 2: randpersons = 4;
	            case 3: randpersons = 9;
	            case 4: randpersons = 12;
	        }
	        GivePlayerMoney(playerid, randmoney);
	        BusDriverCash[playerid] = BusDriverCash[playerid] + randmoney;

	        TogglePlayerControllable(playerid, 0);
	        SetTimerEx("UnFreeze", 3000, false, "i", playerid);

	    }
	    else if(skill == 2)
	    {
	        new randmoney = random(4000);
	        new randpersons = random(5);
	        switch(randpersons)
	        {
	            case 0: randpersons = 6;
	            case 1: randpersons = 15;
	            case 2: randpersons = 4;
	            case 3: randpersons = 9;
	            case 4: randpersons = 12;
	        }
	        GivePlayerMoney(playerid, randmoney);
	        BusDriverCash[playerid] = BusDriverCash[playerid] + randmoney;

	        TogglePlayerControllable(playerid, 0);
	        SetTimerEx("UnFreeze", 3000, false, "i", playerid);

	    }
	    else if(skill == 3)
	    {
	        new randmoney = random(4500);
	        new randpersons = random(5);
	        switch(randpersons)
	        {
	            case 0: randpersons = 6;
	            case 1: randpersons = 15;
	            case 2: randpersons = 4;
	            case 3: randpersons = 9;
	            case 4: randpersons = 12;
	        }
	        GivePlayerMoney(playerid, randmoney);
	        BusDriverCash[playerid] = BusDriverCash[playerid] + randmoney;

	        TogglePlayerControllable(playerid, 0);
	        SetTimerEx("UnFreeze", 3000, false, "i", playerid);

	    }
	    else if(skill == 4)
	    {
	        new randmoney = random(5000);
	        new randpersons = random(5);
	        switch(randpersons)
	        {
	            case 0: randpersons = 6;
	            case 1: randpersons = 15;
	            case 2: randpersons = 4;
	            case 3: randpersons = 9;
	            case 4: randpersons = 12;
	        }
	        GivePlayerMoney(playerid, randmoney);
	        BusDriverCash[playerid] = BusDriverCash[playerid] + randmoney;

	        TogglePlayerControllable(playerid, 0);
	        SetTimerEx("UnFreeze", 3000, false, "i", playerid);

	    }
	    else if(skill == 5)
	    {
	        new randmoney = random(5500);
	        new randpersons = random(5);
	        switch(randpersons)
	        {
	            case 0: randpersons = 6;
	            case 1: randpersons = 15;
	            case 2: randpersons = 4;
	            case 3: randpersons = 9;
	            case 4: randpersons = 12;
	        }
	        GivePlayerMoney(playerid, randmoney);
	        BusDriverCash[playerid] = BusDriverCash[playerid] + randmoney;

	        TogglePlayerControllable(playerid, 0);
	        SetTimerEx("UnFreeze", 3000, false, "i", playerid);

	    }
	    else if(skill == 6)
	    {
	        new randmoney = random(6000);
	        new randpersons = random(5);
	        switch(randpersons)
	        {
	            case 0: randpersons = 6;
	            case 1: randpersons = 15;
	            case 2: randpersons = 4;
	            case 3: randpersons = 9;
	            case 4: randpersons = 12;
	        }
	        GivePlayerMoney(playerid, randmoney);
	        BusDriverCash[playerid] = BusDriverCash[playerid] + randmoney;

	        TogglePlayerControllable(playerid, 0);
	        SetTimerEx("UnFreeze", 3000, false, "i", playerid);

	    }
	    Statii[playerid]++;
	    JobStep[playerid]++;
	    
	    new str[1800];
	    format(str, sizeof(str), "Skill: %d (%d/%d runde efectuate)~n~Bani castigati: %d$~n~Opriri la statii: %d", skill, remain, forup, BusDriverCash[playerid], Statii);
	    PlayerTextDrawSetString(playerid, Jobs2[1], str);

	    if(JobStep[playerid] == 1) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1941.3706,-2169.2083,13.4851,1964.6262,-1899.2827,13.4838,4.0);
	    if(JobStep[playerid] == 2) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1964.6262,-1899.2827,13.4838,1921.6910,-1749.1346,13.4828,4.0);
	    if(JobStep[playerid] == 3) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1921.6910,-1749.1346,13.4828,1819.4100,-1814.2385,13.5056,4.0);
	    if(JobStep[playerid] == 4) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1819.4100,-1814.2385,13.5056,1692.2909,-1764.9092,13.4875,4.0);
	    if(JobStep[playerid] == 5) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1692.2909,-1764.9092,13.4875,1395.2542,-1729.2012,13.4901,4.0);
	    if(JobStep[playerid] == 6) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1395.2542,-1729.2012,13.4901,1315.4188,-1631.5197,13.4827,4.0);
	    if(JobStep[playerid] == 7) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1315.4188,-1631.5197,13.4827,1325.5859,-1392.4742,13.4741,4.0);
	    if(JobStep[playerid] == 8) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1325.5859,-1392.4742,13.4741,1209.0767,-1324.8274,13.5002,4.0);
	    if(JobStep[playerid] == 9) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1209.0767,-1324.8274,13.5002,1082.8730,-1277.8145,13.5019,4.0);
	    if(JobStep[playerid] == 10) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1082.8730,-1277.8145,13.5019,966.0933,-1218.3807,16.8770,4.0);
	    if(JobStep[playerid] == 11) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 966.0933,-1218.3807,16.8770,818.9665,-1137.8669,23.8506,4.0);
	    if(JobStep[playerid] == 12) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 818.9665,-1137.8669,23.8506,794.1818,-1301.3213,13.4795,4.0);
	    if(JobStep[playerid] == 13) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 794.1818,-1301.3213,13.4795,678.5087,-1392.8485,13.5081,4.0);
	    if(JobStep[playerid] == 14) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 678.5087,-1392.8485,13.5081,380.8662,-1492.7212,32.2020,4.0);
	    if(JobStep[playerid] == 15) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 380.8662,-1492.7212,32.2020,258.5574,-1537.6969,32.3608,4.0);
	    if(JobStep[playerid] == 16) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 258.5574,-1537.6969,32.3608,484.7990,-1357.7792,17.9893,4.0);
	    if(JobStep[playerid] == 17) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 484.7990,-1357.7792,17.9893,588.3983,-1232.8560,17.8009,4.0);
	    if(JobStep[playerid] == 18) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 588.3983,-1232.8560,17.8009,774.5882,-1058.5305,24.5938,4.0);
	    if(JobStep[playerid] == 19) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 774.5882,-1058.5305,24.5938,1209.5120,-948.5093,42.8005,4.0);
	    if(JobStep[playerid] == 20) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1209.5120,-948.5093,42.8005,1566.5400,-997.7548,45.7116,4.0);
	    if(JobStep[playerid] == 21) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1566.5400,-997.7548,45.7116,1709.9061,-733.8804,50.0985,4.0);
	    if(JobStep[playerid] == 22) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1709.9061,-733.8804,50.0985,1658.8318,-43.4300,36.4876,4.0);
	    if(JobStep[playerid] == 23) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1658.8318,-43.4300,36.4876,1772.3663,581.9141,23.7034,4.0);
	    if(JobStep[playerid] == 24) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1772.3663,581.9141,23.7034,1841.4648,829.6874,9.9861,4.0);
	    if(JobStep[playerid] == 25) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1841.4648,829.6874,9.9861,2187.5762,806.9039,7.2061,4.0);
	    if(JobStep[playerid] == 26) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 2187.5762,806.9039,7.2061,2290.9165,841.0883,13.9592,4.0);
	    if(JobStep[playerid] == 27) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 2290.9165,841.0883,13.9592,2350.4082,1025.8792,10.7723,4.0);
	    if(JobStep[playerid] == 28) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 2350.4082,1025.8792,10.7723,2570.7004,1070.5811,10.7773,4.0);
	    if(JobStep[playerid] == 29) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 2570.7004,1070.5811,10.7773,2613.5254,1315.6500,10.7696,4.0);
	    if(JobStep[playerid] == 30) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 2613.5254,1315.6500,10.7696,2476.1697,1476.3761,10.7715,4.0);
	    if(JobStep[playerid] == 31) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 2476.1697,1476.3761,10.7715,2401.2478,1616.5609,10.7727,4.0);
	    if(JobStep[playerid] == 32) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 2401.2478,1616.5609,10.7727,2291.8828,1775.9521,10.7812,4.0);
	    if(JobStep[playerid] == 33) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 2291.8828,1775.9521,10.7812,2154.7061,1996.3882,10.7744,4.0);
	    if(JobStep[playerid] == 34) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 2154.7061,1996.3882,10.7744,2228.1877,2386.0630,10.7777,4.0);
	    if(JobStep[playerid] == 35) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 2228.1877,2386.0630,10.7777,2086.0520,2456.9954,10.8048,4.0);
	    if(JobStep[playerid] == 36) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 2086.0520,2456.9954,10.8048,1948.1777,2396.3440,10.7688,4.0);
	    if(JobStep[playerid] == 37) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1948.1777,2396.3440,10.7688,1922.7677,2317.8069,10.8393,4.0);
	    if(JobStep[playerid] == 38) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1922.7677,2317.8069,10.8393,1922.8735,2117.9375,10.8652,4.0);
	    if(JobStep[playerid] == 39) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1922.8735,2117.9375,10.8652,2093.9612,2017.9711,10.8407,4.0);
	    if(JobStep[playerid] == 40) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 2093.9612,2017.9711,10.8407,2039.7142,1522.0779,10.7595,4.0);
	    if(JobStep[playerid] == 41) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 2039.7142,1522.0779,10.7595,2040.6129,1169.0469,10.7807,4.0);
	    if(JobStep[playerid] == 42) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 2040.6129,1169.0469,10.7807,2038.9994,878.8145,7.1755,4.0);
	    if(JobStep[playerid] == 43) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 2038.9994,878.8145,7.1755,1755.5402,619.8901,21.3552,4.0);
	    if(JobStep[playerid] == 44) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1755.5402,619.8901,21.3552,1619.3414,186.8276,33.5024,4.0);
	    if(JobStep[playerid] == 45) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1619.3414,186.8276,33.5024,1659.4628,-329.5979,40.4135,4.0);
	    if(JobStep[playerid] == 46) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1659.4628,-329.5979,40.4135,1688.2992,-728.0701,49.8404,4.0);
	    if(JobStep[playerid] == 47) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1688.2992,-728.0701,49.8404,1412.3439,-937.3050,35.6120,4.0);
	    if(JobStep[playerid] == 48) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1412.3439,-937.3050,35.6120,1432.5333,-1037.7094,23.7933,4.0);
	    if(JobStep[playerid] == 49) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1432.5333,-1037.7094,23.7933,1574.0338,-1138.6904,23.6757,4.0);
	    if(JobStep[playerid] == 50) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1574.0338,-1138.6904,23.6757,1711.5553,-1263.2328,13.4910,4.0);
	    if(JobStep[playerid] == 51) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1711.5553,-1263.2328,13.4910,1590.8885,-1437.7626,13.4817,4.0);
	    if(JobStep[playerid] == 52) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1590.8885,-1437.7626,13.4817,1428.2323,-1567.3893,13.4529,4.0);
	    if(JobStep[playerid] == 53) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1428.2323,-1567.3893,13.4529,1446.8442,-1735.5527,13.4789,4.0);
	    if(JobStep[playerid] == 54) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1446.8442,-1735.5527,13.4789,1580.1357,-1874.8420,13.4791,4.0);
	    if(JobStep[playerid] == 55) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1580.1357,-1874.8420,13.4791,1818.1030,-1904.3914,13.5025,4.0);
	    if(JobStep[playerid] == 56) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1818.1030,-1904.3914,13.5025,1958.2472,-1999.3572,13.4949,4.0);
	    if(JobStep[playerid] == 57) CP[playerid] = 100, SetPlayerRaceCheckpoint(playerid, 0, 1958.2472,-1999.3572,13.4949,1936.2253,-2163.5068,13.4765,4.0);
		if(JobStep[playerid] == 58)
		{
		    CP[playerid] = 0;
			DisablePlayerCheckpoint(playerid);

			Statii[playerid] = 0;
			JobStep[playerid] = 0;
			BusDriverCash[playerid] = 0;
			
			PlayerTextDrawHide(playerid, Jobs2[0]);
			PlayerTextDrawHide(playerid, Jobs2[1]);
			
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			
			PlayerInfo[playerid][BusDriverSkill]++;
			Update(playerid, BusDriverSkillx);
		}
	}
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
	if(PlayerInfo[playerid][hasTazer] == 1 && weaponid == 23 && PlayerInfo[damagedid][isTazed] == 0)
	{
	    new Float:hp;
		GetPlayerHealth(damagedid, hp);
		
	    if(hp < 10) SetPlayerHealth(damagedid, 10);

	    TogglePlayerControllable(damagedid, 0);
	    ApplyAnimation(damagedid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
	    SetTimerEx_("Unfreeze", (10 * 1000), false, -1, "i", damagedid);
	    PlayerInfo[damagedid][isTazed] = 1;
	    
		kStr[0] = EOS;
		format(kStr, sizeof(kStr), "%s has been tased by %s %s.", GetName(damagedid), GetPlayerRank(playerid), GetName(playerid));
		ProxDetector(30.0, playerid, kStr, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
	}
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_NO)
	{
		new vehid = GetClosestVehicleToPlayer(playerid);
		if(vehid == -1 || VehInfo[vehid][Owner] != PlayerInfo[playerid][ID]) return 1;
		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(vehid, engine, lights, alarm, doors, bonnet, boot, objective);
		if(doors == 0) SetVehicleParamsEx(vehid, engine, lights, alarm, 1, bonnet, boot, objective), GameTextForPlayer(playerid, "~w~Vehicle ~n~~r~Locked", 5000, 4);
		if(doors == 1) SetVehicleParamsEx(vehid, engine, lights, alarm, 0, bonnet, boot, objective), GameTextForPlayer(playerid, "~w~Vehicle ~n~~g~Unlocked", 5000, 4);
	}
	if(IsPlayerInAnyVehicle(playerid))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		new vehicle = GetVehicleModel(vehicleid) - 400;
	    if(newkeys & KEY_SUBMISSION && !IsABike(vehicleid))
	    {
	        if(vehicleid == INVALID_VEHICLE_ID) return 1;
			new engine, lights, alarm, doors, bonnet, boot, objective;

	        GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	        if(EngineVehicle[vehicleid] == 0)
	        {
	            SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
	            EngineVehicle[vehicleid] = 1;

	            new string[128];
	            format(string, sizeof(string), "* %s porneste motorul vehiculului %s", GetName(playerid), VehicleNames[vehicle]);
			    ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
	        }
	        else if(EngineVehicle[vehicleid] == 1)
	        {
	            SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);
	            EngineVehicle[vehicleid] = 0;

	            new string[128];
	            format(string, sizeof(string), "* %s opreste motorul vehiculului %s", GetName(playerid), VehicleNames[vehicle]);
			    ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
	        }
	    }
	}
    if(newkeys & KEY_FIRE && PlayerInfo[playerid][Registered] == 0)
    {
        if(FirstPress[playerid] == 0)
        {
        	InterpolateCameraPos(playerid, 1772.629028, -1813.489990, 45.188911, 1610.144897, -2265.480224, 22.239614, 5000);
			InterpolateCameraLookAt(playerid, 1770.010620, -1817.109985, 42.944004, 1613.875000, -2262.500000, 20.754552, 5000);
			FirstPress[playerid] = 1;
			SpawnChoose[playerid] = 1;
		}
		else if(FirstPress[playerid] == 1)
        {
        	InterpolateCameraPos(playerid, 1610.144897, -2265.480224, 22.239614, 1772.629028, -1813.489990, 45.188911, 5000);
			InterpolateCameraLookAt(playerid, 1613.875000, -2262.500000, 20.754552, 1770.010620, -1817.109985, 42.944004, 5000);
			FirstPress[playerid] = 0;
			SpawnChoose[playerid] = 2;
		}
    }
    if(newkeys & KEY_SECONDARY_ATTACK && PlayerInfo[playerid][Registered] == 0)
    {
        if(FirstPress[playerid] == 0)
        {
            PlayerInfo[playerid][SpawnX] = 1743.1216;
            PlayerInfo[playerid][SpawnY] = -1860.9050;
            PlayerInfo[playerid][SpawnZ] = 13.5782;
            PlayerInfo[playerid][SpawnA] = 359.0600;

            Update(playerid, SpawnXx);
            Update(playerid, SpawnYx);
            Update(playerid, SpawnZx);
            Update(playerid, SpawnAx);

            SetSpawnPlayer(playerid);
        }
        else if(FirstPress[playerid] == 1)
        {
            PlayerInfo[playerid][SpawnX] = 1642.4734;
            PlayerInfo[playerid][SpawnY] = -2239.2910;
            PlayerInfo[playerid][SpawnZ] = 13.5285;
            PlayerInfo[playerid][SpawnA] = 359.6730;

            Update(playerid, SpawnXx);
            Update(playerid, SpawnYx);
            Update(playerid, SpawnZx);
            Update(playerid, SpawnAx);

            SetSpawnPlayer(playerid);
        }
    }
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && Speedlimit[playerid] > 0)
    {
        new a, b, c;
        GetPlayerKeys(playerid, a, b ,c);
        
        if(a == 8 && GetVehSpeed(GetPlayerVehicleID(playerid)) > Speedlimit[playerid])
        {
            new newspeed = GetVehSpeed(GetPlayerVehicleID(playerid)) - Speedlimit[playerid];
            ModifyVehicleSpeed(GetPlayerVehicleID(playerid), -newspeed);
        }
    }
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DIALOG_JOBS:
	    {
	        switch(listitem)
		 	{
	            case 0: SetPlayerCheckpoint(playerid, -373.7780,-1427.8170,25.7266, 4.0);
				case 1: SetPlayerCheckpoint(playerid, 1642.3353,-2238.9849,13.4969, 4.0);
	 			case 2: SetPlayerCheckpoint(playerid, 2107.5979,-1788.2808,13.5608, 4.0);
	 			case 3: SetPlayerCheckpoint(playerid, 2433.3757,-2115.3381,13.5469, 4.0);
			}
	        return 1;
	    }
        case DIALOG_GOTOINT:
        {
            if(!response) return SCM(playerid, COLOR_OR, "AdmCmd: You have canceled the teleport.");
            
            switch(listitem)
            {
                case 0:
                {
                    SetPlayerPos(playerid, -25.884498,-185.868988,1003.546875);
                    SetPlayerInterior(playerid, 17);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to 24/7 1");
                    return 1;
                }
                case 1:
                {
                    SetPlayerPos(playerid, 6.091179,-29.271898,1003.549438);
                    SetPlayerInterior(playerid, 10);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to 24/7 2");
                    return 1;
                }
                case 2:
                {
                    SetPlayerPos(playerid, -30.946699,-89.609596,1003.546875);
                    SetPlayerInterior(playerid, 18);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to 24/7 3");
                    return 1;
                }
                case 3:
                {
                    SetPlayerPos(playerid, -25.132598,-139.066986,1003.546875);
                    SetPlayerInterior(playerid, 16);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to 24/7 4");
                    return 1;
                }
                case 4:
                {
                    SetPlayerPos(playerid, -27.312299,-29.277599,1003.557250);
                    SetPlayerInterior(playerid, 4);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to 24/7 5");
                    return 1;
                }
                case 5:
                {
                    SetPlayerPos(playerid, -26.691598,-55.714897,1003.546875);
                    SetPlayerInterior(playerid, 6);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to 24/7 6");
					return 1;
                }
                case 6:
                {
                    SetPlayerPos(playerid, -1827.147338,7.207417,1061.143554);
                    SetPlayerInterior(playerid, 14);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Airoport Ticket Desk");
					return 1;
                }
                case 7:
                {
                    SetPlayerPos(playerid, -1861.936889,54.908092,1061.143554);
                    SetPlayerInterior(playerid, 14);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Airoport Baggage Reclaim");
					return 1;
                }
                case 8:
                {
                    SetPlayerPos(playerid, 1.808619,32.384357,1199.593750);
                    SetPlayerInterior(playerid, 1);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Shamal");
					return 1;
                }
                case 9:
                {
                    SetPlayerPos(playerid, 315.745086,984.969299,1958.919067);
                    SetPlayerInterior(playerid, 9);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Andromada");
					return 1;
                }
                case 10:
                {
                    SetPlayerPos(playerid, 286.148986,-40.644397,1001.515625);
                    SetPlayerInterior(playerid, 1);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Ammunation 1");
					return 1;
                }
                case 11:
                {
                    SetPlayerPos(playerid, 286.800994,-82.547599,1001.515625);
                    SetPlayerInterior(playerid, 4);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Ammunation 2");
					return 1;
                }
                case 12:
                {
                    SetPlayerPos(playerid, 296.919982,-108.071998,1001.515625);
                    SetPlayerInterior(playerid, 6);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Ammunation 3");
					return 1;
                }
                case 13:
                {
                    SetPlayerPos(playerid, 314.820983,-141.431991,999.601562);
                    SetPlayerInterior(playerid, 7);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Ammunation 4");
					return 1;
                }
                case 14:
                {
                    SetPlayerPos(playerid, 316.524993,-167.706985,999.593750);
                    SetPlayerInterior(playerid, 6);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Ammunation 5");
					return 1;
                }
                case 15:
                {
                    SetPlayerPos(playerid, 302.292877,-143.139099,1004.062500);
                    SetPlayerInterior(playerid, 7);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Ammunation Booths");
					return 1;
                }
                case 16:
                {
                    SetPlayerPos(playerid, 298.507934,-141.647048,1004.054748);
                    SetPlayerInterior(playerid, 7);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Ammunation Range");
					return 1;
                }
                case 17:
                {
                    SetPlayerPos(playerid, 1038.531372,0.111030,1001.284484);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Blastin Fools Hallway");
					return 1;
                }
                case 18:
                {
                    SetPlayerPos(playerid, 444.646911,508.239044,1001.419494);
                    SetPlayerInterior(playerid, 12);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Budget Inn Motel Room");
					return 1;
                }
                case 19:
                {
                    SetPlayerPos(playerid, 2215.454833,-1147.475585,1025.796875);
                    SetPlayerInterior(playerid, 14);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Jefferson Motel");
					return 1;
                }
                case 20:
                {
                    SetPlayerPos(playerid, 833.269775,10.588416,1004.179687);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Off Track Betting Shop");
					return 1;
                }
                case 21:
                {
                    SetPlayerPos(playerid, -103.559165,-24.225606,1000.718750);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Sex Shop");
					return 1;
                }
                case 22:
                {
                    SetPlayerPos(playerid, 963.418762,2108.292480,1011.030273);
                    SetPlayerInterior(playerid, 1);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Meat Factory");
					return 1;
                }
                case 23:
                {
                    SetPlayerPos(playerid, -2240.468505,137.060440,1035.414062);
                    SetPlayerInterior(playerid, 6);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Zero's RC Shop");
					return 1;
                }
                case 24:
                {
                    SetPlayerPos(playerid, 663.836242,-575.605407,16.343263);
                    SetPlayerInterior(playerid, 0);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Dillmore Gas Station");
					return 1;
                }
                case 25:
                {
                    SetPlayerPos(playerid, 2169.461181,1618.798339,999.976562);
                    SetPlayerInterior(playerid, 1);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Catigula's Basement");
					return 1;
                }
                    case 26:
                {
                    SetPlayerPos(playerid, 1889.953369,1017.438293,31.882812);
                    SetPlayerInterior(playerid, 10);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to FDC Janitors Room");
					return 1;
                }
                case 27:
                {
                    SetPlayerPos(playerid, -2159.122802,641.517517,1052.381713);
                    SetPlayerInterior(playerid, 1);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Woozie's Office");
					return 1;
                }
                case 28:
                {
                    SetPlayerPos(playerid, 207.737991,-109.019996,1005.132812);
                    SetPlayerInterior(playerid, 15);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Binco");
					return 1;
                }
                case 29:
                {
                    SetPlayerPos(playerid, 204.332992,-166.694992,1000.523437);
                    SetPlayerInterior(playerid, 14);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Didier Sachs");
					return 1;
                }
                case 30:
                {
                    SetPlayerPos(playerid, 207.054992,-138.804992,1003.507812);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Prolaps");
					return 1;
                }
                case 31:
                {
                    SetPlayerPos(playerid, 203.777999,-48.492397,1001.804687);
                    SetPlayerInterior(playerid, 1);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Suburban");
					return 1;
                }
                case 32:
                {
                    SetPlayerPos(playerid, 226.293991,-7.431529,1002.210937);
                    SetPlayerInterior(playerid, 5);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Victim");
					return 1;
                }
                case 33:
                {
                    SetPlayerPos(playerid, 161.391006,-93.159156,1001.804687);
                    SetPlayerInterior(playerid, 18);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to ZIP");
					return 1;
                }
                case 34:
                {
                    SetPlayerPos(playerid, 493.390991,-22.722799,1000.679687);
                    SetPlayerInterior(playerid, 17);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Alhambra");
					return 1;
                }
                case 35:
                {
                    SetPlayerPos(playerid, 501.980987,-69.150199,998.757812);
                    SetPlayerInterior(playerid, 11);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Ten Green Bottles");
					return 1;
                }
                case 36:
                {
                    SetPlayerPos(playerid, -227.027999,1401.229980,27.765625);
                    SetPlayerInterior(playerid, 18);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Lil' Probe Inn");
					return 1;
                }
                case 37:
                {
                    SetPlayerPos(playerid, 457.304748,-88.428497,999.554687);
                    SetPlayerInterior(playerid, 4);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Jay's Dinner");
					return 1;
                }
                case 38:
                {
                    SetPlayerPos(playerid, 454.973937,-110.104995,1000.077209);
                    SetPlayerInterior(playerid, 5);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Gant Bridge Dinner");
					return 1;
                }
                case 39:
                {
                    SetPlayerPos(playerid, 435.271331,-80.958938,999.554687);
                    SetPlayerInterior(playerid, 6);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Secret Valley Dinner");
					return 1;
                }
                case 40:
                {
                    SetPlayerPos(playerid, 452.489990,-18.179698,1001.132812);
                    SetPlayerInterior(playerid, 1);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to World of Coq");
					return 1;
                }
                case 41:
                {
                    SetPlayerPos(playerid, 681.557861,-455.680053,-25.609874);
                    SetPlayerInterior(playerid, 1);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Welcome Pump");
					return 1;
                }
                case 42:
                {
                    SetPlayerPos(playerid, 375.962463,-65.816848,1001.507812);
                    SetPlayerInterior(playerid, 10);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Burger Shot");
					return 1;
                }
                case 43:
                {
                    SetPlayerPos(playerid, 369.579528,-4.487294,1001.858886);
                    SetPlayerInterior(playerid, 9);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Cluckin' Bell");
					return 1;
                }
                case 44:
                {
                    SetPlayerPos(playerid, 373.825653,-117.270904,1001.499511);
                    SetPlayerInterior(playerid, 5);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Well Stacked Pizza");
					return 1;
                }
                case 45:
                {
                    SetPlayerPos(playerid, 381.169189,-188.803024,1000.632812);
                    SetPlayerInterior(playerid, 17);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Jimmy's Sticky Ring");
					return 1;
                }
                case 46:
                {
                    SetPlayerPos(playerid, 244.411987,305.032989,999.148437);
                    SetPlayerInterior(playerid, 1);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Denise Room");
					return 1;
                }
                case 47:
                {
                    SetPlayerPos(playerid, 271.884979,306.631988,999.148437);
                    SetPlayerInterior(playerid, 2);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Katie Room");
					return 1;
                }
                case 48:
                {
                    SetPlayerPos(playerid, 291.282989,310.031982,999.148437);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Helena Room");
					return 1;
                }
                case 49:
                {
                    SetPlayerPos(playerid, 302.180999,300.722991,999.148437);
                    SetPlayerInterior(playerid, 4);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Michelle Room");
					return 1;
                }
                case 50:
                {
                    SetPlayerPos(playerid, 322.197998,302.497985,999.148437);
                    SetPlayerInterior(playerid, 5);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Barbara Room");
					return 1;
                }
                case 51:
                {
                    SetPlayerPos(playerid, 346.870025,309.259033,999.155700);
                    SetPlayerInterior(playerid, 6);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Millie Room");
					return 1;
                }
                case 52:
                {
                    SetPlayerPos(playerid, -959.564392,1848.576782,9.000000);
                    SetPlayerInterior(playerid, 17);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Sherman Dam");
					return 1;
                }
                case 53:
                {
                    SetPlayerPos(playerid, 384.808624,173.804992,1008.382812);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Planning Dept.");
					return 1;
                }
                case 54:
                {
                    SetPlayerPos(playerid, 223.431976,1872.400268,13.734375);
                    SetPlayerInterior(playerid, 0);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Area 51");
					return 1;
                }
                case 55:
                {
                    SetPlayerPos(playerid, 772.111999,-3.898649,1000.728820);
                    SetPlayerInterior(playerid, 5);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to LS Gym");
					return 1;
                }
                case 56:
                {
                    SetPlayerPos(playerid, 774.213989,-48.924297,1000.585937);
                    SetPlayerInterior(playerid, 6);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to SF Gym");
					return 1;
                }
                case 57:
                {
                    SetPlayerPos(playerid, 773.579956,-77.096694,1000.655029);
                    SetPlayerInterior(playerid, 7);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to LV Gym");
					return 1;
                }
                case 58:
                {
                    SetPlayerPos(playerid, 1527.229980,-11.574499,1002.097106);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to B Dup's House");
					return 1;
                }
                case 59:
                {
                    SetPlayerPos(playerid, 1523.509887,-47.821197,1002.130981);
                    SetPlayerInterior(playerid, 2);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to B Dup's Crack Pad");
					return 1;
                }
                case 60:
                {
                    SetPlayerPos(playerid, 2496.049804,-1695.238159,1014.742187);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to CJ's House");
					return 1;
                }
                case 61:
                {
                    SetPlayerPos(playerid, 1267.663208,-781.323242,1091.906250);
                    SetPlayerInterior(playerid, 5);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Madd Dogg's Mansion");
					return 1;
                }
                case 62:
                {
                    SetPlayerPos(playerid, 513.882507,-11.269994,1001.565307);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to OG Loc's House");
					return 1;
                }
                case 63:
                {
                    SetPlayerPos(playerid, 2454.717041,-1700.871582,1013.515197);
                    SetPlayerInterior(playerid, 2);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Ryder's House");
					return 1;
                }
                case 64:
                {
                    SetPlayerPos(playerid, 2527.654052,-1679.388305,1015.498596);
                    SetPlayerInterior(playerid, 1);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Sweet's House");
					return 1;
                }
                case 65:
                {
                    SetPlayerPos(playerid, 2543.462646,-1308.379882,1026.728393);
                    SetPlayerInterior(playerid, 2);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Crack Factory");
					return 1;
                }
                case 66:
                {
                    SetPlayerPos(playerid, 1212.019897,-28.663099,1000.953125);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Big Spread Ranch");
					return 1;
                }
                case 67:
                {
                    SetPlayerPos(playerid, 761.412963,1440.191650,1102.703125);
                    SetPlayerInterior(playerid, 6);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Fanny Batters");
					return 1;
                }
                case 68:
                {
                    SetPlayerPos(playerid, 1204.809936,-11.586799,1000.921875);
                    SetPlayerInterior(playerid, 2);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Strip Club");
					return 1;
                }
                case 69:
                {
                    SetPlayerPos(playerid, 1204.809936,13.897239,1000.921875);
                    SetPlayerInterior(playerid, 2);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Strip Club Private Room");
					return 1;
                }
                case 70:
                {
                    SetPlayerPos(playerid, 942.171997,-16.542755,1000.929687);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Unnamed Brothel");
					return 1;
                }
                case 71:
                {
                    SetPlayerPos(playerid, 964.106994,-53.205497,1001.124572);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Tiger Skin Brothel");
					return 1;
                }
                case 72:
                {
                    SetPlayerPos(playerid, -2640.762939,1406.682006,906.460937);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Pleasure Domes");
					return 1;
                }
                case 73:
                {
                    SetPlayerPos(playerid, -729.276000,503.086944,1371.971801);
                    SetPlayerInterior(playerid, 1);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Liberty City Outside");
					return 1;
                }
                case 74:
                {
                    SetPlayerPos(playerid, -794.806396,497.738037,1376.195312);
                    SetPlayerInterior(playerid, 1);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Liberty City Inside");
					return 1;
                }
                case 75:
                {
                    SetPlayerPos(playerid,  2350.339843,-1181.649902,1027.976562);
                    SetPlayerInterior(playerid, 5);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Gang House");
					return 1;
                }
                case 76:
                {
                    SetPlayerPos(playerid, 2807.619873,-1171.899902,1025.570312);
                    SetPlayerInterior(playerid, 8);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Colonel Furhberger's House");
					return 1;
                }
                case 77:
                {
                    SetPlayerPos(playerid, 18.564971,1118.209960,1083.882812);
                    SetPlayerInterior(playerid, 5);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Crack Den");
					return 1;
                }
                case 78:
                {
                    SetPlayerPos(playerid, 1412.639892,-1.787510,1000.924377);
                    SetPlayerInterior(playerid, 1);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Warehouse 1");
					return 1;
                }
                case 79:
                {
                    SetPlayerPos(playerid, 1302.519897,-1.787510,1001.028259);
                    SetPlayerInterior(playerid, 18);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Warehouse 2");
					return 1;
                }
                case 80:
                {
                    SetPlayerPos(playerid, 2522.000000,-1673.383911,14.866223);
                    SetPlayerInterior(playerid, 0);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Sweet's Garage");
					return 1;
                }
                case 81:
                {
                    SetPlayerPos(playerid, -221.059051,1408.984008,27.773437);
                    SetPlayerInterior(playerid, 18);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Lil' Probe Inn Toilet");
					return 1;
                }
                case 82:
                {
                    SetPlayerPos(playerid, 2324.419921,-1145.568359,1050.710083);
                    SetPlayerInterior(playerid, 12);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Unused Safe House");
					return 1;
                }
                case 83:
                {
                    SetPlayerPos(playerid, -975.975708,1060.983032,1345.671875);
                    SetPlayerInterior(playerid, 10);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to RC Battlefield");
					return 1;
                }
                case 84:
                {
                    SetPlayerPos(playerid, 411.625976,-21.433298,1001.804687);
                    SetPlayerInterior(playerid, 2);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Barber 1");
					return 1;
                }
                case 85:
                {
                    SetPlayerPos(playerid, 418.652984,-82.639793,1001.804687);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Barber 2");
					return 1;
                }
                case 86:
                {
                    SetPlayerPos(playerid, 412.021972,-52.649898,1001.898437);
                    SetPlayerInterior(playerid, 12);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Barber 3");
					return 1;
                }
                case 87:
                {
                    SetPlayerPos(playerid, -204.439987,-26.453998,1002.273437);
                    SetPlayerInterior(playerid, 16);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Tatoo Parlour 1");
					return 1;
                }
                case 88:
                {
                    SetPlayerPos(playerid, -204.439987,-8.469599,1002.273437);
                    SetPlayerInterior(playerid, 17);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Tatoo Parlour 2");
					return 1;
                }
                case 89:
                {
                    SetPlayerPos(playerid, -204.439987,-43.652496,1002.273437);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Tatoo Parlour 3");
					return 1;
                }
                case 90:
                {
                    SetPlayerPos(playerid, 246.783996,63.900199,1003.640625);
                    SetPlayerInterior(playerid, 6);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to LS Police HQ");
					return 1;
                }
                case 91:
                {
                    SetPlayerPos(playerid, 246.375991,109.245994,1003.218750);
                    SetPlayerInterior(playerid, 10);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to SF police HQ");
					return 1;
                }
                case 92:
                {
                    SetPlayerPos(playerid, 288.745971,169.350997,1007.171875);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to LV police HQ");
					return 1;
                }
                case 93:
                {
                    SetPlayerPos(playerid, -2029.798339,-106.675910,1035.171875);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Car School");
					return 1;
                }
                case 94:
                {
                    SetPlayerPos(playerid, -1398.065307,-217.028900,1051.115844);
                    SetPlayerInterior(playerid, 7);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to 8-Track");
					return 1;
                }
                case 95:
                {
                    SetPlayerPos(playerid, -1398.103515,937.631164,1036.479125);
                    SetPlayerInterior(playerid, 15);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Bloodbowl");
					return 1;
                }
                case 96:
                {
                    SetPlayerPos(playerid, -1444.645507,-664.526000,1053.572998);
                    SetPlayerInterior(playerid, 4);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Dirt Track");
					return 1;
                }
                case 97:
                {
                    SetPlayerPos(playerid, -1465.268676,1557.868286,1052.531250);
                    SetPlayerInterior(playerid, 14);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Kickstart");
					return 1;
                }
                case 98:
                {
                    SetPlayerPos(playerid, -1401.829956,107.051300,1032.273437);
                    SetPlayerInterior(playerid, 1);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Vice Stadium");
					return 1;
                }
                case 99:
                {
                    SetPlayerPos(playerid, -1790.378295,1436.949829,7.187500);
                    SetPlayerInterior(playerid, 0);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to SF Garage");
					return 1;
                }
                case 100:
                {
                    SetPlayerPos(playerid, 1643.839843,-1514.819580,13.566620);
                    SetPlayerInterior(playerid, 0);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to LS Garage");
					return 1;
                }
                case 101:
                {
                    SetPlayerPos(playerid, -1685.636474,1035.476196,45.210937);
                    SetPlayerInterior(playerid, 0);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to SF Bomb Shop");
					return 1;
                }
                case 102:
                {
                    SetPlayerPos(playerid, 76.632553,-301.156829,1.578125);
                    SetPlayerInterior(playerid, 0);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Blueberry Warehouse");
					return 1;
                }
                case 103:
                {
                    SetPlayerPos(playerid, 1059.895996,2081.685791,10.820312);
                    SetPlayerInterior(playerid, 0);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to LV Warehouse 1");
					return 1;
                }
                case 104:
                {
                    SetPlayerPos(playerid, 1059.180175,2148.938720,10.820312);
                    SetPlayerInterior(playerid, 0);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to LV Warehouse 2");
					return 1;
                }
                case 105:
                {
                    SetPlayerPos(playerid, 2131.507812,1600.818481,1008.359375);
                    SetPlayerInterior(playerid, 1);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Catigula's Hidden Room");
					return 1;
                }
                case 106:
                {
                    SetPlayerPos(playerid, 2315.952880,-1.618174,26.742187);
                    SetPlayerInterior(playerid, 0);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Bank");
					return 1;
                }
                case 107:
                {
                    SetPlayerPos(playerid, 2319.714843,-14.838361,26.749565);
                    SetPlayerInterior(playerid, 0);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Bank - Behind Desk");
					return 1;
                }
                case 108:
                {
                    SetPlayerPos(playerid, 1710.433715,-1669.379272,20.225049);
                    SetPlayerInterior(playerid, 18);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to LS Atruim");
					return 1;
                }
                case 109:
                {
                    SetPlayerPos(playerid, 1494.325195,1304.942871,1093.289062);
                    SetPlayerInterior(playerid, 3);
                    SCM(playerid, COLOR_OR, "AdmCmd: You have been teleported to Bike School");
					return 1;
                }
            }
        }
	    case DIALOG_REGISTER:
	    {
	        if(response)
	        {
	            if(AccountExists(playerid) > 0)
	            {
					format(kStr, sizeof(kStr), ""D"Bine ai revenit %s pe serverul nostru!\nPentru a continua te rugam sa introduci parola cu care te-ai inregistrat!\n\nIntroducerea parolei este necesara pentru securitatea acestui cont.\nUltima la autentificare pe server: %s", GetCleanName(playerid), LStr);
	    			SPD(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Autentifica-te pe acest cont", kStr, "Ok", "Quit");
	            }
	            else
	            {
		            SCM(playerid, COLOR_SERVER, "SERVER: {FFFFFF}Ti-ai setat limba natala ca fiind limba 'Romana'.");

		            PlayerInfo[playerid][Lang] = 1;
		            kStr[0] = EOS;
		            format(kStr, sizeof(kStr), "Bine ai venit %s pe serverul UNNIC RPG!\n\nPentru a continua te rugam sa introduci o parola pentru a te inregistra.\nAi grija ca parola sa fie cat mai complexa ca sa nu intampini dificulatiti cu contul.");
		            SPD(playerid, DIALOG_REGISTER + 1, DIALOG_STYLE_PASSWORD, "Inregistrare", kStr, "Ok", "");
	            }
	        }
	        else if(!response)
	        {
	            if(AccountExists(playerid) > 0)
	            {
					format(kStr, sizeof(kStr), ""D"Welcome back %s on our server!\nTo continue please type your password that you registered on this server!\n\nThe password is necessary to protect this account.\nYour last login on this server: %s", GetCleanName(playerid), LStr);
	    			SPD(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login on this account", kStr, "Ok", "Quit");
	            }
	            else
	            {
		            SCM(playerid, COLOR_SERVER, "SERVER: {FFFFFF}You have set your language to 'English'.");

		            PlayerInfo[playerid][Lang] = 2;

		            kStr[0] = EOS;
		            format(kStr, sizeof(kStr), "Welcome %s on UNNIC RPG server!\n\nTo continue please insert a password for register.\nMake sure the password to be as complex as not to encounter problems with your account.");
		            SPD(playerid, DIALOG_REGISTER + 1, DIALOG_STYLE_PASSWORD, "Register", kStr, "Ok", "");
	            }
	        }
	    }
		case DIALOG_REGISTER + 1:
		{
		    if(PlayerInfo[playerid][Lang] == 1)
		    {
		    	if(!strlen(inputtext)) return SPD(playerid, DIALOG_REGISTER + 1, DIALOG_STYLE_PASSWORD, "Inregistrare", "Nu ai introdus nici o parola.\n\nTrebuie sa introduci o parola pentru a continua.", "Ok", "");
		    	if(strlen(inputtext) < 6 || strlen(inputtext) > 40) return SPD(playerid, DIALOG_REGISTER + 1, DIALOG_STYLE_PASSWORD, "Inregistrare", "Ai introdus o parola prea mica sau prea mare.\n\nIntrodu o parola cuprinsa intre 6-40 caractere!", "Ok", "");

				kStr[0] = EOS;
				format(kStr, sizeof(kStr), "SERVER: {FFFFFF}Parola acestui cont este acum '%s'.", inputtext);
				SCM(playerid, COLOR_SERVER, kStr);

				new Security[60];
				query[0] = EOS;
				mysql_escape_string(inputtext, Security);
				mysql_format(mysql, query, sizeof(query), "INSERT INTO `accounts` (`Name`, `Password`, `Email`) VALUES ('%s', '%s', 'nothing@email.com')", GetCleanName(playerid), Security);
				mysql_query(mysql, query);

				query[0] = EOS;
				format(query, sizeof(query), "UPDATE `server` SET `LastAccount` = '%s', `LastID` = (SELECT `ID` FROM `accounts` ORDER BY `ID` DESC LIMIT 1)", GetCleanName(playerid));
				mysql_query(mysql, query);
				
				Update(playerid, Langx);

				SPD(playerid, DIALOG_REGISTER + 2, DIALOG_STYLE_INPUT, "Adresa ta de e-mail", "Te rugam sa introduci adresa ta de e-mail.\n\nAdresa de e-mail este necesara pentru securitatea contului!", "Ok", "");
			}
			else if(PlayerInfo[playerid][Lang] == 2)
		    {
		    	if(!strlen(inputtext)) return SPD(playerid, DIALOG_REGISTER + 1, DIALOG_STYLE_PASSWORD, "Register", "You not typed a password.\n\nYou must to insert a password to continue.", "Ok", "");
		    	if(strlen(inputtext) < 6 || strlen(inputtext) > 40) return SPD(playerid, DIALOG_REGISTER + 1, DIALOG_STYLE_PASSWORD, "Register", "You inserted a big or small password.\n\nInsert a password between 6-40 characters!", "Ok", "");

				kStr[0] = EOS;
				format(kStr, sizeof(kStr), "SERVER: {FFFFFF}Your account password is '%s' now.", inputtext);
				SCM(playerid, COLOR_SERVER, kStr);

				new Security[60];
				query[0] = EOS;
				mysql_escape_string(inputtext, Security);
				mysql_format(mysql, query, sizeof(query), "INSERT INTO `accounts` (`Name`, `Password`, `Email`) VALUES ('%s', '%s', 'nothing@email.com')", GetCleanName(playerid), Security);
				mysql_query(mysql, query);

				Update(playerid, Langx);

				query[0] = EOS;
				format(query, sizeof(query), "UPDATE `server` SET `LastAccount` = '%s', `LastID` = (SELECT `ID` FROM `accounts` ORDER BY `ID` DESC LIMIT 1)", GetCleanName(playerid));
				mysql_query(mysql, query);

				SPD(playerid, DIALOG_REGISTER + 2, DIALOG_STYLE_INPUT, "Your e-mail adress", "Please insert your e-mail adress.\n\nThe e-mail adress is neccessary for your security.", "Ok", "");
			}
		}
		case DIALOG_REGISTER + 2:
		{
		    if(PlayerInfo[playerid][Lang] == 1)
		    {
		        if(IsMail(inputtext) && response && strlen(inputtext) > 10)
		        {
		            if(strcmp(inputtext, "@yahoo.com", true) == 0 || strcmp(inputtext, "@yahoo.ro", true) == 0 || strcmp(inputtext, "@gmail.com", true) == 0 || strcmp(inputtext, "@gmail.ro", true) == 0)
		        	{
		            	SPD(playerid, DIALOG_REGISTER + 2, DIALOG_STYLE_INPUT, "Adresa ta de e-mail", "Adresa de e-mail care ai introdus-o nu este valida!\n\nTe rugam sa introduci o adresa de e-mail valida pentru a-ti proteja contul.", "Ok", "");
		            	return 1;
		        	}
		        	kStr[0] = EOS;
		        	query[0] = EOS;
		        	format(kStr, sizeof(kStr), "SERVER: {FFFFFF}Adresa ta de e-mail este '%s'", inputtext);
		        	SCM(playerid, COLOR_SERVER, kStr);

		        	new Security[100];
		        	mysql_escape_string(inputtext, Security);
		        	mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Email` = '%s' WHERE `Name` = '%s'", Security, GetCleanName(playerid));
		        	mysql_query(mysql, query);

		        	SPD(playerid, DIALOG_REGISTER + 3, DIALOG_STYLE_INPUT, "Varsta ta", "Te rugam sa introduci mai jos varsta pe care o ai:", "Ok", "");
		        }
		        else
		        {
		            SPD(playerid, DIALOG_REGISTER + 2, DIALOG_STYLE_INPUT, "Adresa ta de e-mail", "Adresa de e-mail care ai introdus-o nu este valida!\n\nTe rugam sa introduci o adresa de e-mail valida pentru a-ti proteja contul.", "Ok", "");
		            return 1;
		        }
		    }
		    else if(PlayerInfo[playerid][Lang] == 2)
		    {
		        if(IsMail(inputtext) && response && strlen(inputtext) > 10)
		        {
		            if(strcmp(inputtext, "@yahoo.com", true) == 0 || strcmp(inputtext, "@yahoo.ro", true) == 0 || strcmp(inputtext, "@gmail.com", true) == 0 || strcmp(inputtext, "@gmail.ro", true) == 0)
		        	{
		            	SPD(playerid, DIALOG_REGISTER + 2, DIALOG_STYLE_INPUT, "Your e-mail adress", "This e-mail adress is invalid!\n\nPlease insert a valid e-mail adress to protect your account.", "Ok", "");
		            	return 1;
		        	}
		        	kStr[0] = EOS;
		        	query[0] = EOS;
		        	format(kStr, sizeof(kStr), "SERVER: {FFFFFF}Your e-mail adress is '%s'", inputtext);
		        	SCM(playerid, COLOR_SERVER, kStr);

		        	new Security[100];
		        	mysql_escape_string(inputtext, Security);
		        	mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Email` = '%s' WHERE `Name` = '%s'", Security, GetCleanName(playerid));
		        	mysql_query(mysql, query);

		        	strins(inputtext, PlayerInfo[playerid][Email], 0, 100);
		        	Update(playerid, Emailx);

		        	SPD(playerid, DIALOG_REGISTER + 3, DIALOG_STYLE_INPUT, "Your age", "Please insert your age bellow:", "Ok", "");
		        }
		        else
		        {
		            SPD(playerid, DIALOG_REGISTER + 2, DIALOG_STYLE_INPUT, "Your e-mail adress", "This e-mail adress is invalid!\n\nPlease insert a valid e-mail adress to protect your account.", "Ok", "");
		            return 1;
		        }
		    }
		}
		case DIALOG_REGISTER + 3:
		{
		    if(PlayerInfo[playerid][Lang] == 1)
		    {
		    	if(strval(inputtext) < 7 || strval(inputtext) > 80 || !strval(inputtext))
		    	{
		        	SPD(playerid, DIALOG_REGISTER + 3, DIALOG_STYLE_INPUT, "Varsta ta", "Te rugam sa introduci varsta ta reala:", "Ok", "");
		        	return 1;
		    	}
		    	kStr[0] = EOS;
		    	format(kStr, sizeof(kStr), "SERVER: {FFFFFF}Varsta ta este de '%d' ani.", strval(inputtext));
		    	SCM(playerid, COLOR_SERVER, kStr);

		    	PlayerInfo[playerid][Age] = strval(inputtext);
		    	Update(playerid, Agex);

		    	SPD(playerid, DIALOG_REGISTER + 4, DIALOG_STYLE_MSGBOX, "Genul tau", "Te rugam sa selectezi sex-ul tau.", "Masculin", "Feminin");
			}
			else if(PlayerInfo[playerid][Lang] == 2)
			{
			    if(strval(inputtext) < 7 || strval(inputtext) > 80 || !strval(inputtext))
		    	{
		        	SPD(playerid, DIALOG_REGISTER + 3, DIALOG_STYLE_INPUT, "Your age", "Please isert your real age:", "Ok", "");
		        	return 1;
		    	}
		    	kStr[0] = EOS;
		    	format(kStr, sizeof(kStr), "SERVER: {FFFFFF}Your age is '%d' years old.", strval(inputtext));
		    	SCM(playerid, COLOR_SERVER, kStr);

		    	PlayerInfo[playerid][Age] = strval(inputtext);
		    	Update(playerid, Agex);

		    	SPD(playerid, DIALOG_REGISTER + 4, DIALOG_STYLE_MSGBOX, "Your gendre", "Please select your gendre.", "Male", "Female");
			}
		}
		case DIALOG_REGISTER + 4:
		{
		    if(PlayerInfo[playerid][Lang] == 1)
		    {
		        if(response)
		        {
					SCM(playerid, COLOR_SERVER, "SERVER: {FFFFFF}Deci genul tau este 'Masculin'.");

					PlayerInfo[playerid][Gendre] = 1;
		        	Update(playerid, Gendrex);

		        	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Choose your spawn", "Inregistrarea a reusit si ai ajuns la ultimul pas!\n\nGandeste-te cu atentie si alege spawn-ul tau favorit.\nPentru a vedea celalalt spawn valabil, foloseste butonul 'Ctrl'.", "OK", "");

		        	SetPlayerCameraPos(playerid, 1772.629028, -1813.489990, 45.188911);
		        	SetPlayerCameraLookAt(playerid, 1770.010620, -1817.109985, 42.944004);

		        	SpawnChoose[playerid] = 2;

		        	TextDrawHideForPlayer(playerid, Background[0]);
					TextDrawHideForPlayer(playerid, Background[1]);
		        	Info(playerid, "Apasa ~y~LCTRL (LMB) ~w~~h~pentru a schimba spawn-ul si ~r~ENTER ~w~~h~pentru a alege spawn-ul favorit.", 999);
				}
				else if(!response)
				{
				    SCM(playerid, COLOR_SERVER, "SERVER: {FFFFFF}Deci genul tau este 'Feminin'.");

					PlayerInfo[playerid][Gendre] = 2;
		        	Update(playerid, Gendrex);

		        	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Choose your spawn", "Inregistrarea a reusit si ai ajuns la ultimul pas!\n\nGandeste-te cu atentie si alege spawn-ul tau favorit.\nPentru a vedea celalalt spawn valabil, foloseste butonul 'Ctrl'.", "OK", "");

		        	SetPlayerCameraPos(playerid, 1772.629028, -1813.489990, 45.188911);
		        	SetPlayerCameraLookAt(playerid, 1770.010620, -1817.109985, 42.944004);

		        	SpawnChoose[playerid] = 2;

		        	TextDrawHideForPlayer(playerid, Background[0]);
					TextDrawHideForPlayer(playerid, Background[1]);
		        	Info(playerid, "Apasa ~y~LCTRL (LMB) ~w~~h~pentru a schimba spawn-ul si ~r~ENTER ~w~~h~pentru a alege spawn-ul favorit.", 999);
				}
		    }
		    else if(PlayerInfo[playerid][Lang] == 2)
		    {
		        if(response)
		        {
					SCM(playerid, COLOR_SERVER, "SERVER: {FFFFFF}You set your gendre to 'Male'.");

					PlayerInfo[playerid][Gendre] = 1;
		        	Update(playerid, Gendrex);

		        	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Choose your spawn", "Registration successful and you get to the last step!\n\nThink carefully and choose your favorite spawn.\nTo see other available spawn, use the 'Ctrl'.", "OK", "");

		        	SetPlayerCameraPos(playerid, 1772.629028, -1813.489990, 45.188911);
		        	SetPlayerCameraLookAt(playerid, 1770.010620, -1817.109985, 42.944004);

		        	SpawnChoose[playerid] = 2;

		        	TextDrawHideForPlayer(playerid, Background[0]);
					TextDrawHideForPlayer(playerid, Background[1]);
		        	Info(playerid, "Press ~y~LCTRL (LMB) ~w~~h~for change the spawn and ~r~ENTER ~w~~h~for choose your favorite spawn.", 999);
				}
				else if(!response)
				{
				    SCM(playerid, COLOR_SERVER, "SERVER: {FFFFFF}You set your gendre to 'Female'.");

					PlayerInfo[playerid][Gendre] = 2;
		        	Update(playerid, Gendrex);

		        	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Choose your spawn", "Registration successful and you get to the last step!\n\nThink carefully and choose your favorite spawn.\nTo see other available spawn, use the 'Ctrl'.", "OK", "");

		        	SetPlayerCameraPos(playerid, 1772.629028, -1813.489990, 45.188911);
		        	SetPlayerCameraLookAt(playerid, 1770.010620, -1817.109985, 42.944004);

		        	SpawnChoose[playerid] = 2;

		        	TextDrawHideForPlayer(playerid, Background[0]);
					TextDrawHideForPlayer(playerid, Background[1]);
		        	Info(playerid, "Press ~y~LCTRL (LMB) ~w~~h~for change the spawn and ~r~ENTER ~w~~h~for choose your favorite spawn.", 999);
				}
		    }
		}
		case DIALOG_LOGIN:
	    {
	        if(!response) return Kick(playerid);

			new Security[30];
			query[0] = EOS;
			mysql_escape_string(inputtext, Security);
			mysql_format(mysql, query, sizeof(query), "SELECT * FROM `accounts` WHERE `Name` = '%s' AND `Password` = '%s'", GetCleanName(playerid), Security);
            mysql_tquery(mysql, query, "LoginPlayer", "i", playerid);
	    }
	    case DIALOG_SERVERNAME:
	    {
	        if(!response) return 1;

	        ShowPlayerDialog(playerid, DIALOG_SERVERNAME + 1, DIALOG_STYLE_INPUT, "Change Hostname", "Introdu mai jos noul nume al serverului:", "Continue", "Close");
	    }
	    case DIALOG_SERVERNAME + 1:
	    {
	        if(!response) return 1;

	        if(strlen(inputtext) < 5) return ShowPlayerDialog(playerid, DIALOG_SERVERNAME + 1, DIALOG_STYLE_INPUT, "Change Hostname", "Introdu mai jos noul nume al serverului:\n\n{FF0000}Numele ales de tine este prea scurt!", "Continue", "Close");
	        if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_SERVERNAME + 1, DIALOG_STYLE_INPUT, "Change Hostname", "Introdu mai jos noul nume al serverului:\n\n{FF0000}Daca nu vreai sa schimbi numele apasa butonul 'Close'.", "Continue", "Close");

	        strmid(ServerInfo[Hostname], inputtext, 0, strlen(inputtext));

	        new hname[100];
	        format(hname, sizeof(hname), "hostname %s", inputtext);
	        SendRconCommand(hname);

	        query[0] = EOS;
	        new Security[100];
	        mysql_escape_string(inputtext, Security);
	        mysql_format(mysql, query, sizeof(query), "UPDATE `server` SET `Hostname` = '%s'", Security);
	        mysql_query(mysql, query);

	        kStr[0] = EOS;
	        format(kStr, sizeof(kStr), "[SERVER] Numele serverului a fost schimbat in: %s", inputtext);
	        SCM(playerid, COLOR_YELLOW, kStr);
		}
		case DIALOG_MODE:
	    {
	        if(!response) return 1;

	        ShowPlayerDialog(playerid, DIALOG_MODE + 1, DIALOG_STYLE_INPUT, "Change Mode", "Introdu mai jos noul mod al serverului:", "Continue", "Close");
	    }
	    case DIALOG_MODE + 1:
	    {
	        if(!response) return 1;

	        if(strlen(inputtext) < 5) return ShowPlayerDialog(playerid, DIALOG_MODE + 1, DIALOG_STYLE_INPUT, "Change Mode", "Introdu mai jos noul mod al serverului:\n\n{FF0000}Modul ales de tine este prea lung!", "Continue", "Close");
	        if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_MODE + 1, DIALOG_STYLE_INPUT, "Change Mode", "Introdu mai jos noul mod al serverului:\n\n{FF0000}Daca nu vreai sa schimbi modul apasa butonul 'Close'.", "Continue", "Close");

            strmid(ServerInfo[Mode], inputtext, 0, strlen(inputtext));

	        new hname[100];
	        format(hname, sizeof(hname), "%s", inputtext);
	        SetGameModeText(hname);

	        query[0] = EOS;
	        new Security[100];
	        mysql_escape_string(inputtext, Security);
	        mysql_format(mysql, query, sizeof(query), "UPDATE `server` SET `Mode` = '%s'", Security);
	        mysql_query(mysql, query);

	        kStr[0] = EOS;
	        format(kStr, sizeof(kStr), "[SERVER] Modul serverului a fost schimbat in: %s", inputtext);
	        SCM(playerid, COLOR_YELLOW, kStr);
		}
		case DIALOG_DMV:
		{
		    if(!response) return 1;

		    InExam[playerid] = 1;
		    vw[playerid] = playerid;
		    SetPlayerVirtualWorld(playerid, vw[playerid]);

		    FadeColorForPlayer(playerid,0,0,0,255,0,0,0,0,100,5);

		    SetPlayerCheckpoint(playerid, -2059.9194,-184.6152,35.0474, 4.0);
		    CP[playerid] = 1;

		    DMVCar[playerid] = AddStaticVehicleEx(411, -2054.8484,-147.3562,35.0474, 180.1884, 140, 140, 0);
		    PutPlayerInVehicle(playerid, DMVCar[playerid], 0);

		    DMVObj[0] = CreateDynamicObject(979, -2051.47192, -147.82213, 35.08852,   0.00000, 0.00000, 90.66005, vw[playerid]);
			DMVObj[1] = CreateDynamicObject(979, -2051.34302, -158.19008, 35.08852,   0.00000, 0.00000, 90.66005, vw[playerid]);
			DMVObj[2] = CreateDynamicObject(979, -2046.58899, -163.58592, 35.08852,   0.00000, 0.00000, 183.23993, vw[playerid]);
			DMVObj[3] = CreateDynamicObject(979, -2036.07935, -163.01770, 35.08852,   0.00000, 0.00000, 183.23993, vw[playerid]);
			DMVObj[4] = CreateDynamicObject(979, -2031.48376, -168.22890, 35.08852,   0.00000, 0.00000, 90.66005, vw[playerid]);
			DMVObj[5] = CreateDynamicObject(979, -2031.39148, -178.00671, 35.08852,   0.00000, 0.00000, 90.66005, vw[playerid]);
			DMVObj[6] = CreateDynamicObject(979, -2031.33313, -187.56598, 35.08852,   0.00000, 0.00000, 90.66005, vw[playerid]);
			DMVObj[7] = CreateDynamicObject(979, -2031.32520, -197.48700, 35.08852,   0.00000, 0.00000, 90.66005, vw[playerid]);
			DMVObj[8] = CreateDynamicObject(979, -2034.42871, -206.16672, 35.08852,   0.00000, 0.00000, 54.12004, vw[playerid]);
			DMVObj[9] = CreateDynamicObject(979, -2040.14368, -214.07062, 35.08852,   0.00000, 0.00000, 54.12004, vw[playerid]);
			DMVObj[10] = CreateDynamicObject(979, -2048.00342, -218.15009, 35.08852,   0.00000, 0.00000, 5.28005, vw[playerid]);
			DMVObj[11] = CreateDynamicObject(979, -2057.77368, -218.97418, 35.08852,   0.00000, 0.00000, 5.28005, vw[playerid]);
			DMVObj[12] = CreateDynamicObject(979, -2064.98022, -219.65508, 35.08852,   0.00000, 0.00000, 5.28005, vw[playerid]);
			DMVObj[13] = CreateDynamicObject(979, -2058.41235, -148.13011, 35.08852,   0.00000, 0.00000, 270.66010, vw[playerid]);
			DMVObj[14] = CreateDynamicObject(979, -2058.27881, -157.82680, 35.08852,   0.00000, 0.00000, 270.66010, vw[playerid]);
			DMVObj[15] = CreateDynamicObject(979, -2058.34009, -167.98978, 35.08852,   0.00000, 0.00000, 270.66010, vw[playerid]);
			DMVObj[16] = CreateDynamicObject(979, -2053.19336, -172.90979, 35.08852,   0.00000, 0.00000, 360.71997, vw[playerid]);
			DMVObj[17] = CreateDynamicObject(979, -2043.35034, -172.87025, 35.08852,   0.00000, 0.00000, 360.71997, vw[playerid]);
			DMVObj[18] = CreateDynamicObject(979, -2038.78442, -177.82460, 35.08852,   0.00000, 0.00000, -89.39995, vw[playerid]);
			DMVObj[19] = CreateDynamicObject(979, -2038.74951, -187.62698, 35.08852,   0.00000, 0.00000, -89.39995, vw[playerid]);
			DMVObj[20] = CreateDynamicObject(979, -2045.15918, -205.90045, 35.08852,   0.00000, 0.00000, 232.38013, vw[playerid]);
			DMVObj[21] = CreateDynamicObject(979, -2070.14160, -214.80571, 35.08852,   0.00000, 0.00000, 270.66010, vw[playerid]);
			DMVObj[22] = CreateDynamicObject(979, -2070.29150, -204.60133, 35.08852,   0.00000, 0.00000, 270.66010, vw[playerid]);
			DMVObj[23] = CreateDynamicObject(979, -2070.41748, -194.86923, 35.08852,   0.00000, 0.00000, 270.66010, vw[playerid]);
			DMVObj[24] = CreateDynamicObject(979, -2062.47583, -204.74908, 35.08852,   0.00000, 0.00000, 90.66005, vw[playerid]);
			DMVObj[25] = CreateDynamicObject(979, -2062.47925, -194.63466, 35.08852,   0.00000, 0.00000, 89.82005, vw[playerid]);
			DMVObj[26] = CreateDynamicObject(979, -2070.47705, -185.17007, 35.08852,   0.00000, 0.00000, 270.66010, vw[playerid]);
			DMVObj[27] = CreateDynamicObject(979, -2065.59131, -180.33913, 35.08852,   0.00000, 0.00000, 183.23993, vw[playerid]);
			DMVObj[28] = CreateDynamicObject(979, -2057.53271, -179.89044, 35.08852,   0.00000, 0.00000, 183.23993, vw[playerid]);
			DMVObj[29] = CreateDynamicObject(979, -2057.38794, -189.51338, 35.08852,   0.00000, 0.00000, 3.90005, vw[playerid]);
			DMVObj[30] = CreateDynamicObject(979, -2052.32935, -184.34753, 35.08852,   0.00000, 0.00000, 90.66005, vw[playerid]);
			DMVObj[31] = CreateDynamicObject(979, -2038.70593, -192.03574, 35.08852,   0.00000, 0.00000, -89.39995, vw[playerid]);
			DMVObj[32] = CreateDynamicObject(979, -2057.77734, -210.00266, 35.08852,   0.00000, 0.00000, 181.19991, vw[playerid]);
			DMVObj[33] = CreateDynamicObject(979, -2052.91553, -209.89790, 35.08852,   0.00000, 0.00000, 181.19991, vw[playerid]);
			DMVObj[34] = CreateDynamicObject(979, -2041.47131, -201.08081, 35.08852,   0.00000, 0.00000, 232.38013, vw[playerid]);
			DMVObj[35] = CreateDynamicObject(1237, -2051.60181, -142.53262, 34.31403,   0.00000, 0.00000, 0.00000, vw[playerid]);
			DMVObj[36] = CreateDynamicObject(1237, -2052.98560, -142.56273, 34.31403,   0.00000, 0.00000, 0.00000, vw[playerid]);
			DMVObj[37] = CreateDynamicObject(1237, -2054.43188, -142.64972, 34.31403,   0.00000, 0.00000, 0.00000, vw[playerid]);
			DMVObj[38] = CreateDynamicObject(1237, -2055.87817, -142.75671, 34.31403,   0.00000, 0.00000, 0.00000, vw[playerid]);
			DMVObj[39] = CreateDynamicObject(1237, -2057.30225, -142.78476, 34.31403,   0.00000, 0.00000, 0.00000, vw[playerid]);
			DMVObj[40] = CreateDynamicObject(1237, -2058.54834, -142.86191, 34.31403,   0.00000, 0.00000, 0.00000, vw[playerid]);

			Info(playerid, "~y~DMV INSTRUCTOR: ~w~~h~Trebuie sa ajungi la ~r~punctul rosu ~w~~h~de pe harta.~n~Incearca sa nu avariezi masina pe parcursul acestui examen.", 999);
		}
		case DIALOG_TUTORIAL:
		{
		}
		case DIALOG_DS:
		{
		    SPD(playerid, DIALOG_DS + 1, DIALOG_STYLE_LIST, ""SERVER_NAME": Dealership", "Expensive Cars\nCheap Cars\nRegular Cars\nAir Vehicles\nBikes", "Select", "Cancel");
		}
		case DIALOG_DS + 1:
		{
		    if(!response) return 1;

		    new str[1000];
		    new string[1000];
			if(listitem == 0) //Expensive Cars
			{
			    strcat(str, "Car Name\tPrice\tStock\n");
				for(new d = 0; d < sizeof(DInfo); d++)
				{
					if(DInfo[d][Model] >= 400 && DInfo[d][Type] == 1)
					{
						format(string, sizeof(string), "%s\t%s$\t%d vehicles\n", VehicleNames[DInfo[d][Model] - 400], FormatNumber(DInfo[d][Price]), DInfo[d][Stock]);
						strcat(str, string);
					}
				}
				ShowPlayerDialog(playerid, DIALOG_DS + 2, DIALOG_STYLE_TABLIST_HEADERS, "Category: Expensive Cars", str, "Select", "Cancel");
			}
			else if(listitem == 1) //Cheap Cars
			{
			    strcat(str, "Car Name\tPrice\tStock\n");
				for(new d = 0; d < sizeof(DInfo); d++)
				{
					if(DInfo[d][Model] >= 400 && DInfo[d][Type] == 2)
					{
						format(string, sizeof(string), "%s\t%s$\t%d vehicles\n", VehicleNames[DInfo[d][Model] - 400], FormatNumber(DInfo[d][Price]), DInfo[d][Stock]);
						strcat(str, string);
					}
				}
				ShowPlayerDialog(playerid, DIALOG_DS + 3, DIALOG_STYLE_TABLIST_HEADERS, "Category: Cheap Cars", str, "Select", "Cancel");
			}
			else if(listitem == 2) //Regular Cars
			{
			    strcat(str, "Car Name\tPrice\tStock\n");
				for(new d = 0; d < sizeof(DInfo); d++)
				{
					if(DInfo[d][Model] >= 400 && DInfo[d][Type] == 3)
					{
						format(string, sizeof(string), "%s\t%s$\t%d vehicles\n", VehicleNames[DInfo[d][Model] - 400], FormatNumber(DInfo[d][Price]), DInfo[d][Stock]);
						strcat(str, string);
					}
				}
				ShowPlayerDialog(playerid, DIALOG_DS + 4, DIALOG_STYLE_TABLIST_HEADERS, "Category: Regular Cars", str, "Select", "Cancel");
			}
			else if(listitem == 3) //Air Vehicles
			{
			    strcat(str, "Car Name\tPrice\tStock\n");
				for(new d = 0; d < sizeof(DInfo); d++)
				{
					if(DInfo[d][Model] >= 400 && DInfo[d][Type] == 4)
					{
						format(string, sizeof(string), "%s\t%s$\t%d vehicles\n", VehicleNames[DInfo[d][Model] - 400], FormatNumber(DInfo[d][Price]), DInfo[d][Stock]);
						strcat(str, string);
					}
				}
				ShowPlayerDialog(playerid, DIALOG_DS + 5, DIALOG_STYLE_TABLIST_HEADERS, "Category: Air Vehicles", str, "Select", "Cancel");
			}
			else if(listitem == 4) //Bikes
			{
			    strcat(str, "Car Name\tPrice\tStock\n");
				for(new d = 0; d < sizeof(DInfo); d++)
				{
					if(DInfo[d][Model] >= 400 && DInfo[d][Type] == 5)
					{
						format(string, sizeof(string), "%s\t%s$\t%d vehicles\n", VehicleNames[DInfo[d][Model] - 400], FormatNumber(DInfo[d][Price]), DInfo[d][Stock]);
						strcat(str, string);
					}
				}
				ShowPlayerDialog(playerid, DIALOG_DS + 6, DIALOG_STYLE_TABLIST_HEADERS, "Category: Bikes", str, "Select", "Cancel");
			}
		}
		case DIALOG_DS + 2:
		{
		    if(!response) return 1;
		    
		    CreateVeh(playerid, listitem, DInfo[listitem][Type]);
		}
		case DIALOG_CHANGEMAIL:
		{
		    if(!response) return 1;

		    if(!strlen(inputtext)) return SPD(playerid, DIALOG_CHANGEMAIL, DIALOG_STYLE_INPUT, "Change E-Mail", "Nu poti continua daca nu introduci o adresa de e-mail.\nDaca nu vrei sa iti schimbi email-ul apasa butonul \"Cance\".", "OK", "Cancel");
		    if(!IsMail(inputtext) && strlen(inputtext) < 10) return SPD(playerid, DIALOG_CHANGEMAIL, DIALOG_STYLE_INPUT, "Change E-Mail", "Trebuie sa introduci o adresa de e-mail valida.\nDaca nu ai o alta adresa de e-mail valida, apasa butonul \"Cancel\".", "OK", "Cancel");
		    if(strcmp(inputtext, "@yahoo.com", true) == 0 || strcmp(inputtext, "@yahoo.ro", true) == 0 || strcmp(inputtext, "@gmail.com", true) == 0 || strcmp(inputtext, "@gmail.ro", true) == 0)
		    {
		        SPD(playerid, DIALOG_CHANGEMAIL, DIALOG_STYLE_INPUT, "Change E-Mail", "Trebuie sa introduci o adresa de e-mail valida.\nDaca nu ai o alta adresa de e-mail valida, apasa butonul \"Cancel\".", "OK", "Cancel");
		        return 1;
		    }

		    new Security[100];
		    query[0] = '\0';
		    mysql_escape_string(inputtext, Security);
		    mysql_format(mysql, query, sizeof(query), "UPDATE `players` SET `Email` = '%s' WHERE `Name` = '%d'", Security, GetCleanName(playerid));
			mysql_query(mysql, query);

			kStr[0] = '\0';
			format(kStr, sizeof(kStr), "[E-MAIL] Ti-ai schimbat eemail-ul in: %s", inputtext);
			SCM(playerid, COLOR_YELLOW, kStr);
		}
		case DIALOG_CHANGEPASS:
		{
		    if(!response) return 1;

		    new Security[30];
			query[0] = EOS;
			mysql_escape_string(inputtext, Security);
			mysql_format(mysql, query, sizeof(query), "SELECT * FROM `accounts` WHERE `Name` = '%s' AND `Password` = '%s'", GetCleanName(playerid), Security);
		    mysql_tquery(mysql, query, "ChangePassword", "i", playerid);
		}
		case DIALOG_CHANGEPASS + 1:
		{
		    if(!response) return 1;

		    if(!strlen(inputtext)) return SPD(playerid, DIALOG_CHANGEPASS + 1, DIALOG_STYLE_INPUT, "#STEP 2: Change your password", "Nu ai introdus nici o parola!\n\n- Daca nu vrei sa iti schimbi parola apasa butonul \"Cancel\".", "OK", "Cancel");
		    if(strlen(inputtext) < 6) return SPD(playerid, DIALOG_CHANGEPASS + 1, DIALOG_STYLE_INPUT, "#STEP 2: Change your password", "Parola ta este prea mica!\n\n- Introdu o parola cuprinsa intre 6 - 100 caractere.", "OK", "Cancel");

			kStr[0] = '\0';
			format(kStr, sizeof(kStr), "[CHANGE PASSWORD] Parola ta a fost schimbata in: %s", inputtext);
			SCM(playerid, COLOR_YELLOW, kStr);

			query[0] = '\0';
			new Security[100];

			mysql_escape_string(inputtext, Security);
			mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Password` = '%s' WHERE `Name` = '%s'", Security, GetCleanName(playerid));
			mysql_query(mysql, query);
		}
		case DIALOG_CLAN + 1:
		{
		    if(strlen(inputtext) > 2 && strlen(inputtext) < 64)
		    {
		        if(PlayerInfo[playerid][Clan] > 0 || PlayerInfo[playerid][cLeader] > 0) SetPlayerName(playerid, GetCleanName(playerid));

		    	PlayerInfo[playerid][Clan] = LastClanID();
		    	PlayerInfo[playerid][cLeader] = LastClanID();
				PlayerInfo[playerid][cRank] = 6;
				Update(playerid, Clanx);
				Update(playerid, cLeaderx);
				Update(playerid, cRankx);
				
				new string[64];
				strmid(string, inputtext, 0, 64);
				
		    	CreateClan(string, ClanDays);
				SPD(playerid, DIALOG_CLAN + 2, DIALOG_STYLE_INPUT, "Creare clan", "Te rugam sa introduci mai jos tag-ul pe care doresti sa il aiba clanul:\n\n\
																					- Este recomandat ca TAG-ul sa fie de forma [EXEMPLU] / EXEMPLU. (in fata numelui) / .EXEMPLU (in spatele numelui)\n\
																					- Nu alege aceleasi TAG-uri ca cele existente pentru a nu crea confuzii.", "OK", "Cancel");
			}
			else SPD(playerid, DIALOG_CLAN + 1, DIALOG_STYLE_INPUT, "Creare clan", "Numele clanului trebuie sa contina intre 3 si 64 de caractere!:", "OK", "Cancel");
		}
		case DIALOG_CLAN + 2:
		{
		    if(strval(inputtext) == 0 || strval(inputtext) == 1)
		    {
				new string[6];
				strmid(string, inputtext, 0, 6);
		        ClanInfo[PlayerInfo[playerid][cLeader]][Tag] = string;
				cUpdate(PlayerInfo[playerid][cLeader], Tagx);
				SPD(playerid, DIALOG_CLAN + 3, DIALOG_STYLE_INPUT, "Creare clan", "Te rugam sa alegi in ce parte vrei sa fie TAG-ul clanului tau.\n\n\
																				   - Daca doresti ca TAG-ul sa fie la inceputul numelui scrie 0.\n\
																				   - Daca doresti ca TAG-ul sa fie la sfarsitul numelui scrie 1.", "OK", "Cancel");
			}
			else SPD(playerid, DIALOG_CLAN + 2, DIALOG_STYLE_INPUT, "Creare clan", "Tag-ul clanului trebuie sa contina intre 1 si 6 de caractere!:", "OK", "Cancel");
		}
		case DIALOG_CLAN + 3:
		{
		    if(strlen(inputtext) > 0 && strlen(inputtext) < 2)
		    {
		        ClanInfo[PlayerInfo[playerid][cLeader]][Type] = strval(inputtext);
				cUpdate(PlayerInfo[playerid][cLeader], Typex);
				new string[24], nName[24];
				
				if(strval(inputtext) == 1) format(nName, sizeof(nName), "%s%s", GetName(playerid), ClanInfo[PlayerInfo[playerid][cLeader]][Tag]);
				else format(nName, sizeof(nName), "%s%s", ClanInfo[PlayerInfo[playerid][cLeader]][Tag], GetName(playerid));

				strmid(string, nName, 0, 24);
				SetPlayerName(playerid, string);
				SPD(playerid, DIALOG_CLAN + 4, DIALOG_STYLE_MSGBOX, "Creare clan", "Felicitari, ti-ai creat un clan cu succes!\n\
																					Foloseste /clh pentru a vedea comenzile disponibile pentru clanuri.", "OK", "Cancel");
			}
			else
			{
				SPD(playerid, DIALOG_CLAN + 3, DIALOG_STYLE_INPUT, "Creare clan", "Trebuie sa introduci numarul 0 sa fie inaintea numelui sau numarul 1 sa fie dupa nume tag-ul!:", "OK", "Cancel");
			}
		}
		case DIALOG_SHOP:
		{
		    if(!response) return 1;
		    
		    switch(listitem)
		    {
		        case 0:
		        {
		            if(PlayerInfo[playerid][PPoints] < 100) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You don't have enough Premium Points to buy this item.");
		            if(PlayerInfo[playerid][Premium] == 1) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You already have Premium Account!");

					PlayerInfo[playerid][Premium] = 1;
            		PlayerInfo[playerid][PremiumDays] = gettime() + 7*86400;
            		Update(playerid, Premiumx);
            		Update(playerid, PremiumDaysx);
            		
            		PlayerInfo[playerid][PPoints] -= 100;
            		Update(playerid, PPointsx);
            		
		            SCM(playerid, COLOR_YELLOW, "SHOP: Ai cumparat Premium Account valabil pentru 7 zile.");
		        }
		        case 1:
		        {
		            if(PlayerInfo[playerid][PPoints] < 400) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You don't have enough Premium Points to buy this item.");
		            if(PlayerInfo[playerid][Premium] == 1) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You already have Premium Account!");

		            PlayerInfo[playerid][Premium] = 1;
            		PlayerInfo[playerid][PremiumDays] = gettime() + 30*86400;
            		Update(playerid, Premiumx);
            		Update(playerid, PremiumDaysx);

            		PlayerInfo[playerid][PPoints] -= 400;
            		Update(playerid, PPointsx);

		            SCM(playerid, COLOR_YELLOW, "SHOP: Ai cumparat Premium Account valabil pentru 30 zile.");
		        }
		        case 2:
		        {
		            if(PlayerInfo[playerid][PPoints] < 1200) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You don't have enough Premium Points to buy this item.");
		            if(PlayerInfo[playerid][Premium] == 1) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You already have Premium Account!");

		            PlayerInfo[playerid][Premium] = 1;
            		PlayerInfo[playerid][PremiumDays] = gettime() + 90*86400;
            		Update(playerid, Premiumx);
            		Update(playerid, PremiumDaysx);

            		PlayerInfo[playerid][PPoints] -= 1200;
            		Update(playerid, PPointsx);

		            SCM(playerid, COLOR_YELLOW, "SHOP: Ai cumparat Premium Account valabil pentru 90 zile.");
		        }
		        case 3:
		        {
		            if(PlayerInfo[playerid][PPoints] < 4200) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You don't have enough Premium Points to buy this item.");
		            if(PlayerInfo[playerid][Premium] == 1) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You already have Premium Account!");

		            PlayerInfo[playerid][Premium] = 1;
            		PlayerInfo[playerid][PremiumDays] = gettime() + 300*86400;
            		Update(playerid, Premiumx);
            		Update(playerid, PremiumDaysx);

            		PlayerInfo[playerid][PPoints] -= 4200;
            		Update(playerid, PPointsx);

		            SCM(playerid, COLOR_YELLOW, "SHOP: Ai cumparat Premium Account valabil pentru 300 zile.");
		        }
		        case 4:
		        {
		            if(PlayerInfo[playerid][PPoints] < 10000) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You don't have enough Premium Points to buy this item.");
		            if(PlayerInfo[playerid][Premium] == 1) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You already have Premium Account!");

		            PlayerInfo[playerid][Premium] = 1;
            		PlayerInfo[playerid][PremiumDays] = gettime() + 700*86400;
            		Update(playerid, Premiumx);
            		Update(playerid, PremiumDaysx);

            		PlayerInfo[playerid][PPoints] -= 10000;
            		Update(playerid, PPointsx);

		            SCM(playerid, COLOR_YELLOW, "SHOP: Ai cumparat Premium Account valabil pentru 700 zile.");
		        }
		        case 5:
		        {
		            if(PlayerInfo[playerid][PPoints] < 100) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You don't have enough Premium Points to buy this item.");

		            SCM(playerid, COLOR_YELLOW, "SHOP: Ai cumparat $1.000.000 bani cash.");
		            GivePlayerMoney(playerid, 1000000);
		        }
		        case 6:
		        {
		            if(PlayerInfo[playerid][PPoints] < 500) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You don't have enough Premium Points to buy this item.");

		            SCM(playerid, COLOR_YELLOW, "SHOP: Ai cumparat $5.000.000 bani cash.");
		            GivePlayerMoney(playerid, 5000000);
		        }
		        case 7:
		        {
		            if(PlayerInfo[playerid][PPoints] < 1000) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You don't have enough Premium Points to buy this item.");

		            SCM(playerid, COLOR_YELLOW, "SHOP: Ai cumparat $10.000.000 bani cash.");
		            GivePlayerMoney(playerid, 10000000);
		        }
		        case 8:
		        {
		            if(PlayerInfo[playerid][PPoints] < 2000) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You don't have enough Premium Points to buy this item.");

		            SCM(playerid, COLOR_YELLOW, "SHOP: Ai cumparat $20.000.000 bani cash.");
		            GivePlayerMoney(playerid, 20000000);
		        }
		        case 9:
		        {
		            if(PlayerInfo[playerid][PPoints] < 5000) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You don't have enough Premium Points to buy this item.");

		            SCM(playerid, COLOR_YELLOW, "SHOP: Ai cumparat $50.000.000 bani cash.");
		            GivePlayerMoney(playerid, 50000000);
		        }
		        case 10:
		        {
		            if(PlayerInfo[playerid][PPoints] < 10000) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You don't have enough Premium Points to buy this item.");

		            SCM(playerid, COLOR_YELLOW, "SHOP: Ai cumparat $100.000.000 bani cash.");
		            GivePlayerMoney(playerid, 100000000);
		        }
		        case 11:
				{
				    if(PlayerInfo[playerid][PPoints] < 1200) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You don't have enough Premium Points to buy this item.");
				    
				    ClanDays = 30;
				    SPD(playerid, DIALOG_CLAN + 1, DIALOG_STYLE_INPUT, "Creare clan", "Te rugam sa introduci mai jos numele pe care doresti sa il aiba clanul:\n\n\
																						- Ai grija ca numele ales de tine sa nu fie acelasi cu numele clanurilor existente.\n\
																						- Clanul tau va fi valabil pentru 30 zile, dupa care, daca nu va fi platit pentru urmatoarea luna, va fi sters.", "OK", "Cancel");
		        }
		        case 12:
				{
				    if(PlayerInfo[playerid][PPoints] < 2000) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You don't have enough Premium Points to buy this item.");

					ClanDays = 60;
				    SPD(playerid, DIALOG_CLAN + 1, DIALOG_STYLE_INPUT, "Creare clan", "Te rugam sa introduci mai jos numele pe care doresti sa il aiba clanul:\n\n\
																						- Ai grija ca numele ales de tine sa nu fie acelasi cu numele clanurilor existente.\n\
																						- Clanul tau va fi valabil pentru 30 zile, dupa care, daca nu va fi platit pentru urmatoarea luna, va fi sters.", "OK", "Cancel");
		        }
		    }
		}
	}
	return 1;
}

public OnPlayerModelSelection(playerid, response, listid, modelid)
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    return 0;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	return 1;
}

MySQLConnect()
{
    new read[64];
    new File:file = fopen("ServerStart.txt", io_read);
    if(file)
    {
	    fread(file, read);
	    fclose(file);
	    MySQLType = strval(read);
    }
    if(MySQLType == 0)
    {
        mysql = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DB, MYSQL_PASS);
        if(mysql_errno(mysql) != 0)
        {
            printf(" - MySQL Connection - Windows! -");
            printf(" (!) Host: %s [FAILED]", MYSQL_HOST);
            printf(" (!) User: %s [FAILED]", MYSQL_USER);
            printf(" (!) Database: %s [FAILED]\n", MYSQL_DB);

        }
        else
        {
            printf(" - MySQL Connection - Windows! -");
	        printf(" (!) Host: %s [CONNECTED]", MYSQL_HOST);
            printf(" (!) User: %s [CONNECTED]", MYSQL_USER);
            printf(" (!) Database: %s [CONNECTED]\n", MYSQL_DB);

        }
    }
    else if(MySQLType == 1)
    {
        mysql = mysql_connect(MYSQL_HOST_LINUX, MYSQL_USER_LINUX, MYSQL_DB_LINUX, MYSQL_PASS_LINUX);
        if(mysql_errno(mysql) != 0)
        {
            printf(" - MySQL Connection - Linux! -");
            printf(" (!) Host: %s [FAILED]", MYSQL_HOST_LINUX);
            printf(" (!) User: %s [FAILED]", MYSQL_USER_LINUX);
            printf(" (!) Database: %s [FAILED]\n", MYSQL_DB_LINUX);

        }
        else
        {
            printf(" - MySQL Connection - Linux! -");
            printf(" (!) Host: %s [CONNECTED]", MYSQL_HOST_LINUX);
            printf(" (!) User: %s [CONNECTED]", MYSQL_USER_LINUX);
            printf(" (!) Database: %s [CONNECTED]\n", MYSQL_DB_LINUX);

        }
    }
}

//Commands - General
CMD:clandays(playerid, params[])
{
	kStr[0] = '\0';
	format(kStr, sizeof(kStr), "Clan Days: %d", (ClanInfo[PlayerInfo[playerid][Clan]][Days] - gettime()) / 86400);
	SCM(playerid, COLOR_WHITE, kStr);
	return 1;
}
CMD:help(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    SCM(playerid, COLOR_BLUE, "# ACCOUNT: {FFFFFF}/stats /changemail /changepass /buylevel /toggletag");
	    SCM(playerid, COLOR_BLUE, "# GENERAL: {FFFFFF}/animlist /pay /turfs /skills /serverinfo /eject /speedlimit");
	    SCM(playerid, COLOR_BLUE, "# GENERAL: {FFFFFF}/shop");
	    SCM(playerid, COLOR_BLUE, "# VEHICLE: {FFFFFF}/vehicles");
	    if(PlayerInfo[playerid][Faction] > 0)
	    {
	    	SCM(playerid, COLOR_BLUE, "# FACTION: {FFFFFF}/f(actionchat) /orderlist /order /heal /armor");
	    }
	}
	return 1;
}
CMD:shop(playerid, params[])
{
	new str[100];
	kStr[0] = '\0';
	
	format(str, sizeof(str), "UNNIC SHOP | %d Premium Points", PlayerInfo[playerid][PPoints]);
	strcat(kStr, "Shop Type\tDuration\tPrice\n");
	strcat(kStr, "Premium Account\t{0FBD12}7 days\t{A82721}100 {FFFFFF}Premium Points\n");
	strcat(kStr, "Premium Account\t{0FBD12}30 days\t{A82721}400 {FFFFFF}Premium Points\n");
	strcat(kStr, "Premium Account\t{0FBD12}90 days\t{A82721}1200 {FFFFFF}Premium Points\n");
	strcat(kStr, "Premium Account\t{0FBD12}300 days\t{A82721}4200 {FFFFFF}Premium Points\n");
	strcat(kStr, "Premium Account\t{0FBD12}700 days\t{A82721}10000 {FFFFFF}Premium Points\n");
	strcat(kStr, "$1.000.000 Cash Money\t-\t{A82721}100 {FFFFFF}Premium Points\n");
	strcat(kStr, "$5.000.000 Cash Money\t-\t{A82721}500 {FFFFFF}Premium Points\n");
	strcat(kStr, "$10.000.000 Cash Money\t-\t{A82721}1000 {FFFFFF}Premium Points\n");
	strcat(kStr, "$20.000.000 Cash Money\t-\t{A82721}2000 {FFFFFF}Premium Points\n");
	strcat(kStr, "$50.000.000 Cash Money\t-\t{A82721}5000 {FFFFFF}Premium Points\n");
	strcat(kStr, "$100.000.000 Cash Money\t-\t{A82721}10000 {FFFFFF}Premium Points\n");
	strcat(kStr, "Create a clan\t{0FBD12}30 days\t{A82721}1200 {FFFFFF}Premium Points\n");
	strcat(kStr, "Create a clan\t{0FBD12}60 days\t{A82721}2000 {FFFFFF}Premium Points\n");
	SPD(playerid, DIALOG_SHOP, DIALOG_STYLE_TABLIST_HEADERS, str, kStr, "Select", "Close");
	return 1;
}
CMD:speedlimit(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You aren't in a vehicle!");
	if(sscanf(params, "d", params[0])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/speedlimit [KM/H]");
	if(params[0] < 0) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~Invalid vehicle speed!");
	if(params[0] == 0)
	{
	    Speedlimit[playerid] = 0;
		SCM(playerid, COLOR_PURPLE, "* Ai dezactivat limita de viteza.");
		return 1;
	}
	Speedlimit[playerid] = params[0];
	
	kStr[0] = '\0';
	format(kStr, sizeof(kStr), "* Ti-ai setat limita de viteza la %d KM/H, orice vehicul vei conduce nu va depasi aceasta limita.", params[0]);
	SCM(playerid, COLOR_PURPLE, kStr);
	return 1;
}
CMD:eject(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You aren't in a vehicle!");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You aren't the driver of this vehicle!");
	if(sscanf(params, "u", params[0])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/eject [Name/ID]");
	if(params[0] == INVALID_PLAYER_ID) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~This player isn't in your vehicle!");
	if(params[0] == playerid) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You can't eject yourself!");
	
	RemovePlayerFromVehicle(params[0]);
	
	kStr[0] = '\0';
	format(kStr, sizeof(kStr), "* %s te-a dat afara din vehiculul sau.", GetName(playerid));
	SCM(params[0], COLOR_PURPLE, kStr);
	
	format(kStr, sizeof(kStr), "* L-ai dat afara din vehicul pe %s.", GetName(params[0]));
	SCM(playerid, COLOR_PURPLE, kStr);
	return 1;
}
CMD:toggletag(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][gradTag] == false)
	    {
	        PlayerInfo[playerid][gradTag] = true;
	        TagTimer[playerid] = SetTimerEx_("UpdateGradTag", 1000, true, -1, "d", playerid);
	    }
	    else
	    {
	        PlayerInfo[playerid][gradTag] = false;
	        KillTimer(TagTimer[playerid]);
	    }
	}
	return 1;
}

//Commands - Faction type 1

CMD:tazer(playerid, params[])
{
	new fid = PlayerInfo[playerid][Faction];
	if(fid == 0 || FactionInfo[fid][fType] != 1 || !IsValidFaction(fid)) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");

	if(PlayerInfo[playerid][hasTazer] == 0)
	{
        PlayerInfo[playerid][hasTazer] = 1;
        GivePlayerWeapon(playerid, 23, 65500);
        SCM(playerid, COLOR_PURPLE, "You took your tazer out of the holster.");
    }
    else
	{
        PlayerInfo[playerid][hasTazer] = 0;
        SetPlayerAmmo(playerid, 23, 0);
        GivePlayerWeapon(playerid, 24, 500);
        SCM(playerid, COLOR_PURPLE, "You put your tazer in the holster.");
    }
	return 1;
}
alias:tazer("taser");

/*CMD:cuff(playerid, params[])
{
	new fid, targetid;
	fid = PlayerInfo[playerid][Faction];
	if(fid == 0 || FactionInfo[fid][fType] != 1 || !IsValidFaction(fid)) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
    if(PlayerInfo[playerid][isCuffed] == 0)
	{
        for(new i=MAX_PLAYER_ATTACHED_OBJECTS-1; i!=0; i--)
            {
	            if(!IsPlayerAttachedObjectSlotUsed(playerid, i))
	            {
	                new skin = GetPlayerSkin(playerid);
	                SetPVarInt(playerid, "CUFF_object_index", i);

	                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CUFFED);

	                SetPlayerAttachedObject(playerid, i, 19418, 6, CUFF_CuffObjectOffsets[skin][0], CUFF_CuffObjectOffsets[skin][1], CUFF_CuffObjectOffsets[skin][2], CUFF_CuffObjectOffsets[skin][3], CUFF_CuffObjectOffsets[skin][4], CUFF_CuffObjectOffsets[skin][5], CUFF_CuffObjectOffsets[skin][6], CUFF_CuffObjectOffsets[skin][7], CUFF_CuffObjectOffsets[skin][8]);
	                return 1;
	            }
            }
    }
    else {
        PlayerInfo[playerid][hasTazer] = 0;
        SetPlayerAmmo(playerid, 23, 0);
        GivePlayerWeapon(playerid, 24, 500);
        SCM(playerid, COLOR_PURPLE, "You put your tazer in the holster.");
    }
	return 1;
}*/

//Commands - Animations
CMD:animlist(playerid, params[])
{
	SCM(playerid, COLOR_BLUE, "** Animatii valabile **");
    SCM(playerid, 0, ""W"/handsup /dance[1-4] /rap /rap2 /rap3 /wankoff /wank /strip[1-7] /sexy[1-8] /bj[1-4] /cellin /cellout /lean /piss /follow");
    SCM(playerid, 0, ""W"/greet /injured /injured2 /hitch /bitchslap /cpr /gsign1 /gsign2 /gsigne /gsign4 /gsign5 /gift /getup");
    SCM(playerid, 0, ""W"/chairsit /stand /slapped /slapass /drunk /gwalk /gwalk2 /mwalk /fwalk /celebrate /celebrate2 /win /win2");
    SCM(playerid, 0, ""W"/yes /deal /deal2 /thankyou /invite1 /invite2 /sit /scratch /bomb /getarrested /laugh /lookout /robman");
    SCM(playerid, 0, ""W"/crossarms /crossarms2 /crossarms3 /lay /cover /vomit /eat /wave /crack /crack2 /smokem /smokef /msit /fsit");
    SCM(playerid, 0, ""W"/chat /fucku /taichi /chairsit /relax /bat1 /bat2 /bat3 /bat4 /bat5 /nod /cry1 /cry2 /chant /carsmoke /aim");
    SCM(playerid, 0, ""W"/gang1 /gang2 /gang3 /gang4 /gang5 /gang6 /gang7 /bed1 /bed2 /bed3 /bed4 /carsit /carsit2 /stretch /angry");
    SCM(playerid, 0, ""W"/kiss1 /kiss2 /kiss3 /kiss4 /kiss5 /kiss6 /kiss7 /kiss8 /exhausted /ghand1 /ghand2 /ghand3 /ghand4 /ghand5");
    SCM(playerid, 0, ""W"/basket1 /basket2 /basket3 /basket4 /basket5 /basket6 /akick /box /cockgun");
    SCM(playerid, 0, ""W"/bar1 /bar2 /bar3 /bar4 /lay2 /liftup /putdown /die /joint /die2 /aim2");
    return 1;
}
CMD:handsup(playerid, params[]) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
CMD:stopanim(playerid, params[]) return ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0);
CMD:dance(playerid, params[]) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
CMD:dance2(playerid, params[]) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
CMD:dance3(playerid, params[]) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
CMD:dance4(playerid, params[]) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
CMD:rap(playerid, params[]) return ApplyAnimation(playerid,"RAPPING","RAP_A_Loop",4.0,1,1,1,1,0);
CMD:rap2(playerid, params[]) return ApplyAnimation(playerid,"RAPPING","RAP_B_Loop",4.0,1,1,1,1,0);
CMD:rap3(playerid, params[]) return ApplyAnimation(playerid,"RAPPING","RAP_C_Loop",4.0,1,1,1,1,0);
CMD:wankoff(playerid, params[]) return ApplyAnimation(playerid,"PAULNMAC","wank_in",4.0,1,1,1,1,0);
CMD:wank(playerid, params[]) return ApplyAnimation(playerid,"PAULNMAC","wank_loop",4.0,1,1,1,1,0);
CMD:strip(playerid, params[]) return ApplyAnimation(playerid,"STRIP","strip_A",4.0,1,1,1,1,0);
CMD:strip2(playerid, params[]) return ApplyAnimation(playerid,"STRIP","strip_B",4.0,1,1,1,1,0);
CMD:strip3(playerid, params[]) return ApplyAnimation(playerid,"STRIP","strip_C",4.0,1,1,1,1,0);
CMD:strip4(playerid, params[]) return ApplyAnimation(playerid,"STRIP","strip_D",4.0,1,1,1,1,0);
CMD:strip5(playerid, params[]) return ApplyAnimation(playerid,"STRIP","strip_E",4.0,1,1,1,1,0);
CMD:strip6(playerid, params[]) return ApplyAnimation(playerid,"STRIP","strip_F",4.0,1,1,1,1,0);
CMD:strip7(playerid, params[]) return ApplyAnimation(playerid,"STRIP","strip_G",4.0,1,1,1,1,0);
CMD:sexy(playerid, params[]) return ApplyAnimation(playerid,"SNM","SPANKING_IDLEW",4.1,0,1,1,1,1);
CMD:sexy2(playerid, params[]) return ApplyAnimation(playerid,"SNM","SPANKING_IDLEP",4.1,0,1,1,1,1);
CMD:sexy3(playerid, params[]) return ApplyAnimation(playerid,"SNM","SPANKINGW",4.1,0,1,1,1,1);
CMD:sexy4(playerid, params[]) return ApplyAnimation(playerid,"SNM","SPANKINGP",4.1,0,1,1,1,1);
CMD:sexy5(playerid, params[]) return ApplyAnimation(playerid,"SNM","SPANKEDW",4.1,0,1,1,1,1);
CMD:sexy6(playerid, params[]) return ApplyAnimation(playerid,"SNM","SPANKEDP",4.1,0,1,1,1,1);
CMD:sexy7(playerid, params[]) return ApplyAnimation(playerid,"SNM","SPANKING_ENDW",4.1,0,1,1,1,1);
CMD:sexy8(playerid, params[]) return ApplyAnimation(playerid,"SNM","SPANKING_ENDP",4.1,0,1,1,1,1);
CMD:bj(playerid, params[]) return ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_START_P",4.1,0,1,1,1,1);
CMD:bj2(playerid, params[]) return ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_START_W",4.1,0,1,1,1,1);
CMD:bj3(playerid, params[]) return ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_LOOP_P",4.1,0,1,1,1,1);
CMD:bj4(playerid, params[]) return ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_LOOP_W",4.1,0,1,1,1,1);
CMD:cellin(playerid, params[]) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
CMD:cellout(playerid, params[]) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
CMD:lean(playerid, params[]) return ApplyAnimation(playerid,"GANGS","leanIDLE", 4.0, 1, 0, 0, 0, 0);
CMD:piss(playerid, params[]) return SetPlayerSpecialAction(playerid, 68);
CMD:follow(playerid, params[]) return ApplyAnimation(playerid,"WUZI","Wuzi_follow",4.0,0,0,0,0,0);
CMD:greet(playerid, params[]) return ApplyAnimation(playerid,"WUZI","Wuzi_Greet_Wuzi",4.0,0,0,0,0,0);
CMD:stand(playerid, params[]) return ApplyAnimation(playerid,"WUZI","Wuzi_stand_loop", 4.0, 1, 0, 0, 0, 0);
CMD:injured2(playerid, params[]) return ApplyAnimation(playerid,"SWAT","gnstwall_injurd", 4.0, 1, 0, 0, 0, 0);
CMD:hitch(playerid, params[]) return ApplyAnimation(playerid,"MISC","Hiker_Pose", 4.0, 1, 0, 0, 0, 0);
CMD:bitchslap(playerid, params[]) return ApplyAnimation(playerid,"MISC","bitchslap",4.0,0,0,0,0,0);
CMD:cpr(playerid, params[]) return ApplyAnimation(playerid,"MEDIC","CPR", 4.0, 1, 0, 0, 0, 0);
CMD:gsign1(playerid, params[]) return ApplyAnimation(playerid,"GHANDS","gsign1",4.0,0,1,1,1,1);
CMD:gsign2(playerid, params[]) return ApplyAnimation(playerid,"GHANDS","gsign2",4.0,0,1,1,1,1);
CMD:gsign3(playerid, params[]) return ApplyAnimation(playerid,"GHANDS","gsign3",4.0,0,1,1,1,1);
CMD:gsign4(playerid, params[]) return ApplyAnimation(playerid,"GHANDS","gsign4",4.0,0,1,1,1,1);
CMD:gsign5(playerid, params[]) return ApplyAnimation(playerid,"GHANDS","gsign5",4.0,0,1,1,1,1);
CMD:gift(playerid, params[]) return ApplyAnimation(playerid,"KISSING","gift_give",4.0,0,0,0,0,0);
CMD:chairsit(playerid, params[]) return ApplyAnimation(playerid,"PED","SEAT_idle", 4.0, 1, 0, 0, 0, 0);
CMD:injured(playerid, params[]) return ApplyAnimation(playerid,"SWEET","Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0);
CMD:slapped(playerid, params[]) return ApplyAnimation(playerid,"SWEET","ho_ass_slapped",4.0,0,0,0,0,0);
CMD:slapass(playerid, params[]) return ApplyAnimation(playerid,"SWEET","sweet_ass_slap",4.0,0,0,0,0,0);
CMD:drunk(playerid, params[]) return ApplyAnimation(playerid,"PED","WALK_DRUNK",4.1,1,1,1,1,1);
CMD:skate(playerid, params[]) return ApplyAnimation(playerid,"SKATE","skate_run",4.1,1,1,1,1,1);
CMD:gwalk(playerid, params[]) return ApplyAnimation(playerid,"PED","WALK_gang1",4.1,1,1,1,1,1);
CMD:gwalk2(playerid, params[]) return ApplyAnimation(playerid,"PED","WALK_gang2",4.1,1,1,1,1,1);
CMD:limp(playerid, params[]) return ApplyAnimation(playerid,"PED","WALK_old",4.1,1,1,1,1,1);
CMD:eatsit(playerid, params[]) return ApplyAnimation(playerid,"FOOD","FF_Sit_Loop", 4.0, 1, 0, 0, 0, 0);
CMD:celebrate(playerid, params[]) return ApplyAnimation(playerid,"benchpress","gym_bp_celebrate", 4.0, 1, 0, 0, 0, 0);
CMD:win(playerid, params[]) return ApplyAnimation(playerid,"CASINO","cards_win", 4.0, 1, 0, 0, 0, 0);
CMD:win2(playerid, params[]) return ApplyAnimation(playerid,"CASINO","Roulette_win", 4.0, 1, 0, 0, 0, 0);
CMD:yes(playerid, params[]) return ApplyAnimation(playerid,"CLOTHES","CLO_Buy", 4.0, 1, 0, 0, 0, 0);
CMD:deal2(playerid, params[]) return ApplyAnimation(playerid,"DEALER","DRUGS_BUY", 4.0, 1, 0, 0, 0, 0);
CMD:thankyou(playerid, params[]) return ApplyAnimation(playerid,"FOOD","SHP_Thank", 4.0, 1, 0, 0, 0, 0);
CMD:invite1(playerid, params[]) return ApplyAnimation(playerid,"GANGS","Invite_Yes",4.1,0,1,1,1,1);
CMD:invite2(playerid, params[]) return ApplyAnimation(playerid,"GANGS","Invite_No",4.1,0,1,1,1,1);
CMD:celebrate2(playerid, params[]) return ApplyAnimation(playerid,"GYMNASIUM","gym_tread_celebrate", 4.0, 1, 0, 0, 0, 0);
CMD:sit(playerid, params[]) return ApplyAnimation(playerid,"INT_OFFICE","OFF_Sit_Type_Loop", 4.0, 1, 0, 0, 0, 0);
CMD:scratch(playerid, params[]) return ApplyAnimation(playerid,"MISC","Scratchballs_01", 4.0, 1, 0, 0, 0, 0);
CMD:bomb(playerid, params[]) return ClearAnimations(playerid), ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
CMD:getarrested(playerid, params[]) return ApplyAnimation(playerid,"ped", "ARRESTgun", 4.0, 0, 1, 1, 1, -1);
CMD:laugh(playerid, params[]) return ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0);
CMD:lookout(playerid, params[]) return ApplyAnimation(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0);
CMD:robman(playerid, params[]) return ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0);
CMD:crossarms(playerid, params[]) return ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1);
CMD:crossarms2(playerid, params[]) return ApplyAnimation(playerid, "DEALER", "DEALER_IDLE", 4.0, 0, 1, 1, 1, -1);
CMD:crossarms3(playerid, params[]) return ApplyAnimation(playerid, "DEALER", "DEALER_IDLE_01", 4.0, 0, 1, 1, 1, -1);
CMD:lay(playerid, params[]) return ApplyAnimation(playerid,"BEACH", "bather", 4.0, 1, 0, 0, 0, 0);
CMD:vomit(playerid, params[]) return ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0);
CMD:eat(playerid, params[]) return ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0);
CMD:wave(playerid, params[]) return ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0);
CMD:deal(playerid, params[]) return ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 3.0, 0, 0, 0, 0, 0);
CMD:crack(playerid, params[]) return ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
CMD:smokem(playerid, params[]) return ApplyAnimation(playerid,"SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0);
CMD:smokef(playerid, params[]) return ApplyAnimation(playerid, "SMOKING", "F_smklean_loop", 4.0, 1, 0, 0, 0, 0);
CMD:msit(playerid, params[]) return ApplyAnimation(playerid,"BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0);
CMD:fsit(playerid, params[]) return ApplyAnimation(playerid,"BEACH", "ParkSit_W_loop", 4.0, 1, 0, 0, 0, 0);
CMD:chat(playerid, params[]) return ApplyAnimation(playerid,"PED","IDLE_CHAT",4.1,1,1,1,1,1);
CMD:fucku(playerid, params[]) return ApplyAnimation(playerid,"PED","fucku",4.0,0,0,0,0,0);
CMD:taichi(playerid, params[]) return ApplyAnimation(playerid,"PARK","Tai_Chi_Loop", 4.0, 1, 0, 0, 0, 0);
CMD:relax(playerid, params[]) return ApplyAnimation(playerid,"BEACH","Lay_Bac_Loop", 4.0, 1, 0, 0, 0, 0);
CMD:bat1(playerid, params[]) return ApplyAnimation(playerid,"BASEBALL","Bat_IDLE", 4.0, 1, 0, 0, 0, 0);
CMD:bat2(playerid, params[]) return ApplyAnimation(playerid,"BASEBALL","Bat_M", 4.0, 1, 0, 0, 0, 0);
CMD:bat3(playerid, params[]) return ApplyAnimation(playerid,"BASEBALL","BAT_PART", 4.0, 1, 0, 0, 0, 0);
CMD:bat4(playerid, params[]) return ApplyAnimation(playerid,"CRACK","Bbalbat_Idle_01", 4.0, 1, 0, 0, 0, 0);
CMD:bat5(playerid, params[]) return ApplyAnimation(playerid,"CRACK","Bbalbat_Idle_02", 4.0, 1, 0, 0, 0, 0);
CMD:nod(playerid, params[]) return ApplyAnimation(playerid,"COP_AMBIENT","Coplook_nod",4.0,0,0,0,0,0);
CMD:gang1(playerid, params[]) return ApplyAnimation(playerid,"GANGS","hndshkaa",4.0,0,0,0,0,0);
CMD:gang2(playerid, params[]) return ApplyAnimation(playerid,"GANGS","hndshkba",4.0,0,0,0,0,0);
CMD:gang3(playerid, params[]) return ApplyAnimation(playerid,"GANGS","hndshkca",4.0,0,0,0,0,0);
CMD:gang4(playerid, params[]) return ApplyAnimation(playerid,"GANGS","hndshkcb",4.0,0,0,0,0,0);
CMD:gang5(playerid, params[]) return ApplyAnimation(playerid,"GANGS","hndshkda",4.0,0,0,0,0,0);
CMD:gang6(playerid, params[]) return ApplyAnimation(playerid,"GANGS","hndshkea",4.0,0,0,0,0,0);
CMD:gang7(playerid, params[]) return ApplyAnimation(playerid,"GANGS","hndshkfa",4.0,0,0,0,0,0);
CMD:cry1(playerid, params[]) return ApplyAnimation(playerid,"GRAVEYARD","mrnF_loop", 4.0, 1, 0, 0, 0, 0);
CMD:cry2(playerid, params[]) return ApplyAnimation(playerid,"GRAVEYARD","mrnM_loop", 4.0, 1, 0, 0, 0, 0);
CMD:bed1(playerid, params[]) return ApplyAnimation(playerid,"INT_HOUSE","BED_In_L",4.1,0,1,1,1,1);
CMD:bed2(playerid, params[]) return ApplyAnimation(playerid,"INT_HOUSE","BED_In_R",4.1,0,1,1,1,1);
CMD:bed3(playerid, params[]) return ApplyAnimation(playerid,"INT_HOUSE","BED_Loop_L", 4.0, 1, 0, 0, 0, 0);
CMD:bed4(playerid, params[]) return ApplyAnimation(playerid,"INT_HOUSE","BED_Loop_R", 4.0, 1, 0, 0, 0, 0);
CMD:kiss2(playerid, params[]) return ApplyAnimation(playerid,"BD_FIRE","Grlfrd_Kiss_03",4.0,0,0,0,0,0);
CMD:kiss3(playerid, params[]) return ApplyAnimation(playerid,"KISSING","Grlfrd_Kiss_01",4.0,0,0,0,0,0);
CMD:kiss4(playerid, params[]) return ApplyAnimation(playerid,"KISSING","Grlfrd_Kiss_02",4.0,0,0,0,0,0);
CMD:kiss5(playerid, params[]) return ApplyAnimation(playerid,"KISSING","Grlfrd_Kiss_03",4.0,0,0,0,0,0);
CMD:kiss6(playerid, params[]) return ApplyAnimation(playerid,"KISSING","Playa_Kiss_01",4.0,0,0,0,0,0);
CMD:kiss7(playerid, params[]) return ApplyAnimation(playerid,"KISSING","Playa_Kiss_02",4.0,0,0,0,0,0);
CMD:kiss8(playerid, params[]) return ApplyAnimation(playerid,"KISSING","Playa_Kiss_03",4.0,0,0,0,0,0);
CMD:carsit(playerid, params[]) return ApplyAnimation(playerid,"CAR","Tap_hand", 4.0, 1, 0, 0, 0, 0);
CMD:carsit2(playerid, params[]) return ApplyAnimation(playerid,"LOWRIDER","Sit_relaxed", 4.0, 1, 0, 0, 0, 0);
CMD:fwalk(playerid, params[]) return ApplyAnimation(playerid,"ped","WOMAN_walksexy",4.1,1,1,1,1,1);
CMD:mwalk(playerid, params[]) return ApplyAnimation(playerid,"ped","WALK_player",4.1,1,1,1,1,1);
CMD:stretch(playerid, params[]) return ApplyAnimation(playerid,"PLAYIDLES","stretch",4.0,0,0,0,0,0);
CMD:chant(playerid, params[]) return ApplyAnimation(playerid,"RIOT","RIOT_CHANT", 4.0, 1, 0, 0, 0, 0);
CMD:angry(playerid, params[]) return ApplyAnimation(playerid,"RIOT","RIOT_ANGRY",4.0,0,0,0,0,0);
CMD:crack2(playerid, params[]) return ApplyAnimation(playerid, "CRACK", "crckidle2", 4.0, 1, 0, 0, 0, 0);
CMD:ghand1(playerid, params[]) return ApplyAnimation(playerid,"GHANDS","gsign1LH",4.0,0,1,1,1,1);
CMD:ghand2(playerid, params[]) return ApplyAnimation(playerid,"GHANDS","gsign2LH",4.0,0,1,1,1,1);
CMD:ghand3(playerid, params[]) return ApplyAnimation(playerid,"GHANDS","gsign3LH",4.0,0,1,1,1,1);
CMD:ghand4(playerid, params[]) return ApplyAnimation(playerid,"GHANDS","gsign4LH",4.0,0,1,1,1,1);
CMD:ghand5(playerid, params[]) return ApplyAnimation(playerid,"GHANDS","gsign5LH",4.0,0,1,1,1,1);
CMD:exhausted(playerid, params[]) return ApplyAnimation(playerid,"FAT","IDLE_tired", 4.0, 1, 0, 0, 0, 0);
CMD:carsmoke(playerid, params[]) return ApplyAnimation(playerid,"PED","Smoke_in_car", 4.0, 1, 0, 0, 0, 0);
CMD:aim(playerid, params[]) return ApplyAnimation(playerid,"PED","gang_gunstand", 4.0, 1, 0, 0, 0, 0);
CMD:getup(playerid, params[]) return ApplyAnimation(playerid,"PED","getup",4.0,0,0,0,0,0);
CMD:basket1(playerid, params[]) return ApplyAnimation(playerid,"BSKTBALL","BBALL_def_loop", 4.0, 1, 0, 0, 0, 0);
CMD:basket2(playerid, params[]) return ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop", 4.0, 1, 0, 0, 0, 0);
CMD:basket3(playerid, params[]) return ApplyAnimation(playerid,"BSKTBALL","BBALL_pickup",4.0,0,0,0,0,0);
CMD:basket4(playerid, params[]) return ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
CMD:basket5(playerid, params[]) return ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk",4.1,0,1,1,1,1);
CMD:basket6(playerid, params[]) return ApplyAnimation(playerid,"BSKTBALL","BBALL_run",4.1,1,1,1,1,1);
CMD:akick(playerid, params[]) return ApplyAnimation(playerid,"FIGHT_E","FightKick",4.0,0,0,0,0,0);
CMD:box(playerid, params[]) return ApplyAnimation(playerid,"GYMNASIUM","gym_shadowbox",4.1,1,1,1,1,1);
CMD:cockgun(playerid, params[]) return ApplyAnimation(playerid, "SILENCED", "Silence_reload", 3.0, 0, 0, 0, 0, 0);
CMD:bar1(playerid, params[]) return ApplyAnimation(playerid, "BAR", "Barcustom_get", 3.0, 0, 0, 0, 0, 0);
CMD:bar2(playerid, params[]) return ApplyAnimation(playerid, "BAR", "Barcustom_order", 3.0, 0, 0, 0, 0, 0);
CMD:bar3(playerid, params[]) return ApplyAnimation(playerid, "BAR", "Barserve_give", 3.0, 0, 0, 0, 0, 0);
CMD:bar4(playerid, params[]) return ApplyAnimation(playerid, "BAR", "Barserve_glass", 3.0, 0, 0, 0, 0, 0);
CMD:lay2(playerid, params[]) return ApplyAnimation(playerid,"BEACH", "SitnWait_loop_W", 4.0, 1, 0, 0, 0, 0);
CMD:liftup(playerid, params[]) return ApplyAnimation(playerid, "CARRY", "liftup", 3.0, 0, 0, 0, 0, 0);
CMD:putdown(playerid, params[]) return ApplyAnimation(playerid, "CARRY", "putdwn", 3.0, 0, 0, 0, 0, 0);
CMD:joint(playerid, params[]) return ApplyAnimation(playerid,"GANGS","smkcig_prtl",4.0,0,1,1,1,1);
CMD:die(playerid, params[]) return ApplyAnimation(playerid,"KNIFE","KILL_Knife_Ped_Die",4.1,0,1,1,1,1);
CMD:shakehead(playerid, params[]) return ApplyAnimation(playerid, "MISC", "plyr_shkhead", 3.0, 0, 0, 0, 0, 0);
CMD:die2(playerid, params[]) return ApplyAnimation(playerid, "PARACHUTE", "FALL_skyDive_DIE", 4.0, 0, 1, 1, 1, -1);
CMD:aim2(playerid, params[]) return ApplyAnimation(playerid, "SHOP", "SHP_Gun_Aim", 4.0, 0, 1, 1, 1, -1);
CMD:benddown(playerid, params[]) return ApplyAnimation(playerid, "BAR", "Barserve_bottle", 4.0, 0, 0, 0, 0, 0);
CMD:checkout(playerid, params[]) return ApplyAnimation(playerid, "GRAFFITI", "graffiti_Chkout", 4.0, 0, 0, 0, 0, 0);
    
CMD:stats(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    new str3[1800], pGendre[50], pLang[50], pAcc[50], pJob[50], pMuted[10], pFreezed[10], pJailed[10], pFaction[1500], pLeader[10];

	    if(PlayerInfo[playerid][Gendre] == 1) pGendre = "Male";
	    else if(PlayerInfo[playerid][Gendre] == 2) pGendre = "Female";

	    if(PlayerInfo[playerid][Lang] == 1) pLang = "Romana";
	    else if(PlayerInfo[playerid][Lang] == 2) pLang = "English";

	    if(PlayerInfo[playerid][Premium] == 0) pAcc = "No";
	    else if(PlayerInfo[playerid][Premium] > 0)
		{
			if(PlayerInfo[playerid][PremiumDays] > 0) format(pAcc, sizeof(pAcc), "Yes (%d Days)", ((PlayerInfo[playerid][PremiumDays] - gettime())/86400)+1);
			else if(PlayerInfo[playerid][PremiumDays] == 0) pAcc = "Yes";
		}

	    if(PlayerInfo[playerid][Job] == 0) pJob = "None";
	    else if(PlayerInfo[playerid][Job] == 1) pJob = "Farmer";
	    else if(PlayerInfo[playerid][Job] == 2) pJob = "Bus Driver";

	    if(PlayerInfo[playerid][Muted] == 0) pMuted = "No";
	    else if(PlayerInfo[playerid][Muted] == 1) pMuted = "Yes";

	    if(PlayerInfo[playerid][Freeze] == 0) pFreezed = "No";
	    else if(PlayerInfo[playerid][Freeze] == 1) pFreezed = "Yes";

	    if(PlayerInfo[playerid][Jailed] == 0) pJailed = "No";
	    else if(PlayerInfo[playerid][Jailed] == 1) pJailed = "Yes";

	    if(PlayerInfo[playerid][Faction] == 0) pFaction = "No";
	    else if(PlayerInfo[playerid][Faction] > 0)
		{
			new i = PlayerInfo[playerid][Faction];
			strmid(pFaction, FactionInfo[i][fName], 0, strlen(FactionInfo[i][fName]));
		}

	    if(PlayerInfo[playerid][Leader] == 0) pLeader = "No";
	    else if(PlayerInfo[playerid][Leader] > 0) pLeader = "Yes";

	    format(str3, sizeof(str3), "--------------------------------------------------------------------------------------------------------------------------------------\n");
	    SCM(playerid, COLOR_BLUE, str3);
	    format(str3, sizeof(str3), "ACCOUNT NAME: %s | Last Login: %s | Your IP: %s | Account ID: %d\n", GetCleanName(playerid), PlayerInfo[playerid][LastL], GetIP(playerid), PlayerInfo[playerid][ID]);
	    SCM(playerid, COLOR_WHITE, str3);
	    format(str3, sizeof(str3), "Gendre:[%s] Age:[%d] E-Mail:[%s] Language:[%s] Level:[%d]\n", pGendre, PlayerInfo[playerid][Age], PlayerInfo[playerid][Email], pLang, PlayerInfo[playerid][Level]);
	    SCM(playerid, COLOR_WHITE, str3);
	    format(str3, sizeof(str3), " RP:[%d] Paydays:[%d] Cash:[$%d] Bank:[$%d] PPoints:[%d] Job:[%d] Skin:[%d]\n", PlayerInfo[playerid][Respect], PlayerInfo[playerid][Paydays], PlayerInfo[playerid][Money], PlayerInfo[playerid][Bank], PlayerInfo[playerid][PPoints], GetPlayerSkin(playerid));
	    SCM(playerid, COLOR_WHITE, str3);
	    format(str3, sizeof(str3), "Crimes:[%d] Deaths:[%d] Job:[%s] Admin:[%d] Helper:[%d] Wanted:[%d] Muted:[%s]\n", PlayerInfo[playerid][Kills], PlayerInfo[playerid][Deaths], pJob, PlayerInfo[playerid][Admin], PlayerInfo[playerid][Helper], GetPlayerWantedLevel(playerid), pMuted);
	    SCM(playerid, COLOR_WHITE, str3);
	    format(str3, sizeof(str3), "Premium:[%s] Freezed:[%s] Jailed:[%s] Faction:[%s] Rank:[%d] Leader:[%s]", pAcc, pFreezed, pJailed, pFaction, PlayerInfo[playerid][Rank], pLeader);
	    SCM(playerid, COLOR_WHITE, str3);
	    format(str3, sizeof(str3), "--------------------------------------------------------------------------------------------------------------------------------------\n");
	    SCM(playerid, COLOR_BLUE, str3);
	}
	return 1;
}
CMD:changemail(playerid, params[])
{
	SPD(playerid, DIALOG_CHANGEMAIL, DIALOG_STYLE_INPUT, "Change E-Mail", "Scrie noul tau e-mail mai jos.\n\n\
																		   - Ai grija ca email-ul pe care il introduci sa fie valid.\n\
																		   - Email-ul este important pentru siguranta contului tau.", "OK", "Cancel");
	return 1;
}
CMD:changepass(playerid, params[])
{
	SPD(playerid, DIALOG_CHANGEPASS, DIALOG_STYLE_INPUT, "#STEP 1: Confirm your password", "Scrie mai jos parola actuala a contului tau.\n\n\
	                                                                                        - Daca gresesti parola actuala, nu iti vei putea schimba parola.\n\
	                                                                                        - Nu comunica nimanui parola ta veche sau cea noua pentru a evita pierderea contului.", "OK", "Cancel");
	return 1;
}
CMD:buylevel(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 0)
	{
	    new ammount = PlayerInfo[playerid][Level] * 4;
	    new costlevel = (PlayerInfo[playerid][Level] + 1) * 10000;
	    kStr[0] = '\0';

	    if(PlayerInfo[playerid][Respect] < ammount)
	    {
	        format(kStr, sizeof(kStr), "~r~~h~ERROR: ~w~~h~Ai nevoie de ~y~~h~%d ~w~~h~RP pentru a trece la nivelul urmator. (%d/%d)", ammount, PlayerInfo[playerid][Respect], ammount);
	        InfoBox(playerid, 7000, kStr);
	        return 1;
	    }
	    if(PlayerInfo[playerid][Money] < costlevel)
	    {
	        format(kStr, sizeof(kStr), "~r~~h~ERROR: ~w~~h~Ai nevoie de ~g~~h~$~y~~h~%d$ ~w~~h~pentru a trece la nivelul urmator.", PlayerInfo[playerid][Money] - costlevel);
	        InfoBox(playerid, 7000, kStr);
	        return 1;
	    }
	    PlayerInfo[playerid][Respect] -= ammount;
	    PlayerInfo[playerid][Level]++;
	    PlayerInfo[playerid][Money] -= costlevel;

	    GivePlayerMoney(playerid, -costlevel);
	    SetPlayerScore(playerid, PlayerInfo[playerid][Level]);

	    Update(playerid, Respectx);
	    Update(playerid, Levelx);
	    Update(playerid, Moneyx);

	    format(kStr, sizeof(kStr), "Ai avansat la nivelul %d! Ai fost taxat cu -%d RP si -$%d bani.", PlayerInfo[playerid][Level], ammount, costlevel);
	    SCM(playerid, COLOR_YELLOW, kStr);
	}
	return 1;
}
CMD:pay(playerid, params[])
{
	if(PlayerInfo[playerid][Level] < 3) return InfoBox(playerid, 6000, "~r~~h~ERROR: ~w~~h~Ai nevoie de minim nivel 3 pentru a folosi aceasta comanda!");
	if(sscanf(params, "ud", params[0], params[1])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/pay [Name/ID] [ammount]");
	if(params[0] == INVALID_PLAYER_ID) return InfoBox(playerid, 6000, "~r~~h~ERROR: ~w~~h~This player don't exist!");
	if(params[1] < 0 || params[1] > 1000000) return InfoBox(playerid, 6000, "~r~~h~ERROR: ~w~~h~You can pay a player with money between 0$ - 1.000.000$.");
	if(!ProxDetectorS(5.0, playerid, params[0])) return InfoBox(playerid, 6000, "~r~~h~ERROR: ~w~~h~You aren't near on this player!");

	PlayerInfo[playerid][Money] -= params[1];
	GivePlayerMoney(playerid, -params[1]);

	PlayerInfo[params[0]][Money] += params[1];
	GivePlayerMoney(params[0], params[1]);

	kStr[0] = '\0';
	format(kStr, sizeof(kStr), "[PAY] %s(%d) has pay %s(%d) with $%d money.", GetName(playerid), playerid, GetName(params[0]), params[0], params[1]);
	ProxDetector(10.0, playerid, kStr, COLOR_CREAM, COLOR_CREAM, COLOR_CREAM, COLOR_CREAM, COLOR_CREAM);
	return 1;
}

//Clans
CMD:ccommandrank(playerid, params[])
{
	new fcrank, cid = PlayerInfo[playerid][Clan];
	if(sscanf(params, "ii", fcrank)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/ccommandrank [Rankid]");
	
	if(cid > 0 && IsValidClan(cid) > 0 && (PlayerInfo[playerid][cRank] >= ClanInfo[cid][CommandRank] || PlayerInfo[playerid][cLeader] == cid))
	{
		ClanInfo[cid][CommandRank] = fcrank;
		cUpdate(cid, CommandRankx);

		kStr[0] = EOS;
		format(kStr, sizeof(kStr), "LeaderCmd: Rank-ul de comanda al clanului %s a fost schimbat la rank %d.", ClanInfo[cid][Name], fcrank);
		SCM(playerid, COLOR_OR, kStr);
	}
	else SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");
	return 1;
}

CMD:capps(playerid, params[])
{
	new capps;
	if(sscanf(params, "i", capps)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/capps [Status]");
	new cid = PlayerInfo[playerid][Clan];
	if(cid > 0 && IsValidClan(cid) > 0 && (PlayerInfo[playerid][cRank] >= ClanInfo[cid][CommandRank] || PlayerInfo[playerid][cLeader] == cid))
	{
		ClanInfo[cid][Applications] = capps;
		cUpdate(cid, Applicationsx);

		kStr[0] = EOS;
		format(kStr, sizeof(kStr), "LeaderCmd: Ai setat aplicatiile clanului %s la %d.", ClanInfo[cid][Name], capps);
		SCM(playerid, COLOR_OR, kStr);
	}
	else SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");
	return 1;
}

CMD:c(playerid, params[])
{
	new msg[94], string[128];
	if(sscanf(params,"s[94]", msg)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/c(lan) [Message]");

	new fid = PlayerInfo[playerid][Clan];
	if(fid < 0 && !IsValidClan(fid)) return SCM(playerid, COLOR_ERROR, "Nu faci parte dintr-un clan!");
		
	format(string, sizeof(string), "(( CLAN: %s %s says: %s ))", GetPlayerClanRank(playerid), GetName(playerid), msg);
	ClanMessage(fid, COLOR_DARKGOLD, string);
	return 1;
}
alias:c("clan", "clanchat");

CMD:breakcar(playerid, params[])
{
	new Float:x, Float:y, Float:z;
	new cid = PlayerInfo[playerid][Clan];
	
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		if(cid > 0 && IsValidClan(cid) && IsValidVehicle(i))
		{
			GetVehiclePos(i, x, y, z);
			if(IsPlayerInRangeOfPoint(playerid, 5.00, x, y, z))
			{
				if(IsClanVeh(i))
				{
					if(VehInfo[i][Clan] == cid) return InfoBox(playerid, 5000, "~r~~h~ERROR: This car already belongs to your clan!");
					ClanCarBreakTimer[playerid] = SetTimerEx_("BreakCarClan", 1000, true, -1, "ddd", playerid, VehInfo[i][Clan], i);
					i = MAX_VEHICLES + 1;
				}
			}
		}
	}
	return 1;
}

CMD:placecar(playerid, params[])
{
	new cid = PlayerInfo[playerid][Clan];
	new i = GetPlayerVehicleID(playerid);

	if(cid > 0 && IsValidClan(cid) && IsValidVehicle(i) && IsClanVeh(i))
	{
		if(VehInfo[i][Clan] != cid) return InfoBox(playerid, 5000, "~r~~h~ERROR: You can't park this car!");

		GetVehiclePos(i, VehInfo[i][PosX], VehInfo[i][PosY], VehInfo[i][PosZ]);
		GetVehicleZAngle(i, VehInfo[i][PosA]);

		vUpdate(i, PosX);
		vUpdate(i, PosY);
		vUpdate(i, PosZ);
		vUpdate(i, PosA);

		InfoBox(playerid, 5000, "~g~~h~You have successfully parked this car!");
		SetVehicleToRespawn(i);
	}
	return 1;
}

CMD:crankname(playerid, params[])
{
	new frank, frname[32];
	new cid = PlayerInfo[playerid][Clan];
	
	if(cid < 0 && IsValidClan(cid) < 0 && (PlayerInfo[playerid][cRank] <= ClanInfo[cid][CommandRank] || PlayerInfo[playerid][cLeader] != cid)) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You haven't acces to this command!");
	if(sscanf(params, "is[32]", frank, frname)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/crankname [Rankid] [Name]");

	switch(frank)
	{
		case 1:
		{
			ClanInfo[cid][Rank1] = frname;
			cUpdate(cid, Rank1x);

			format(kStr, sizeof(kStr), "LeaderCmd: Numele rank-ului %d al clanului %s a fost setat la %s.", frank, ClanInfo[cid][Name], frname);
			SCM(playerid, COLOR_OR, kStr);
		}
		case 2:
		{
			ClanInfo[cid][Rank2] = frname;
			cUpdate(cid, Rank2x);

			format(kStr, sizeof(kStr), "LeaderCmd: Numele rank-ului %d al clanului %s a fost setat la %s.", frank, ClanInfo[cid][Name], frname);
			SCM(playerid, COLOR_OR, kStr);
		}
		case 3:
		{
			ClanInfo[cid][Rank3] = frname;
			cUpdate(cid, Rank3x);

			format(kStr, sizeof(kStr), "LeaderCmd: Numele rank-ului %d al clanului %s a fost setat la %s.", frank, ClanInfo[cid][Name], frname);
			SCM(playerid, COLOR_OR, kStr);
		}
		case 4:
		{
			ClanInfo[cid][Rank4] = frname;
			cUpdate(cid, Rank4x);

			format(kStr, sizeof(kStr), "LeaderCmd: Numele rank-ului %d al clanului %s a fost setat la %s.", frank, ClanInfo[cid][Name], frname);
			SCM(playerid, COLOR_OR, kStr);
		}
		case 5:
		{
			ClanInfo[cid][Rank5] = frname;
			cUpdate(cid, Rank5x);

			format(kStr, sizeof(kStr), "LeaderCmd: Numele rank-ului %d al clanului %s a fost setat la %s.", frank, ClanInfo[cid][Name], frname);
			SCM(playerid, COLOR_OR, kStr);
		}
		case 6:
		{
			ClanInfo[cid][Rank6] = frname;
			cUpdate(cid, Rank6x);

			format(kStr, sizeof(kStr), "LeaderCmd: Numele rank-ului %d al clanului %s a fost setat la %s.", frank, ClanInfo[cid][Name], frname);
			SCM(playerid, COLOR_OR, kStr);
		}
		case 7:
		{
			ClanInfo[cid][Leader] = frname;
			cUpdate(cid, Leaderx);

			format(kStr, sizeof(kStr), "LeaderCmd: Numele liderului clanului %s a fost setat la %s.", ClanInfo[cid][Name], frname);
			SCM(playerid, COLOR_OR, kStr);
		}
	}
	return 1;
}

CMD:cmotd(playerid, params[])
{
	new cid = PlayerInfo[playerid][Clan], cmotd[128];
	
	if(sscanf(params, "s[128]", cmotd)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/cmotd [Motd]");
	if(cid < 0 && ClanInfo[cid][ID] < 0 && (PlayerInfo[playerid][cRank] <= ClanInfo[cid][CommandRank] || PlayerInfo[playerid][cLeader] != cid)) return SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");

	ClanInfo[cid][Motd] = cmotd;
	cUpdate(cid, Motdx);

	SCM(playerid, COLOR_OR, "LeaderCmd: Motd-ul clanului a fost schimbat cu succes!");
	return 1;
}

CMD:cgiverank(playerid, params[])
{
	new targetid, rank, reason[64];
	new cid = PlayerInfo[playerid][Clan];
	
	if(sscanf(params,"iis[64]", targetid, rank, reason)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/cgiverank [Playerid] [Rank] [Motiv]");
    if(PlayerInfo[targetid][Clan] == cid) return SCM(playerid, COLOR_ERROR, "ERROR: Jucatorul nu face parte din factiunea ta!");
    if(PlayerInfo[targetid][cRank] > PlayerInfo[playerid][cRank]) return SCM(playerid, COLOR_ERROR, "ERROR: Nu poti seta rank-ul acestui jucator!");
    if(rank < 0 && rank > 7) return SCM(playerid, COLOR_ERROR, "ERROR: Acest rank este invalid!");
    if(targetid == INVALID_PLAYER_ID) return SCM(playerid, COLOR_ERROR, "Jucatorul nu este online!");

	if(cid > 0 && IsValidClan(cid) > 0 && (PlayerInfo[playerid][cRank] >= ClanInfo[cid][CommandRank] || PlayerInfo[playerid][Leader] == cid))
	{
		PlayerInfo[targetid][cRank] = rank;
		Update(targetid, cRankx);
		    
		new string[128];
		format(string, sizeof(string), "ClanCmd: I-ai setat rank-ul %s lui %s, motiv: %s.", GetPlayerRank(targetid), GetName(targetid), reason);
   		SCM(playerid, COLOR_DARKCYAN, string);

		format(string, sizeof(string), "ClanCmd: %s ti-a setat rank-ul %s, motiv: %s.", GetName(playerid), GetPlayerRank(targetid), reason);
   		SCM(playerid, COLOR_DARKCYAN, string);

		format(string, sizeof(string), "ClanCmd: %s has set %s's new rank to: %s, reason: %s.", GetName(playerid), GetName(targetid), GetPlayerRank(targetid), reason);
   		SCM(playerid, COLOR_DARKCYAN, string);

		mysql_format(mysql, query, sizeof(query), "INSERT INTO `log_Clans` (`Text`, `Author`, `Victim`, `cID`, `Type`, `Date`) VALUES ('%s', '%d', '%d', '%d', '2', NOW())", string, PlayerInfo[playerid][ID], PlayerInfo[targetid][ID], ClanInfo[cid][ID]);
		mysql_query(mysql, query);
	}
	return 1;
}

CMD:cwarn(playerid, params[])
{
	new targetid, reason[64];
	if(sscanf(params,"is[64]", targetid, reason)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/fwarn [Playerid] [Motiv]");
	if(IsPlayerConnected(targetid))
	{
	    new cid = PlayerInfo[playerid][Clan];
		if(cid > 0 && ClanInfo[cid][ID] > 0 && (PlayerInfo[playerid][cRank] >= ClanInfo[cid][CommandRank] || PlayerInfo[playerid][cLeader] == cid))
		{
		    if(PlayerInfo[targetid][Clan] == cid)
		    {
		        if(PlayerInfo[targetid][cRank] < PlayerInfo[playerid][cRank])
		        {
	            	PlayerInfo[targetid][CWarns]++;
	            	Update(targetid, CWarnsx);
				    new string[128];
					format(string, sizeof(string), "I-ai dat lui %s un clan warn, motiv: %s.", GetName(targetid), reason);
				    SCM(playerid, COLOR_DARKCYAN, string);
					format(string, sizeof(string), "%s ti-a dat un clan warn, motiv: %s.", GetName(playerid), reason);
				    SCM(playerid, COLOR_DARKCYAN, string);
					format(string, sizeof(string), "%s has given a new clan warn to %s, reason: %s.", GetName(playerid), GetName(targetid), GetPlayerClanRank(targetid), reason);
				    SCM(playerid, COLOR_DARKCYAN, string);
					mysql_format(mysql, query, sizeof(query), "INSERT INTO `log_clans` (`Text`, `Author`, `Victim`, `ID`, `Type`, `Date`) VALUES ('%s', '%d', '%d', '%d', '3', NOW())", string, PlayerInfo[playerid][ID], PlayerInfo[targetid][ID], ClanInfo[cid][ID]);
					mysql_query(mysql, query);
					if(PlayerInfo[targetid][CWarns] == 3)
					{
						format(string, sizeof(string), "%s has been uninvited from the clan by %s with 24 FPunish, reason: %s(3/3 Warns).", GetName(targetid), GetName(playerid), reason);
					    ClanMessage(cid, COLOR_DARKGOLD, string);
				        PlayerInfo[targetid][Clan] = 0;
				        PlayerInfo[targetid][cRank] = 0;
				        PlayerInfo[targetid][cLeader] = 0;
				        PlayerInfo[targetid][CWarns] = 0;
						ClanInfo[cid][Members]--;
						cUpdate(playerid, Membersx);
				        SetPlayerColor(targetid, 0xFFFFFFFF);
				        ResetPlayerWeapons(targetid);
				        
						if(IsPlayerInAnyVehicle(targetid) && GetPlayerVehicleSeat(targetid) == 0) RemovePlayerFromVehicle(targetid);

						Update(targetid, Clanx);
						Update(targetid, Rankx);
						Update(targetid, Leaderx);
						Update(targetid, CWarnsx);
						RespawnPlayer(targetid);
						mysql_format(mysql, query, sizeof(query), "INSERT INTO `log_clans` (`Text`, `Author`, `Victim`, `ID`, `Type`, `Date`) VALUES ('%s', '%d', '%d', '%d', '2', NOW())", string, PlayerInfo[playerid][ID], PlayerInfo[targetid][ID], ClanInfo[cid][ID]);
						mysql_query(mysql, query);
					}
		        }
			    else SCM(playerid, COLOR_ERROR, "ERROR: Nu poti oferii un warn acestui jucator!");
			}
		    else SCM(playerid, COLOR_ERROR, "ERROR: Jucatorul nu face parte din factiunea ta!");
		}
		else SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");
	}
	else SCM(playerid, COLOR_ERROR, "Jucatorul nu este online!");
	return 1;
}

CMD:cunwarn(playerid, params[])
{
	new targetid, reason[64];
	if(sscanf(params,"is[64]", targetid, reason)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/cwarn [Playerid] [Motiv]");
	if(IsPlayerConnected(targetid))
	{
	    new cid = PlayerInfo[playerid][Clan];
		if(cid > 0 && ClanInfo[cid][ID] > 0 && (PlayerInfo[playerid][cRank] >= ClanInfo[cid][CommandRank] || PlayerInfo[playerid][cLeader] == cid))
		{
		    if(PlayerInfo[targetid][Clan] == cid)
		    {
		        if(PlayerInfo[targetid][cRank] < PlayerInfo[playerid][cRank])
		        {
		            if(PlayerInfo[targetid][CWarns] > 0)
		            {
		            	PlayerInfo[targetid][CWarns]++;
		            	Update(targetid, CWarnsx);
					    new string[128];
						format(string, sizeof(string), "I-ai scos lui %s un clan warn, motiv: %s.", GetName(targetid), reason);
					    SCM(playerid, COLOR_DARKCYAN, string);
						format(string, sizeof(string), "%s ti-a scos un clan warn, motiv: %s.", GetName(playerid), reason);
					    SCM(playerid, COLOR_DARKCYAN, string);
						format(string, sizeof(string), "%s has removed clan warn from %s, reason: %s.", GetName(playerid), GetName(targetid), GetPlayerClanRank(targetid), reason);
					    SCM(playerid, COLOR_DARKCYAN, string);
						mysql_format(mysql, query, sizeof(query), "INSERT INTO `log_clans` (`Text`, `Author`, `Victim`, `ID`, `Type`, `Date`) VALUES ('%s', '%d', '%d', '%d', '3', NOW())", string, PlayerInfo[playerid][ID], PlayerInfo[targetid][ID], ClanInfo[cid][ID]);
						mysql_query(mysql, query);
					}
				    else SCM(playerid, COLOR_ERROR, "ERROR: Acest jucator nu are nici-un clan warn!");
		        }
			    else SCM(playerid, COLOR_ERROR, "ERROR: Nu poti oferii un warn acestui jucator!");
			}
		    else SCM(playerid, COLOR_ERROR, "ERROR: Jucatorul nu face parte din factiunea ta!");
		}
		else SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");
	}
	else SCM(playerid, COLOR_ERROR, "Jucatorul nu este online!");
	return 1;
}

CMD:cinvite(playerid, params[])
{
	new targetid;
	if(sscanf(params,"i", targetid)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/cinvite [Playerid]");
	if(PlayerInfo[targetid][Clan] > 0 || PlayerInfo[targetid][cLeader] > 0) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~This player is already in a clan!");
	if(IsPlayerConnected(targetid))
	{
	    new cid = PlayerInfo[playerid][Clan];
		if(cid > 0 && ClanInfo[cid][ID] > 0 && (PlayerInfo[playerid][cRank] >= ClanInfo[cid][CommandRank] || PlayerInfo[playerid][cLeader] == cid))
		{
		    if(PlayerInfo[targetid][Clan] == 0)
		    {
		        if(ClanInfo[cid][Members] < ClanInfo[cid][Slots])
		        {
			        PlayerInfo[targetid][Clan] = cid;
			        PlayerInfo[targetid][cRank] = 1;
			        PlayerInfo[targetid][cLeader] = 0;
					Update(targetid, Clanx);
					Update(targetid, cRankx);
					Update(targetid, cLeaderx);
					ClanInfo[cid][Members]++;
					cUpdate(playerid, Membersx);
					new string1[24], nName[24];

					if(ClanInfo[PlayerInfo[playerid][Clan]][Type] == 1)
					{
						format(nName, sizeof(nName), "%s%s", GetName(targetid), ClanInfo[PlayerInfo[targetid][Clan]][Tag]);
					}
					else if(ClanInfo[PlayerInfo[playerid][Clan]][Type] == 0)
					{
						format(nName, sizeof(nName), "%s%s", ClanInfo[PlayerInfo[targetid][Clan]][Tag], GetName(targetid));
					}
					strmid(string1, nName, 0, 24);
					SetPlayerName(targetid, string1);
				    new string[128];
					format(string, sizeof(string), "%s has been invited to the clan by %s.", GetName(targetid), GetName(playerid));
				    ClanMessage(cid, COLOR_DARKGOLD, string);
					mysql_format(mysql, query, sizeof(query), "INSERT INTO `log_clans` (`Text`, `Author`, `Victim`, `ID`, `Type`, `Date`) VALUES ('%s', '%d', '%d', '%d', '1', NOW())", string, PlayerInfo[playerid][ID], PlayerInfo[targetid][ID], ClanInfo[cid][ID]);
					mysql_query(mysql, query);
				}
			    else SCM(playerid, COLOR_ERROR, "ERROR: Clanul este deja plin!");
		    }
		    else SCM(playerid, COLOR_ERROR, "ERROR: Jucatorul deja face parte dintr-un clan!");
		}
		else SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");
	}
	else SCM(playerid, COLOR_ERROR, "Jucatorul nu este online!");
	return 1;
}

CMD:cuninvite(playerid, params[])
{
	new targetid, reason[64];
	if(sscanf(params,"is[64]", targetid, reason)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/cuninvite [Playerid] [Reason]");
	if(IsPlayerConnected(targetid))
	{
	    new cid = PlayerInfo[playerid][Clan];
		if(cid > 0 && ClanInfo[cid][ID] > 0 && (PlayerInfo[playerid][cRank] >= ClanInfo[cid][CommandRank] || PlayerInfo[playerid][cLeader] == cid))
		{
		    if(PlayerInfo[targetid][Clan] == cid)
		    {
		        if(PlayerInfo[targetid][cRank] >= PlayerInfo[playerid][cRank])
		        {
		            SCM(playerid, COLOR_ERROR, "ERROR: Nu poti demite un jucator cu rank mai mare!");
		        }
		        else
		        {
				    new string[128];
					format(string, sizeof(string), "%s has been uninvited from the clan by %s, reason: %s.", GetName(targetid), GetName(playerid), reason);
				    ClanMessage(cid, COLOR_DARKGOLD, string);
				    SetPlayerName(targetid, GetCleanName(targetid));
			        PlayerInfo[targetid][Clan] = 0;
			        PlayerInfo[targetid][cRank] = 0;
			        PlayerInfo[targetid][cLeader] = 0;
				    PlayerInfo[targetid][CWarns] = 0;
					ClanInfo[cid][Members]--;
					cUpdate(playerid, Membersx);
					Update(targetid, Clanx);
					Update(targetid, cRankx);
					Update(targetid, cLeaderx);
					Update(targetid, CWarnsx);
					mysql_format(mysql, query, sizeof(query), "INSERT INTO `log_clans` (`Text`, `Author`, `Victim`, `ID`, `Type`, `Date`) VALUES ('%s', '%d', '%d', '%d', '2', NOW())", string, PlayerInfo[playerid][ID], PlayerInfo[targetid][ID], ClanInfo[cid][ID]);
					mysql_query(mysql, query);
				}
		    }
		    else SCM(playerid, COLOR_ERROR, "ERROR: Jucatorul nu face parte din clanul tau!");
		}
		else SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");
	}
	else SCM(playerid, COLOR_ERROR, "Jucatorul nu este online!");
	return 1;
}

CMD:cmembers(playerid, params[])
{
	new cid = PlayerInfo[playerid][Clan];
	if(cid > 0 && ClanInfo[cid][ID] > 0)
	{
		SCM(playerid, COLOR_WHITE, "========== Membrii clanului ==========");
		new string[128];
	    foreach(Player, i)
		{
		    if(PlayerInfo[i][Clan] == cid)
		    {
		        format(string, sizeof(string), "%s - %s", GetName(i), GetPlayerClanRank(i));
		        SCM(playerid, COLOR_WHITE, string);
		    }
		}
		SCM(playerid, COLOR_WHITE, "===================================");
	}
	else SCM(playerid, COLOR_ERROR, "Nu faci parte dintr-un clan!");
	return 1;
}


//Factions
CMD:exit(playerid, params[])
{
	for(new i = 1;i < MAX_FACTIONS; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, FactionInfo[i][fIntX], FactionInfo[i][fIntY], FactionInfo[i][fIntZ]))
		{
		    SetPlayerPos(playerid, FactionInfo[i][fExtX], FactionInfo[i][fExtY], FactionInfo[i][fExtZ]);
		    SetPlayerInterior(playerid, 0);
		    
			if(FactionInfo[PlayerInfo[playerid][Faction]][fInWar] == 2) SetPlayerVirtualWorld(playerid, FactionInfo[i][fAttackedTurf] + 999);
			else SetPlayerVirtualWorld(playerid, 0);

			i = MAX_FACTIONS + 1;
		}
	}
	return 1;
}
CMD:turfs(playerid, params[])
{
    if(PlayerInfo[playerid][tView] == 0)
    {
		for(new i = 0; i < sizeof(Turfs) && Turfs[i][Faction] > 0; i++)
		{
		    GangZoneShowForPlayer(playerid, Turfs[i][ID], ((FactionInfo[Turfs[i][Faction]][fColor] & ~0xFF) | 0x99), 0x000000FF);
		}
		foreach(Player, i)
		{
		   IsTurfAttacked(i);
		}
		PlayerInfo[playerid][tView] = 1;
    }
    else
    {
    	for(new i=0; i < sizeof(Turfs) && Turfs[i][Faction] > 0;i++)
		{
	        GangZoneHideForPlayer(playerid, Turfs[i][ID]);
        }
	   	PlayerInfo[playerid][tView] = 0;
    }
	return 1;
}
CMD:enter(playerid, params[])
{
	for(new i = 1;i < MAX_FACTIONS; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, FactionInfo[i][fExtX], FactionInfo[i][fExtY], FactionInfo[i][fExtZ]) && PlayerInfo[playerid][Faction] == FactionInfo[i][fID])
		{
		    SetPlayerPos(playerid, FactionInfo[i][fIntX], FactionInfo[i][fIntY], FactionInfo[i][fIntZ]);
		    SetPlayerInterior(playerid, FactionInfo[i][fInt]);
		    SetPlayerVirtualWorld(playerid, FactionInfo[i][fVW]);
			i = MAX_FACTIONS + 1;
		}
	}
	return 1;
}

CMD:fmotd(playerid, params[])
{
	new fid, fmotd[128];
	if(sscanf(params, "s[128]", fmotd)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/fmotd [Motd]");
	fid = PlayerInfo[playerid][Faction];
	if(fid > 0 && FactionInfo[fid][fID] > 0 && (PlayerInfo[playerid][Rank] >= FactionInfo[fid][fCommandRank] || PlayerInfo[playerid][Leader] == fid))
	{
		FactionInfo[fid][fMotd] = fmotd;
		fUpdate(fid, Motdx);
		SCM(playerid, COLOR_OR, "Motd-ul factiunii a fost schimbat cu succes!");
	}
	else SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");
	return 1;
}

CMD:fapps(playerid, params[])
{
	new fapps;
	if(sscanf(params, "i", fapps)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/fapps [Status]");
	new fid = PlayerInfo[playerid][Faction];
	if(fid > 0 && IsValidFaction(fid) > 0 && (PlayerInfo[playerid][Rank] >= FactionInfo[fid][fCommandRank] || PlayerInfo[playerid][Leader] == fid))
	{
		FactionInfo[fid][fApplications] = fapps;
		fUpdate(fid, Applicationsx);

		kStr[0] = EOS;
		format(kStr, sizeof(kStr), "LeaderCmd: Ai setat aplicatiile factiunii %s la %d.", FactionInfo[fid][fName], fapps);
		SCM(playerid, COLOR_OR, kStr);
	}
	else SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");
	return 1;
}


CMD:turfinfo(playerid, params[])
{
	new string[128], turf;
	if(IsPlayerInAnyGangZone(playerid))
	{
		turf = GetTurfID(GetPlayerGangZone(playerid));
		format(string, sizeof(string), "You are on turf: %d, the turf belongs to: %s, turf color: %s", turf, FactionInfo[Turfs[turf][Faction]][fName], FactionInfo[Turfs[turf][Faction]][fColor]);
		SCM(playerid, COLOR_OR, string);
	}
	return 1;
}

CMD:turfattack(playerid, params[])
{
	new fid = PlayerInfo[playerid][Faction];
	if(fid > 0 && FactionInfo[fid][fID] > 0 && (PlayerInfo[playerid][Rank] >= FactionInfo[fid][fCommandRank] || PlayerInfo[playerid][Leader] == fid))
	{
		if(IsPlayerInAnyGangZone(playerid))
		{
		    new turf = GetTurfID(GetPlayerGangZone(playerid));
			if(FactionInfo[fid][fType] == 9)
			{
			    if(turf >= 0)
			    {
					if(Turfs[turf][Faction] != fid)
					{
					    if(FactionInfo[fid][fInWar] == 0)
					    {
						    if(FactionInfo[Turfs[turf][Faction]][fInWar] == 0)
						    {
								new Hour, Minute, Second;
								gettime(Hour, Minute, Second);
								if(Hour >= ServerInfo[WarMinHour] && Hour < ServerInfo[WarMaxHour])
								{
									Turfs[turf][Attacker] = fid;
									Turfs[turf][isAttacked] = 1;
								    FactionInfo[fid][fInWar] = 1;
								    FactionInfo[fid][fAttackedTurf] = turf;
								    FactionInfo[Turfs[turf][Faction]][fAttackedTurf] = turf;
								    FactionInfo[Turfs[turf][Faction]][fInWar] = 3;
								    new string[128];
								    format(string, sizeof(string), "FACTION: %s a trimis declaratie de razboi factiunii %s pe teritoriul %s.", GetName(playerid), FactionInfo[Turfs[turf][Faction]][fName], Turfs[turf][Name]);
									FactionMessage(fid, COLOR_DARKCYAN, string);
								    format(string, sizeof(string), "FACTION: %s v-a trimis declaratie de razboi pentru teritoriul %s.", FactionInfo[fid][fName], Turfs[turf][Name]);
								    FactionMessage(Turfs[turf][Faction], COLOR_OR, string);
						    		printf("Turf attacked: %d by faction: %d", turf, fid);
								}
								else SCM(playerid, COLOR_ERROR, "ERROR: Nu poti declara razboi la ora aceasta!");
							}
							else SCM(playerid, COLOR_ERROR, "ERROR: Factiunii cui apartine turf-ul i-a fost declarat sau este in razboi!");
						}
						else SCM(playerid, COLOR_ERROR, "ERROR: Factiunea ta deja a declarat sau este in razboi!");
					}
					else SCM(playerid, COLOR_ERROR, "ERROR: Acest turf apartine deja factiunii tale!");
				}
				else SCM(playerid, COLOR_ERROR, "ERROR: Acest turf este invalid!");
			}
			else SCM(playerid, COLOR_ERROR, "ERROR: Nu faci parte dintr-o mafie sau un gang!");
		}
		else SCM(playerid, COLOR_ERROR, "ERROR: Nu te aflii pe niciun turf!");
	}
	else SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");
	return 1;
}


CMD:acceptwar(playerid, params[])
{
	new fid = PlayerInfo[playerid][Faction];
	if(fid > 0 && FactionInfo[fid][fID] > 0 && (PlayerInfo[playerid][Rank] >= FactionInfo[fid][fCommandRank] || PlayerInfo[playerid][Leader] == fid))
	{
		if(FactionInfo[fid][fInWar] == 3)
		{
		    new turf = FactionInfo[fid][fAttackedTurf];
			if(Turfs[turf][Faction] == fid)
			{
				new Hour, Minute, Second;
				gettime(Hour, Minute, Second);
				if(Hour >= ServerInfo[WarMinHour] && Hour < ServerInfo[WarMaxHour])
				{
					Turfs[turf][isAttacked] = 2;
				    FactionInfo[fid][fInWar] = 2;
				    FactionInfo[Turfs[turf][Faction]][fInWar] = 2;
				    printf("Turf accepted: %d", turf);
					foreach(Player, i)
					{
					   IsTurfAttacked(i);
					}
				    new string[128];
				    format(string, sizeof(string), "FACTION: Ai acceptat declaratia de razboi de la factiunea %s.", FactionInfo[Turfs[turf][Attacker]][fName]);
				    SCM(playerid, COLOR_OR, string);
				    format(string, sizeof(string), "FACTION: %s a acceptat declaratia de razboi de la factiunea %s.", GetName(playerid), FactionInfo[Turfs[turf][Attacker]][fName]);
					FactionMessage(fid, COLOR_DARKCYAN, string);
					new fidi, def, atk;
				    def = Turfs[turf][Faction];
				    atk = Turfs[turf][Attacker];
				    format(string, sizeof(string), "FACTION: Razboiul cu factiunea %s pentru turf-ul %s a inceput.", FactionInfo[Turfs[turf][Faction]][fName], Turfs[turf][Name]);
					FactionMessage(atk, COLOR_DARKCYAN, string);
					foreach(Player, i)
					{
					    fidi = PlayerInfo[i][Faction];
						if((def == fidi || atk == fidi) && Turfs[turf][isAttacked] == 2 && GetTurfID(GetPlayerGangZone(i)) == turf)
						{
						    SetPlayerVirtualWorld(i, FactionInfo[i][fAttackedTurf] + 999);
						    FactionInfo[fidi][fOnTurf]++;
							format(string, sizeof(string), "On turf: %i - %i", FactionInfo[def][fOnTurf], FactionInfo[atk][fOnTurf]);
							PlayerTextDrawSetString(i, WarTD[i][3], string);
							format(string, sizeof(string), "Turf: %s", Turfs[turf][Name]);
							PlayerTextDrawSetString(i, WarTD[i][1], string);
							format(string, sizeof(string), "%s %i - %i %s", FactionInfo[def][fName], FactionInfo[def][fScore], FactionInfo[atk][fScore], FactionInfo[atk][fName]);
							PlayerTextDrawSetString(i, WarTD[i][2], string);
							for(new x = 0; x < 7; x++)
							{
								PlayerTextDrawShow(i, WarTD[i][x]);
							}
						}
					}
					SetTimerEx_("WarTimer", 1000, true, -1, "i", turf);
				}
				else SCM(playerid, COLOR_ERROR, "ERROR: Nu poti declara razboi la ora aceasta!");
			}
			else SCM(playerid, COLOR_ERROR, "ERROR: Acest turf nu apartine factiunii tale!");
		}
		else SCM(playerid, COLOR_ERROR, "ERROR: Nu ti-a declarat nimeni razboi!");
	}
	else SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");
	return 1;
}

CMD:fcr(playerid, params[])
{
	new fid;
	fid = PlayerInfo[playerid][Faction];
	if(fid > 0 && FactionInfo[fid][fID] > 0 && (PlayerInfo[playerid][Rank] >= FactionInfo[fid][fCommandRank] || PlayerInfo[playerid][Leader] == fid))
	{
		for(new i;i < (Total_Veh_Created + 1);i++)
		{
		    if(VehInfo[i][Faction] == fid)
		    {
		        if(IsVehicleOccupied(i) == 0)
			    {
					SetVehicleToRespawn(i);
		        	VehInfo[i][Fuel] = 100;
			    }
		    }
		}
		new string[128];
		format(string, sizeof(string), "%s a respawnat masinile factiunii.", GetName(playerid));
		FactionMessage(fid, COLOR_DARKCYAN, string);
	}
	else SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");
	return 1;
}

CMD:f(playerid, params[])
{
	new msg[94], string[128];
	if(sscanf(params,"s[94]", msg)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/f(action) [Message]");
	if(IsPlayerConnected(playerid))
	{
	    new fid = PlayerInfo[playerid][Faction];
		if(fid > 0 && FactionInfo[fid][fID] > 0)
		{
			format(string, sizeof(string), "(( FACTION: %s %s says: %s ))", GetPlayerRank(playerid), GetName(playerid), msg);
		    FactionMessage(fid, COLOR_DARKCYAN, string);
		}
		else
		{
		    SCM(playerid, COLOR_ERROR, "Nu faci parte dintr-o factiune!");
		}
	}
	return 1;
}
alias:f("faction", "factionchat");

CMD:order(playerid, params[])
{
	new order;
	if(sscanf(params,"i", order)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/order [1/2/3/4]");
    new fid = PlayerInfo[playerid][Faction];
	if(fid > 0 && FactionInfo[fid][fID] > 0)
	{
		if(IsPlayerInRangeOfPoint(playerid, 500.0, FactionInfo[fid][fIntX], FactionInfo[fid][fIntY], FactionInfo[fid][fIntZ]))
		{
		    switch(order)
		    {
		        case 1:
		        {
		            if(PlayerInfo[playerid][Money] >= 500)
		            {
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder1][0], 1000);
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder1][1], 1000);
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder1][2], 1000);
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder1][3], 1000);
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder1][4], 1000);
						PlayerInfo[playerid][Money] = PlayerInfo[playerid][Money] - 500;
						ResetPlayerMoney(playerid);
						GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);
						SCM(playerid, COLOR_DARKCYAN, "Order cumparat cu succes.");
					}
					else
					{
					    SCM(playerid, COLOR_ERROR, "Nu ai destui bani!");
					}
		        }
		        case 2:
		        {
		            if(PlayerInfo[playerid][Money] >= 1000)
		            {
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder2][0], 1000);
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder2][1], 1000);
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder2][2], 1000);
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder2][3], 1000);
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder2][4], 1000);
						PlayerInfo[playerid][Money] = PlayerInfo[playerid][Money] - 1000;
						ResetPlayerMoney(playerid);
						GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);
						SCM(playerid, COLOR_DARKCYAN, "Order cumparat cu succes.");
					}
					else
					{
					    SCM(playerid, COLOR_ERROR, "Nu ai destui bani!");
					}
		        }
		        case 3:
		        {
		            if(PlayerInfo[playerid][Money] >= 1500)
		            {
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder3][0], 1000);
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder3][1], 1000);
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder3][2], 1000);
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder3][3], 1000);
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder3][4], 1000);
						PlayerInfo[playerid][Money] = PlayerInfo[playerid][Money] - 1500;
						ResetPlayerMoney(playerid);
						GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);
						SCM(playerid, COLOR_DARKCYAN, "Order cumparat cu succes.");
					}
					else
					{
					    SCM(playerid, COLOR_ERROR, "Nu ai destui bani!");
					}
		        }
		        case 4:
		        {
		            if(PlayerInfo[playerid][Money] >= 2000)
		            {
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder4][0], 1000);
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder4][1], 1000);
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder4][2], 1000);
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder4][3], 1000);
			        	GivePlayerWeapon(playerid, FactionInfo[fid][fOrder4][4], 1000);
						PlayerInfo[playerid][Money] = PlayerInfo[playerid][Money] - 2000;
						ResetPlayerMoney(playerid);
						GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);
						SCM(playerid, COLOR_DARKCYAN, "Order cumparat cu succes.");
					}
					else SCM(playerid, COLOR_ERROR, "Nu ai destui bani!");
		        }
		    }
		}
		else SCM(playerid, COLOR_ERROR, "Nu te aflii la pozitia corecta!");
	}
	else SCM(playerid, COLOR_ERROR, "Nu faci parte dintr-o factiune!");
	return 1;
}
CMD:armor(playerid, params[])
{
    new fid = PlayerInfo[playerid][Faction];
	if(fid > 0 && FactionInfo[fid][fID] > 0)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, FactionInfo[fid][fIntX], FactionInfo[fid][fIntY], FactionInfo[fid][fIntZ]))
		{
			PlayerInfo[playerid][Money] = PlayerInfo[playerid][Money] - 100;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);
			Update(playerid, Moneyx);
			SetPlayerArmour(playerid, 100);
		}
		else SCM(playerid, COLOR_ERROR, "Nu te aflii la pozitia corecta!");
	}
	else SCM(playerid, COLOR_ERROR, "Nu faci parte dintr-o factiune!");
	return 1;
}
CMD:heal(playerid, params[])
{
    new fid = PlayerInfo[playerid][Faction];
	if(fid > 0 && FactionInfo[fid][fID] > 0)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, FactionInfo[fid][fIntX], FactionInfo[fid][fIntY], FactionInfo[fid][fIntZ]))
		{
			PlayerInfo[playerid][Money] = PlayerInfo[playerid][Money] - 50;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);
			Update(playerid, Moneyx);
			SetPlayerHealth(playerid, 100);
		}
		else SCM(playerid, COLOR_ERROR, "Nu te aflii la pozitia corecta!");
	}
	else SCM(playerid, COLOR_ERROR, "Nu faci parte dintr-o factiune!");
	return 1;
}
CMD:orderlist(playerid, params[])
{
	new string[128];
	new fid = PlayerInfo[playerid][Faction];
	if(fid > 0 && FactionInfo[fid][fID] > 0)
	{
	    SCM(playerid, COLOR_LIGHTCYAN, "=========== Order list ===========");
		format(string, sizeof(string),"Order 1: %s, %s, %s, %s, %s || Rank: 1 || Price: 500$", GetWeaponNameEx(FactionInfo[fid][fOrder1][0]), GetWeaponNameEx(FactionInfo[fid][fOrder1][1]), GetWeaponNameEx(FactionInfo[fid][fOrder1][2]), GetWeaponNameEx(FactionInfo[fid][fOrder1][3]), GetWeaponNameEx(FactionInfo[fid][fOrder1][4]));
        SCM(playerid, COLOR_LIGHTCYAN, string);
		format(string, sizeof(string),"Order 2: %s, %s, %s, %s, %s || Rank: 3 || Price: 1000$", GetWeaponNameEx(FactionInfo[fid][fOrder2][0]), GetWeaponNameEx(FactionInfo[fid][fOrder2][1]), GetWeaponNameEx(FactionInfo[fid][fOrder2][2]), GetWeaponNameEx(FactionInfo[fid][fOrder2][3]), GetWeaponNameEx(FactionInfo[fid][fOrder2][4]));
        SCM(playerid, COLOR_LIGHTCYAN, string);
		format(string, sizeof(string),"Order 3: %s, %s, %s, %s, %s || Rank: 4 || Price: 1500$", GetWeaponNameEx(FactionInfo[fid][fOrder3][0]), GetWeaponNameEx(FactionInfo[fid][fOrder3][1]), GetWeaponNameEx(FactionInfo[fid][fOrder3][2]), GetWeaponNameEx(FactionInfo[fid][fOrder3][3]), GetWeaponNameEx(FactionInfo[fid][fOrder3][4]));
        SCM(playerid, COLOR_LIGHTCYAN, string);
		format(string, sizeof(string),"Order 4: %s, %s, %s, %s, %s || Rank: 5 || Price: 2000$", GetWeaponNameEx(FactionInfo[fid][fOrder4][0]), GetWeaponNameEx(FactionInfo[fid][fOrder4][1]), GetWeaponNameEx(FactionInfo[fid][fOrder4][2]), GetWeaponNameEx(FactionInfo[fid][fOrder4][3]), GetWeaponNameEx(FactionInfo[fid][fOrder4][4]));
        SCM(playerid, COLOR_LIGHTCYAN, string);
	    SCM(playerid, COLOR_LIGHTCYAN, "==============================");
	}
	else SCM(playerid, COLOR_ERROR, "Nu faci parte dintr-o factiune!");
	return 1;
}

CMD:giverank(playerid, params[])
{
	new targetid, rank, reason[64], fid = PlayerInfo[playerid][Faction];
	if(sscanf(params,"iis[64]", targetid, rank, reason)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/giverank [Playerid] [Rank] [Motiv]");
    if(rank < 0 && rank < 7) return SCM(playerid, COLOR_ERROR, "ERROR: Acest rank este invalid!");
    if(PlayerInfo[targetid][Rank] >= PlayerInfo[playerid][Rank]) return SCM(playerid, COLOR_ERROR, "ERROR: Nu poti seta rank-ul acestui jucator!");
    if(PlayerInfo[targetid][Faction] != fid) return SCM(playerid, COLOR_ERROR, "ERROR: Jucatorul nu face parte din factiunea ta!");
    if(fid <= 0 && FactionInfo[fid][fID] <= 0 && (PlayerInfo[playerid][Rank] < FactionInfo[fid][fCommandRank] || PlayerInfo[playerid][Leader] != fid))
	return SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");
	if(!IsPlayerConnected(targetid)) return SCM(playerid, COLOR_ERROR, "Jucatorul nu este online!");

	PlayerInfo[targetid][Rank] = rank;
	Update(targetid, Rankx);
	SetPlayerSkin(targetid, GetPlayerRankSkin(targetid));
	
 	new string[128];
	format(string, sizeof(string), "I-ai setat rank-ul %s lui %s, motiv: %s.", GetPlayerRank(targetid), GetName(targetid), reason);
 	SCM(playerid, COLOR_DARKCYAN, string);
 	
	format(string, sizeof(string), "%s ti-a setat rank-ul %s, motiv: %s.", GetName(playerid), GetPlayerRank(targetid), reason);
 	SCM(playerid, COLOR_DARKCYAN, string);
 	
	format(string, sizeof(string), "%s has set %s's new rank to: %s, reason: %s.", GetName(playerid), GetName(targetid), GetPlayerRank(targetid), reason);
 	SCM(playerid, COLOR_DARKCYAN, string);
 	
	mysql_format(mysql, query, sizeof(query), "INSERT INTO `log_factions` (`Text`, `Author`, `Victim`, `fID`, `Type`, `Date`) VALUES ('%s', '%d', '%d', '%d', '2', NOW())", string, PlayerInfo[playerid][ID], PlayerInfo[targetid][ID], FactionInfo[fid][fID]);
	mysql_query(mysql, query);
	return 1;
}

CMD:fwarn(playerid, params[])
{
	new targetid, reason[64], fid = PlayerInfo[playerid][Faction], string[128];
	if(sscanf(params,"is[64]", targetid, reason)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/fwarn [Playerid] [Motiv]");
	if(IsPlayerConnected(targetid)) return SCM(playerid, COLOR_ERROR, "Jucatorul nu este online!");
	if(fid <= 0 && FactionInfo[fid][fID] <= 0 && (PlayerInfo[playerid][Rank] < FactionInfo[fid][fCommandRank] || PlayerInfo[playerid][Leader] != fid))
	return SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");
	if(PlayerInfo[targetid][Faction] != fid) return SCM(playerid, COLOR_ERROR, "ERROR: Jucatorul nu face parte din factiunea ta!");
	if(PlayerInfo[targetid][Rank] > PlayerInfo[playerid][Rank]) return SCM(playerid, COLOR_ERROR, "ERROR: Nu poti oferii un warn acestui jucator!");

	PlayerInfo[targetid][FWarns]++;
	Update(targetid, FWarnsx);

	format(string, sizeof(string), "I-ai dat lui %s un faction warn, motiv: %s.", GetName(targetid), reason);
	SCM(playerid, COLOR_DARKCYAN, string);

	format(string, sizeof(string), "%s ti-a dat un faction warn, motiv: %s.", GetName(playerid), reason);
	SCM(playerid, COLOR_DARKCYAN, string);

	format(string, sizeof(string), "%s has given a new faction warn to %s, reason: %s.", GetName(playerid), GetName(targetid), GetPlayerRank(targetid), reason);
	SCM(playerid, COLOR_DARKCYAN, string);

	mysql_format(mysql, query, sizeof(query), "INSERT INTO `log_factions` (`Text`, `Author`, `Victim`, `fID`, `Type`, `Date`) VALUES ('%s', '%d', '%d', '%d', '3', NOW())", string, PlayerInfo[playerid][ID], PlayerInfo[targetid][ID], FactionInfo[fid][fID]);
	mysql_query(mysql, query);

	if(PlayerInfo[targetid][FWarns] == 3)
	{
		format(string, sizeof(string), "%s has been uninvited from the faction by %s with 24 FPunish, reason: %s(3/3 Warns).", GetName(targetid), GetName(playerid), reason);
		FactionMessage(fid, COLOR_DARKCYAN, string);

		PlayerInfo[targetid][Faction] = 0;
		PlayerInfo[targetid][Rank] = 0;
		PlayerInfo[targetid][Leader] = 0;
		PlayerInfo[targetid][FPunish] = 24;
		PlayerInfo[targetid][FWarns] = 0;
		FactionInfo[fid][fMembers]--;
		fUpdate(playerid, Membersx);
		SetPlayerColor(targetid, 0xFFFFFFFF);
		ResetPlayerWeapons(targetid);
				        
		if(IsPlayerInAnyVehicle(targetid) && GetPlayerVehicleSeat(targetid) == 0) RemovePlayerFromVehicle(targetid);

		Update(targetid, Factionx);
		Update(targetid, Rankx);
		Update(targetid, Leaderx);
		Update(targetid, FPunishx);
		Update(targetid, FWarnsx);
		RespawnPlayer(targetid);
						
		mysql_format(mysql, query, sizeof(query), "INSERT INTO `log_factions` (`Text`, `Author`, `Victim`, `fID`, `Type`, `Date`) VALUES ('%s', '%d', '%d', '%d', '2', NOW())", string, PlayerInfo[playerid][ID], PlayerInfo[targetid][ID], FactionInfo[fid][fID]);
		mysql_query(mysql, query);
	}
	return 1;
}

CMD:funwarn(playerid, params[])
{
	new targetid, reason[64];
	if(sscanf(params,"is[64]", targetid, reason)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/fwarn [Playerid] [Motiv]");
	if(IsPlayerConnected(targetid))
	{
	    new fid = PlayerInfo[playerid][Faction];
		if(fid > 0 && FactionInfo[fid][fID] > 0 && (PlayerInfo[playerid][Rank] >= FactionInfo[fid][fCommandRank] || PlayerInfo[playerid][Leader] == fid))
		{
		    if(PlayerInfo[targetid][Faction] == fid)
		    {
		        if(PlayerInfo[targetid][Rank] < PlayerInfo[playerid][Rank])
		        {
		            if(PlayerInfo[targetid][FWarns] > 0)
		            {
		            	PlayerInfo[targetid][FWarns]++;
		            	Update(targetid, FWarnsx);
					    new string[128];
						format(string, sizeof(string), "I-ai scos lui %s un faction warn, motiv: %s.", GetName(targetid), reason);
					    SCM(playerid, COLOR_DARKCYAN, string);
						format(string, sizeof(string), "%s ti-a scos un faction warn, motiv: %s.", GetName(playerid), reason);
					    SCM(playerid, COLOR_DARKCYAN, string);
						format(string, sizeof(string), "%s has removed faction warn from %s, reason: %s.", GetName(playerid), GetName(targetid), GetPlayerRank(targetid), reason);
					    SCM(playerid, COLOR_DARKCYAN, string);
						mysql_format(mysql, query, sizeof(query), "INSERT INTO `log_factions` (`Text`, `Author`, `Victim`, `fID`, `Type`, `Date`) VALUES ('%s', '%d', '%d', '%d', '3', NOW())", string, PlayerInfo[playerid][ID], PlayerInfo[targetid][ID], FactionInfo[fid][fID]);
						mysql_query(mysql, query);
					}
				    else SCM(playerid, COLOR_ERROR, "ERROR: Acest jucator nu are nici-un faction warn!");
		        }
			    else SCM(playerid, COLOR_ERROR, "ERROR: Nu poti oferii un warn acestui jucator!");
			}
		    else SCM(playerid, COLOR_ERROR, "ERROR: Jucatorul nu face parte din factiunea ta!");
		}
		else SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");
	}
	else SCM(playerid, COLOR_ERROR, "Jucatorul nu este online!");
	return 1;
}

CMD:invite(playerid, params[])
{
	new targetid;
	if(sscanf(params,"i", targetid)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/invite [Playerid]");
	if(IsPlayerConnected(targetid))
	{
	    if(PlayerInfo[targetid][FPunish] > 0) return SCM(playerid, COLOR_ERROR, "ERROR: Jucatorul are faction punishment.");
	    new fid = PlayerInfo[playerid][Faction];
		if(fid > 0 && FactionInfo[fid][fID] > 0 && (PlayerInfo[playerid][Rank] >= FactionInfo[fid][fCommandRank] || PlayerInfo[playerid][Leader] == fid))
		{
		    if(PlayerInfo[targetid][Faction] == 0)
		    {
		        if(FactionInfo[fid][fMembers] < FactionInfo[fid][fSlots])
		        {
			        if(FactionInfo[fid][fMinLevel] <= PlayerInfo[targetid][Level])
			        {
				        PlayerInfo[targetid][Faction] = fid;
				        PlayerInfo[targetid][Rank] = 1;
				        PlayerInfo[targetid][Leader] = 0;
						Update(targetid, Factionx);
						Update(targetid, Rankx);
						Update(targetid, Leaderx);
						FactionInfo[fid][fMembers]++;
						fUpdate(playerid, Membersx);
					    new string[128];
						format(string, sizeof(string), "%s has been invited to the faction by %s.", GetName(targetid), GetName(playerid));
					    FactionMessage(fid, COLOR_DARKCYAN, string);
						mysql_format(mysql, query, sizeof(query), "INSERT INTO `log_factions` (`Text`, `Author`, `Victim`, `fID`, `Type`, `Date`) VALUES ('%s', '%d', '%d', '%d', '1', NOW())", string, PlayerInfo[playerid][ID], PlayerInfo[targetid][ID], FactionInfo[fid][fID]);
						mysql_query(mysql, query);
						RespawnPlayer(targetid);
				    }
				    else SCM(playerid, COLOR_ERROR, "ERROR: Jucatorul nu are nivelul necesar pentru a intra in factiune!");
				}
			    else SCM(playerid, COLOR_ERROR, "ERROR: Factiunea este deja plina!");
		    }
		    else SCM(playerid, COLOR_ERROR, "ERROR: Jucatorul deja face parte dintr-o factiune!");
		}
		else SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");
	}
	else SCM(playerid, COLOR_ERROR, "Jucatorul nu este online!");
	return 1;
}

CMD:uninvite(playerid, params[])
{
	new targetid, fp, reason[64];
	if(sscanf(params,"iis[64]", targetid, fp, reason)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/uninvite [Playerid] [FPunish] [Reason]");
	if(fp > 64 || fp < 0) return SCM(playerid, COLOR_ERROR, "ERROR: Faction punishment-ul trebuie sa fie intre 0 si 64!");
	if(IsPlayerConnected(targetid))
	{
	    new fid = PlayerInfo[playerid][Faction];
		if(fid > 0 && FactionInfo[fid][fID] > 0 && (PlayerInfo[playerid][Rank] >= FactionInfo[fid][fCommandRank] || PlayerInfo[playerid][Leader] == fid))
		{
		    if(PlayerInfo[targetid][Faction] == fid)
		    {
		        if(PlayerInfo[targetid][Rank] >= PlayerInfo[playerid][Rank])
		        {
		            SCM(playerid, COLOR_ERROR, "ERROR: Nu poti demite un jucator cu rank mai mare!");
		        }
		        else
		        {
				    new string[128];
					format(string, sizeof(string), "%s has been uninvited from the faction by %s with %d FPunish, reason: %s.", GetName(targetid), GetName(playerid), fp, reason);
				    FactionMessage(fid, COLOR_DARKCYAN, string);
			        PlayerInfo[targetid][Faction] = 0;
			        PlayerInfo[targetid][Rank] = 0;
			        PlayerInfo[targetid][Leader] = 0;
				    PlayerInfo[targetid][FWarns] = 0;
			        PlayerInfo[targetid][FPunish] = fp;
					FactionInfo[fid][fMembers]--;
					fUpdate(playerid, Membersx);
			        SetPlayerColor(targetid, 0xFFFFFFFF);
			        ResetPlayerWeapons(targetid);
					if(IsPlayerInAnyVehicle(targetid) && GetPlayerVehicleSeat(targetid) == 0)
					{
						RemovePlayerFromVehicle(targetid);
					}
					Update(targetid, Factionx);
					Update(targetid, Rankx);
					Update(targetid, Leaderx);
					Update(targetid, FPunishx);
					Update(targetid, FWarnsx);
					RespawnPlayer(targetid);
					mysql_format(mysql, query, sizeof(query), "INSERT INTO `log_factions` (`Text`, `Author`, `Victim`, `fID`, `Type`, `Date`) VALUES ('%s', '%d', '%d', '%d', '2', NOW())", string, PlayerInfo[playerid][ID], PlayerInfo[targetid][ID], FactionInfo[fid][fID]);
					mysql_query(mysql, query);
				}
		    }
		    else SCM(playerid, COLOR_ERROR, "ERROR: Jucatorul nu face parte din factiunea ta!");
		}
		else SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda!");
	}
	else SCM(playerid, COLOR_ERROR, "Jucatorul nu este online!");
	return 1;
}

CMD:fmembers(playerid, params[])
{
	new fid = PlayerInfo[playerid][Faction], string[128];
	if(fid <= 0 && FactionInfo[fid][fID] <= 0) return SCM(playerid, COLOR_ERROR, "Nu faci parte dintr-o factiune!");

	SCM(playerid, COLOR_WHITE, "========== Membrii factiunii ==========");

	foreach(Player, i)
	{
		if(PlayerInfo[i][Faction] == fid)
		{
		    format(string, sizeof(string), "%s - %s", GetName(i), GetPlayerRank(i));
		    SCM(playerid, COLOR_WHITE, string);
		}
	}
	SCM(playerid, COLOR_WHITE, "===================================");
	return 1;
}
CMD:fdeposit(playerid, params[])
{
	new item[8], amount;
	if(sscanf(params,"s[8]i", item, amount)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/fdeposit [Item] [Amount]");
	new fid = PlayerInfo[playerid][Faction];
	if(fid > 0 && FactionInfo[fid][fID] > 0)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, FactionInfo[fid][fIntX], FactionInfo[fid][fIntY], FactionInfo[fid][fIntZ]))
		{
	        if(!strcmp(item, "money", true))
	        {
				if(PlayerInfo[playerid][Money] >= amount)
				{
				    PlayerInfo[playerid][Money] = PlayerInfo[playerid][Money] - amount;
				    FactionInfo[fid][fMoney] = FactionInfo[fid][fMoney] + amount;
					ResetPlayerMoney(playerid);
					GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);
				    Update(playerid, Moneyx);
				    fUpdate(fid, fMoneyx);
				}
				else
				{
				    SCM(playerid, COLOR_ERROR, "Nu ai destui bani!");
				}
	        }
	        else if(!strcmp(item, "mats", true))
	        {
				if(PlayerInfo[playerid][Materials] >= amount)
				{
				    PlayerInfo[playerid][Materials] = PlayerInfo[playerid][Materials] - amount;
				    FactionInfo[fid][fMats] = FactionInfo[fid][fMats] + amount;
				    Update(playerid, Materialsx);
				    fUpdate(fid, fMatsx);
				}
				else
				{
				    SCM(playerid, COLOR_ERROR, "Nu ai destule materiale!");
				}
	        }
	        else if(!strcmp(item, "drugs", true))
	        {
				if(PlayerInfo[playerid][Drugs] >= amount)
				{
				    PlayerInfo[playerid][Drugs] = PlayerInfo[playerid][Drugs] - amount;
				    FactionInfo[fid][fDrugs] = FactionInfo[fid][fDrugs] + amount;
				    Update(playerid, Drugsx);
				    fUpdate(fid, fDrugsx);
				}
				else SCM(playerid, COLOR_ERROR, "Nu ai destule droguri!");
	        }
		}
		else SCM(playerid, COLOR_ERROR, "Nu te aflii la pozitia corecta!");
	}
	else SCM(playerid, COLOR_ERROR, "Nu faci parte dintr-o factiune!");
	return 1;
}

CMD:fbalance(playerid, params[])
{
	new fid = PlayerInfo[playerid][Faction];
	if(fid > 0 && FactionInfo[fid][fID] > 0)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, FactionInfo[fid][fIntX], FactionInfo[fid][fIntY], FactionInfo[fid][fIntZ]))
		{
	        new string[128];
	        SCM(playerid, COLOR_WHITE, "========== Balanta factiune ==========");
	        format(string, sizeof(string), "Bani: %d$", FactionInfo[fid][fMoney]);
	        SCM(playerid, COLOR_WHITE, string);
	        format(string, sizeof(string), "Droguri: %d", FactionInfo[fid][fDrugs]);
	        SCM(playerid, COLOR_WHITE, string);
	        format(string, sizeof(string), "Materiale: %d", FactionInfo[fid][fMats]);
	        SCM(playerid, COLOR_WHITE, string);
	        SCM(playerid, COLOR_WHITE, "==================================");
		}
		else SCM(playerid, COLOR_ERROR, "Nu te aflii la pozitia corecta!");
	}
	else SCM(playerid, COLOR_ERROR, "Nu faci parte dintr-o factiune!");
	return 1;
}

CMD:fwithdraw(playerid, params[])
{
	new item[8], amount;
	if(sscanf(params,"s[8]i", item, amount)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/fdeposit [Item] [Amount]");
	new fid = PlayerInfo[playerid][Faction];
	if(fid > 0 && FactionInfo[fid][fID] > 0 && (PlayerInfo[playerid][Rank] >= FactionInfo[fid][fCommandRank] || PlayerInfo[playerid][Leader] == fid))
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, FactionInfo[fid][fIntX], FactionInfo[fid][fIntY], FactionInfo[fid][fIntZ]))
		{
	        if(!strcmp(item, "money", true))
	        {
				if(FactionInfo[fid][fMoney] >= amount)
				{
				    PlayerInfo[playerid][Money] = PlayerInfo[playerid][Money] + amount;
				    FactionInfo[fid][fMoney] = FactionInfo[fid][fMoney] - amount;
					GivePlayerMoney(playerid, amount);
				    Update(playerid, Moneyx);
				    fUpdate(fid, fMoneyx);
				}
				else SCM(playerid, COLOR_ERROR, "Nu sunt destui bani in depozit!");
	        }
	        else if(!strcmp(item, "mats", true))
	        {
				if(FactionInfo[fid][fMats] >= amount)
				{
				    PlayerInfo[playerid][Materials] = PlayerInfo[playerid][Materials] + amount;
				    FactionInfo[fid][fMats] = FactionInfo[fid][fMats] - amount;
				    Update(playerid, Materialsx);
				    fUpdate(fid, fMatsx);
				}
				else SCM(playerid, COLOR_ERROR, "Nu sunt destule materiale in depozit!");
	        }
	        else if(!strcmp(item, "drugs", true))
	        {
				if(FactionInfo[fid][fDrugs] >= amount)
				{
				    PlayerInfo[playerid][Drugs] = PlayerInfo[playerid][Drugs] + amount;
				    FactionInfo[fid][fDrugs] = FactionInfo[fid][fDrugs] - amount;
				    Update(playerid, Drugsx);
				    fUpdate(fid, fDrugsx);
				}
				else SCM(playerid, COLOR_ERROR, "Nu sunt destule droguri in depozit!");
	        }
		}
		else SCM(playerid, COLOR_ERROR, "Nu te aflii la pozitia corecta!");
	}
	else SCM(playerid, COLOR_ERROR, "Nu faci parte dintr-o factiune sau nu ai rank-ul necesar!");
	return 1;
}

CMD:v(playerid, params[])
{
	for(new i = 0; i < 20; i++) if(PlayerInfo[playerid][Vehicles][i] != 0) SCM(playerid, COLOR_WHITE, VehInfo[PlayerInfo[playerid][Vehicles][i]][Model]);
	return 1;
}

//Dealership
CMD:buyvehicle(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 6.0, 1139.3975,-1761.5178,13.5952))
	{
	    /*//Textdraw version
		TogglePlayerControllable(playerid, 0);
		SetPlayerVirtualWorld(playerid, playerid + 1);
		SetPlayerInterior(playerid, 1);
		SetPlayerPos(playerid, 604.9370, -2.9715, 1003.8300);
		DSID[playerid] = 1;

		DSVeh[playerid] = CreateVehicle(D1Info[DSID[playerid]][d1Model], 613.7783, -2.9987, 1000.5500, 75.7200, 1, 1, -1);

		LinkVehicleToInterior(DSVeh[playerid], 1);
		SetVehicleVirtualWorld(DSVeh[playerid], playerid + 1);
		SetPlayerCameraPos(playerid, 604.9370, -2.9715, 1003.8300);
		SetPlayerCameraLookAt(playerid, 605.9343, -2.9241, 1003.4600);

		kStr[0] = EOS;
		format(kStr, sizeof(kStr), "Model: %s", VehicleNames[D1Info[DSID[playerid]][d1Model] - 400]);
		PlayerTextDrawSetString(playerid, DSTD[3], kStr);

		format(kStr, sizeof(kStr),"Price: ~g~~h~%d", D1Info[DSID[playerid]][d1Price]);
		PlayerTextDrawSetString(playerid, DSTD[4], kStr);

		format(kStr, sizeof(kStr),"Stock: ~g~~h~%d", D1Info[DSID[playerid]][d1Stock]);
		PlayerTextDrawSetString(playerid, DSTD[5], kStr);

		SelectTextDraw(playerid, 0xFFFFFFAA);
		PlayerTextDrawShow(playerid, DSTD[0]);
		PlayerTextDrawShow(playerid, DSTD[1]);
		PlayerTextDrawShow(playerid, DSTD[2]);
		PlayerTextDrawShow(playerid, DSTD[3]);
		PlayerTextDrawShow(playerid, DSTD[4]);
		PlayerTextDrawShow(playerid, DSTD[5]);
		PlayerTextDrawShow(playerid, DSTD[6]);
		PlayerTextDrawShow(playerid, DSTD[7]);
		PlayerTextDrawShow(playerid, DSTD[8]);
		PlayerTextDrawShow(playerid, DSTD[9]);
		PlayerTextDrawShow(playerid, DSTD[10]);
		PlayerTextDrawShow(playerid, DSTD[11]);*/

		//Dialog version
		SPD(playerid, DIALOG_DS, DIALOG_STYLE_MSGBOX, ""SERVER_NAME": Dealership", "Buna, observ ca doresti sa vezi vehiculele disponibile pe acest server.\n\n\
																				    Pentru a putea cumpara o masina, ai nevoie de nivel 3 si bani pentru achizitionarea acesteia.\n\
																				    Cea mai ieftina masina din dealership este Faggio, iar cea mai scumpa este Infernus.\n\n\
																				    Apasa pe butonul 'Next' pentru a vedea lista cu masinile disponibile.", "Next", "Cancel");
	}
	else SCM(playerid, COLOR_ERROR, "Nu esti in apropierea dealership-ului.");
	return 1;
}
CMD:gotods(playerid, params[])
{
	SetPlayerPos(playerid, 1139.3975,-1761.5178,13.5952);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	return 1;
}
//Jobs
CMD:jobs(playerid, params[])
{
	kStr[0] = EOS;
	strcat(kStr, "Job Name\tLevel\n");
	strcat(kStr, "{FFFFFF}Farmer\tLevel 1\n"); //1
	strcat(kStr, "{FFFFFF}Bus Driver\tLevel 1\n"); //2
	strcat(kStr, "{FFFFFF}Pizza Boy\tLevel 1\n"); //3
	strcat(kStr, "{FFFFFF}Trucker\tLevel 1\n"); //4
	SPD(playerid, DIALOG_JOBS, DIALOG_STYLE_TABLIST_HEADERS, "UNNIC: Jobs System", kStr, "Select", "Close");
	return 1;
}
CMD:getjob(playerid, params[])
{
	kStr[0] = EOS;
	if(IsPlayerInRangeOfPoint(playerid, 6.0, -373.7780,-1427.8170,25.7266)) //Farmer
	{
	    if(PlayerInfo[playerid][Job] == 1) return SCM(playerid, COLOR_WHITE, "Esti angajat deja ca fermier!");
	    if(PlayerInfo[playerid][Job] != 0) return SCM(playerid, COLOR_WHITE, "Esti angajat deja intr-un loc de munca!");

	    format(kStr, sizeof(kStr), "Felicitari %s, ai devenit fermier. Urca intr-un tractor pentru a incepe munca!", GetName(playerid));
	    SCM(playerid, COLOR_WHITE, kStr);

	    PlayerInfo[playerid][Job] = 1;
	    Update(playerid, Jobx);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 6.0, 1642.3353,-2238.9849,13.4969)) //Bus Driver
	{
	    if(PlayerInfo[playerid][Job] == 2) return SCM(playerid, COLOR_WHITE, "Esti angajat deja ca sofer de bus!");
	    if(PlayerInfo[playerid][Job] != 0) return SCM(playerid, COLOR_WHITE, "Esti angajat deja intr-un loc de munca!");

	    format(kStr, sizeof(kStr), "Felicitari %s, ai devenit sofer de bus. Urca intr-un autocar pentru a incepe munca!", GetName(playerid));
	    SCM(playerid, COLOR_WHITE, kStr);

	    PlayerInfo[playerid][Job] = 2;
	    Update(playerid, Jobx);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 6.0, 2107.5979,-1788.2808,13.5608)) //Pizza Boy
	{
	    if(PlayerInfo[playerid][Job] == 3) return SCM(playerid, COLOR_WHITE, "You're already employed as pizza boy!");
	    if(PlayerInfo[playerid][Job] != 0) return SCM(playerid, COLOR_WHITE, "Esti angajat deja intr-un loc de munca!");

	    format(kStr, sizeof(kStr), "Felicitari %s, ai devenit pizza boy. Tasteaza /pizza pentru a incepe munca!", GetName(playerid));
	    SCM(playerid, COLOR_WHITE, kStr);

	    PlayerInfo[playerid][Job] = 3;
	    Update(playerid, Jobx);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 6.0, 2433.3757,-2115.3381,13.5469)) //Trucker
	{
	    if(PlayerInfo[playerid][Job] == 3) return SCM(playerid, COLOR_WHITE, "You're already employed as trucker!");
	    if(PlayerInfo[playerid][Job] != 0) return SCM(playerid, COLOR_WHITE, "Esti angajat deja intr-un loc de munca!");

	    format(kStr, sizeof(kStr), "Felicitari %s, ai devenit sofer de tir. Urca intr-un tir pentru a incepe munca!", GetName(playerid));
	    SCM(playerid, COLOR_WHITE, kStr);

	    PlayerInfo[playerid][Job] = 4;
	    Update(playerid, Jobx);
	}
	return 1;
}
CMD:pizza(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    
	if(PlayerInfo[playerid][Job] != 3) return InfoBox(playerid, 500, "~r~~h~ERROR: ~w~~h~You're not employed as pizza boy.");
	if(Working[playerid] == 1) return SCM(playerid, COLOR_WHITE, "Esti deja in decursul muncii!");
	if(!IsPizzaBoyVeh(vehicleid)) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~Nu esti intr-un scuter pentru a livra pizza!");
	
	new rand = random(sizeof(RandomPizza));
	SetPlayerCheckpoint(playerid, RandomPizza[rand][0], RandomPizza[rand][1], RandomPizza[rand][2], 3.0);
	CP[playerid] = 300;
		
	new Float:Position[3];
	GetPlayerPos(playerid, Position[0], Position[1], Position[2]);
		
	new distance = floatround(GetDistanceBetweenPoints(Position[0], Position[1], Position[2], RandomPizza[rand][0], RandomPizza[rand][1], RandomPizza[rand][2]), floatround_round);
		
	new skill, remain, forup;
	GetPizzaBoySkill(playerid, skill, remain, forup);
		
	if(skill == 1) pizzaprize[playerid] = distance*8;
	if(skill == 2) pizzaprize[playerid] = distance*8 + (distance*8)*(10/100);
	if(skill == 3) pizzaprize[playerid] = distance*8 + (distance*8)*(20/100);
	if(skill == 4) pizzaprize[playerid] = distance*8 + (distance*8)*(30/100);
	if(skill == 5) pizzaprize[playerid] = distance*8 + (distance*8)*(40/100);
	if(skill == 6) pizzaprize[playerid] = distance*8 + (distance*8)*(50/100);
	
	Working[playerid] = 1;
					
	Info(playerid, "~y~~h~Job Info: ~w~~h~Du-te la checkpointul ~r~rosu ~w~~h~setat pe mapa pentru a livra pizza.", 8000);
	return 1;
}
CMD:stopwork(playerid, params[])
{
	if(PlayerInfo[playerid][Job] == 3)
	{
	    SCM(playerid, COLOR_WHITE, "JOB INFO: Ai refuzat comanda plasata pentru pizza.");
	    
	    DisablePlayerCheckpoint(playerid);
	    SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	    
	    Working[playerid] = 0;
	}
	return 1;
}
CMD:quitjob(playerid, params[])
{
	if(PlayerInfo[playerid][Job] == 0) return SCM(playerid, COLOR_ERROR, "Nu esti angajat nicaieri pentru a demisiona!");

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "%s, ai parasit acest job si ai devenit somer!", GetName(playerid));
	SCM(playerid, COLOR_WHITE, kStr);
	SCM(playerid, COLOR_WHITE, "Daca doresti sa te reangajezi alege un job din lista /jobs!");

	PlayerInfo[playerid][Job] = 0;
	Update(playerid, Jobx);
	return 1;
}
CMD:gotojob(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 4) return SCM(playerid, COLOR_ERROR, "ERROR: Nu ai autorizatie pentru a folosi aceasta comanda.");
	if(sscanf(params, "d", params[0])) return SCM(playerid, COLOR_WHITE, "SYNTAX: /gotojob [ID]");

	if(params[0] == 1) SetPlayerPos(playerid, -373.7780, -1427.8170, 25.7266); //Farmer
	else if(params[0] == 2) SetPlayerPos(playerid, 1642.3353, -2238.9849, 13.4969); //Bus Driver
	return 1;
}
CMD:skills(playerid, params[])
{
	kStr[0] = EOS;
	new kStr2[1500];

	new fskill, fremain, fforup;
	GetFarmerSkill(playerid, fskill, fremain, fforup);

	new bskill, bremain, bforup;
	GetBusDriverSkill(playerid, bskill, bremain, bforup);
	
	new pskill, premain, pforup;
	GetPizzaBoySkill(playerid, pskill, premain, pforup);

	format(kStr, sizeof(kStr), ""OR"JOB: Farmer "W"- Skill: %d | Runde facute: %d (%d runde necesare pentru urmatorul skill)\n", fskill, fremain, fforup - fremain);
	strcat(kStr2, kStr);
	format(kStr, sizeof(kStr), ""OR"JOB: Bus Driver "W"- Skill: %d | Runde facute: %d (%d runde necesare pentru urmatorul skill)\n", bskill, bremain, bforup - bremain);
	strcat(kStr2, kStr);
	format(kStr, sizeof(kStr), ""OR"JOB: Pizza Boy "W"- Skill: %d | Runde facute: %d (%d runde necesare pentru urmatorul skill)\n", pskill, premain, pforup - premain);
	strcat(kStr2, kStr);
	SPD(playerid, 0, DIALOG_STYLE_MSGBOX, "UNNIC - Jobs Skill", kStr2, "Close", "");
	return 1;
}
CMD:engine(playerid,params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if(vehicleid == INVALID_VEHICLE_ID || IsABike(vehicleid)) return 1;
	new engine, lights, alarm, doors, bonnet, boot, objective;
	new vehicle = GetVehicleModel(vehicleid) - 400;

    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);

	new string[128];
    format(string, sizeof(string), "* %s porneste motorul vehiculului %s", GetName(playerid), VehicleNames[vehicle]);
	ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
    return 1;
}
CMD:stopengine(playerid,params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if(vehicleid == INVALID_VEHICLE_ID || IsABike(vehicleid)) return 1;
	new engine, lights, alarm, doors, bonnet, boot, objective;
	new vehicle = GetVehicleModel(vehicleid) - 400;

    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);

	new string[128];
    format(string, sizeof(string), "* %s opreste motorul vehiculului %s", GetName(playerid), VehicleNames[vehicle]);
	ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
	return 1;
}
CMD:centura(playerid, params[])
{
	if(Centura[playerid] == 0)
	{
	    SCM(playerid, COLOR_PURPLE, "* Ti-ai pus centura de siguranta.");
	    Centura[playerid] = 1;
	}
	else if(Centura[playerid] == 1)
	{
	    SCM(playerid, COLOR_PURPLE, "* Ti-ai scos centura de siguranta.");
	    Centura[playerid] = 0;
	}
	return 1;
}
CMD:seatbelt(playerid, params[]) return callcmd::centura(playerid, params);

CMD:serverinfo(playerid, params[])
{
	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "Server Record: %d\n\
								Record Date: %s\n\
								Last Account: %s\n\
								Server Language: %s\n\
								Server Map: %s", ServerInfo[Record], ServerInfo[RecordDate], ServerInfo[LastAccount], ServerInfo[Language], ServerInfo[Map]);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Server Informations", kStr, "OK", "");
	return 1;
}
CMD:exam(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 6.0, 1219.2212,-1813.0067,16.5938))
	{
		if(PlayerInfo[playerid][CarL] > 0)
		{
	    	kStr[0] = EOS;
	    	format(kStr, sizeof(kStr), "Detii deja un permis de conducere valabil pentru inca %d zile.", PlayerInfo[playerid][CarL]);
	    	SCM(playerid, COLOR_ERROR, kStr);
	    	return 1;
		}
		if(InExam[playerid] == 1) return SCM(playerid, COLOR_ERROR, "Esti deja in decursul testului pentru carnetul de conducere.");

		SPD(playerid, DIALOG_DMV, DIALOG_STYLE_MSGBOX, "DMV: Confirm", "Buna, te aflii in locul de sustinere a examenului pentru carnetul de conducere.\n\n\
																		Carnetul de sofer este un document esential fara de care nu ai dreptul sa conduci.\n\
																		Mai intai de toate, trebuie sa treci toate testele pe care noi ti le vom pregati.\n\n\
																		Esti sigur ca doresti sa sustii examenul pentru carnetul de conducere?", "Start", "Cancel");
	}
	else SCM(playerid, COLOR_ERROR, "Ne esti in apropierea scolii de soferi.");
	return 1;
}
//Admin Commands - Admin 1
CMD:respawn(playerid, params[])
{
	new targetid;
	if(PlayerInfo[playerid][Admin] < 1) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	if(sscanf(params,"u", targetid)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/respawn [Playerid]");
	if(IsPlayerConnected(targetid)) RespawnPlayer(targetid);
	return 1;
}
CMD:kill(playerid, params[])
{
	new targetid;
	if(PlayerInfo[playerid][Admin] < 1) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	if(sscanf(params,"u", targetid)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/kill [Playerid]");
	if(IsPlayerConnected(targetid)) SetPlayerHealth(targetid, 0);
	return 1;
}

CMD:setint(playerid, params[])
{
	new targetid, intid;
	if(PlayerInfo[playerid][Admin] < 1) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	if(sscanf(params,"ud", targetid, intid)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setint [Playerid] [Interior]");
	if(!IsPlayerConnected(targetid)) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~Player is offline!");
  	SetPlayerInterior(targetid, intid);
	return 1;
}

CMD:setvw(playerid, params[])
{
	new targetid, vwid;
	if(PlayerInfo[playerid][Admin] < 1) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	if(sscanf(params,"ud", targetid, vwid)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setint [Playerid] [Worldid]");
	if(!IsPlayerConnected(targetid)) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~Player is offline!");
  	SetPlayerVirtualWorld(targetid, vwid);
	return 1;
}

CMD:gotoint(playerid,params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new telestring[1550], part[40];
	for(new OrT = 1; OrT < sizeof(OrTeleports); OrT++)
    {
        format(part, sizeof(part), "\n%s", OrTeleports[OrT]);
        strcat(telestring, part, sizeof(telestring));
    }
    ShowPlayerDialog(playerid, DIALOG_GOTOINT, DIALOG_STYLE_LIST, "Select a teleport location", telestring, "Teleport", "Cancel");
    return 1;
}

CMD:gotocar(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
    new veh;
	if(sscanf(params, "d", veh)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/gotocar [Vehicleid]");
    new string[64];
    new Float:X, Float:Y, Float:Z;
    GetVehiclePos(veh, X, Y, Z);
    SetPlayerPos(playerid, X+1, Y, Z);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, GetVehicleVirtualWorld(veh));
    format(string, sizeof(string), "AdmCmd: You have been teleported to vehicle %d!", veh);
    SCM(playerid, COLOR_OR, string);
    return 1;
}

CMD:goto(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new targetid, str[128];
	if(sscanf(params, "u", targetid)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/goto [Playerid]");
	if(!IsPlayerConnected(targetid))  return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~Player is not online!");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetid, x, y, z);
	SetPlayerPos(playerid, x+1, y+1, z);
	SetPlayerInterior(playerid, GetPlayerInterior(targetid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
	format(str, sizeof(str), "AdmCmd: You have been teleported to %s.", GetName(targetid));
	SCM(playerid, COLOR_OR, str);
	if(IsPlayerInAnyVehicle(playerid)) 
	{
	  GetPlayerPos(targetid, x, y, z);
	  SetVehiclePos(playerid, x+1, y+1, z);
	}
	return 1;
}

CMD:gethere(playerid,params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new targetid, str[128];
	if(sscanf(params, "u", targetid)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/gethere [Playerid]");
	if(!IsPlayerConnected(targetid))  return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~Player is not online!");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(targetid, x+1, y+1, z);
	format(str, sizeof(str), "AdmCmd: You have teleported %s to yourself.", GetName(targetid));
	SCM(playerid, COLOR_OR, str);
	format(str, sizeof(str), "AdmCmd: You have been teleported to %s.", GetName(playerid));
	SCM(targetid, COLOR_OR, str);
	SetPlayerInterior(targetid, GetPlayerInterior(playerid));
	SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
	if(IsPlayerInAnyVehicle(targetid))
	{
	  GetPlayerPos(playerid, x, y, z);
	  SetVehiclePos(targetid, x+1, y+1, z);
	}
    return 1;
}

CMD:afh(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	SCM(playerid, COLOR_WHITE,"============ Comenzi administrator factiuni ============");
	SCM(playerid, COLOR_WHITE,"/setfactionname, /setfactionrankname, /setfactionskin, /setfactiontype, /setfactionminlevel");
	SCM(playerid, COLOR_WHITE,"/setfactioninterior, /setfactionexterior, /setfactiondrugs, /setfactionmoney, /setfactionmats, /setfactionorder");
	SCM(playerid, COLOR_WHITE,"/setfactioncommandrank, /setfactionslots, /setfactionmotd, /setfactionapps, /reloadfactions, /createfaction");
	SCM(playerid, COLOR_WHITE,"/setfactioncolor, /createfactioncar, /setfactioncarpos, /setfactioncarrank, /setfactioncarcolor, /deletefactioncar");
	SCM(playerid, COLOR_WHITE,"================================================");
	return 1;
}

CMD:fpk(playerid, params[])
{
    new targetid, fp, reason[64], fid = PlayerInfo[targetid][Faction];
	if(PlayerInfo[playerid][Admin] < 1) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	if(sscanf(params,"iis[64]", targetid, fp, reason))  return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~[Playerid] [FPunish] [Reason]");
	if(fp > 64 || fp < 0) return SCM(playerid, COLOR_ERROR, "ERROR: Faction punishment-ul trebuie sa fie intre 0 si 64!");
	if(!IsPlayerConnected(targetid)) return SCM(playerid, COLOR_ERROR, "Jucatorul nu este online!");
	if(fid <= 0 && FactionInfo[fid][fID] <= 0) return SCM(playerid, COLOR_ERROR, "ERROR: Nu exista nici-o factiune cu acest ID!");

	new string[128];
	format(string, sizeof(string), "AdmCmd: You have kicked %s out from faction %s with %d FPunish, reason: %s.", GetName(targetid), FactionInfo[fid][fName], fp, reason);
	SCM(playerid, COLOR_OR, string);
	
	format(string, sizeof(string), "%s has been uninvited from the faction by admin %s with %d FPunish, reason: %s.", GetName(targetid), GetName(playerid), fp, reason);
	FactionMessage(fid, COLOR_DARKCYAN, string);
	
	PlayerInfo[targetid][Faction] = 0;
 	PlayerInfo[targetid][Rank] = 0;
 	PlayerInfo[targetid][Leader] = 0;
 	PlayerInfo[targetid][FWarns] = 0;
 	PlayerInfo[targetid][FPunish] = fp;
	FactionInfo[fid][fMembers]--;
	fUpdate(playerid, Membersx);
 	SetPlayerColor(targetid, 0xFFFFFFFF);
 	ResetPlayerWeapons(targetid);
 	
	if(IsPlayerInAnyVehicle(targetid) && GetPlayerVehicleSeat(targetid) == 0) RemovePlayerFromVehicle(targetid);

	Update(targetid, Factionx);
	Update(targetid, Rankx);
	Update(targetid, Leaderx);
	Update(targetid, FPunishx);
	Update(targetid, FWarnsx);
	RespawnPlayer(targetid);
	
	mysql_format(mysql, query, sizeof(query), "INSERT INTO `log_factions` (`Text`, `Author`, `Victim`, `fID`, `Type`, `Date`) VALUES ('%s', '%d', '%d', '%d', '2', NOW())", string, PlayerInfo[playerid][ID], PlayerInfo[targetid][ID], FactionInfo[fid][fID]);
	mysql_query(mysql, query);
	return 1;
}

CMD:cpk(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return InfoBox(playerid, 5000, "Nu ai autorizatie pentru a folosi aceasta comanda!");
	new targetid, reason[64];
	if(sscanf(params,"is[64]", targetid, reason)) return InfoBox(playerid, 5000, "USAGE: /cpk [Playerid] [Reason]");
	if(IsPlayerConnected(targetid))
	{
	    new cid = PlayerInfo[targetid][Clan];
	    if(cid > 0 && IsValidClan(cid))
	    {
		    new string[128], string1[24];
			format(string, sizeof(string), "AdmCmd: You have kicked %s out from clan %s, reason: %s.", GetName(targetid), ClanInfo[cid][Name], reason);
			SCM(playerid, COLOR_OR, string);
			format(string, sizeof(string), "%s has been kicked from the clan by admin %s, reason: %s.", GetName(targetid), GetName(playerid), reason);
		    ClanMessage(cid, COLOR_DARKGOLD, string);
			new lastclan = LastClanID();
			for(new i; i < lastclan; i++)
			{
			    if(strfind(GetName(targetid), ClanInfo[i][Tag]) != -1)
			    {
		            if(ClanInfo[PlayerInfo[targetid][Clan]][Type] == 0)
		            {
		                strmid(string1, GetName(targetid), strlen(ClanInfo[i][Tag]), strlen(GetName(targetid)));
		                SetPlayerName(targetid, string1);
		            }
		            else if(ClanInfo[PlayerInfo[targetid][Clan]][Type] == 1)
		            {
						strmid(string1, GetName(targetid), 0, strlen(GetName(targetid)) - strlen(ClanInfo[i][Tag]));
		                SetPlayerName(targetid, string1);
		            }
			    }
			}
	        PlayerInfo[targetid][Clan] = 0;
	        PlayerInfo[targetid][cRank] = 0;
	        PlayerInfo[targetid][cLeader] = 0;
		    PlayerInfo[targetid][CWarns] = 0;
			ClanInfo[cid][Members]--;
			cUpdate(playerid, Membersx);
			Update(targetid, Clanx);
			Update(targetid, cRankx);
			Update(targetid, cLeaderx);
			Update(targetid, CWarnsx);
			mysql_format(mysql, query, sizeof(query), "INSERT INTO `log_clans` (`Text`, `Author`, `Victim`, `ID`, `Type`, `Date`) VALUES ('%s', '%d', '%d', '%d', '2', NOW())", string, PlayerInfo[playerid][ID], PlayerInfo[targetid][ID], ClanInfo[cid][ID]);
			mysql_query(mysql, query);
		}
		else SCM(playerid, COLOR_ERROR, "ERROR: Nu exista nici-un clan cu acest ID!");
	}
	else SCM(playerid, COLOR_ERROR, "Jucatorul nu este online!");
	return 1;
}
CMD:ban(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You haven't acces to this command!");
	if(sscanf(params, "uds[100]", params[0], params[1], params[2])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/ban [ID] [Days] [Reason]");
	if(params[0] == INVALID_PLAYER_ID) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~This player isn't connected.");
	if(params[1] < 0) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You must to type valid days.");
	if(!params[2]) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You must to type a reason for this ban.");
	
	kStr[0] = '\0';
	format(kStr, sizeof(kStr), "AdmCmd: %s(%d) a primit interdictie pe server timp de %d zile de la administratorul %s. Motiv: %s", GetName(params[0]), params[0], params[1], GetName(playerid), params[2]);
	SendClientMessageToAll(COLOR_OR, kStr);
	
	new bDate[100], hour, mins, secs, y, m, d;
	gettime(hour, mins, secs);
	getdate(y, m, d);
	
	format(bDate, sizeof(bDate), "%02d.%02d.%d %02d:%02d", d, m, y, hour, mins);
	
	strmid(BanInfo[params[0]][Name], GetName(params[0]), 0, strlen(GetName(params[0])));
	strmid(BanInfo[params[0]][Reason], params[2], 0, strlen(params[2]));
	strmid(BanInfo[params[0]][Date], bDate, 0, strlen(bDate));
	strmid(BanInfo[params[0]][Admin], GetCleanName(playerid), 0, strlen(GetCleanName(playerid)));
	strmid(BanInfo[params[0]][IP], GetIP(params[0]), 0, strlen(GetIP(params[0])));
	
	BanInfo[params[0]][Days] = gettime() + params[1]*86400;
	
	query[0] = '\0';
	mysql_format(mysql, query, sizeof(query), "INSERT INTO `bans` (`Name`, `IP`, `Admin`, `Date`, `Reason`, `Days`) VALUES ('%s', '%s', '%s', '%s', '%s', '%d')", GetName(params[0]), GetIP(params[0]), GetName(playerid), bDate, params[2], BanInfo[params[0]][Days]);
	mysql_query(mysql, query);
	
	KickEx(params[0]);
	return 1;
}
CMD:freeze(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You haven't acces to this command!");
	if(sscanf(params, "ud", params[0], params[1])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/freeze [ID] [Time]");
	if(params[0] == INVALID_PLAYER_ID) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~This player don't exist or isn't connected!");
	if(params[1] < 0) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You must to type valid minutes.");
	
	TogglePlayerControllable(params[0], 0);
	SetTimerEx("UnFreezePlayer", params[1]*1000, false, "i", params[0]);
	
	kStr[0] = '\0';
	format(kStr, sizeof(kStr), "AdmCmd: %s(%d) te-a inghetat pentru %d minute.", GetName(playerid), playerid, params[1]);
	SCM(params[0], COLOR_OR, kStr);
	
	format(kStr, sizeof(kStr), "AdmCmd: L-ai inghetat pe %s(%d) pentru %d minute.", GetName(params[0]), params[0], params[1]);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:unfreeze(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You haven't acces to this command!");
	if(sscanf(params, "u", params[0])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/unfreeze [ID]");
	if(params[0] == INVALID_PLAYER_ID) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~This player don't exist or isn't connected!");
	
	TogglePlayerControllable(params[0], 1);

	kStr[0] = '\0';
	format(kStr, sizeof(kStr), "AdmCmd: %s(%d) ti-a dat unfreeze.", GetName(playerid), playerid);
	SCM(params[0], COLOR_OR, kStr);

	format(kStr, sizeof(kStr), "AdmCmd: I-ai dat unfreeze lui %s(%d).", GetName(params[0]), params[0]);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}

//Admin Commands - Admin 2
CMD:afcr(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 2) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new fid;
	if(sscanf(params, "i", fid)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/afcr [FACTIONID]");
	if(fid > 0 && FactionInfo[fid][fID] > 0)
	{
		for(new i;i < Total_Veh_Created + 1;i++)
		{
		    if(VehInfo[i][Faction] == fid)
		    {
		        if(IsVehicleOccupied(i) == 0)
			    {
			        SetVehicleToRespawn(i);
		        	VehInfo[i][Fuel] = 100;
			    }
		    }
		}
		new string[128];
		format(string, sizeof(string), "AdmCmd: %s a respawnat masinile factiunii.", GetName(playerid));
		FactionMessage(fid, COLOR_OR, string);
		format(string, sizeof(string), "AdmCmd: Ai respawnat masinile factiunii %s.", FactionInfo[fid][fName]);
		SCM(playerid, COLOR_OR, string);
	}
	else SCM(playerid, COLOR_ERROR, "ERROR: Aceasta factiune nu exista!");
	return 1;
}
//Admin Commands - Admin 3

//Admin Commands - Admin 4

//Admin Commands - Admin 5

//Admin Commands - Admin 6
CMD:servername(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	ShowPlayerDialog(playerid, DIALOG_SERVERNAME, DIALOG_STYLE_MSGBOX, "Server Name", "Esti sigur ca doresti sa schimbi numele serverului?", "Da", "Nu");
	return 1;
}
CMD:servermode(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	ShowPlayerDialog(playerid, DIALOG_MODE, DIALOG_STYLE_MSGBOX, "Server Mode", "Esti sigur ca doresti sa schimbi modul serverului?", "Da", "Nu");
	return 1;
}
CMD:reloadclans(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	mysql_tquery(mysql, "SELECT * FROM `clans`", "LoadClans", "");
	SCM(playerid, COLOR_OR, "AdmCmd: Clanurile au fost incarcate cu succes!");
	return 1;
}
CMD:createclan(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	if(sscanf(params, "d", params[0])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/createclan [Days]");

	ClanDays = params[0];
	
	SPD(playerid, DIALOG_CLAN + 1, DIALOG_STYLE_INPUT, "Creare clan", "Te rugam sa introduci mai jos numele pe care doresti sa il aiba clanul:", "OK", "Cancel");
	return 1;
}

CMD:setclanrankname(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new cid, frank, frname[32];
	if(sscanf(params, "iis[32]", cid, frank, frname)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setclanrankname [Clanid] [Rankid] [Name]");
	if(ClanInfo[cid][ID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nici-un clan cu acest ID!");
	switch(frank)
	{
		case 1:
		{
			ClanInfo[cid][Rank1] = frname;
			cUpdate(cid, Rank1x);

			format(kStr, sizeof(kStr), "AdmCmd: Numele rank-ului %d al clanului %s a fost setat la %s.", frank, ClanInfo[cid][Name], frname);
			SCM(playerid, COLOR_OR, kStr);
		}
		case 2:
		{
			ClanInfo[cid][Rank2] = frname;
			cUpdate(cid, Rank2x);

			format(kStr, sizeof(kStr), "AdmCmd: Numele rank-ului %d al clanului %s a fost setat la %s.", frank, ClanInfo[cid][Name], frname);
			SCM(playerid, COLOR_OR, kStr);
		}
		case 3:
		{
			ClanInfo[cid][Rank3] = frname;
			cUpdate(cid, Rank3x);

			format(kStr, sizeof(kStr), "AdmCmd: Numele rank-ului %d al clanului %s a fost setat la %s.", frank, ClanInfo[cid][Name], frname);
			SCM(playerid, COLOR_OR, kStr);
		}
		case 4:
		{
			ClanInfo[cid][Rank4] = frname;
			cUpdate(cid, Rank4x);

			format(kStr, sizeof(kStr), "AdmCmd: Numele rank-ului %d al clanului %s a fost setat la %s.", frank, ClanInfo[cid][Name], frname);
			SCM(playerid, COLOR_OR, kStr);
		}
		case 5:
		{
			ClanInfo[cid][Rank5] = frname;
			cUpdate(cid, Rank5x);

			format(kStr, sizeof(kStr), "AdmCmd: Numele rank-ului %d al clanului %s a fost setat la %s.", frank, ClanInfo[cid][Name], frname);
			SCM(playerid, COLOR_OR, kStr);
		}
		case 6:
		{
			ClanInfo[cid][Rank6] = frname;
			cUpdate(cid, Rank6x);

			format(kStr, sizeof(kStr), "AdmCmd: Numele rank-ului %d al clanului %s a fost setat la %s.", frank, ClanInfo[cid][Name], frname);
			SCM(playerid, COLOR_OR, kStr);
		}
		case 7:
		{
			ClanInfo[cid][Leader] = frname;
			cUpdate(cid, Leaderx);

			format(kStr, sizeof(kStr), "AdmCmd: Numele liderului clanului %s a fost setat la %s.", ClanInfo[cid][Name], frname);
			SCM(playerid, COLOR_OR, kStr);
		}
	}
	return 1;
}

CMD:setclanslots(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new cid, fslots;
	if(sscanf(params, "ii", cid, fslots)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setclanslots [ID] [Amount]");
	if(ClanInfo[cid][ID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nicio factiune cu acest ID!");
	ClanInfo[cid][Slots] = fslots;
	cUpdate(cid, Slotsx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: Sloturile clanului %s au fost schimbate la %d.", ClanInfo[cid][Name], fslots);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}

CMD:setclancommandrank(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new cid, fcrank;
	if(sscanf(params, "ii", cid, fcrank)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setclancommandrank [ID] [Rankid]");
	if(ClanInfo[cid][ID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nicio factiune cu acest ID!");
	ClanInfo[cid][CommandRank] = fcrank;
	cUpdate(cid, CommandRankx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: Rank-ul de comanda al clanului %s a fost schimbat la rank %d.", ClanInfo[cid][Name], fcrank);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}

CMD:setclanapps(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new cid, fapps;
	if(sscanf(params, "ii", cid, fapps)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setclanapps [ID] [Status]");
	if(ClanInfo[cid][ID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nicio factiune cu acest ID!");
	ClanInfo[cid][Applications] = fapps;
	cUpdate(cid, Applicationsx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: Ai setat aplicatiile clanului %s la %d.", ClanInfo[cid][Name], fapps);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:createclancar(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new cid, model, Float:x, Float:y, Float:z, Float:a;
	if(sscanf(params, "ii", cid, model)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/createclancar [Clanid] [Modelid]");
	if(ClanInfo[cid][ID] > 0)
	{
	    GetPlayerPos(playerid, x, y, z);
	    GetPlayerFacingAngle(playerid, a);
		CreateClanVeh(playerid, x, y, z, a, model, cid);
	}
	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: Ai creat o masina noua pentru clanul %s.", ClanInfo[cid][Name]);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:setclancarpos(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new veh, Float:x, Float:y, Float:z, Float:a;
	veh = GetPlayerVehicleID(playerid);
	if(veh > 0 && IsClanVeh(veh))
	{
	    GetPlayerPos(playerid, x, y, z);
	    GetVehicleZAngle(veh, a);
	    VehInfo[veh][PosX] = x;
	    VehInfo[veh][PosY] = y;
	    VehInfo[veh][PosZ] = z;
	    VehInfo[veh][PosA] = a;
		vUpdate(veh, PosXx);
		vUpdate(veh, PosYx);
		vUpdate(veh, PosZx);
		vUpdate(veh, PosAx);
		SCM(playerid, COLOR_OR, "AdmCmd: Pozitia masinii a fost modificata cu succes.");
 	}
 	else
 	{
		SCM(playerid, COLOR_ERROR, "Nu te aflii in masina unei factiuni!");
	}
	return 1;
}
CMD:deleteclancar(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new veh = GetPlayerVehicleID(playerid);
	if(IsClanVeh(veh))
	{
		query[0] = EOS;
		VehInfo[veh][Spawnable] = 0;
		mysql_format(mysql, query, sizeof(query), "DELETE FROM `vehicles` WHERE `ID` = '%d'", VehInfo[veh][ID]);
		mysql_query(mysql, query);
		DestroyVehicle(veh);
		kStr[0] = EOS;
		format(kStr, sizeof(kStr), "AdmCmd: Ai distrus definitiv masina acestui clan.");
		SCM(playerid, COLOR_OR, kStr);
 	}
 	else SCM(playerid, COLOR_ERROR, "Nu te aflii in masina unei factiuni!");
	return 1;
}
CMD:setfactionorder(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new order, fid, wp[5];
	if(sscanf(params,"iiiiiii", fid, order, wp[0], wp[1], wp[2], wp[3], wp[4])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setfactionorder [Factionid] [1/2/3/4] [Weaponid] [Weaponid] [Weaponid] [Weaponid] [Weaponid]");
	if(fid > 0 && FactionInfo[fid][fID] > 0)
	{
	    for(new i;i < 5;i++)
	    {
	    	if(wp[i] < 0 || wp[i] > 35 && (wp[i] != 41 && wp[i] != 42 && wp[i] != 43))
	    	{
	    	    return SCM(playerid, COLOR_ERROR, "Id-ul unei arme este interzis sau invalid!");
	    	}
	    }
	    switch(order)
	    {
	        case 1:
	        {
	        	FactionInfo[fid][fOrder1][0] = wp[0];
	        	FactionInfo[fid][fOrder1][1] = wp[1];
	        	FactionInfo[fid][fOrder1][2] = wp[2];
	        	FactionInfo[fid][fOrder1][3] = wp[3];
	        	FactionInfo[fid][fOrder1][4] = wp[4];
	        	fUpdate(fid, fOrder1x);
	        }
	        case 2:
	        {
	        	FactionInfo[fid][fOrder2][0] = wp[0];
	        	FactionInfo[fid][fOrder2][1] = wp[1];
	        	FactionInfo[fid][fOrder2][2] = wp[2];
	        	FactionInfo[fid][fOrder2][3] = wp[3];
	        	FactionInfo[fid][fOrder2][4] = wp[4];
	        	fUpdate(fid, fOrder2x);
	        }
	        case 3:
	        {
	        	FactionInfo[fid][fOrder3][0] = wp[0];
	        	FactionInfo[fid][fOrder3][1] = wp[1];
	        	FactionInfo[fid][fOrder3][2] = wp[2];
	        	FactionInfo[fid][fOrder3][3] = wp[3];
	        	FactionInfo[fid][fOrder3][4] = wp[4];
	        	fUpdate(fid, fOrder3x);
	        }
	        case 4:
	        {
	        	FactionInfo[fid][fOrder4][0] = wp[0];
	        	FactionInfo[fid][fOrder4][1] = wp[1];
	        	FactionInfo[fid][fOrder4][2] = wp[2];
	        	FactionInfo[fid][fOrder4][3] = wp[3];
	        	FactionInfo[fid][fOrder4][4] = wp[4];
	        	fUpdate(fid, fOrder4x);
	        }
	    }
	    new string[128];
	    format(string, sizeof(string), "AdmCmd: Ai schimbat cu succes order-ul cu ID: %d al factiunii %s.", order, FactionInfo[fid][fName]);
		SCM(playerid, COLOR_OR, string);
	}
	else SCM(playerid, COLOR_ERROR, "Factiune invalida!");
	return 1;
}
CMD:reloadfactions(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	mysql_tquery(mysql, "SELECT * FROM `factions`", "LoadFactions", "");
	SCM(playerid, COLOR_OR, "AdmCmd: Factiunile au fost incarcate cu succes!");
	return 1;
}
CMD:createfaction(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	CreateFaction();
	SCM(playerid, COLOR_OR, "AdmCmd: Ai creat o factiune noua cu succes!");
	return 1;
}
CMD:createfactioncar(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new fid, model, Float:x, Float:y, Float:z, Float:a;
	if(sscanf(params, "ii", fid, model)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/createfactioncar [Factionid] [Modelid]");
	if(FactionInfo[fid][fID] > 0)
	{
	    GetPlayerPos(playerid, x, y, z);
	    GetPlayerFacingAngle(playerid, a);
		CreateFactionVeh(playerid, x, y, z, a, model, fid);
	}
	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: Ai creat o masina noua pentru factiunea %s.", FactionInfo[fid][fName]);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:setfactioncarpos(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new veh, Float:x, Float:y, Float:z, Float:a;
	veh = GetPlayerVehicleID(playerid);
	if(veh > 0 && IsFactionVeh(veh))
	{
	    GetPlayerPos(playerid, x, y, z);
	    GetVehicleZAngle(veh, a);
	    VehInfo[veh][PosX] = x;
	    VehInfo[veh][PosY] = y;
	    VehInfo[veh][PosZ] = z;
	    VehInfo[veh][PosA] = a;
		vUpdate(veh, PosXx);
		vUpdate(veh, PosYx);
		vUpdate(veh, PosZx);
		vUpdate(veh, PosAx);
		SCM(playerid, COLOR_OR, "AdmCmd: Pozitia masinii a fost modificata cu succes.");
 	}
 	else SCM(playerid, COLOR_ERROR, "Nu te aflii in masina unei factiuni!");
	return 1;
}
CMD:setfactioncarcolor(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new col1, col2;
	if(sscanf(params, "ii", col1, col2)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setfactioncarcolor [Color1] [Color2]");
	new veh = GetPlayerVehicleID(playerid);
	if(veh > 0)
	{
		if(col1 >= 0 && col1 < 256 && col2 >= 0 && col2 < 256)
		{
		    VehInfo[veh][Color1] = col1;
		    VehInfo[veh][Color2] = col2;
		   	ChangeVehicleColor(veh, VehInfo[veh][Color1], VehInfo[veh][Color2]);
			vUpdate(veh, Color1x);
			vUpdate(veh, Color2x);
			SCM(playerid, COLOR_OR, "AdmCmd: Culoarea masinii a fost modificata cu succes!");
	 	}
	 	else SCM(playerid, COLOR_ERROR, "ID-ul unei culori este invalid!");
 	}
 	else SCM(playerid, COLOR_ERROR, "Nu te aflii in masina unei factiuni!");
	return 1;
}
CMD:setfactioncarrank(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new rank;
	if(sscanf(params, "i", rank)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setfactioncarrank [Rank]");
	new veh = GetPlayerVehicleID(playerid);
	if(veh > 0)
	{
		if(rank > 0 && rank < 7)
		{
		    VehInfo[veh][Rank] = rank;
			vUpdate(veh, Rankx);
			SCM(playerid, COLOR_OR, "AdmCmd: Rank-ul masinii a fost modificat cu succes!");
	 	}
	 	else SCM(playerid, COLOR_ERROR, "ID-ul rank-ului este invalid!");
 	}
 	else SCM(playerid, COLOR_ERROR, "Nu te aflii in masina unei factiuni!");
	return 1;
}
CMD:deletefactioncar(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new veh = GetPlayerVehicleID(playerid);
	if(IsFactionVeh(veh))
	{
		query[0] = EOS;
		VehInfo[veh][Spawnable] = 0;
		mysql_format(mysql, query, sizeof(query), "DELETE FROM `vehicles` WHERE `ID` = '%d'", VehInfo[veh][ID]);
		mysql_query(mysql, query);
		DestroyVehicle(veh);
		kStr[0] = EOS;
		format(kStr, sizeof(kStr), "AdmCmd: Ai distrus definitiv masina acestei factiuni.");
		SCM(playerid, COLOR_OR, kStr);
 	}
 	else SCM(playerid, COLOR_ERROR, "Nu te aflii in masina unei factiuni!");
	return 1;
}
CMD:setturfname(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new tname[32];
	if(sscanf(params, "s[64]", tname)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setturfname [Name]");
	if(IsPlayerInAnyGangZone(playerid))
	{
	    new turf = GetTurfID(GetPlayerGangZone(playerid));
		Turfs[turf][Name] = tname;
		tUpdate(turf, Namex);

		kStr[0] = EOS;
		format(kStr, sizeof(kStr), "AdmCmd: Numele turf-ului cu ID %d a fost schimbat in %s.", turf, Turfs[turf][Name]);
		SCM(playerid, COLOR_OR, kStr);
	}
	return 1;
}
CMD:setfactionname(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new fid, fname[64];
	if(sscanf(params, "is[64]", fid, fname)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setfactionname [ID] [Name]");
	if(FactionInfo[fid][fID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nicio factiune cu acest ID!");
	FactionInfo[fid][fName] = fname;
	fUpdate(fid, Namex);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: Numele factiunii cu ID %d a fost schimbat in %s.", fid, FactionInfo[fid][fName]);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:setfactionmotd(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new fid, fmotd[128];
	if(sscanf(params, "is[128]", fid, fmotd)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setfactionmotd [ID] [Motd]");
	if(FactionInfo[fid][fID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nicio factiune cu acest ID!");
	FactionInfo[fid][fMotd] = fmotd;
	fUpdate(fid, Motdx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: Motd-ul factiunii %s a fost schimbat cu succes.", FactionInfo[fid][fName]);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:setfactiontype(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new fid, ftype;
	if(sscanf(params, "ii", fid, ftype)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setfactiontype [ID] [Type]");
	if(FactionInfo[fid][fID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nicio factiune cu acest ID!");
	FactionInfo[fid][fType] = ftype;
	fUpdate(fid, fTypex);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: Tipul factiunii %s este acum %d.", FactionInfo[fid][fName], ftype);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:setfactioncolor(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new fid, fcolor[32];
	if(sscanf(params, "is[32]", fid, fcolor)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setfactioncolor [ID] [Color]");
	if(FactionInfo[fid][fID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nicio factiune cu acest ID!");
	FactionInfo[fid][fColor] = HexToInt(fcolor);
	fUpdate(fid, fColorx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: Culoarea factiunii {%s}%s{FF6347} a fost schimbata cu succes.", fcolor, FactionInfo[fid][fName]);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:setfactiondrugs(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new fid, fdrugs;
	if(sscanf(params, "ii", fid, fdrugs)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setfactiondrugs [ID] [Amount]");
	if(FactionInfo[fid][fID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nicio factiune cu acest ID!");
	FactionInfo[fid][fDrugs] = fdrugs;
	fUpdate(fid, fDrugsx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: Drogurile factiunii %s au fost schimbate la %d.", FactionInfo[fid][fName], fdrugs);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:setfactionmats(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new fid, fmats;
	if(sscanf(params, "ii", fid, fmats)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setfactionmats [ID] [Amount]");
	if(FactionInfo[fid][fID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nicio factiune cu acest ID!");
	FactionInfo[fid][fMats] = fmats;
	fUpdate(fid, fMatsx);


	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: Materialele factiunii %s au fost schimbate la %d.", FactionInfo[fid][fName], fmats);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:setfactionmoney(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new fid, fmoney;
	if(sscanf(params, "ii", fid, fmoney)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setfactionmoney [ID] [Amount]");
	if(FactionInfo[fid][fID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nicio factiune cu acest ID!");
	FactionInfo[fid][fMoney] = fmoney;
	fUpdate(fid, fMoneyx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: Ai setat banii factiunii %s la %d.", FactionInfo[fid][fName], fmoney);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:setfactionslots(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new fid, fslots;
	if(sscanf(params, "ii", fid, fslots)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setfactionslots [ID] [Amount]");
	if(FactionInfo[fid][fID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nicio factiune cu acest ID!");
	FactionInfo[fid][fSlots] = fslots;
	fUpdate(fid, Slotsx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: Sloturile factiunii %s au fost schimbate la %d.", FactionInfo[fid][fName], fslots);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:setfactioncommandrank(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new fid, fcrank;
	if(sscanf(params, "ii", fid, fcrank)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setfactioncommandrank [ID] [Rank]");
	if(FactionInfo[fid][fID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nicio factiune cu acest ID!");
	FactionInfo[fid][fCommandRank] = fcrank;
	fUpdate(fid, CommandRankx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: Rank-ul de comanda al factiunii %s a fost schimbat la rank %d.", FactionInfo[fid][fName], fcrank);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:setfactionapps(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new fid, fapps;
	if(sscanf(params, "ii", fid, fapps)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setfactionapps [ID] [Status]");
	if(FactionInfo[fid][fID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nicio factiune cu acest ID!");
	FactionInfo[fid][fApplications] = fapps;
	fUpdate(fid, Applicationsx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: Ai setat aplicatiile factiunii %s la %d.", FactionInfo[fid][fName], fapps);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:setfactionminlevel(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new fid, fminlevel;
	if(sscanf(params, "ii", fid, fminlevel)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setfactionminlevel [ID] [Minimum level]");
	if(FactionInfo[fid][fID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nicio factiune cu acest ID!");
	FactionInfo[fid][fMinLevel] = fminlevel;
	fUpdate(fid, fMinLevelx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: Nivelul minim de intrare in factiunea %s este %d.", FactionInfo[fid][fName], fminlevel);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:setfactionexterior(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new fid, Float:x, Float:y, Float:z;
	kStr[0] = EOS;
	if(sscanf(params, "i", fid)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setfactionexterior [ID]");
	if(FactionInfo[fid][fID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nicio factiune cu acest ID!");
	GetPlayerPos(playerid, x, y, z);
	FactionInfo[fid][fExtX] = x;
	FactionInfo[fid][fExtY] = y;
	FactionInfo[fid][fExtZ] = z;
	fUpdate(fid, fExtXx);
	fUpdate(fid, fExtYx);
	fUpdate(fid, fExtZx);
	DestroyDynamicPickup(FactionInfo[fid][fPickup]);
	DestroyDynamic3DTextLabel(FactionInfo[fid][fText3D]);
	FactionInfo[fid][fPickup] = CreateDynamicPickup(1239, 20, FactionInfo[fid][fExtX], FactionInfo[fid][fExtY], FactionInfo[fid][fExtZ], 0);
	FactionInfo[fid][fText3D] = CreateDynamic3DTextLabel(FactionInfo[fid][fName], COLOR_WHITE, FactionInfo[fid][fExtX], FactionInfo[fid][fExtY], FactionInfo[fid][fExtZ], 20.0);
	format(kStr, sizeof(kStr), "AdmCmd: Ai schimbat exteriorul factiunii %s cu succes.", FactionInfo[fid][fName]);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:setfactioninterior(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
	new fid, Float:x, Float:y, Float:z;
	kStr[0] = EOS;
	if(sscanf(params, "i", fid)) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/setfactioninterior [ID]");
	if(FactionInfo[fid][fID] < 1) return SCM(playerid, COLOR_ERROR, "Nu exista nicio factiune cu acest ID!");
	GetPlayerPos(playerid, x, y, z);
	FactionInfo[fid][fIntX] = x;
	FactionInfo[fid][fIntY] = y;
	FactionInfo[fid][fIntZ] = z;
	FactionInfo[fid][fInt] = GetPlayerInterior(playerid);
	FactionInfo[fid][fVW] = GetPlayerVirtualWorld(playerid);
	fUpdate(fid, fIntXx);
	fUpdate(fid, fIntYx);
	fUpdate(fid, fIntZx);
	fUpdate(fid, fIntx);
	fUpdate(fid, fVWx);
	format(kStr, sizeof(kStr), "AdmCmd: Ai schimbat interiorul factiunii %s cu succes.", FactionInfo[fid][fName]);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:makeadmin(playerid, params[])
{
    if(strcmp(GetName(playerid), "KnowN") && PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
    if(sscanf(params, "ud", params[0], params[1])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/makeadmin [ID] [Level]");
    if(params[0] == INVALID_PLAYER_ID) return SCM(playerid, COLOR_ERROR, "Acest jucator nu este conectat!");

    PlayerInfo[params[0]][Admin] = params[1];
    Update(playerid, Adminx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: %s(%d) ti-a setat nivelul de admin la %d.", GetName(playerid), playerid, params[1]);
	SCM(params[0], COLOR_OR, kStr);

	format(kStr, sizeof(kStr), "AdmCmd: I-ai setat nivelul de admin la %d lui %s(%d).", params[1], GetName(params[0]), params[0]);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:makeleader(playerid, params[])
{
    if(strcmp(GetName(playerid), "KnowN") && PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
    if(sscanf(params, "ud", params[0], params[1])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/makeleader [ID] [Faction]");
    if(params[0] == INVALID_PLAYER_ID) return SCM(playerid, COLOR_ERROR, "Acest jucator nu este conectat!");

    PlayerInfo[params[0]][Leader] = params[1];
    PlayerInfo[params[0]][Faction] = params[1];
    PlayerInfo[params[0]][Rank] = 6;
    Update(playerid, Leaderx);
    Update(playerid, Rankx);
    Update(playerid, Factionx);
	RespawnPlayer(params[0]);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: %s(%d) ti-a setat lider la %s.", GetName(playerid), playerid, FactionInfo[params[1]][fName]);
	SCM(params[0], COLOR_OR, kStr);

	format(kStr, sizeof(kStr), "AdmCmd: I-ai setat setat lider la %s lui %s(%d).", FactionInfo[params[1]], GetName(params[0]), params[0]);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:makeclanleader(playerid, params[])
{
    if(PlayerInfo[playerid][Admin] < 6) return SCM(playerid, COLOR_ERROR, "Nu ai autorizatie pentru a folosi aceasta comanda!");
    if(sscanf(params, "ud", params[0], params[1])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/makeclanleader [ID] [Clan]");
    if(params[0] == INVALID_PLAYER_ID) return SCM(playerid, COLOR_ERROR, "Acest jucator nu este conectat!");

    new string[24], nName[24];
    if(PlayerInfo[params[0]][Clan] > 0 || PlayerInfo[params[0]][cLeader] > 0) SetPlayerName(params[0], GetCleanName(params[0]));
	if(ClanInfo[PlayerInfo[params[0]][Clan]][Type] == 1) format(nName, sizeof(nName), "%s%s", GetName(params[0]), ClanInfo[PlayerInfo[params[0]][cLeader]][Tag]);
	else if(ClanInfo[PlayerInfo[params[0]][Clan]][Type] == 0) format(nName, sizeof(nName), "%s%s", ClanInfo[PlayerInfo[params[0]][cLeader]][Tag], GetCleanName(params[0]));

	strmid(string, nName, 0, 24);
	SetPlayerName(params[0], string);

    PlayerInfo[params[0]][cLeader] = params[1];
    PlayerInfo[params[0]][Clan] = params[1];
    PlayerInfo[params[0]][cRank] = 6;
    Update(params[0], cLeaderx);
    Update(params[0], cRankx);
    Update(params[0], Clanx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: %s(%d) ti-a setat lider la clanul %s.", GetName(playerid), playerid, ClanInfo[params[1]][Name]);
	SCM(params[0], COLOR_OR, kStr);

	format(kStr, sizeof(kStr), "AdmCmd: I-ai setat setat lider la clanul %s lui %s(%d).", ClanInfo[params[1]][Name], GetName(params[0]), params[0]);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:makehelper(playerid, params[])
{
    if(strcmp(GetName(playerid), "KnowN") && PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
    if(sscanf(params, "ud", params[0], params[1])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/makehelper [ID] [Level]");
    if(params[0] == INVALID_PLAYER_ID) return SCM(playerid, COLOR_ERROR, "Acest jucator nu este conectat!");

    PlayerInfo[params[0]][Helper] = params[1];
    Update(playerid, Helperx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: %s(%d) ti-a setat nivelul de helper la %d.", GetName(playerid), playerid, params[1]);
	SCM(params[0], COLOR_OR, kStr);

	format(kStr, sizeof(kStr), "AdmCmd: I-ai setat nivelul de helper la %d lui %s(%d).", params[1], GetName(params[0]), params[0]);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:makepremium(playerid, params[])
{
    if(strcmp(GetName(playerid), "KnowN") && PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
    if(sscanf(params, "udI", params[0], params[1], params[2])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/makepremium [ID] [Type(0 - Temporary/1 - Permanent)] [Days]");
    if(params[0] == INVALID_PLAYER_ID) return InfoBox(playerid, 7000, "~r~~w~ERROR: ~w~~h~This player isn't connected!");
    if(PlayerInfo[params[0]][Premium] == 1) return InfoBox(playerid, 700, "~r~~h~ERROR: ~w~~h~This player already have Premium Account.");
    
    switch(params[1])
    {
        case 0:
		{
		    if(params[1] < 0 || params[1] > 1) return InfoBox(playerid, 7000, "~r~~h~USAGE: ~w~~h~/makepremium [ID] [Type] [Days]~n~~w~~h~Type: 0 - Temporary / 1 - Permanent");
		    
            PlayerInfo[params[0]][Premium] = 1;
            PlayerInfo[params[0]][PremiumDays] = gettime() + params[2]*86400;
            Update(params[0], Premiumx);
            Update(params[0], PremiumDaysx);
            
            kStr[0] = '\0';
            format(kStr, sizeof(kStr), "AdmCmd: %s(%d) ti-a setat cont Premium pentru %d zile.", GetName(playerid), playerid, params[2]);
            SCM(params[0], COLOR_OR, kStr);
            
            format(kStr, sizeof(kStr), "AdmCmd: I-ai setat lui %s(%d) cont Premium pentru %d zile.", GetName(params[0]), params[0], params[2]);
            SCM(playerid, COLOR_OR, kStr);
        }
        case 1:
        {
            PlayerInfo[params[0]][Premium] = 1;
            PlayerInfo[params[0]][PremiumDays] = 0;
            
            Update(params[0], Premiumx);
            Update(params[0], PremiumDaysx);
            
            kStr[0] = '\0';
            format(kStr, sizeof(kStr), "AdmCmd: %s(%d) ti-a setat cont Premium permanent.", GetName(playerid), playerid);
            SCM(params[0], COLOR_OR, kStr);
            
            format(kStr, sizeof(kStr), "AdmCmd: I-ai setat lui %s(%d) cont Premium permanent.", GetName(params[0]), params[0]);
            SCM(playerid, COLOR_OR, kStr);
        }
    }
	return 1;
}
CMD:removepremium(playerid, params[])
{
    if(strcmp(GetName(playerid), "KnowN") && PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
    if(sscanf(params, "u", params[0])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/removepremium [ID]");
    if(params[0] == INVALID_PLAYER_ID) return InfoBox(playerid, 7000, "~r~~w~ERROR: ~w~~h~This player isn't connected!");
    if(PlayerInfo[params[0]][Premium] == 0) return InfoBox(playerid, 700, "~r~~h~ERROR: ~w~~h~This player haven't Premium Account.");
    
    PlayerInfo[params[0]][Premium] = 0;
    PlayerInfo[params[0]][PremiumDays] = 0;
    Update(params[0], Premiumx);
    Update(params[0], PremiumDaysx);
    
    kStr[0] = '\0';
    format(kStr, sizeof(kStr), "AdmCmd: %s(%d) ti-a scos contul Premium.", GetName(playerid), playerid);
    SCM(params[0], COLOR_OR, kStr);

    format(kStr, sizeof(kStr), "AdmCmd: I-ai scos contul Premium lui %s(%d).", GetName(params[0]), params[0]);
    SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:givepp(playerid, params[])
{
    if(strcmp(GetName(playerid), "KnowN") && PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
    if(sscanf(params, "ud", params[0], params[1])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/givepp [ID] [ammount]");
    if(params[0] == INVALID_PLAYER_ID) return SCM(playerid, COLOR_ERROR, "Acest jucator nu este conectat!");

    PlayerInfo[params[0]][PPoints] = params[1];
	Update(playerid, PPointsx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: %s(%d) ti-a dat %d Premium Points.", GetName(playerid), playerid, params[1]);
	SCM(params[0], COLOR_OR, kStr);

	format(kStr, sizeof(kStr), "AdmCmd: I-ai dat %d Premium Points lui %s(%d).", params[1], GetName(params[0]), params[0]);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:givemoney(playerid, params[])
{
    if(strcmp(GetName(playerid), "KnowN") && PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
    if(sscanf(params, "ud", params[0], params[1])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/givemoney [ID] [ammount]");
    if(params[0] == INVALID_PLAYER_ID) return SCM(playerid, COLOR_ERROR, "Acest jucator nu este conectat!");

    PlayerInfo[params[0]][Money] = params[1];
	GivePlayerMoney(params[0], params[1]);
	Update(params[0], Moneyx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: %s(%d) ti-a dat %d$ bani.", GetName(playerid), playerid, params[1]);
	SCM(params[0], COLOR_OR, kStr);

	format(kStr, sizeof(kStr), "AdmCmd: I-ai dat %d$ bani lui %s(%d).", params[1], GetName(params[0]), params[0]);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:giverp(playerid, params[])
{
    if(strcmp(GetName(playerid), "KnowN") && PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 5000, "~r~~h~ERROR: ~w~~h~You aren't authorized to use this command!");
    if(sscanf(params, "ud", params[0], params[1])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/giverp [ID] [ammount]");
    if(params[0] == INVALID_PLAYER_ID) return SCM(playerid, COLOR_ERROR, "Acest jucator nu este conectat!");

    PlayerInfo[params[0]][Respect] = params[1];
	GivePlayerMoney(playerid, params[1]);
	Update(playerid, Respectx);

	kStr[0] = EOS;
	format(kStr, sizeof(kStr), "AdmCmd: %s(%d) ti-a dat %d RP.", GetName(playerid), playerid, params[1]);
	SCM(params[0], COLOR_OR, kStr);

	format(kStr, sizeof(kStr), "AdmCmd: I-ai dat %d RP lui %s(%d).", params[1], GetName(params[0]), params[0]);
	SCM(playerid, COLOR_OR, kStr);
	return 1;
}
CMD:unban(playerid, params[])
{
    if(PlayerInfo[playerid][Admin] < 6) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You haven't acces to this command!");
	if(sscanf(params, "s[100]", params[0])) return InfoBox(playerid, 5000, "~r~~h~USAGE: ~w~~h~/unban [Name]");

	query[0] = '\0';
	new Security[100];

	mysql_escape_string(GetCleanName(params[0]), Security, mysql);
	mysql_format(mysql, query, sizeof(query), "SELECT * FROM `bans` WHERE `Name` = '%s'", Security);
	mysql_tquery(mysql, query, "CheckBannedAccount", "ds", playerid, Security);
	return 1;
}

//Stocks

/*GetWeaponPickup(weaponid)
{
	switch(weaponid)
	{
	    case 1: return 331; case 2: return 333; case 3: return 334; // this is to define the weapons
		case 4: return 335; case 5: return 336; case 6: return 337;
		case 7: return 338; case 8: return 339; case 9: return 341;
		case 10: return 321; case 11: return 322; case 12: return 323;
		case 13: return 324; case 14: return 325; case 15: return 326;
		case 16: return 342; case 17: return 343; case 18: return 344;
		case 22: return 346; case 23: return 347; case 24: return 348;
		case 25: return 349; case 26: return 350; case 27: return 351;
		case 28: return 352; case 29: return 353; case 30: return 355;
		case 31: return 356; case 32: return 372; case 33: return 357;
		case 34: return 358; case 35: return 359; case 36: return 360;
		case 37: return 361; case 38: return 362; case 39: return 363;
		case 41: return 365; case 42: return 366; case 46: return 371; //example, this case is the id 46 is the parachute, we will drop the parachute, that's if  you got one
	}
	return -1;
}*/

AntiDeAMX()
{
    new a[][] =
    {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a
}

stock GetPlayerZone(Float:zX, Float:zY, Float:zZ)
{
	for(new i = 0; i < sizeof(gSAZones); i++)
	{
		if(zX > gSAZones[i][zzX] && zY > gSAZones[i][zzY] && zZ > gSAZones[i][zzZ] && zX < gSAZones[i][MX] && zY < gSAZones[i][MY] && zZ < gSAZones[i][MZ])
		return i;
	}
	return false;
}

stock KickEx(playerid)
{
	SetTimerEx("KickPlayer", 100, false, "i", playerid);
	return 1;
}

stock ModifyVehicleSpeed(vehicleid, vKM)
{
    new Float:Vx, Float:Vy, Float:Vz, Float:DV, Float:multiple;
    
    GetVehicleVelocity(vehicleid,Vx,Vy,Vz);
    DV = floatsqroot(Vx*Vx + Vy*Vy + Vz*Vz);
    
    if(DV > 0)
    {
        multiple = ((vKM + DV * 100) / (DV * 100));
        return SetVehicleVelocity(vehicleid,Vx*multiple,Vy*multiple,Vz*multiple);
    }
    return 0;
}

stock IsPlayerInZone(playerid, zone[]) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
	new TmpZone[MAX_ZONE_NAME];
	GetPlayer3DZone(playerid, TmpZone, sizeof(TmpZone));
	for(new i = 0; i != sizeof(gSAZones); i++)
	{
		if(strfind(TmpZone, zone, true) != -1)
		return 1;
	}
	return 0;
}

stock GetPlayer2DZone(playerid, zone[], len) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock GetPlayer3DZone(playerid, zone[], len) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4] && z >= gSAZones[i][SAZONE_AREA][2] && z <= gSAZones[i][SAZONE_AREA][5])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}
stock Sec2HMS(secs, &hours, &minutes, &seconds)
{
  	if (secs < 0) return false;
  	minutes = secs / 60;
  	seconds = secs % 60;
  	hours = minutes / 60;
  	minutes = minutes % 60;
  	return 1;
}
stock RGBAToHex(r, g, b, a) return (r<<24 | g<<16 | b<<8 | a);
stock IntToHex(n)
{
	new str[32];
	format(str, sizeof (str), "{%06x}", n >>> 8);
	return str;
}

stock HexToRGBA(colour, &r, &g, &b, &a) //By Betamaster
{
	r = (colour >> 24) & 0xFF;
	g = (colour >> 16) & 0xFF;
	b = (colour >> 8) & 0xFF;
	a = colour & 0xFF;
}

stock HexToInt(string[])
{
	if (string[0]==0) return 0;
	new i;
	new cur=1;
	new res=0;
	for (i=strlen(string);i>0;i--)
	{
		if (string[i-1]<58) res=res+cur*(string[i-1]-48); else res=res+cur*(string[i-1]-65+10);
		cur=cur*16;
	}
	return res;
}

stock GetWeaponNameEx(weaponid)
{
	new weapon[32];
	new len = sizeof(weapon);
    switch(weaponid)
    {
		case 0: strcat(weapon, "None", len);
        case 18: strcat(weapon, "Molotov Cocktail", len);
        case 44: strcat(weapon, "Night Vision Goggles", len);
        case 45:  strcat(weapon, "Thermal Goggles", len);
        default: GetWeaponName(weaponid, weapon, len);
    }
    return weapon;
}

stock IsVehicleOccupied(vehicleid)
{
    for(new i =0; i < MAX_PLAYERS; i++) if(IsPlayerInVehicle(i,vehicleid)) return 1;
	return 0;
}

GetTurfID(turf)
{
	for(new i = 0; i < MAX_ZONES; i++) if(Turfs[i][ID] == turf) return i;
	return -1;
}

stock IsTurfAttacked(playerid)
{
	new fid = PlayerInfo[playerid][Faction];
	if(fid > 0 && FactionInfo[fid][fID] > 0 && PlayerInfo[playerid][Rank] > 0)
	{
		for(new i;i < sizeof(Turfs);i++)
		{
		    if(FactionInfo[fid][fAttackedTurf] == i && Turfs[i][isAttacked] == 2 && Turfs[i][Attacker] > 0)
		    {
		        new attacker = Turfs[i][Attacker];
                GangZoneFlashForPlayer(playerid, Turfs[i][ID], ((FactionInfo[attacker][fColor] & ~0xFF) | 0x99));
                i = sizeof(Turfs) + 1;
				SetPlayerTeam(playerid, fid);
		    }
		}
	}
}

stock GetPlayerRank(playerid)
{
	new fid = PlayerInfo[playerid][Faction];
	new rName[32];
	if(fid > 0 && FactionInfo[fid][fID] > 0 && PlayerInfo[playerid][Rank] > 0)
	{
	    if(PlayerInfo[playerid][Rank] == 6 && PlayerInfo[playerid][Leader] == fid) format(rName, sizeof(rName), "%s", FactionInfo[fid][fLeader]);
	    else
	    {
		    switch(PlayerInfo[playerid][Rank])
		    {
		        case 1: format(rName, sizeof(rName), "%s", FactionInfo[fid][fRank1]);
		        case 2: format(rName, sizeof(rName), "%s", FactionInfo[fid][fRank2]);
		        case 3: format(rName, sizeof(rName), "%s", FactionInfo[fid][fRank3]);
		        case 4: format(rName, sizeof(rName), "%s", FactionInfo[fid][fRank4]);
		        case 5: format(rName, sizeof(rName), "%s", FactionInfo[fid][fRank5]);
		        case 6: format(rName, sizeof(rName), "%s", FactionInfo[fid][fRank6]);
		    }
	    }
	}
	return rName;
}

stock GetPlayerClanRank(playerid)
{
	new fid = PlayerInfo[playerid][Clan];
	new rName[32];
	if(fid > 0 && IsValidClan(fid) && PlayerInfo[playerid][cRank] > 0)
	{
	    if(PlayerInfo[playerid][cRank] == 6 && PlayerInfo[playerid][cLeader] == fid) format(rName, sizeof(rName), "%s", ClanInfo[fid][Leader]);
	    else
	    {
		    switch(PlayerInfo[playerid][Rank])
		    {
		        case 1: format(rName, sizeof(rName), "%s", ClanInfo[fid][Rank1]);
		        case 2: format(rName, sizeof(rName), "%s", ClanInfo[fid][Rank2]);
		        case 3: format(rName, sizeof(rName), "%s", ClanInfo[fid][Rank3]);
		        case 4: format(rName, sizeof(rName), "%s", ClanInfo[fid][Rank4]);
		        case 5: format(rName, sizeof(rName), "%s", ClanInfo[fid][Rank5]);
		        case 6: format(rName, sizeof(rName), "%s", ClanInfo[fid][Rank6]);
		    }
	    }
	}
	return rName;
}

stock GetPlayerRankSkin(playerid)
{
	new fid = PlayerInfo[playerid][Faction];
	new rSkin;
	if(fid > 0 && FactionInfo[fid][fID] > 0 && PlayerInfo[playerid][Rank] > 0)
	{
	    if(PlayerInfo[playerid][Rank] == 6 && PlayerInfo[playerid][Leader] == fid) rSkin = FactionInfo[fid][fSkin7];
	    else
	    {
		    switch(PlayerInfo[playerid][Rank])
		    {
		        case 1: rSkin = FactionInfo[fid][fSkin1];
		        case 2: rSkin = FactionInfo[fid][fSkin2];
		        case 3: rSkin = FactionInfo[fid][fSkin3];
		        case 4: rSkin = FactionInfo[fid][fSkin4];
		        case 5: rSkin = FactionInfo[fid][fSkin5];
		        case 6: rSkin = FactionInfo[fid][fSkin6];
		    }
	    }
	}
	return rSkin;
}

stock GetName(playerid)
{
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, sizeof(pName));
	return pName;
}

stock GetCleanName(playerid)
{
	new pName[MAX_PLAYER_NAME];
	new lastclan = LastClanID();
	pName = GetName(playerid);
	for(new i; i < lastclan; i++)
	{
	    if(strfind(GetName(playerid), ClanInfo[i][Tag]) != -1)
	    {
            if(ClanInfo[PlayerInfo[playerid][Clan]][Type] == 0) strmid(pName, GetName(playerid), strlen(ClanInfo[i][Tag]), strlen(GetName(playerid)));
            else if(ClanInfo[PlayerInfo[playerid][Clan]][Type] == 1) strmid(pName, GetName(playerid), 0, strlen(GetName(playerid)) - strlen(ClanInfo[i][Tag]));
	    }
	}
	return pName;
}
stock GetIP(playerid)
{
	new pIP[24];
	GetPlayerIp(playerid, pIP, sizeof(pIP));
	return pIP;
}
stock IsMail(email[])
{
  	new len=strlen(email);
  	new cstate=0;
  	new i;
  	for(i=0;i<len;i++)
	{
	    if ((cstate==0 || cstate==1) && (email[i]>='A' && email[i]<='Z')||(email[i]>='0' && email[i]<='9') || (email[i]>='a' && email[i]<='z')  || (email[i]=='.')  || (email[i]=='-')  || (email[i]=='_'))
	    {
	    }
		else
		{
	       if((cstate==0) &&(email[i]=='@')) cstate=1;
		   else return false;
	 	}
	}
  	if(cstate<1) return false;
  	if(len<6) return false;
  	if((email[len-3]=='.') || (email[len-4]=='.') || (email[len-5]=='.')) return true;
  	return false;
}
stock GetVehicleName(vehicleid)
{
	new vString[100];
	format(vString, sizeof(vString), "%s", VehicleNames[GetVehicleModel(vehicleid) - 400]);
	return vString;
}
stock FormatNumber(number)
{
   new Str[15];
   format(Str, 15, "%d", number);

   if(strlen(Str) < sizeof(Str))
   {
      	if(number >= 1000 && number < 10000 || number >= -1000 && number < -10000) strins( Str, ",", 1, sizeof(Str));
      	else if(number >= 10000 && number < 100000 || number >= -10000 && number < -100000) strins(Str, ",", 2, sizeof(Str));
      	else if(number >= 100000 && number < 1000000 || number >= -100000 && number < -1000000) strins(Str, ",", 3, sizeof(Str));
      	else if(number >= 1000000 && number < 10000000 || number >= -1000000 && number < -10000000) strins(Str, ",", 1, sizeof(Str)),strins(Str, ",", 5, sizeof(Str));
      	else if(number >= 10000000 && number < 100000000 || number >= -10000000 && number < -100000000) strins(Str, ",", 2, sizeof(Str)),strins(Str, ",", 6, sizeof(Str));
      	else if(number >= 100000000 && number < 1000000000 || number >= -100000000 && number < -1000000000) strins(Str, ",", 3, sizeof(Str)),strins(Str, ",", 7, sizeof(Str));
      	else if(number >= 1000000000 && number < 10000000000 || number >= -1000000000 && number < -10000000000)
      	{
           	strins(Str, ",", 1, sizeof(Str)),
           	strins(Str, ",", 5, sizeof(Str)),
           	strins(Str, ",", 9, sizeof(Str));
		}
      	else format(Str, 10, "%d", number);
   }
   else  format( Str, 15, "<BUG>" );
   return Str;
}
stock PlayerTextdraws(playerid)
{
    Info_TD = CreatePlayerTextDraw(playerid,25.000000, 126.000000, "~r~~h~USAGE: ~w~~h~/setadmin <Name/ID> <Level>");
	PlayerTextDrawBackgroundColor(playerid,Info_TD, 50);
	PlayerTextDrawFont(playerid,Info_TD, 1);
	PlayerTextDrawLetterSize(playerid,Info_TD, 0.200000, 1.000000);
	PlayerTextDrawColor(playerid,Info_TD, -1);
	PlayerTextDrawSetOutline(playerid,Info_TD, 1);
	PlayerTextDrawSetProportional(playerid,Info_TD, 1);
	PlayerTextDrawUseBox(playerid,Info_TD, 1);
	PlayerTextDrawBoxColor(playerid,Info_TD, 100);
	PlayerTextDrawTextSize(playerid,Info_TD, 148.000000, 2.000000);
	PlayerTextDrawSetSelectable(playerid,Info_TD, 0);

    Logo[0] = CreatePlayerTextDraw(playerid,616.000000, 432.000000, "RPG~n~"SERVER_VERS"");
	PlayerTextDrawBackgroundColor(playerid,Logo[0], 70);
	PlayerTextDrawFont(playerid,Logo[0], 2);
	PlayerTextDrawLetterSize(playerid,Logo[0], 0.179999, 0.699998);
	PlayerTextDrawColor(playerid,Logo[0], -1);
	PlayerTextDrawSetOutline(playerid,Logo[0], 1);
	PlayerTextDrawSetProportional(playerid,Logo[0], 1);
	PlayerTextDrawSetSelectable(playerid,Logo[0], 0);

	Logo[1] = CreatePlayerTextDraw(playerid,564.000000, 429.000000, "UNNIC");
	PlayerTextDrawBackgroundColor(playerid,Logo[1], 70);
	PlayerTextDrawFont(playerid,Logo[1], 2);
	PlayerTextDrawLetterSize(playerid,Logo[1], 0.419999, 1.899999);
	PlayerTextDrawColor(playerid,Logo[1], -1);
	PlayerTextDrawSetOutline(playerid,Logo[1], 1);
	PlayerTextDrawSetProportional(playerid,Logo[1], 1);
	PlayerTextDrawSetSelectable(playerid,Logo[1], 0);

	WarTD[playerid][0] = CreatePlayerTextDraw(playerid,626.000000, 359.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,WarTD[playerid][0], 255);
	PlayerTextDrawFont(playerid,WarTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid,WarTD[playerid][0], 0.500000, 5.699999);
	PlayerTextDrawColor(playerid,WarTD[playerid][0], -1);
	PlayerTextDrawSetOutline(playerid,WarTD[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid,WarTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid,WarTD[playerid][0], 1);
	PlayerTextDrawUseBox(playerid,WarTD[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid,WarTD[playerid][0], 80);
	PlayerTextDrawTextSize(playerid,WarTD[playerid][0], 452.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,WarTD[playerid][0], 0);

	WarTD[playerid][1] = CreatePlayerTextDraw(playerid,541.000000, 360.000000, "Turf: Turfname");
	PlayerTextDrawAlignment(playerid,WarTD[playerid][1], 2);
	PlayerTextDrawBackgroundColor(playerid,WarTD[playerid][1], 255);
	PlayerTextDrawFont(playerid,WarTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid,WarTD[playerid][1], 0.240000, 0.799999);
	PlayerTextDrawColor(playerid,WarTD[playerid][1], -1);
	PlayerTextDrawSetOutline(playerid,WarTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid,WarTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid,WarTD[playerid][1], 0);

	WarTD[playerid][2] = CreatePlayerTextDraw(playerid,539.000000, 368.000000, "Faction1 0 - 0 Faction2");
	PlayerTextDrawAlignment(playerid,WarTD[playerid][2], 2);
	PlayerTextDrawBackgroundColor(playerid,WarTD[playerid][2], 255);
	PlayerTextDrawFont(playerid,WarTD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid,WarTD[playerid][2], 0.240000, 0.799999);
	PlayerTextDrawColor(playerid,WarTD[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid,WarTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid,WarTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid,WarTD[playerid][2], 0);

	WarTD[playerid][3] = CreatePlayerTextDraw(playerid,539.000000, 376.000000, "On turf: 0 - 0");
	PlayerTextDrawAlignment(playerid,WarTD[playerid][3], 2);
	PlayerTextDrawBackgroundColor(playerid,WarTD[playerid][3], 255);
	PlayerTextDrawFont(playerid,WarTD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid,WarTD[playerid][3], 0.240000, 0.799999);
	PlayerTextDrawColor(playerid,WarTD[playerid][3], -1);
	PlayerTextDrawSetOutline(playerid,WarTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid,WarTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid,WarTD[playerid][3], 0);

	WarTD[playerid][4] = CreatePlayerTextDraw(playerid,539.000000, 384.000000, "Your kills: 0");
	PlayerTextDrawAlignment(playerid,WarTD[playerid][4], 2);
	PlayerTextDrawBackgroundColor(playerid,WarTD[playerid][4], 255);
	PlayerTextDrawFont(playerid,WarTD[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid,WarTD[playerid][4], 0.240000, 0.799999);
	PlayerTextDrawColor(playerid,WarTD[playerid][4], -1);
	PlayerTextDrawSetOutline(playerid,WarTD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid,WarTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid,WarTD[playerid][4], 0);

	WarTD[playerid][5] = CreatePlayerTextDraw(playerid,539.000000, 392.000000, "Your deaths: 0");
	PlayerTextDrawAlignment(playerid,WarTD[playerid][5], 2);
	PlayerTextDrawBackgroundColor(playerid,WarTD[playerid][5], 255);
	PlayerTextDrawFont(playerid,WarTD[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid,WarTD[playerid][5], 0.240000, 0.799999);
	PlayerTextDrawColor(playerid,WarTD[playerid][5], -1);
	PlayerTextDrawSetOutline(playerid,WarTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid,WarTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid,WarTD[playerid][5], 0);

	WarTD[playerid][6] = CreatePlayerTextDraw(playerid,539.000000, 400.000000, "War Time: ~r~30:00");
	PlayerTextDrawAlignment(playerid,WarTD[playerid][6], 2);
	PlayerTextDrawBackgroundColor(playerid,WarTD[playerid][6], 255);
	PlayerTextDrawFont(playerid,WarTD[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid,WarTD[playerid][6], 0.240000, 0.799999);
	PlayerTextDrawColor(playerid,WarTD[playerid][6], -1);
	PlayerTextDrawSetOutline(playerid,WarTD[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid,WarTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid,WarTD[playerid][6], 0);

  	Jobs[0] = CreatePlayerTextDraw(playerid,183.000000, 181.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,Jobs[0], 255);
	PlayerTextDrawFont(playerid,Jobs[0], 1);
	PlayerTextDrawLetterSize(playerid,Jobs[0], 0.500000, 4.199995);
	PlayerTextDrawColor(playerid,Jobs[0], -1);
	PlayerTextDrawSetOutline(playerid,Jobs[0], 0);
	PlayerTextDrawSetProportional(playerid,Jobs[0], 1);
	PlayerTextDrawSetShadow(playerid,Jobs[0], 1);
	PlayerTextDrawUseBox(playerid,Jobs[0], 1);
	PlayerTextDrawBoxColor(playerid,Jobs[0], 140);
	PlayerTextDrawTextSize(playerid,Jobs[0], 10.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Jobs[0], 0);

	Jobs[1] = CreatePlayerTextDraw(playerid,18.000000, 181.000000, "JOB");
	PlayerTextDrawBackgroundColor(playerid,Jobs[1], 255);
	PlayerTextDrawFont(playerid,Jobs[1], 0);
	PlayerTextDrawLetterSize(playerid,Jobs[1], 0.500000, 1.400000);
	PlayerTextDrawColor(playerid,Jobs[1], -1);
	PlayerTextDrawSetOutline(playerid,Jobs[1], 0);
	PlayerTextDrawSetProportional(playerid,Jobs[1], 1);
	PlayerTextDrawSetShadow(playerid,Jobs[1], 1);
	PlayerTextDrawSetSelectable(playerid,Jobs[1], 0);

	Jobs[2] = CreatePlayerTextDraw(playerid,18.000000, 204.000000, "Munceste inca ~r~120 secunde ~w~~h~pentru a fi platit!");
	PlayerTextDrawBackgroundColor(playerid,Jobs[2], 255);
	PlayerTextDrawFont(playerid,Jobs[2], 1);
	PlayerTextDrawLetterSize(playerid,Jobs[2], 0.190000, 1.100000);
	PlayerTextDrawColor(playerid,Jobs[2], -1);
	PlayerTextDrawSetOutline(playerid,Jobs[2], 0);
	PlayerTextDrawSetProportional(playerid,Jobs[2], 1);
	PlayerTextDrawSetShadow(playerid,Jobs[2], 1);
	PlayerTextDrawSetSelectable(playerid,Jobs[2], 0);

	Jobs[3] = CreatePlayerTextDraw(playerid,183.000000, 224.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,Jobs[3], 255);
	PlayerTextDrawFont(playerid,Jobs[3], 1);
	PlayerTextDrawLetterSize(playerid,Jobs[3], 0.500000, 1.399995);
	PlayerTextDrawColor(playerid,Jobs[3], -1);
	PlayerTextDrawSetOutline(playerid,Jobs[3], 0);
	PlayerTextDrawSetProportional(playerid,Jobs[3], 1);
	PlayerTextDrawSetShadow(playerid,Jobs[3], 1);
	PlayerTextDrawUseBox(playerid,Jobs[3], 1);
	PlayerTextDrawBoxColor(playerid,Jobs[3], 140);
	PlayerTextDrawTextSize(playerid,Jobs[3], 10.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Jobs[3], 0);

	Jobs[4] = CreatePlayerTextDraw(playerid,18.000000, 224.000000, "(!) Trebuie sa mergi cu o viteza mai mare de 25 KM/H.");
	PlayerTextDrawBackgroundColor(playerid,Jobs[4], 255);
	PlayerTextDrawFont(playerid,Jobs[4], 1);
	PlayerTextDrawLetterSize(playerid,Jobs[4], 0.170000, 1.100000);
	PlayerTextDrawColor(playerid,Jobs[4], -1);
	PlayerTextDrawSetOutline(playerid,Jobs[4], 0);
	PlayerTextDrawSetProportional(playerid,Jobs[4], 1);
	PlayerTextDrawSetShadow(playerid,Jobs[4], 1);
	PlayerTextDrawSetSelectable(playerid,Jobs[4], 0);

	EventTD[0] = CreatePlayerTextDraw(playerid,178.000000, 282.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,EventTD[0], 255);
	PlayerTextDrawFont(playerid,EventTD[0], 1);
	PlayerTextDrawLetterSize(playerid,EventTD[0], 0.500000, 4.699999);
	PlayerTextDrawColor(playerid,EventTD[0], -1);
	PlayerTextDrawSetOutline(playerid,EventTD[0], 0);
	PlayerTextDrawSetProportional(playerid,EventTD[0], 1);
	PlayerTextDrawSetShadow(playerid,EventTD[0], 1);
	PlayerTextDrawUseBox(playerid,EventTD[0], 1);
	PlayerTextDrawBoxColor(playerid,EventTD[0], 140);
	PlayerTextDrawTextSize(playerid,EventTD[0], 9.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,EventTD[0], 0);

	EventTD[1] = CreatePlayerTextDraw(playerid,16.000000, 282.000000, "Organizator: ~r~KnowN~n~~w~~h~Tip event: ~y~Car derby~n~~w~~h~Suma: ~g~~h~140.000$");
	PlayerTextDrawBackgroundColor(playerid,EventTD[1], 255);
	PlayerTextDrawFont(playerid,EventTD[1], 1);
	PlayerTextDrawLetterSize(playerid,EventTD[1], 0.220000, 0.899999);
	PlayerTextDrawColor(playerid,EventTD[1], -1);
	PlayerTextDrawSetOutline(playerid,EventTD[1], 0);
	PlayerTextDrawSetProportional(playerid,EventTD[1], 1);
	PlayerTextDrawSetShadow(playerid,EventTD[1], 1);
	PlayerTextDrawSetSelectable(playerid,EventTD[1], 0);

	EventTD[2] = CreatePlayerTextDraw(playerid,15.000000, 307.000000, "Eventul va incepe in 120 de secunde!~n~Pentru a participa, tasteaza comanda /join.");
	PlayerTextDrawBackgroundColor(playerid,EventTD[2], 255);
	PlayerTextDrawFont(playerid,EventTD[2], 1);
	PlayerTextDrawLetterSize(playerid,EventTD[2], 0.220000, 0.899999);
	PlayerTextDrawColor(playerid,EventTD[2], -1);
	PlayerTextDrawSetOutline(playerid,EventTD[2], 0);
	PlayerTextDrawSetProportional(playerid,EventTD[2], 1);
	PlayerTextDrawSetShadow(playerid,EventTD[2], 1);
	PlayerTextDrawSetSelectable(playerid,EventTD[2], 0);

	EngineTD = CreatePlayerTextDraw(playerid,499.000000, 341.000000, "PLEASE WAIT ...");
	PlayerTextDrawBackgroundColor(playerid,EngineTD, 40);
	PlayerTextDrawFont(playerid,EngineTD, 2);
	PlayerTextDrawLetterSize(playerid,EngineTD, 0.259999, 1.100000);
	PlayerTextDrawColor(playerid,EngineTD, -1);
	PlayerTextDrawSetOutline(playerid,EngineTD, 1);
	PlayerTextDrawSetProportional(playerid,EngineTD, 1);
	PlayerTextDrawSetSelectable(playerid,EngineTD, 0);

	Jobs2[0] = CreatePlayerTextDraw(playerid,157.000000, 289.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,Jobs2[0], 255);
	PlayerTextDrawFont(playerid,Jobs2[0], 1);
	PlayerTextDrawLetterSize(playerid,Jobs2[0], 0.500000, 3.699999);
	PlayerTextDrawColor(playerid,Jobs2[0], -1);
	PlayerTextDrawSetOutline(playerid,Jobs2[0], 0);
	PlayerTextDrawSetProportional(playerid,Jobs2[0], 1);
	PlayerTextDrawSetShadow(playerid,Jobs2[0], 1);
	PlayerTextDrawUseBox(playerid,Jobs2[0], 1);
	PlayerTextDrawBoxColor(playerid,Jobs2[0], 120);
	PlayerTextDrawTextSize(playerid,Jobs2[0], 18.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Jobs2[0], 0);

	Jobs2[1] = CreatePlayerTextDraw(playerid,25.000000, 294.000000, "Skill: 1 (1/4 runde efectuate)~n~Bani castigati: 1000$~n~Opriri la statii: 0");
	PlayerTextDrawBackgroundColor(playerid,Jobs2[1], 60);
	PlayerTextDrawFont(playerid,Jobs2[1], 1);
	PlayerTextDrawLetterSize(playerid,Jobs2[1], 0.220000, 0.799999);
	PlayerTextDrawColor(playerid,Jobs2[1], -1);
	PlayerTextDrawSetOutline(playerid,Jobs2[1], 1);
	PlayerTextDrawSetProportional(playerid,Jobs2[1], 1);
	PlayerTextDrawSetSelectable(playerid,Jobs2[1], 0);

	InfoTD = CreatePlayerTextDraw(playerid,347.000000, 377.000000, "Apasa ~y~LCTRL (LMB) ~w~~h~pentru a schimba spawn-ul si ~r~ENTER ~w~~h~pentru a alege spawn-ul favorit.");
	PlayerTextDrawAlignment(playerid,InfoTD, 2);
	PlayerTextDrawBackgroundColor(playerid,InfoTD, 50);
	PlayerTextDrawFont(playerid,InfoTD, 1);
	PlayerTextDrawLetterSize(playerid,InfoTD, 0.240000, 1.100000);
	PlayerTextDrawColor(playerid,InfoTD, -1);
	PlayerTextDrawSetOutline(playerid,InfoTD, 1);
	PlayerTextDrawSetProportional(playerid,InfoTD, 1);
	PlayerTextDrawSetSelectable(playerid,InfoTD, 0);

	DSTD[0] = CreatePlayerTextDraw(playerid, 441.500000, 327.875000, "usebox");
	PlayerTextDrawLetterSize(playerid, DSTD[0], 0.000000, 8.958338);
	PlayerTextDrawTextSize(playerid, DSTD[0], 201.500000, 0.000000);
	PlayerTextDrawAlignment(playerid, DSTD[0], 1);
	PlayerTextDrawColor(playerid, DSTD[0], 0);
	PlayerTextDrawUseBox(playerid, DSTD[0], true);
	PlayerTextDrawBoxColor(playerid, DSTD[0], 102);
	PlayerTextDrawSetShadow(playerid, DSTD[0], 0);
	PlayerTextDrawSetOutline(playerid, DSTD[0], 0);
	PlayerTextDrawFont(playerid, DSTD[0], 0);

	DSTD[1] = CreatePlayerTextDraw(playerid, 199.000000, 327.875000, "_");
	PlayerTextDrawLetterSize(playerid, DSTD[1], 0.000000, 8.965276);
	PlayerTextDrawTextSize(playerid, DSTD[1], 166.500000, 0.000000);
	PlayerTextDrawAlignment(playerid, DSTD[1], 1);
	PlayerTextDrawColor(playerid, DSTD[1], 0);
	PlayerTextDrawUseBox(playerid, DSTD[1], true);
	PlayerTextDrawBoxColor(playerid, DSTD[1], 102);
	PlayerTextDrawSetShadow(playerid, DSTD[1], 0);
	PlayerTextDrawSetOutline(playerid, DSTD[1], 0);
	PlayerTextDrawFont(playerid, DSTD[1], 0);
	PlayerTextDrawSetSelectable(playerid, DSTD[1], true);

	DSTD[2] = CreatePlayerTextDraw(playerid, 476.500000, 327.875000, "_");
	PlayerTextDrawLetterSize(playerid, DSTD[2], 0.000000, 8.969445);
	PlayerTextDrawTextSize(playerid, DSTD[2], 444.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, DSTD[2], 1);
	PlayerTextDrawColor(playerid, DSTD[2], 0);
	PlayerTextDrawUseBox(playerid, DSTD[2], true);
	PlayerTextDrawBoxColor(playerid, DSTD[2], 102);
	PlayerTextDrawSetShadow(playerid, DSTD[2], 0);
	PlayerTextDrawSetOutline(playerid, DSTD[2], 0);
	PlayerTextDrawFont(playerid, DSTD[2], 0);
	PlayerTextDrawSetSelectable(playerid, DSTD[2], true);

	DSTD[3] = CreatePlayerTextDraw(playerid, 324.000000, 329.875000, "MODEL: INFERNUS");
	PlayerTextDrawLetterSize(playerid, DSTD[3], 0.223499, 1.223750);
	PlayerTextDrawTextSize(playerid, DSTD[3], -8.000000, 17.500000);
	PlayerTextDrawAlignment(playerid, DSTD[3], 2);
	PlayerTextDrawColor(playerid, DSTD[3], -1);
	PlayerTextDrawSetShadow(playerid, DSTD[3], 0);
	PlayerTextDrawSetOutline(playerid, DSTD[3], 1);
	PlayerTextDrawBackgroundColor(playerid, DSTD[3], 51);
	PlayerTextDrawFont(playerid, DSTD[3], 2);
	PlayerTextDrawSetProportional(playerid, DSTD[3], 1);

	DSTD[4] = CreatePlayerTextDraw(playerid, 324.000000, 340.812500, "");
	PlayerTextDrawLetterSize(playerid, DSTD[4], 0.232500, 1.249999);
	PlayerTextDrawAlignment(playerid, DSTD[4], 2);
	PlayerTextDrawColor(playerid, DSTD[4], -1);
	PlayerTextDrawSetShadow(playerid, DSTD[4], 0);
	PlayerTextDrawSetOutline(playerid, DSTD[4], 1);
	PlayerTextDrawBackgroundColor(playerid, DSTD[4], 51);
	PlayerTextDrawFont(playerid, DSTD[4], 2);
	PlayerTextDrawSetProportional(playerid, DSTD[4], 1);

	DSTD[5] = CreatePlayerTextDraw(playerid, 323.000000, 351.750000, "STOCK: 46");
	PlayerTextDrawLetterSize(playerid, DSTD[5], 0.211500, 1.315624);
	PlayerTextDrawAlignment(playerid, DSTD[5], 2);
	PlayerTextDrawColor(playerid, DSTD[5], -1);
	PlayerTextDrawSetShadow(playerid, DSTD[5], 0);
	PlayerTextDrawSetOutline(playerid, DSTD[5], 1);
	PlayerTextDrawBackgroundColor(playerid, DSTD[5], 51);
	PlayerTextDrawFont(playerid, DSTD[5], 2);
	PlayerTextDrawSetProportional(playerid, DSTD[5], 1);

	DSTD[6] = CreatePlayerTextDraw(playerid, 323.000000, 380.625000, "TEST CAR");
	PlayerTextDrawLetterSize(playerid, DSTD[6], 0.229499, 1.311249);
	PlayerTextDrawAlignment(playerid, DSTD[6], 2);
	PlayerTextDrawColor(playerid, DSTD[6], -1);
	PlayerTextDrawSetShadow(playerid, DSTD[6], 0);
	PlayerTextDrawSetOutline(playerid, DSTD[6], 1);
	PlayerTextDrawBackgroundColor(playerid, DSTD[6], 51);
	PlayerTextDrawFont(playerid, DSTD[6], 2);
	PlayerTextDrawSetProportional(playerid, DSTD[6], 1);
	PlayerTextDrawSetSelectable(playerid, DSTD[6], true);

	DSTD[7] = CreatePlayerTextDraw(playerid, 323.500000, 392.000000, "MORE INFORMATIONS");
	PlayerTextDrawLetterSize(playerid, DSTD[7], 0.234999, 1.276250);
	PlayerTextDrawAlignment(playerid, DSTD[7], 2);
	PlayerTextDrawColor(playerid, DSTD[7], -1);
	PlayerTextDrawSetShadow(playerid, DSTD[7], 0);
	PlayerTextDrawSetOutline(playerid, DSTD[7], 1);
	PlayerTextDrawBackgroundColor(playerid, DSTD[7], 51);
	PlayerTextDrawFont(playerid, DSTD[7], 2);
	PlayerTextDrawSetProportional(playerid, DSTD[7], 1);
	PlayerTextDrawSetSelectable(playerid, DSTD[7], true);

	DSTD[8] = CreatePlayerTextDraw(playerid, 239.000000, 366.187500, "BUY CAR");
	PlayerTextDrawLetterSize(playerid, DSTD[8], 0.227500, 1.324375);
	PlayerTextDrawAlignment(playerid, DSTD[8], 2);
	PlayerTextDrawColor(playerid, DSTD[8], -1);
	PlayerTextDrawSetShadow(playerid, DSTD[8], 0);
	PlayerTextDrawSetOutline(playerid, DSTD[8], 1);
	PlayerTextDrawBackgroundColor(playerid, DSTD[8], 51);
	PlayerTextDrawFont(playerid, DSTD[8], 2);
	PlayerTextDrawSetProportional(playerid, DSTD[8], 1);
	PlayerTextDrawSetSelectable(playerid, DSTD[8], true);

	DSTD[9] = CreatePlayerTextDraw(playerid, 407.500000, 366.187500, "CANCEL");
	PlayerTextDrawLetterSize(playerid, DSTD[9], 0.236499, 1.355000);
	PlayerTextDrawAlignment(playerid, DSTD[9], 2);
	PlayerTextDrawColor(playerid, DSTD[9], -1);
	PlayerTextDrawSetShadow(playerid, DSTD[9], 0);
	PlayerTextDrawSetOutline(playerid, DSTD[9], 1);
	PlayerTextDrawBackgroundColor(playerid, DSTD[9], 51);
	PlayerTextDrawFont(playerid, DSTD[9], 2);
	PlayerTextDrawSetProportional(playerid, DSTD[9], 1);
	PlayerTextDrawSetSelectable(playerid, DSTD[9], true);

	DSTD[10] = CreatePlayerTextDraw(playerid, 175.500000, 346.500000, "<");
	PlayerTextDrawLetterSize(playerid, DSTD[10], 0.542499, 4.640625);
	PlayerTextDrawAlignment(playerid, DSTD[10], 1);
	PlayerTextDrawColor(playerid, DSTD[10], -1);
	PlayerTextDrawSetShadow(playerid, DSTD[10], 0);
	PlayerTextDrawSetOutline(playerid, DSTD[10], 1);
	PlayerTextDrawBackgroundColor(playerid, DSTD[10], 51);
	PlayerTextDrawFont(playerid, DSTD[10], 1);
	PlayerTextDrawSetProportional(playerid, DSTD[10], 1);
	PlayerTextDrawSetSelectable(playerid, DSTD[10], true);

	DSTD[11] = CreatePlayerTextDraw(playerid, 455.000000, 347.375000, ">");
	PlayerTextDrawLetterSize(playerid, DSTD[11], 0.524999, 4.509376);
	PlayerTextDrawAlignment(playerid, DSTD[11], 1);
	PlayerTextDrawColor(playerid, DSTD[11], -1);
	PlayerTextDrawSetShadow(playerid, DSTD[11], 0);
	PlayerTextDrawSetOutline(playerid, DSTD[11], 1);
	PlayerTextDrawBackgroundColor(playerid, DSTD[11], 51);
	PlayerTextDrawFont(playerid, DSTD[11], 1);
	PlayerTextDrawSetProportional(playerid, DSTD[11], 1);
	PlayerTextDrawSetSelectable(playerid, DSTD[11], true);
}

stock RemoveBuildings(playerid)
{
	//Farmer
	RemoveBuildingForPlayer(playerid, 3276, -378.7734, -1459.0234, 25.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -384.2344, -1455.8281, 25.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -368.7813, -1454.3672, 25.4766, 0.25);

	//Bus Driver
	RemoveBuildingForPlayer(playerid, 1215, 1586.2109, -2325.5625, 13.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1624.9453, -2247.0234, 13.0781, 0.25);
}

stock IsFarmerVeh(vehicleid)
{
    for(new i = 0; i < sizeof(FarmVeh); i++) if(vehicleid == FarmVeh[i]) return 1;
	return 0;
}

stock IsBusDriverVeh(vehicleid)
{
    for(new i = 0; i < sizeof(BDVeh); i++) if(vehicleid == BDVeh[i]) return 1;
	return 0;
}

stock IsTruckerVeh(vehicleid)
{
    for(new i = 0; i < sizeof(TVeh); i++) if(vehicleid == TVeh[i]) return 1;
	return 0;
}

stock IsPizzaBoyVeh(vehicleid)
{
    if(vehicleid == PBVeh[1] || vehicleid == PBVeh[2] || vehicleid == PBVeh[3] || vehicleid == PBVeh[4] || vehicleid == PBVeh[5] || vehicleid == PBVeh[6] ||
	vehicleid == PBVeh[7] || vehicleid == PBVeh[8] || vehicleid == PBVeh[9] || vehicleid == PBVeh[10] || vehicleid == PBVeh[11] || vehicleid == PBVeh[12] ||
	vehicleid == PBVeh[13] || vehicleid == PBVeh[14])
	{
		return 1;
	}
	return 0;
}

stock IsFactionVeh(vehicleid)
{
    if(VehInfo[vehicleid][Faction] > 0) return 1;
	return 0;
}

stock IsClanVeh(vehicleid)
{
    if(VehInfo[vehicleid][Clan] > 0) return 1;
	return 0;
}

stock IsABike(carid)
{
	switch(GetVehicleModel(carid))
	{
		case 510, 481, 509: return 1;
	}
	return 0;
}

stock CheckCarSpeed(playerid, mode = 1)
{
    new Float:Velocity[3];
    GetVehicleVelocity(GetPlayerVehicleID(playerid), Velocity[0], Velocity[1], Velocity[2]) ;
    return IsPlayerInAnyVehicle(playerid) ? floatround(((floatsqroot(((Velocity[0] * Velocity[0]) + (Velocity[1] * Velocity[1]) + (Velocity[2] * Velocity[2]))) * (!mode ? 105.0 : 170.0))) * 1) : 0;
}

stock GetVehSpeed(vehicleid)
{
	new Float:x, Float:y, Float:z, speed;

	GetVehicleVelocity(vehicleid, x, y, z);
 	speed = floatround(floatsqroot(x*x + y*y + z*z) * 180);
 	return speed;
}

stock GetVehNumber(playerid)
{
	new nr = 0;
	for(new i = 1; i <= Total_Veh_Created; i++) if(VehInfo[i][Owner] == PlayerInfo[playerid][ID] && !VehInfo[i][Type]) nr ++;
	return nr;
}

stock GetModelNumber(playerid, model)
{
	new nr = 0;
	for(new i = 1; i <= Total_Veh_Created; i++) if(VehInfo[i][Owner] == PlayerInfo[playerid][ID] && VehInfo[i][Model] == model) nr ++;
	return nr;
}

stock DespawnVeh(playerid)
{
	new vehicle = GetSpawnedVeh(playerid);
	if(vehicle != 0)
	{
	    if(IsValidObject(neon1[vehicle])) DestroyObject(neon1[vehicle]);
		if(IsValidObject(neon2[vehicle])) DestroyObject(neon2[vehicle]);

	    VehInfo[OwnedVeh[vehicle]][Spawned] = 0;
		vUpdate(OwnedVeh[vehicle], Spawnedx);

	    vUpdate(OwnedVeh[vehicle], KMx);
	    OwnedVeh[vehicle] = 0;
		DestroyVehicle(vehicle);
	}
	return 1;
}

stock GetSpawnedVeh(playerid)
{
	for(new i = 1; i < MAX_VEHICLES; i++) if(i != INVALID_VEHICLE_ID && VehInfo[i][Owner] == PlayerInfo[playerid][ID]) return i;
	return 0;
}

stock IsVehSpawned(vehicle)
{
	for(new i = 1; i < MAX_VEHICLES; i++) if(i != INVALID_VEHICLE_ID && OwnedVeh[i] == vehicle) return 1;
	return 0;
}

stock timec(timestamp, compare = -1)
{
    if(compare == -1) compare = gettime();

    new n, Float:d = (timestamp > compare) ? timestamp - compare:compare - timestamp, returnstr[32];
    if(d < 60) format(returnstr, sizeof(returnstr), "1 Minute"), return returnstr;
	else if(d < 3600) n = floatround(floatdiv(d, 60.0), floatround_floor), format(returnstr, sizeof(returnstr), "Minute");
	else if(d < 86400) n = floatround(floatdiv(d, 3600.0), floatround_floor), format(returnstr, sizeof(returnstr), "Hour");
	else if (d < 2592000) n = floatround(floatdiv(d, 86400.0), floatround_floor), format(returnstr, sizeof(returnstr), "Day");
	else if(d < 31536000) n = floatround(floatdiv(d, 2592000.0), floatround_floor), format(returnstr, sizeof(returnstr), "Month");
	else n = floatround(floatdiv(d, 31536000.0), floatround_floor), format(returnstr, sizeof(returnstr), "Year");

    if(n == 1) format(returnstr, sizeof(returnstr), "1 %s", returnstr);
    else format(returnstr, sizeof(returnstr), "%d %ss", n, returnstr);
    return returnstr;
}

//Functions
function ChangePassword(playerid)
{
	new rows, fields;
	cache_get_data(rows, fields, mysql);

	if(rows)
	{
	    SPD(playerid, DIALOG_CHANGEPASS + 1, DIALOG_STYLE_INPUT, "#STEP 2: Change your password", "Introdu parola dorita de tine.\n\n\
																								   - Ai grija sa nu gresesti parola, altminteri iti vei pierde contul.\n\
																								   - Introdu o parola grea, dar pe care sa o poti tine minte.\n\
																								   - Introdu caractere care sa faca parola mai complicata. (ex: '#', '6', '&', '*')", "OK", "Cancel");
		return 1;
	}
	else
	{
	    SPD(playerid, DIALOG_CHANGEPASS, DIALOG_STYLE_PASSWORD, "#STEP 1: Change your password", "Parola introdusa de tine este incorecta.\n\n\
																								  - Trebuie sa introduci parola actuala pentru a continua.\n\
																								  - Daca nu vrei sa iti schimbi parola apasa butonul \"Cancel\".", "OK", "Cancel");
		return 1;
	}
}
function CheckAccount(playerid)
{
	new Rows, Fields;
	kStr[0] = EOS;

	cache_get_data(Rows, Fields, mysql);
	if(!Rows)
	{
	    ClearChat(playerid, 50);
	    format(kStr, sizeof(kStr), ""D"RO: Bine ai venit %s pe server, te rugam sa selectezi limba ta natala.\n\n"D"EN: Welcome %s on our server, please select your body language.", GetCleanName(playerid), GetCleanName(playerid));
	    SPD(playerid, DIALOG_REGISTER, DIALOG_STYLE_MSGBOX, "Selecteaza-ti limba / Select your language", kStr, "Romana", "English");

	    InterpolateCameraPos(playerid, 980.072143, -960.567077, 99.725479, 1400.930297, -870.748352, 83.779884, 30000);
		InterpolateCameraLookAt(playerid, 984.804748, -962.165954, 99.940254, 1401.416503, -865.772155, 83.748634, 30000);
	}
	else
	{
		PlayerInfo[playerid][LastL] = cache_get_field_content(0, "LastLogin", LStr);
		PlayerInfo[playerid][Lang] = cache_get_field_content_int(0, "Lang");

		ClearChat(playerid, 50);

		InterpolateCameraPos(playerid, 980.072143, -960.567077, 99.725479, 1400.930297, -870.748352, 83.779884, 30000);
		InterpolateCameraLookAt(playerid, 984.804748, -962.165954, 99.940254, 1401.416503, -865.772155, 83.748634, 30000);

	    if(PlayerInfo[playerid][Lang] == 1)
	    {
			format(kStr, sizeof(kStr), ""D"Bine ai revenit %s pe serverul nostru!\nPentru a continua te rugam sa introduci parola cu care te-ai inregistrat!\n\nIntroducerea parolei este necesara pentru securitatea acestui cont.\nUltima la autentificare pe server: %s", GetCleanName(playerid), LStr);
	    	SPD(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Autentifica-te pe acest cont", kStr, "Ok", "Quit");
		}
		else if(PlayerInfo[playerid][Lang] == 2)
		{
		    format(kStr, sizeof(kStr), ""D"Welcome back %s on our server!\nTo continue please type your password that you registered on this server!\n\nThe password is necessary to protect this account.\nYour last login on this server: %s", GetCleanName(playerid), LStr);
	    	SPD(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login on this account", kStr, "Ok", "Quit");
		}
	}
}

function LoginPlayer(playerid)
{
    new Rows, Fields, hStr[128], vString[126];
	cache_get_data(Rows, Fields, mysql);

	if(Rows)
	{
        PlayerInfo[playerid][ID] = cache_get_field_content_int(0, "ID");
		PlayerInfo[playerid][Name] = cache_get_field_content(0, "Name", hStr);
		PlayerInfo[playerid][Password] = cache_get_field_content(0, "Password", hStr);
		PlayerInfo[playerid][Gendre] = cache_get_field_content_int(0, "Gendre");
		PlayerInfo[playerid][Age] = cache_get_field_content_int(0, "Age");

		cache_get_field_content(0, "Email", PlayerInfo[playerid][Email], mysql, 100);

		PlayerInfo[playerid][Lang] = cache_get_field_content_int(0, "Lang");
		PlayerInfo[playerid][Admin] = cache_get_field_content_int(0, "Admin");
		PlayerInfo[playerid][Helper] = cache_get_field_content_int(0, "Helper");

		PlayerInfo[playerid][Level] = cache_get_field_content_int(0, "Level");
		SetPlayerScore(playerid, PlayerInfo[playerid][Level]);

		PlayerInfo[playerid][Premium] = cache_get_field_content_int(0, "Premium");
		PlayerInfo[playerid][PremiumDays] = cache_get_field_content_int(0, "PremiumDays");
		PlayerInfo[playerid][Registered] = cache_get_field_content_int(0, "Registered");
		PlayerInfo[playerid][Respect] = cache_get_field_content_int(0, "Respect");

		PlayerInfo[playerid][Money] = cache_get_field_content_int(0, "Money");
		GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);

		PlayerInfo[playerid][Bank] = cache_get_field_content_int(0, "Bank");
		PlayerInfo[playerid][Kills] = cache_get_field_content_int(0, "Kills");
		PlayerInfo[playerid][Deaths] = cache_get_field_content_int(0, "Deaths");
		PlayerInfo[playerid][Wanted] = cache_get_field_content_int(0, "Wanted");
		PlayerInfo[playerid][Job] = cache_get_field_content_int(0, "Job");
		PlayerInfo[playerid][Tutorial] = cache_get_field_content_int(0, "Tutorial");
		PlayerInfo[playerid][PPoints] = cache_get_field_content_int(0, "PPoints");
		PlayerInfo[playerid][Paydays] = cache_get_field_content_int(0, "Paydays");
		PlayerInfo[playerid][Muted] = cache_get_field_content_int(0, "Muted");
		PlayerInfo[playerid][MuteTime] = cache_get_field_content_int(0, "MuteTime");
		PlayerInfo[playerid][Freeze] = cache_get_field_content_int(0, "Freeze");
		PlayerInfo[playerid][FreezeTime] = cache_get_field_content_int(0, "FreezeTime");
		PlayerInfo[playerid][Jailed] = cache_get_field_content_int(0, "Jailed");
		PlayerInfo[playerid][JailTime] = cache_get_field_content_int(0, "JailTime");
		PlayerInfo[playerid][Skin] = cache_get_field_content_int(0, "Skin");
		PlayerInfo[playerid][PIN] = cache_get_field_content_int(0, "PIN");
		PlayerInfo[playerid][CarL] = cache_get_field_content_int(0, "CarL");
		PlayerInfo[playerid][FlyL] = cache_get_field_content_int(0, "FlyL");
		PlayerInfo[playerid][GunL] = cache_get_field_content_int(0, "GunL");
		PlayerInfo[playerid][BoatL] = cache_get_field_content_int(0, "BoatL");

		cache_get_field_content(0, "LastLogin", PlayerInfo[playerid][LastL], mysql, 100);

		PlayerInfo[playerid][FarmerSkill] = cache_get_field_content_int(0, "FarmerSkill");
		PlayerInfo[playerid][BusDriverSkill] = cache_get_field_content_int(0, "BusDriverSkill");
		PlayerInfo[playerid][PizzaBoySkill] = cache_get_field_content_int(0, "PizzaBoySkill");
		PlayerInfo[playerid][SpawnX] = cache_get_field_content_float(0, "SpawnX");
		PlayerInfo[playerid][SpawnY] = cache_get_field_content_float(0, "SpawnY");
		PlayerInfo[playerid][SpawnZ] = cache_get_field_content_float(0, "SpawnZ");
		PlayerInfo[playerid][SpawnA] = cache_get_field_content_float(0, "SpawnA");
		PlayerInfo[playerid][Faction] = cache_get_field_content_int(0, "Faction");
		PlayerInfo[playerid][Rank] = cache_get_field_content_int(0, "Rank");
		PlayerInfo[playerid][Leader] = cache_get_field_content_int(0, "Leader");
		PlayerInfo[playerid][Materials] = cache_get_field_content_int(0, "Materials");
		PlayerInfo[playerid][Drugs] = cache_get_field_content_int(0, "Drugs");
		PlayerInfo[playerid][cRank] = cache_get_field_content_int(0, "cRank");
		PlayerInfo[playerid][cLeader] = cache_get_field_content_int(0, "cLeader");
		PlayerInfo[playerid][Clan] = cache_get_field_content_int(0, "Clan");
		PlayerInfo[playerid][FWarns] = cache_get_field_content_int(0, "FWarns");
		PlayerInfo[playerid][FPunish] = cache_get_field_content_int(0, "FPunish");
		PlayerInfo[playerid][CWarns] = cache_get_field_content_int(0, "CWarns");
		PlayerInfo[playerid][VehicleSlots] = cache_get_field_content_int(0, "VehicleSlots");
		
		cache_get_field_content(0, "Vehicles",hStr), format(vString, 126, hStr);
		new output[21][6], count;
		count = strexplode(output, vString, ",");
		for (new i = 0; i < count; i++) PlayerInfo[playerid][Vehicles][i] = strval(output[i]), PlayerInfo[playerid][VehCount]++;
		
		if(PlayerInfo[playerid][PremiumDays] > 0 && PlayerInfo[playerid][Premium] == 1)
		{
		    if(gettime() > PlayerInfo[playerid][PremiumDays])
		    {
		        PlayerInfo[playerid][Premium] = 0;
		        PlayerInfo[playerid][PremiumDays] = 0;
		        Update(playerid, Premiumx);
		        Update(playerid, PremiumDaysx);
		        
		        SCM(playerid, COLOR_WHITE, "SERVER: Contul tau premium a expirat. Daca vrei sa iti iei cont premium din nou, tasteaza /shop.");
		    }
		}

		if(PlayerInfo[playerid][Clan] > 0 && IsValidClan(PlayerInfo[playerid][Clan]))
		{
			new nName[24];
			if(ClanInfo[PlayerInfo[playerid][Clan]][Type] == 1)
			{
				format(nName, sizeof(nName), "%s%s", GetCleanName(playerid), ClanInfo[PlayerInfo[playerid][Clan]][Tag]);
			}
			else
			{
				format(nName, sizeof(nName), "%s%s", ClanInfo[PlayerInfo[playerid][Clan]][Tag], GetCleanName(playerid));
			}
			strmid(nName, nName, 0, 24);
			SetPlayerName(playerid, nName);
		}

		SetSpawnPlayer(playerid);
	}
	else
	{
	    if(PlayerInfo[playerid][Lang] == 1)
	    {
			format(kStr, sizeof(kStr), ""D"Bine ai revenit %s pe serverul nostru!\nPentru a continua te rugam sa introduci parola cu care te-ai inregistrat!\n\nIntroducerea parolei este necesara pentru securitatea acestui cont.\nUltima la autentificare pe server: %s\n\nParola pe care ai introdus-o este incorecta, introdu parola corecta pentru a continua:", GetCleanName(playerid), LStr);
	    	SPD(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Autentifica-te pe acest cont", kStr, "Ok", "Quit");
		}
		else if(PlayerInfo[playerid][Lang] == 2)
		{
		    format(kStr, sizeof(kStr), ""D"Welcome back %s on our server!\nTo continue please type your password that you registered on this server!\n\nThe password is necessary to protect this account.\nYour last login on this server: %s\n\nThis password is incorrect, insert the correct password to continue:", GetCleanName(playerid), PlayerInfo[playerid][LastL]);
	    	SPD(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login on this account", kStr, "Ok", "Quit");
		}
	}
}
function GetClosestVehicleToPlayer(playerid)
{
	if(!IsPlayerConnected(playerid) || playerid == INVALID_PLAYER_ID) return 1;
	new Float:dis = 5.0;
	new veh = -1;
	new Float:x, Float:y, Float:z, Float:distance;
	GetPlayerPos(playerid, x, y, z);
	for(new i = 1; i < MAX_VEHICLES; i++)
	{
		distance = GetVehicleDistanceFromPoint(i, x, y, z);
	    if(distance <= dis)
	    {
	        dis = distance;
	        veh = i;
			break;
		}
	}
	return veh;
}

stock GetOfflineInfo(playerid, type)
{
    new Rows, Fields, hStr[100];
	query[0] = EOS;
	switch(type)
	{
		case Namex:
		{
			mysql_format(mysql, query, sizeof(query), "SELECT * FROM `accounts` WHERE `ID` = %d", playerid);
			mysql_query(mysql, query);
			cache_get_data(Rows, Fields, mysql);
			if(Rows)
			{
				new data[100];
				cache_get_field_content(0, "Name",hStr), format(data, 100, hStr);
				return data;
			}
		}
	}
	format(hStr, sizeof(hStr), "NONE");
	return hStr;
}

function Update(playerid, type)
{
    if(IsPlayerConnected(playerid) && AccountExists(playerid))
	{
		query[0] = EOS;
		switch(type)
		{
			case IDx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `ID` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][ID], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Namex:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Name` = '%s' WHERE `ID` = '%d'", PlayerInfo[playerid][Name], PlayerInfo[playerid][ID]);
				mysql_query(mysql, query);
			}
			case Passwordx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Password` = '%s' WHERE `Name` = '%s'", PlayerInfo[playerid][Password], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Gendrex:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Gendre` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Gendre], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Agex:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Age` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Age], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Emailx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Email` = '%s' WHERE `Name` = '%s'", PlayerInfo[playerid][Email], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Langx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Lang` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Lang], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Adminx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Admin` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Admin], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Helperx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Helper` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Helper], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Levelx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Level` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Level], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Premiumx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Premium` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Premium], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case PremiumDaysx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `PremiumDays` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][PremiumDays], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Registeredx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Registered` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Registered], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Respectx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Respect` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Respect], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Moneyx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Money` = '%d' WHERE `Name` = '%s'", GetPlayerMoney(playerid), GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Bankx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Bank` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Bank], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Killsx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Kills` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Kills], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Deathsx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Deaths` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Deaths], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Wantedx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Wanted` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Wanted], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Jobx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Job` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Job], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Tutorialx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Tutorial` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Tutorial], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case PPointsx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `PPoints` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][PPoints], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Paydaysx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Paydays` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Paydays], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Mutedx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Muted` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Muted], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case MuteTimex:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `MuteTime` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][MuteTime], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Freezex:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Freeze` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Freeze], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case FreezeTimex:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `FreezeTime` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][FreezeTime], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Jailedx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Jailed` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Jailed], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case JailTimex:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `JailTime` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][JailTime], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Skinx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Skin` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Skin], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case PINx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `PIN` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][PIN], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case CarLx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `CarL` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][CarL], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case GunLx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `GunL` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][GunL], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case FlyLx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `FlyL` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][FlyL], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case BoatLx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `BoatL` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][BoatL], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case LastLx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `LastLogin` = '%s' WHERE `Name` = '%s'", PlayerInfo[playerid][LastL], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case FarmerSkillx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `FarmerSkill` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][FarmerSkill], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case BusDriverSkillx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `BusDriverSkill` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][BusDriverSkill], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case PizzaBoySkillx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `PizzaBoySkill` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][PizzaBoySkill], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case TruckerSkillx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `TruckerSkill` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][TruckerSkill], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case SpawnXx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `SpawnX` = '%f' WHERE `Name` = '%s'", PlayerInfo[playerid][SpawnX], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case SpawnYx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `SpawnY` = '%f' WHERE `Name` = '%s'", PlayerInfo[playerid][SpawnY], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case SpawnZx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `SpawnZ` = '%f' WHERE `Name` = '%s'", PlayerInfo[playerid][SpawnZ], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case SpawnAx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `SpawnA` = '%f' WHERE `Name` = '%s'", PlayerInfo[playerid][SpawnA], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Factionx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Faction` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Faction], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Rankx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Rank` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Rank], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Leaderx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Leader` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Leader], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Materialsx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Materials` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Materials], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Drugsx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Drugs` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Drugs], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case cLeaderx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `cLeader` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][cLeader], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case cRankx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `cRank` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][cRank], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Clanx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Clan` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][Clan], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case FWarnsx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `FWarns` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][FWarns], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case FPunishx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `FPunish` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][FPunish], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case CWarnsx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `CWarns` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][CWarns], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case VehicleSlotsx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `VehicleSlots` = '%d' WHERE `Name` = '%s'", PlayerInfo[playerid][VehicleSlots], GetCleanName(playerid));
				mysql_query(mysql, query);
			}
			case Vehiclesx:
			{
				new nString[126], str[6];
				for(new i = 0; i < 20; i++)
				{
					valstr(str, PlayerInfo[playerid][Vehicles][i]);
					if(PlayerInfo[playerid][Vehicles][i] > 0 && i == 0) strimplode("", nString, sizeof(nString), nString, str);
					if(PlayerInfo[playerid][Vehicles][i] > 0 && i != 0) strimplode(",", nString, sizeof(nString), nString, str);
				}
				mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `Vehicles` = '%e' WHERE `Name` = '%s'", nString, GetCleanName(playerid));
				mysql_query(mysql, query);
			}
		}
	}
}

function CreateFaction()
{
	new lID;
	for(new i = 1;i < MAX_FACTIONS;i++)
	{
	    if(FactionInfo[i][fID] < 1)
	    {
			query[0] = EOS;
			FactionInfo[i][fID] = lID + 1;
			mysql_format(mysql, query, sizeof(query), "INSERT INTO `factions` (`ID`) VALUES ('%d')", FactionInfo[i][fID]);
			mysql_query(mysql, query);
			i = MAX_FACTIONS + 1;
		}
		else
		{
		    lID = FactionInfo[i][fID];
		}
	}
	return 1;
}

function LastClanID()
{
	new lID = 0;
	for(new i = 1;i < MAX_CLANS;i++)
	{
	    if(ClanInfo[i][ID] < 1)
	    {
	        lID = lID + 1;
			i = MAX_CLANS + 1;
		}
		else lID = ClanInfo[i][ID];
	}
	return lID;
}

function LastPickupID()
{
	new lID = 0;
	for(new i = 1;i < MAX_PICKUPS;i++)
	{
	    if(PickupInfo[i][ID] < 1)
	    {
	        lID = lID + 1;
			i = MAX_PICKUPS + 1;
		}
		else lID = PickupInfo[i][ID];
	}
	return lID;
}

function AccountExists(playerid)
{
	new querya[128], total, rows, fields;
	mysql_format(mysql, querya, sizeof(querya), "SELECT * FROM `accounts` WHERE `Name` = '%s'", GetCleanName(playerid));
	mysql_query(mysql, querya);
	cache_get_data(rows, fields, mysql);
	total = rows;
	return total;
}
function LastCarID()
{
	new lID = -1;
	for(new i = 1;i < MAX_VEHICLES;i++)
	{
	    if(IsValidVehicle(i)) lID++;
		else lID++, i = MAX_VEHICLES + 1;
	}
	return lID;
}
function LastDatabaseCarID()
{
	new Rows, Fields, lID;
	cache_get_data(Rows, Fields, mysql);
	mysql_query(mysql, "SELECT * FROM `vehicles` ORDER BY `ID` DESC LIMIT 1");
	lID = cache_get_field_content_int(0, "ID");
	return lID;
}


function LastPlayerID()
{
	new lID = 0;
	for(new i = 1, j = GetPlayerPoolSize(); i < j; i++)
	{
	    if(PlayerInfo[i][ID] < 1) lID = lID + 1, i = MAX_PLAYERS + 1;
		else lID = PlayerInfo[i][ID];
	}
	return lID;
}

function CreateClan(name[64], time)
{
	new lID;
	for(new i = 1;i < MAX_CLANS;i++)
	{
	    if(ClanInfo[i][ID] < 1)
	    {
			query[0] = EOS;
			ClanInfo[i][ID] = lID + 1;
			mysql_format(mysql, query, sizeof(query), "INSERT INTO `clans` (`ID`, `Name`, `Days`, `Slots`) VALUES ('%d', '%s', '%d', '%d')", ClanInfo[i][ID], name, gettime() + time*86400, 15);
			mysql_query(mysql, query);
			i = MAX_CLANS + 1;
		}
		else lID = ClanInfo[i][ID];
	}
	return 1;
}

function tUpdate(turfid, type)
{
   	query[0] = EOS;
	switch(type)
	{
		case Namex:
		{
			mysql_format(mysql, query, sizeof(query), "UPDATE `turfs` SET `Name` = '%s' WHERE `ID` = %d", Turfs[turfid][Name], Turfs[turfid][MysqlID]);
			mysql_query(mysql, query);
		}
		case Factionx:
		{
			mysql_format(mysql, query, sizeof(query), "UPDATE `turfs` SET `Faction` = '%d' WHERE `ID` = %d", Turfs[turfid][Faction], Turfs[turfid][MysqlID]);
			mysql_query(mysql, query);
		}
	}
	return 1;
}


function fUpdate(factionid, type)
{
	if(IsValidFaction(factionid))
	{
	   	query[0] = EOS;
		switch(type)
		{
			case Namex:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fName` = '%s' WHERE `ID` = '%d'", FactionInfo[factionid][fName], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Motdx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fMotd` = '%s' WHERE `ID` = '%d'", FactionInfo[factionid][fMotd], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Rank1x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fRank1` = '%s' WHERE `ID` = '%d'", FactionInfo[factionid][fRank1], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Rank2x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fRank2` = '%s' WHERE `ID` = '%d'", FactionInfo[factionid][fRank2], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Rank3x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fRank3` = '%s' WHERE `ID` = '%d'", FactionInfo[factionid][fRank3], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Rank4x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fRank4` = '%s' WHERE `ID` = '%d'", FactionInfo[factionid][fRank4], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Rank5x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fRank5` = '%s' WHERE `ID` = '%d'", FactionInfo[factionid][fRank5], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Rank6x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fRank6` = '%s' WHERE `ID` = '%d'", FactionInfo[factionid][fRank6], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Leaderx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fLeader` = '%s' WHERE `ID` = '%d'", FactionInfo[factionid][fLeader], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Skin1x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fSkin1` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fSkin1], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Skin2x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fSkin2` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fSkin2], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Skin3x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fSkin3` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fSkin3], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Skin4x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fSkin4` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fSkin4], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Skin5x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fSkin5` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fSkin5], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Skin6x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fSkin6` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fSkin6], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Skin7x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fSkin7` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fSkin7], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fIntXx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fIntX` = '%f' WHERE `ID` = '%d'", FactionInfo[factionid][fIntX], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fIntYx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fIntY` = '%f' WHERE `ID` = '%d'", FactionInfo[factionid][fIntY], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fIntZx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fIntZ` = '%f' WHERE `ID` = '%d'", FactionInfo[factionid][fIntZ], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fExtXx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fExtX` = '%f' WHERE `ID` = '%d'", FactionInfo[factionid][fExtX], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fExtYx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fExtY` = '%f' WHERE `ID` = '%d'", FactionInfo[factionid][fExtY], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fExtZx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fExtZ` = '%f' WHERE `ID` = '%d'", FactionInfo[factionid][fExtZ], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fIntx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fInt` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fInt], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fVWx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fVW` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fVW], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Slotsx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fSlots` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fSlots], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Membersx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fMembers` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fMembers], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case Applicationsx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fApplications` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fApplications], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fMoneyx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fMoney` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fMoney], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fDrugsx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fDrugs` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fDrugs], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fMatsx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fMats` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fMats], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fMinLevelx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fMinLevel` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fMinLevel], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case CommandRankx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fCommandRank` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fCommandRank], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fTypex:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fType` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fType], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fColorx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fColor` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fColor], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fOrder1x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fOrder1_1` = '%d', `fOrder1_2` = '%d', `fOrder1_3` = '%d', `fOrder1_4` = '%d', `fOrder1_5` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fOrder1][0], FactionInfo[factionid][fOrder1][1], FactionInfo[factionid][fOrder1][2], FactionInfo[factionid][fOrder1][3], FactionInfo[factionid][fOrder1][4], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fOrder2x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fOrder2_1` = '%d', `fOrder2_2` = '%d', `fOrder2_3` = '%d', `fOrder2_4` = '%d', `fOrder2_5` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fOrder2][0], FactionInfo[factionid][fOrder2][1], FactionInfo[factionid][fOrder2][2], FactionInfo[factionid][fOrder2][3], FactionInfo[factionid][fOrder2][4], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fOrder3x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fOrder3_1` = '%d', `fOrder3_2` = '%d', `fOrder3_3` = '%d', `fOrder3_4` = '%d', `fOrder3_5` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fOrder3][0], FactionInfo[factionid][fOrder3][1], FactionInfo[factionid][fOrder3][2], FactionInfo[factionid][fOrder3][3], FactionInfo[factionid][fOrder3][4], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
			case fOrder4x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `fOrder4_1` = '%d', `fOrder4_2` = '%d', `fOrder4_3` = '%d', `fOrder4_4` = '%d', `fOrder4_5` = '%d' WHERE `ID` = '%d'", FactionInfo[factionid][fOrder4][0], FactionInfo[factionid][fOrder4][1], FactionInfo[factionid][fOrder4][2], FactionInfo[factionid][fOrder4][3], FactionInfo[factionid][fOrder4][4], FactionInfo[factionid][fID]);
				mysql_query(mysql, query);
			}
		}
	}
	return 1;
}

function cUpdate(cid, type)
{
	if(IsValidClan(cid))
	{
	   	query[0] = EOS;
		switch(type)
		{
			case Namex:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `clans` SET `Name` = '%s' WHERE `ID` = '%d'", ClanInfo[cid][Name], ClanInfo[cid][ID]);
				mysql_query(mysql, query);
			}
			case Tagx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `clans` SET `Tag` = '%s' WHERE `ID` = '%d'", ClanInfo[cid][Tag], ClanInfo[cid][ID]);
				mysql_query(mysql, query);
			}
			case Motdx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `clans` SET `Motd` = '%s' WHERE `ID` = '%d'", ClanInfo[cid][Motd], ClanInfo[cid][ID]);
				mysql_query(mysql, query);
			}
			case Rank1x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `clans` SET `Rank1` = '%s' WHERE `ID` = '%d'", ClanInfo[cid][Rank1], ClanInfo[cid][ID]);
				mysql_query(mysql, query);
			}
			case Rank2x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `clans` SET `Rank2` = '%s' WHERE `ID` = '%d'", ClanInfo[cid][Rank2], ClanInfo[cid][ID]);
				mysql_query(mysql, query);
			}
			case Rank3x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `clans` SET `Rank3` = '%s' WHERE `ID` = '%d'", ClanInfo[cid][Rank3], ClanInfo[cid][ID]);
				mysql_query(mysql, query);
			}
			case Rank4x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `clans` SET `Rank4` = '%s' WHERE `ID` = '%d'", ClanInfo[cid][Rank4], ClanInfo[cid][ID]);
				mysql_query(mysql, query);
			}
			case Rank5x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `clans` SET `Rank5` = '%s' WHERE `ID` = '%d'", ClanInfo[cid][Rank5], ClanInfo[cid][ID]);
				mysql_query(mysql, query);
			}
			case Rank6x:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `clans` SET `Rank6` = '%s' WHERE `ID` = '%d'", ClanInfo[cid][Rank6], ClanInfo[cid][ID]);
				mysql_query(mysql, query);
			}
			case Leaderx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `clans` SET `Leader` = '%s' WHERE `ID` = '%d'", ClanInfo[cid][Leader], ClanInfo[cid][ID]);
				mysql_query(mysql, query);
			}
			case Slotsx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `clans` SET `Slots` = '%d' WHERE `ID` = '%d'", ClanInfo[cid][Slots], ClanInfo[cid][ID]);
				mysql_query(mysql, query);
			}
			case Membersx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `clans` SET `Members` = '%d' WHERE `ID` = '%d'", ClanInfo[cid][Members], ClanInfo[cid][ID]);
				mysql_query(mysql, query);
			}
			case Applicationsx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `clans` SET `Applications` = '%d' WHERE `ID` = '%d'", ClanInfo[cid][Applications], ClanInfo[cid][ID]);
				mysql_query(mysql, query);
			}
			case CommandRankx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `clans` SET `CommandRank` = '%d' WHERE `ID` = '%d'", ClanInfo[cid][CommandRank], ClanInfo[cid][ID]);
				mysql_query(mysql, query);
			}
			case Typex:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `clans` SET `Type` = '%d' WHERE `ID` = '%d'", ClanInfo[cid][Type], ClanInfo[cid][ID]);
				mysql_query(mysql, query);
			}
			case Daysx:
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE `clans` SET `Days` = '%d' WHERE `ID` = '%d'", ClanInfo[cid][Days], ClanInfo[cid][ID]);
				mysql_query(mysql, query);
			}
		}
	}
	return 1;
}

function IsValidFaction(factionid)
{
	if(FactionInfo[factionid][fID] > 0) return 1;
	return 0;
}

function IsValidClan(clanid)
{
	if(ClanInfo[clanid][ID] > 0) return 1;
	return 0;
}


function vUpdate(id, type)
{
    query[0] = EOS;
	switch(type)
	{
		case IDx:
		{
			mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `ID` = '%d' WHERE `ID` = '%d'", VehInfo[id][ID], VehInfo[id][ID]);
			mysql_query(mysql, query);
		}
		case Modelx:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `Model` = '%d' WHERE `ID` = '%d'", VehInfo[id][Model], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case Color1x:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `Color1` = '%d' WHERE `ID` = '%d'", VehInfo[id][Color1], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case Color2x:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `Color2` = '%d' WHERE `ID` = '%d'", VehInfo[id][Color2], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case Pricex:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `Price` = '%d' WHERE `ID` = '%d'", VehInfo[id][Price], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case Ownerx:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `Owner` = '%d' WHERE `ID` = '%d'", VehInfo[id][Owner], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case PosXx:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `PosX` = '%f' WHERE `ID` = '%d'", VehInfo[id][PosX], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case PosYx:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `PosY` = '%f' WHERE `ID` = '%d'", VehInfo[id][PosY], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case PosZx:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `PosZ` = '%f' WHERE `ID` = '%d'", VehInfo[id][PosZ], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case PosAx:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `PosA` = '%f' WHERE `ID` = '%d'", VehInfo[id][PosA], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case Platex:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `Plate` = '%s' WHERE `ID` = '%d'", VehInfo[id][Plate], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case PaintJx:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `PaintJ` = '%d' WHERE `ID` = '%d'", VehInfo[id][PaintJ], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case Lockedx:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `Locked` = '%d' WHERE `ID` = '%d'", VehInfo[id][Locked], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case Spawnedx:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `Spawned` = '%d' WHERE `ID` = '%d'", VehInfo[id][Spawned], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case KMx:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `KM` = '%d' WHERE `ID` = '%d'", VehInfo[id][KM], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case Fuelx:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `Fuel` = '%d' WHERE `ID` = '%d'", VehInfo[id][Fuel], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case Typex:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `Type` = '%d' WHERE `ID` = '%d'", VehInfo[id][Type], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case Factionx:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `Faction` = '%d' WHERE `ID` = '%d'", VehInfo[id][Faction], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case Rankx:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `Rank` = '%d' WHERE `ID` = '%d'", VehInfo[id][Rank], VehInfo[id][ID]);
		    mysql_query(mysql, query);
		}
		case dsStockx:
		{
		    mysql_format(mysql, query, sizeof(query), "UPDATE `dealership` SET `Stock` = '%d' WHERE `Model` = '%d'", DInfo[id][Stock], DInfo[id][Model]);
		    mysql_query(mysql, query);
		}
	}
}

function SetSpawnPlayer(playerid)
{
	SetPlayerHealth(playerid, 100);
	if(PlayerInfo[playerid][Faction] == 0)
	{
    	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][Skin], PlayerInfo[playerid][SpawnX], PlayerInfo[playerid][SpawnY], PlayerInfo[playerid][SpawnZ], PlayerInfo[playerid][SpawnA], 0, 0, 0, 0, 0, 0);
	}
	else
	{
	    new fid = PlayerInfo[playerid][Faction];
    	SetSpawnInfo(playerid, PlayerInfo[playerid][Faction], GetPlayerRankSkin(playerid), FactionInfo[fid][fIntX], FactionInfo[fid][fIntY], FactionInfo[fid][fIntZ], 0, 0, 0, 0, 0, 0, 0);
	}
	TogglePlayerSpectating(playerid, 0);
    HideInfoTD(playerid);
    
    if(PlayerInfo[playerid][Lang] == 1)
    {
        if(PlayerInfo[playerid][Registered] == 1)
        {
            ClearChat(playerid, 50);
            SCM(playerid, COLOR_SERVER, "SERVER: {FFFFFF}Bine ai revenit pe serverul UNNIC RPG.");
        }
        else
        {
            ClearChat(playerid, 50);
            SCM(playerid, COLOR_SERVER, "SERVER: {FFFFFF}Bine ai venit pe serverul UNNIC RPG.");
            SCM(playerid, COLOR_SERVER, "SERVER: {FFFFFF}Ai primit +1.500$ in cont pentru inceput.");

			Info(playerid, "Mergi la ~r~punctul rosu ~w~~h~de pe harta pentru a lua permisul auto.", 999);
			SetPlayerCheckpoint(playerid, 1219.2212,-1813.0067,16.5938, 4.0);
			CP[playerid] = 5;

			SPD(playerid, DIALOG_TUTORIAL, DIALOG_STYLE_MSGBOX, "Tutorial 1: DMV License", "Bun venit la tutorialul Scoala de Soferi.\n\
																			  				Pentru a obtine permisul auto trebuie sa ajungi la punctul rosu de pe harta, acolo se afla DMV-ul.\n\
																			  				Pentru a afla unde este DMV-ul poti folosi de asemenea comanda /gps in chat.", "OK", "");

			PlayerInfo[playerid][Registered] = 1;
	    	Update(playerid, Registeredx);
        }
    }
    else if(PlayerInfo[playerid][Lang] == 2)
    {
        if(PlayerInfo[playerid][Registered] == 1)
        {
            ClearChat(playerid, 50);
            SCM(playerid, COLOR_SERVER, "SERVER: {FFFFFF}Welcome back on UNNIC RPG server.");
        }
        else
        {
            ClearChat(playerid, 50);
            SCM(playerid, COLOR_SERVER, "SERVER: {FFFFFF}Welcome on UNNIC RPG server.");
            SCM(playerid, COLOR_SERVER, "SERVER: {FFFFFF}You got +1.500$ for starting from our staff.");

			Info(playerid, "Go at ~r~red checkpoint ~w~~h~on minimap to take the DMV license.", 999);
			SetPlayerCheckpoint(playerid, 1219.2212,-1813.0067,16.5938, 4.0);
			CP[playerid] = 5;

			SPD(playerid, DIALOG_TUTORIAL, DIALOG_STYLE_MSGBOX, "Tutorial 1: DMV License", "Welcome on Driving School tutorial.\n\
																			  				For obtain the car license you must to go at the red checkpoint on minimap, here is the DMV.\n\
																			  				To find the DMV, you can use /gps in chat.", "OK", "");

            PlayerInfo[playerid][Registered] = 1;
	    	Update(playerid, Registeredx);
        }
    }
    IsPlayerLogged[playerid] = 1;
}

function RespawnPlayer(playerid)
{
	SetPlayerHealth(playerid, 100);
	if(PlayerInfo[playerid][Faction] == 0)
	{
    	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][Skin], PlayerInfo[playerid][SpawnX], PlayerInfo[playerid][SpawnY], PlayerInfo[playerid][SpawnZ] + 0.5, PlayerInfo[playerid][SpawnA], 0, 0, 0, 0, 0, 0);
        SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
	}
	else
	{
	    new fid = PlayerInfo[playerid][Faction];
    	SetSpawnInfo(playerid, PlayerInfo[playerid][Faction], GetPlayerRankSkin(playerid), FactionInfo[fid][fIntX], FactionInfo[fid][fIntY], FactionInfo[fid][fIntZ] + 0.5, 0, 0, 0, 0, 0, 0, 0);
		SetPlayerInterior(playerid, FactionInfo[fid][fInt]);
		SetPlayerVirtualWorld(playerid, FactionInfo[fid][fVW]);
	}
	TogglePlayerSpectating(playerid, 0);
    SpawnPlayer(playerid);
    HideInfoTD(playerid);
}

function ClearChat(playerid, lines)
{
    if(IsPlayerConnected(playerid)) for(new i = 0; i < lines; i++) SCM(playerid, COLOR_SERVER, "");
	return 1;
}

function ProxDetector(Float:radi, playerid, string[], col1, col2, col3, col4, col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;

		GetPlayerPos(playerid, oldposx, oldposy, oldposz);

		foreach(Player, i)
		{
			if(GetPlayerInterior(playerid) == GetPlayerInterior(i) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
			{
				if(!BigEar[i])
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);

					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SCM(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SCM(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SCM(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SCM(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SCM(i, col5, string);
					}
				}
				else
				{
					SCM(i, col1, string);
				}
			}
		}
	}
	return 1;
}

function ProxDetectorS(Float:radi, playerid, targetid)
{
    if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);

		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);

		if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

function LoadSystems()
{
	printf("");
	printf(" ---------------------------------------");
	printf(" Check database dynamic systems ...");
	printf(" ---------------------------------------");
	printf("");
	mysql_tquery(mysql, "SELECT * FROM `server`", "LoadServer", "");
	mysql_tquery(mysql, "SELECT * FROM `dealership`", "LoadDS", "");
	mysql_tquery(mysql, "SELECT * FROM `factions`", "LoadFactions", "");
	mysql_tquery(mysql, "SELECT * FROM `clans`", "LoadClans", "");
	mysql_tquery(mysql, "SELECT * FROM `vehicles`", "LoadVehicles", "");
	mysql_tquery(mysql, "SELECT * FROM `turfs`", "LoadTurfs", "");
}

function LoadServer()
{
	new srv[500];

	cache_get_field_content(0, "Hostname", ServerInfo[Hostname], mysql, 100);
	cache_get_field_content(0, "Language", ServerInfo[Language], mysql, 100);
	cache_get_field_content(0, "Mode", ServerInfo[Mode], mysql, 100);
	cache_get_field_content(0, "Map", ServerInfo[Map], mysql, 50);
	cache_get_field_content(0, "RecordDate", ServerInfo[RecordDate], mysql, 50);
	cache_get_field_content(0, "LastAccount", ServerInfo[LastAccount], mysql, 40);
	ServerInfo[LastID] = cache_get_field_content_int(0, "LastID");
	ServerInfo[Record] = cache_get_field_content_int(0, "Record");
	ServerInfo[WarMinHour] = cache_get_field_content_int(0, "WarMinHour");
	ServerInfo[WarMaxHour] = cache_get_field_content_int(0, "WarMaxHour");

	format(srv, sizeof(srv), "hostname %s", ServerInfo[Hostname]);
	SendRconCommand(srv);

	format(srv, sizeof(srv), "language %s", ServerInfo[Language]);
	SendRconCommand(srv);

	new y, m, d, h, mins, secs;
	getdate(y, m, d);
	gettime(h, mins, secs);

	new str[500];
	format(str, sizeof(str), "RPG %02d/%02d/%d %02d:%02d", d, m, y, h, mins);

	format(srv, sizeof(srv), "%s", str);
	SetGameModeText(srv);

	format(srv, sizeof(srv), "map %s", ServerInfo[Map]);
	SendRconCommand(srv);

	return 1;
}

function LoadDS()
{
	new Fields, Rows, id = 0;
	cache_get_data(Rows, Fields, mysql);

	for(new i = 0; i < Rows; i++)
	{
		DInfo[id][ID] = cache_get_field_content_int(i, "ID");
		DInfo[id][Model] = cache_get_field_content_int(i, "Model");
		DInfo[id][Price] = cache_get_field_content_int(i, "Price");
		DInfo[id][Stock] = cache_get_field_content_int(i, "Stock");
		DInfo[id][Type] = cache_get_field_content_int(i, "Type");
		DInfo[id][TypeID] = GetTypeID(DInfo[id][Type]);
		printf("Loaded ds: ID: %d || Model: %d || id: %d || typeid: %d", DInfo[id][ID], DInfo[id][Model], id, DInfo[id][TypeID]);
	    id++;
	}

	printf(" * Load Dealership: %d", Rows);
	return 1;
}

function LoadVehicles()
{
	new rows, fields, temp[128], vehid;
    cache_get_data(rows, fields, mysql);
    if(rows)
    {
        for(new i = 0;i < rows; i++)
        {
            Total_Veh_Created++;
	        VehInfo[Total_Veh_Created][ID] = cache_get_field_content_int(i, "ID");
	        VehInfo[Total_Veh_Created][CarID] = cache_get_field_content_int(i, "CarID");
	        cache_get_field_content(i, "Plate",temp), format(VehInfo[i][Plate], 32, temp);
	        VehInfo[Total_Veh_Created][Owner] = cache_get_field_content_int(i, "Owner");
	        VehInfo[Total_Veh_Created][PosX] = cache_get_field_content_float(i, "PosX");
	        VehInfo[Total_Veh_Created][PosY] = cache_get_field_content_float(i, "PosY");
	        VehInfo[Total_Veh_Created][PosZ] = cache_get_field_content_float(i, "PosZ");
	        VehInfo[Total_Veh_Created][PosA] = cache_get_field_content_float(i, "PosA");
	        VehInfo[Total_Veh_Created][Color1] = cache_get_field_content_int(i, "Color1");
	        VehInfo[Total_Veh_Created][Color2] = cache_get_field_content_int(i, "Color2");
	        VehInfo[Total_Veh_Created][Model] = cache_get_field_content_int(i, "Model");
	        VehInfo[Total_Veh_Created][Faction] = cache_get_field_content_int(i, "Faction");
	        VehInfo[Total_Veh_Created][Rank] = cache_get_field_content_int(i, "Rank");
	        VehInfo[Total_Veh_Created][Clan] = cache_get_field_content_int(i, "Clan");
	        VehInfo[Total_Veh_Created][KM] = cache_get_field_content_int(i, "KM");
	        VehInfo[Total_Veh_Created][Locked] = cache_get_field_content_int(i, "Locked");
	        VehInfo[Total_Veh_Created][Type] = cache_get_field_content_int(i, "Type");
	        VehInfo[Total_Veh_Created][Spawnable] = 1;
	        vehid = CreateVehicle(VehInfo[Total_Veh_Created][Model], VehInfo[Total_Veh_Created][PosX], VehInfo[Total_Veh_Created][PosY], VehInfo[Total_Veh_Created][PosZ], VehInfo[Total_Veh_Created][PosA], VehInfo[Total_Veh_Created][Color1], VehInfo[Total_Veh_Created][Color2], 500000);
			if(VehInfo[Total_Veh_Created][Owner] > 0) SetVehicleNumberPlate(vehid, GetOfflineInfo(VehInfo[Total_Veh_Created][Owner], Namex));
		}
		printf(" * Load Vehicles: %d", rows);
	}
    return 1;
}
function LoadFactions()
{
	new rows, fields, temp[128];
    cache_get_data(rows, fields, mysql);
    if(rows)
    {
        for(new i = 0;i < rows && i < MAX_FACTIONS; i++)
        {
			new fid = i + 1;
	        FactionInfo[fid][fID] = cache_get_field_content_int(i, "ID");
	        cache_get_field_content(i, "fName",temp), format(FactionInfo[fid][fName], 64, temp);
	        cache_get_field_content(i, "fRank1",temp), format(FactionInfo[fid][fRank1], 32, temp);
	        cache_get_field_content(i, "fRank2",temp), format(FactionInfo[fid][fRank2], 32, temp);
	        cache_get_field_content(i, "fRank3",temp), format(FactionInfo[fid][fRank3], 32, temp);
	        cache_get_field_content(i, "fRank4",temp), format(FactionInfo[fid][fRank4], 32, temp);
	        cache_get_field_content(i, "fRank5",temp), format(FactionInfo[fid][fRank5], 32, temp);
	        cache_get_field_content(i, "fRank6",temp), format(FactionInfo[fid][fRank6], 32, temp);
	        cache_get_field_content(i, "fLeader",temp), format(FactionInfo[fid][fLeader], 32, temp);
	        FactionInfo[fid][fSkin1] = cache_get_field_content_int(i, "fSkin1");
	        FactionInfo[fid][fSkin2] = cache_get_field_content_int(i, "fSkin2");
	        FactionInfo[fid][fSkin3] = cache_get_field_content_int(i, "fSkin3");
	        FactionInfo[fid][fSkin4] = cache_get_field_content_int(i, "fSkin4");
	        FactionInfo[fid][fSkin5] = cache_get_field_content_int(i, "fSkin5");
	        FactionInfo[fid][fSkin6] = cache_get_field_content_int(i, "fSkin6");
	        FactionInfo[fid][fSkin7] = cache_get_field_content_int(i, "fSkin7");
	        cache_get_field_content(i, "fMotd",temp), format(FactionInfo[fid][fMotd], 128, temp);
	        FactionInfo[fid][fExtX] = cache_get_field_content_float(i, "fExtX");
	        FactionInfo[fid][fExtY] = cache_get_field_content_float(i, "fExtY");
	        FactionInfo[fid][fExtZ] = cache_get_field_content_float(i, "fExtZ");
	        FactionInfo[fid][fIntX] = cache_get_field_content_float(i, "fIntX");
	        FactionInfo[fid][fIntY] = cache_get_field_content_float(i, "fIntY");
	        FactionInfo[fid][fIntZ] = cache_get_field_content_float(i, "fIntZ");
	        FactionInfo[fid][fInt] = cache_get_field_content_int(i, "fInt");
	        FactionInfo[fid][fVW] = cache_get_field_content_int(i, "fVW");
	        FactionInfo[fid][fSlots] = cache_get_field_content_int(i, "fSlots");
	        FactionInfo[fid][fMembers] = cache_get_field_content_int(i, "fMembers");
	        FactionInfo[fid][fApplications] = cache_get_field_content_int(i, "fApplications");
	        FactionInfo[fid][fMoney] = cache_get_field_content_int(i, "fMoney");
	        FactionInfo[fid][fMats] = cache_get_field_content_int(i, "fMats");
	        FactionInfo[fid][fMinLevel] = cache_get_field_content_int(i, "fMinLevel");
	        FactionInfo[fid][fCommandRank] = cache_get_field_content_int(i, "fCommandRank");
	        FactionInfo[fid][fType] = cache_get_field_content_int(i, "fType");
	        FactionInfo[fid][fColor] = cache_get_field_content_int(i, "fColor");
	        FactionInfo[fid][fOrder1][0] = cache_get_field_content_int(i, "fOrder1_1");
	        FactionInfo[fid][fOrder1][1] = cache_get_field_content_int(i, "fOrder1_2");
	        FactionInfo[fid][fOrder1][2] = cache_get_field_content_int(i, "fOrder1_3");
	        FactionInfo[fid][fOrder1][3] = cache_get_field_content_int(i, "fOrder1_4");
	        FactionInfo[fid][fOrder1][4] = cache_get_field_content_int(i, "fOrder1_5");
	        FactionInfo[fid][fOrder2][0] = cache_get_field_content_int(i, "fOrder2_1");
	        FactionInfo[fid][fOrder2][1] = cache_get_field_content_int(i, "fOrder2_2");
	        FactionInfo[fid][fOrder2][2] = cache_get_field_content_int(i, "fOrder2_3");
	        FactionInfo[fid][fOrder2][3] = cache_get_field_content_int(i, "fOrder2_4");
	        FactionInfo[fid][fOrder2][4] = cache_get_field_content_int(i, "fOrder2_5");
	        FactionInfo[fid][fOrder3][0] = cache_get_field_content_int(i, "fOrder3_1");
	        FactionInfo[fid][fOrder3][1] = cache_get_field_content_int(i, "fOrder3_2");
	        FactionInfo[fid][fOrder3][2] = cache_get_field_content_int(i, "fOrder3_3");
	        FactionInfo[fid][fOrder3][3] = cache_get_field_content_int(i, "fOrder3_4");
	        FactionInfo[fid][fOrder3][4] = cache_get_field_content_int(i, "fOrder3_5");
	        FactionInfo[fid][fOrder4][0] = cache_get_field_content_int(i, "fOrder4_1");
	        FactionInfo[fid][fOrder4][1] = cache_get_field_content_int(i, "fOrder4_2");
	        FactionInfo[fid][fOrder4][2] = cache_get_field_content_int(i, "fOrder4_3");
	        FactionInfo[fid][fOrder4][3] = cache_get_field_content_int(i, "fOrder4_4");
	        FactionInfo[fid][fOrder4][4] = cache_get_field_content_int(i, "fOrder4_5");
	        FactionInfo[fid][fPickup] = CreateDynamicPickup(1239, 20, FactionInfo[fid][fExtX], FactionInfo[fid][fExtY], FactionInfo[fid][fExtZ], 0);
	        FactionInfo[fid][fText3D] = CreateDynamic3DTextLabel(FactionInfo[fid][fName], COLOR_WHITE, FactionInfo[fid][fExtX], FactionInfo[fid][fExtY], FactionInfo[fid][fExtZ], 20.0);
    	}
		printf(" * Load Factions: %d", rows);
	}
    return 1;
}

function LoadClans()
{
	new rows, fields, temp[128];
    cache_get_data(rows, fields, mysql);
    if(rows)
    {
        for(new i = 0;i < rows && i < MAX_CLANS; i++)
        {
			new cid = i + 1;
	        ClanInfo[cid][ID] = cache_get_field_content_int(i, "ID");
	        cache_get_field_content(i, "Name",temp), format(ClanInfo[cid][Name], 64, temp);
	        cache_get_field_content(i, "Tag",temp), format(ClanInfo[cid][Tag], 6, temp);
	        cache_get_field_content(i, "Rank1",temp), format(ClanInfo[cid][Rank1], 32, temp);
	        cache_get_field_content(i, "Rank2",temp), format(ClanInfo[cid][Rank2], 32, temp);
	        cache_get_field_content(i, "Rank3",temp), format(ClanInfo[cid][Rank3], 32, temp);
	        cache_get_field_content(i, "Rank4",temp), format(ClanInfo[cid][Rank4], 32, temp);
	        cache_get_field_content(i, "Rank5",temp), format(ClanInfo[cid][Rank5], 32, temp);
	        cache_get_field_content(i, "Rank6",temp), format(ClanInfo[cid][Rank6], 32, temp);
	        cache_get_field_content(i, "Leader",temp), format(ClanInfo[cid][Leader], 32, temp);
	        cache_get_field_content(i, "Motd",temp), format(ClanInfo[cid][Motd], 128, temp);
	        ClanInfo[cid][Slots] = cache_get_field_content_int(i, "Slots");
	        ClanInfo[cid][Members] = cache_get_field_content_int(i, "Members");
	        ClanInfo[cid][Applications] = cache_get_field_content_int(i, "Applications");
	        ClanInfo[cid][CommandRank] = cache_get_field_content_int(i, "CommandRank");
	        ClanInfo[cid][Type] = cache_get_field_content_int(i, "Type");
	        ClanInfo[cid][Days] = cache_get_field_content_int(i, "Days");
		}
		printf(" * Load Clans: %d", rows);
	}
    return 1;
}

function LoadTurfs()
{
	new Fields, Rows, temp[128];
	cache_get_data(Rows, Fields, mysql);

	for(new i = 0; i < Rows; i++)
	{
		Turfs[i][MysqlID] = cache_get_field_content_int(i, "ID");
		Turfs[i][MinX] = cache_get_field_content_float(i, "MinX");
		Turfs[i][MinY] = cache_get_field_content_float(i, "MinY");
		Turfs[i][MaxX] = cache_get_field_content_float(i, "MaxX");
		Turfs[i][MaxY] = cache_get_field_content_float(i, "MaxY");
		Turfs[i][Faction] = cache_get_field_content_int(i, "Faction");
	   	cache_get_field_content(i, "Name",temp), format(Turfs[i][Name], 32, temp);
		Turfs[i][ID] = GangZoneCreate(Turfs[i][MinX], Turfs[i][MinY], Turfs[i][MaxX], Turfs[i][MaxY]);
	}

	printf(" * Load Turfs: %d", Rows);
}

function LoadBanDetalis(playerid)
{
	new Fields, Rows;
	cache_get_data(Rows, Fields, mysql);
	
	if(Rows)
	{
	    BanInfo[playerid][ID] = cache_get_field_content_int(0, "ID");
	    BanInfo[playerid][Days] = cache_get_field_content_int(0, "Days");
	    
	    cache_get_field_content(0, "Name", BanInfo[playerid][Name], mysql, 100);
	    cache_get_field_content(0, "IP", BanInfo[playerid][IP], mysql, 100);
	    cache_get_field_content(0, "Admin", BanInfo[playerid][Admin], mysql, 100);
	    cache_get_field_content(0, "Date", BanInfo[playerid][Date], mysql, 100);
	    cache_get_field_content(0, "Reason", BanInfo[playerid][Reason], mysql, 100);
	    
	    kStr[0] = '\0';
	    format(kStr, sizeof(kStr), "Ai interdictie pe acest server!\n\n\
	                                Nume: %s\n\
	                                IP: %s\n\
	                                Timp: %d zile\n\
	                                Data: %s\n\
	                                Admin:: %s\n\
	                                Motiv: %s\n\n\
	                                Pentru unban viziteaza unnic.ro!",
		BanInfo[playerid][Name], BanInfo[playerid][IP], ((BanInfo[playerid][Days]-gettime())/86400)+1, BanInfo[playerid][Date], BanInfo[playerid][Admin], BanInfo[playerid][Reason]);
		SPD(playerid, 0, DIALOG_STYLE_MSGBOX, "Acest IP are interdictie", kStr, "OK", "");
		
		KickEx(playerid);
	}
	else
	{
	    query[0] = '\0';
	    mysql_format(mysql, query, sizeof(query), "SELECT * FROM `accounts` WHERE `Name` = '%s'", GetCleanName(playerid));
		mysql_tquery(mysql, query, "CheckAccount", "d", playerid);
	}
	return 1;
}

function FarmerTimer(playerid)
{
    if(IsPlayerInRangeOfPoint(playerid, 270.0, -388.4804, -1395.7417, 23.4229))
	{
	    if(CheckCarSpeed(playerid) > 24)
	    {
	        PlayerTextDrawHide(playerid, Jobs[3]);
	        PlayerTextDrawHide(playerid, Jobs[4]);

			if(FarmSec[playerid] != 0)
			{
				new string[128];
				format(string, sizeof(string), "Munceste inca ~r~%d secunde ~w~~h~pentru a fi platit!", FarmSec[playerid]);
				PlayerTextDrawSetString(playerid, Jobs[2], string);

				FarmSec[playerid]--;
			}
			else if(FarmSec[playerid] == 0)
			{
				RemovePlayerFromVehicle(playerid);
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));

				PlayerInfo[playerid][FarmerSkill]++;
				Update(playerid, FarmerSkillx);

				new skill, remain, forup;
				GetFarmerSkill(playerid, skill, remain, forup);

				PlayerTextDrawHide(playerid, EngineTD);

				if(skill == 1)
				{
				    new randmoney = random(20000);
				    new randkg = random(20);
				    FarmerMoney[playerid] = FarmerMoney[playerid] + randmoney;

				    new string[128];
					format(string, sizeof(string), "JOB: Ai colectat %d kg de cereale si ai primit %d bani.", randkg, randmoney);
					SCM(playerid, COLOR_YELLOW, string);
					SCM(playerid, COLOR_YELLOW, "JOB: Pentru a continua munca, urca intr-un tractor.");

					SetVehicleToRespawn(GetPlayerVehicleID(playerid));

					PlayerTextDrawHide(playerid, Jobs[0]);
					PlayerTextDrawHide(playerid, Jobs[1]);
					PlayerTextDrawHide(playerid, Jobs[2]);
					PlayerTextDrawHide(playerid, Jobs[3]);
					PlayerTextDrawHide(playerid, Jobs[4]);

					PlayerTextDrawHide(playerid, EngineTD);
					
					PlayerInfo[playerid][FarmerSkill]++;
					Update(playerid, FarmerSkillx);

					KillTimer(FTimer[playerid]);
				}
				else if(skill == 2)
				{
				    new randmoney = random(24000);
				    new randkg = random(30);

				    FarmerMoney[playerid] = FarmerMoney[playerid] + randmoney;
				    GivePlayerMoney(playerid, randmoney);

				    new string[128];
					format(string, sizeof(string), "JOB: Ai colectat %d kg de cereale si ai primit %d bani.", randkg, randmoney);
					SCM(playerid, COLOR_YELLOW, string);
					SCM(playerid, COLOR_YELLOW, "JOB: Pentru a continua munca, urca intr-un tractor.");

					SetVehicleToRespawn(GetPlayerVehicleID(playerid));

					PlayerTextDrawHide(playerid, Jobs[0]);
					PlayerTextDrawHide(playerid, Jobs[1]);
					PlayerTextDrawHide(playerid, Jobs[2]);
					PlayerTextDrawHide(playerid, Jobs[3]);
					PlayerTextDrawHide(playerid, Jobs[4]);

					PlayerTextDrawHide(playerid, EngineTD);

					PlayerInfo[playerid][FarmerSkill]++;
					Update(playerid, FarmerSkillx);

					KillTimer(FTimer[playerid]);
				}
				else if(skill == 3)
				{
				    new randmoney = random(30000);
				    new randkg = random(40);

				    FarmerMoney[playerid] = FarmerMoney[playerid] + randmoney;
				    GivePlayerMoney(playerid, randmoney);

				    new string[128];
					format(string, sizeof(string), "JOB: Ai colectat %d kg de cereale si ai primit %d bani.", randkg, randmoney);
					SCM(playerid, COLOR_YELLOW, string);
					SCM(playerid, COLOR_YELLOW, "JOB: Pentru a continua munca, urca intr-un tractor.");

					SetVehicleToRespawn(GetPlayerVehicleID(playerid));

					PlayerTextDrawHide(playerid, Jobs[0]);
					PlayerTextDrawHide(playerid, Jobs[1]);
					PlayerTextDrawHide(playerid, Jobs[2]);
					PlayerTextDrawHide(playerid, Jobs[3]);
					PlayerTextDrawHide(playerid, Jobs[4]);

					PlayerTextDrawHide(playerid, EngineTD);

					PlayerInfo[playerid][FarmerSkill]++;
					Update(playerid, FarmerSkillx);

					KillTimer(FTimer[playerid]);
				}
				else if(skill == 4)
				{
				    new randmoney = random(35000);
				    new randkg = random(50);

				    FarmerMoney[playerid] = FarmerMoney[playerid] + randmoney;
				    GivePlayerMoney(playerid, randmoney);

				    new string[128];
					format(string, sizeof(string), "JOB: Ai colectat %d kg de cereale si ai primit %d bani.", randkg, randmoney);
					SCM(playerid, COLOR_YELLOW, string);
					SCM(playerid, COLOR_YELLOW, "JOB: Pentru a continua munca, urca intr-un tractor.");

					SetVehicleToRespawn(GetPlayerVehicleID(playerid));

					PlayerTextDrawHide(playerid, Jobs[0]);
					PlayerTextDrawHide(playerid, Jobs[1]);
					PlayerTextDrawHide(playerid, Jobs[2]);
					PlayerTextDrawHide(playerid, Jobs[3]);
					PlayerTextDrawHide(playerid, Jobs[4]);

					PlayerTextDrawHide(playerid, EngineTD);

					PlayerInfo[playerid][FarmerSkill]++;
					Update(playerid, FarmerSkillx);

					KillTimer(FTimer[playerid]);
				}
				else if(skill == 5)
				{
				    new randmoney = random(40000);
				    new randkg = random(60);

				    FarmerMoney[playerid] = FarmerMoney[playerid] + randmoney;
				    GivePlayerMoney(playerid, randmoney);

				    new string[128];
					format(string, sizeof(string), "JOB: Ai colectat %d kg de cereale si ai primit %d bani.", randkg, randmoney);
					SCM(playerid, COLOR_YELLOW, string);
					SCM(playerid, COLOR_YELLOW, "JOB: Pentru a continua munca, urca intr-un tractor.");

					SetVehicleToRespawn(GetPlayerVehicleID(playerid));

					PlayerTextDrawHide(playerid, Jobs[0]);
					PlayerTextDrawHide(playerid, Jobs[1]);
					PlayerTextDrawHide(playerid, Jobs[2]);
					PlayerTextDrawHide(playerid, Jobs[3]);
					PlayerTextDrawHide(playerid, Jobs[4]);

					PlayerTextDrawHide(playerid, EngineTD);

					PlayerInfo[playerid][FarmerSkill]++;
					Update(playerid, FarmerSkillx);

					KillTimer(FTimer[playerid]);
				}
				else if(skill == 6)
				{
				    new randmoney = random(45000);
				    new randkg = random(65);

				    FarmerMoney[playerid] = FarmerMoney[playerid] + randmoney;
				    GivePlayerMoney(playerid, randmoney);

				    new string[128];
					format(string, sizeof(string), "JOB: Ai colectat %d kg de cereale si ai primit %d bani.", randkg, randmoney);
					SCM(playerid, COLOR_YELLOW, string);
					SCM(playerid, COLOR_YELLOW, "JOB: Pentru a continua munca, urca intr-un tractor.");

					SetVehicleToRespawn(GetPlayerVehicleID(playerid));

					PlayerTextDrawHide(playerid, Jobs[0]);
					PlayerTextDrawHide(playerid, Jobs[1]);
					PlayerTextDrawHide(playerid, Jobs[2]);
					PlayerTextDrawHide(playerid, Jobs[3]);
					PlayerTextDrawHide(playerid, Jobs[4]);

					PlayerTextDrawHide(playerid, EngineTD);

					KillTimer(FTimer[playerid]);
				}
			}
		}
		else
		{
			PlayerTextDrawShow(playerid, Jobs[3]);
			PlayerTextDrawShow(playerid, Jobs[4]);
		}
	}
	else
	{
	    if(FarmOut[playerid] != 0)
	    {
        	new string[128];
			format(string, sizeof(string), "Intoarce-te inapoi pe camp. ~r~(%d secunde)", FarmOut[playerid]);
			PlayerTextDrawSetString(playerid, Jobs[2], string);

			FarmOut[playerid]--;
		}
		else if(FarmOut[playerid] == 0)
		{
		    RemovePlayerFromVehicle(playerid);
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));

			PlayerTextDrawHide(playerid, Jobs[0]);
			PlayerTextDrawHide(playerid, Jobs[1]);
			PlayerTextDrawHide(playerid, Jobs[2]);
			PlayerTextDrawHide(playerid, Jobs[3]);
			PlayerTextDrawHide(playerid, Jobs[4]);

			PlayerTextDrawHide(playerid, EngineTD);

			KillTimer(FTimer[playerid]);
		}
	}
	return 1;
}

function CheckSpeedometer(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);

	if(IsABike(vehicleid))
	{
		return 1;
	}
	else
	{
		new Float:vHP, vCentura[50], vString[1500];

		if(Centura[playerid] == 1) vCentura = "~g~~h~YES";
		else if(Centura[playerid] == 0) vCentura = "~r~NO";

		GetVehicleHealth(vehicleid, vHP);

		format(vString, sizeof(vString), "~w~~h~SPEED: %d KM/H~n~~w~~h~FUEL: 100 L~n~~w~~h~VEHICLE HP: %.2f%~n~~w~~h~SEATBELT: %s", GetVehSpeed(vehicleid), vHP, vCentura);
		PlayerTextDrawSetString(playerid, EngineTD, vString);
	}
	return 1;
}

function UnFreeze(playerid)
{
	TogglePlayerControllable(playerid, 1);
}

function GetFarmerSkill(playerid, &skill, &remain, &forup)
{
	new skillp = PlayerInfo[playerid][FarmerSkill];
	if(skillp >= 0 && skillp <= 30) skill = 1, remain = skillp, forup = 30;
	else if(skillp > 30 && skillp <= 40) skill = 2, remain = skillp - 40, forup = 40;
	else if(skillp > 40 && skillp <= 50) skill = 3, remain = skillp - 50, forup = 50;
	else if(skillp > 50 && skillp <= 60) skill = 4, remain = skillp - 60, forup = 60;
	else if(skillp > 60 && skillp <= 70) skill = 5, remain = skillp - 70, forup = 70;
	else if(skillp > 70) skill = 6, remain = 0, forup = 0;
	return 1;
}

function GetBusDriverSkill(playerid, &skill, &remain, &forup)
{
	new skillp = PlayerInfo[playerid][BusDriverSkill];
	if(skillp >= 0 && skillp <= 4) skill = 1, remain = skillp, forup = 4;
	else if(skillp > 4 && skillp <= 5) skill = 2, remain = skillp - 5, forup = 5;
	else if(skillp > 5 && skillp <= 6) skill = 3, remain = skillp - 6, forup = 6;
	else if(skillp > 6 && skillp <= 7) skill = 4, remain = skillp - 7, forup = 7;
	else if(skillp > 7 && skillp <= 8) skill = 5, remain = skillp - 8, forup = 8;
	else if(skillp > 8) skill = 6, remain = 0, forup = 0;
	return 1;
}

function GetPizzaBoySkill(playerid, &skill, &remain, &forup)
{
	new skillp = PlayerInfo[playerid][PizzaBoySkill];
	if(skillp >= 0 && skillp <= 30) skill = 1, remain = skillp, forup = 30;
	else if(skillp > 30 && skillp <= 40) skill = 2, remain = skillp - 40, forup = 40;
	else if(skillp > 40 && skillp <= 50) skill = 3, remain = skillp - 50, forup = 50;
	else if(skillp > 50 && skillp <= 60) skill = 4, remain = skillp - 60, forup = 60;
	else if(skillp > 60 && skillp <= 70) skill = 5, remain = skillp - 70, forup = 70;
	else if(skillp > 70) skill = 6, remain = 0, forup = 0;
	return 1;
}

function GetTruckerSkill(playerid, &skill, &remain, &forup)
{
	new skillp = PlayerInfo[playerid][TruckerSkill];
	if(skillp >= 0 && skillp <= 30) skill = 1, remain = skillp, forup = 30;
	else if(skillp > 30 && skillp <= 40) skill = 2, remain = skillp - 40, forup = 40;
	else if(skillp > 40 && skillp <= 50) skill = 3, remain = skillp - 50, forup = 50;
	else if(skillp > 50 && skillp <= 60) skill = 4, remain = skillp - 60, forup = 60;
	else if(skillp > 60 && skillp <= 70) skill = 5, remain = skillp - 70, forup = 70;
	else if(skillp > 70) skill = 6, remain = 0, forup = 0;
	return 1;
}

function ConnectedPlayers()
{
    new OnlinePlayers;
	foreach(new i: Player) OnlinePlayers++;
    return OnlinePlayers;
}

function Info(playerid, text[], interval)
{
	PlayerTextDrawSetString(playerid, InfoTD, text);
	PlayerTextDrawShow(playerid, InfoTD);

	if(interval == 999) return 1;
	else SetTimerEx("HideInfoTD", interval, false, "i", playerid);

	return 1;
}

function HideInfoTD(playerid)
{
	PlayerTextDrawHide(playerid, InfoTD);
	return 1;
}

function InfoBox(playerid, interval, text[])
{
	PlayerTextDrawSetString(playerid, Info_TD, text);
	PlayerTextDrawShow(playerid, Info_TD);
	PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);

	KillTimer(InfoBoxTimer[playerid]);
	InfoBoxTimer[playerid] = SetTimerEx("HideInfoBox", interval, false, "i", playerid);

	return 1;
}

function HideInfoBox(playerid)
{
	KillTimer(InfoBoxTimer[playerid]);
	PlayerTextDrawHide(playerid, Info_TD);
	return 1;
}

function GetTypeID(type)
{
	new count = -1;
	for(new i = 0; i < sizeof(DInfo) - 1; i++)
	{
		if(DInfo[i][Type] == type) count++;
	}
	return count;
}

function CreateVeh(playerid, id, type)
{
	for(new i = 0; i < sizeof(DInfo) - 1; i++)
	{
		if(DInfo[i][TypeID] == id && DInfo[id][Type] == type)
		{
			id = i;
			break;
		}
	}
	printf("CreateVeh called(playerid = %d, id = %d, type = %d);", playerid, id, type);
	if(PlayerInfo[playerid][Level] < 3) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You must have level 3 to buy a vehicle!");
	/*for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(VehInfo[i][Owner]PlayerInfo[playerid][VehicleSlots]) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~You already own ~y~~h~3 ~w~~h~vehicles!");
	}*/
	
	new price, model, stok;
	if(type == 1 && PlayerInfo[playerid][CarL] <= 0) return InfoBox(playerid, 700, "~r~~h~ERROR: ~w~~h~You don't have driving license.");
	else if(type == 2 && PlayerInfo[playerid][CarL] <= 0) return InfoBox(playerid, 700, "~r~~h~ERROR: ~w~~h~You don't have driving license.");
	else if(type == 3 && PlayerInfo[playerid][CarL] <= 0) return InfoBox(playerid, 700, "~r~~h~ERROR: ~w~~h~You don't have driving license.");
	else if(type == 4 && PlayerInfo[playerid][CarL] <= 0) return InfoBox(playerid, 700, "~r~~h~ERROR: ~w~~h~You don't have driving license.");
	else if(type == 5 && PlayerInfo[playerid][FlyL] <= 0) return InfoBox(playerid, 700, "~r~~h~ERROR: ~w~~h~You don't have flying license.");

	price = DInfo[id][Price];
	model = DInfo[id][Model];
	stok = DInfo[id][Stock];
	
	if(stok == 0) return SCM(playerid, COLOR_ERROR, "Stock-ul acestui model s-a epuizat.");
	//if(GetModelNumber(playerid, model) > 0 && PlayerInfo[playerid][Premium] == 0) return SCM(playerid, COLOR_ERROR, "Ai deja o masina de acelasi model.");
	else if(GetModelNumber(playerid, model) > 1 && PlayerInfo[playerid][Premium] == 1) return SCM(playerid, COLOR_ERROR, "Ai deja doua masini de acelasi model.");
	if(GetPlayerMoney(playerid) >= price)
	{
		Total_Veh_Created++;

		GivePlayerMoney(playerid, -price);

		VehInfo[Total_Veh_Created][ID] = Total_Veh_Created;
		VehInfo[Total_Veh_Created][Model] = model;
		VehInfo[Total_Veh_Created][Color1] = 1;
		VehInfo[Total_Veh_Created][Color2] = 1;
		VehInfo[Total_Veh_Created][Price] = price;
		
		new rand = random(10), Float:vX, Float:vY, Float:vZ, Float:vA;
		switch(rand)
		{
		    case 0: vX = 1098.8871, vY = -1754.9214, vZ = 13.0789, vA = 89.7970;
		    case 1: vX = 1098.4381, vY = -1757.7813, vZ = 13.0794, vA = 90.4114;
		    case 2: vX = 1098.5553, vY = -1760.8018, vZ = 13.0781, vA = 89.7532;
		    case 3: vX = 1081.7026, vY = -1760.7748, vZ = 13.1044, vA = 90.5796;
		    case 4: vX = 1062.3899, vY = -1760.8810, vZ = 13.1310, vA = 89.2518;
		    case 5: vX = 1062.0364, vY = -1769.6487, vZ = 13.0961, vA = 269.8909;
		    case 6: vX = 1080.0249, vY = -1769.6814, vZ = 13.0845, vA = 269.9079;
		    case 7: vX = 1098.5431, vY = -1769.7092, vZ = 13.0751, vA = 269.9037;
		    case 8: vX = 1062.3470, vY = -1772.6241, vZ = 13.0824, vA = 269.6127;
		    case 9: vX = 1062.6421, vY = -1749.1575, vZ = 13.1763, vA = 270.9571;
		}

		if(type == 1)
		{
			VehInfo[Total_Veh_Created][PosX] = vX;
			VehInfo[Total_Veh_Created][PosY] = vY;
			VehInfo[Total_Veh_Created][PosZ] = vZ;
			VehInfo[Total_Veh_Created][PosA] = vA;
		}
		else if(type == 2)
		{
			VehInfo[Total_Veh_Created][PosX] = 295.0822;
			VehInfo[Total_Veh_Created][PosY] = -1540.6110;
			VehInfo[Total_Veh_Created][PosZ] = 24.1658;
			VehInfo[Total_Veh_Created][PosA] = 55.1379;

		}
		else if(type == 3)
		{
			VehInfo[Total_Veh_Created][PosX] = 274.3840;
			VehInfo[Total_Veh_Created][PosY] = -1605.9503;
			VehInfo[Total_Veh_Created][PosZ] = 115.3351;
			VehInfo[Total_Veh_Created][PosA] = 259.8618;
		}

		VehInfo[Total_Veh_Created][Owner] = PlayerInfo[playerid][ID];
		strmid(VehInfo[Total_Veh_Created][Plate], "Server", 0, 32, 32);
		VehInfo[Total_Veh_Created][PaintJ] = 6;
		VehInfo[Total_Veh_Created][Locked] = 1;
		VehInfo[Total_Veh_Created][Spawned] = 1;
		VehInfo[Total_Veh_Created][Destroyed] = 0;
		VehInfo[Total_Veh_Created][KM] = 0;
		VehInfo[Total_Veh_Created][Neon] = 0;
		VehInfo[Total_Veh_Created][Fuel] = 100;
		VehInfo[Total_Veh_Created][Type] = type;

		query[0] = (EOS);
		mysql_format(mysql, query, sizeof(query) ,"INSERT INTO `vehicles` (`CarID`,`Model`,`Color1`,`Color2`,`Price`,`PosX`,`PosY`,`PosZ`,`PosA`,`Owner`,`Plate`,`PaintJ`,`Locked`,`Spawned`,`Type`) VALUES (%d,%d,%d,%d,%d,%f,%f,%f,%f,%d,'%s',%d,%d,%d,%d)",
		Total_Veh_Created,
		VehInfo[Total_Veh_Created][Model],
		VehInfo[Total_Veh_Created][Color1],
		VehInfo[Total_Veh_Created][Color2],
		VehInfo[Total_Veh_Created][Price],
		VehInfo[Total_Veh_Created][PosX],
		VehInfo[Total_Veh_Created][PosY],
		VehInfo[Total_Veh_Created][PosZ],
		VehInfo[Total_Veh_Created][PosA],
		VehInfo[Total_Veh_Created][Owner],
		VehInfo[Total_Veh_Created][Plate],
		VehInfo[Total_Veh_Created][PaintJ],
		VehInfo[Total_Veh_Created][Locked],
		VehInfo[Total_Veh_Created][Spawned],
		VehInfo[Total_Veh_Created][Type],
		VehInfo[Total_Veh_Created][Faction]);
		mysql_query(mysql, query);
		
		DespawnVeh(playerid);
		
		for(new i = 0; i < 20; i++)
		{
			if(PlayerInfo[playerid][Vehicles][i] < 1)
			{
				PlayerInfo[playerid][Vehicles][i] = LastDatabaseCarID();
				Update(playerid, Vehiclesx);
				break;
			}
		}

		kStr[0] = '\0';
		format(kStr, sizeof(kStr), "%s", GetName(playerid));
		
		new cCar = CreateVehicle(VehInfo[Total_Veh_Created][Model], VehInfo[Total_Veh_Created][PosX], VehInfo[Total_Veh_Created][PosY], VehInfo[Total_Veh_Created][PosZ], VehInfo[Total_Veh_Created][PosA], VehInfo[Total_Veh_Created][Color1], VehInfo[Total_Veh_Created][Color2], 500000);
		SetVehicleNumberPlate(cCar, kStr);

		new alarm, doors, bonnet, boot, objective;
		SetVehicleParamsEx(cCar,VEHICLE_PARAMS_OFF,VEHICLE_PARAMS_OFF,alarm,doors,bonnet,boot,objective);
        PutPlayerInVehicle(playerid, cCar, 0);
        OwnedVeh[cCar] = Total_Veh_Created;
		
		DInfo[id][Stock]--;
		vUpdate(id, dsStockx);
	}
	else SCM(playerid, COLOR_ERROR, "Nu ai destui bani.");
	return 1;
}
function CreateFactionVeh(playerid, Float:x, Float:y, Float:z, Float:a, model, faction)
{
		Total_Veh_Created++;

		VehInfo[Total_Veh_Created][ID] = Total_Veh_Created;
		VehInfo[Total_Veh_Created][Model] = model;
		VehInfo[Total_Veh_Created][Color1] = 0;
		VehInfo[Total_Veh_Created][Color2] = 0;
		VehInfo[Total_Veh_Created][PosX] = x;
		VehInfo[Total_Veh_Created][PosY] = y;
		VehInfo[Total_Veh_Created][PosZ] = z;
		VehInfo[Total_Veh_Created][PosA] = a;
		VehInfo[Total_Veh_Created][Faction] = faction;
		VehInfo[Total_Veh_Created][Spawnable] = 1;

		query[0] = (EOS);
		mysql_format(mysql, query, sizeof(query) ,"INSERT INTO `vehicles` (`ID`,`Model`,`Color1`,`Color2`,`PosX`,`PosY`,`PosZ`,`PosA`, `Faction`) VALUES (%d,%d,%d,%d,%f,%f,%f,%f,%d)",
		Total_Veh_Created,
		VehInfo[Total_Veh_Created][Model],
		VehInfo[Total_Veh_Created][Color1],
		VehInfo[Total_Veh_Created][Color2],
		VehInfo[Total_Veh_Created][PosX],
		VehInfo[Total_Veh_Created][PosY],
		VehInfo[Total_Veh_Created][PosZ],
		VehInfo[Total_Veh_Created][PosA],
		VehInfo[Total_Veh_Created][Faction]);
		mysql_query(mysql ,query);

		new cCar = CreateVehicle(VehInfo[Total_Veh_Created][Model], VehInfo[Total_Veh_Created][PosX], VehInfo[Total_Veh_Created][PosY], VehInfo[Total_Veh_Created][PosZ], VehInfo[Total_Veh_Created][PosA], 0, 0, 500000);
		SetVehicleNumberPlate(cCar, "Faction");
        PutPlayerInVehicle(playerid, cCar, 0);
		return 1;
}

function CreateClanVeh(playerid, Float:x, Float:y, Float:z, Float:a, model, clan)
{
		Total_Veh_Created++;

		VehInfo[Total_Veh_Created][ID] = Total_Veh_Created;
		VehInfo[Total_Veh_Created][Model] = model;
		VehInfo[Total_Veh_Created][Color1] = random(255);
		VehInfo[Total_Veh_Created][Color2] = random(255);
		VehInfo[Total_Veh_Created][PosX] = x;
		VehInfo[Total_Veh_Created][PosY] = y;
		VehInfo[Total_Veh_Created][PosZ] = z;
		VehInfo[Total_Veh_Created][PosA] = a;
		VehInfo[Total_Veh_Created][Clan] = clan;
		VehInfo[Total_Veh_Created][Spawnable] = 1;

		query[0] = (EOS);
		mysql_format(mysql, query, sizeof(query) ,"INSERT INTO `vehicles` (`ID`,`Model`,`Color1`,`Color2`,`PosX`,`PosY`,`PosZ`,`PosA`, `Clan`) VALUES (%d,%d,%d,%d,%f,%f,%f,%f,%d)",
		Total_Veh_Created,
		VehInfo[Total_Veh_Created][Model],
		VehInfo[Total_Veh_Created][Color1],
		VehInfo[Total_Veh_Created][Color2],
		VehInfo[Total_Veh_Created][PosX],
		VehInfo[Total_Veh_Created][PosY],
		VehInfo[Total_Veh_Created][PosZ],
		VehInfo[Total_Veh_Created][PosA],
		VehInfo[Total_Veh_Created][Clan]);
		mysql_query(mysql ,query);

		new cCar = CreateVehicle(VehInfo[Total_Veh_Created][Model], VehInfo[Total_Veh_Created][PosX], VehInfo[Total_Veh_Created][PosY], VehInfo[Total_Veh_Created][PosZ], VehInfo[Total_Veh_Created][PosA], VehInfo[Total_Veh_Created][Color1], VehInfo[Total_Veh_Created][Color2], 500000);
		SetVehicleNumberPlate(cCar, "Clan");
        PutPlayerInVehicle(playerid, cCar, 0);
		return 1;
}

function FactionMessage(factionid, color, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][Faction] == factionid)
			{
				SCM(i, color, string);
			}
		}
	}
	return 1;
}

function ClanMessage(clanid, color, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][Clan] == clanid)
			{
				SCM(i, color, string);
			}
		}
	}
	return 1;
}

function OnPlayerEnterGangZone(playerid, zone)
{
	new turf = GetTurfID(zone);
	new fid = PlayerInfo[playerid][Faction];
	if((Turfs[turf][Faction] == fid || Turfs[turf][Attacker] == fid) && Turfs[turf][isAttacked] == 2)
	{
	    new def, atk;
	    def = Turfs[turf][Faction];
	    atk = Turfs[turf][Attacker];
		FactionInfo[fid][fOnTurf]++;
		new string[128];
		SetPlayerArmour(playerid, 0);
		format(string, sizeof(string), "On turf: %d - %d", FactionInfo[def][fOnTurf], FactionInfo[atk][fOnTurf]);
		foreach(Player, i)
		{
			PlayerTextDrawSetString(i, WarTD[i][3], string);
		}
		for(new x = 0; x < 7; x++)
		{
			PlayerTextDrawShow(playerid, WarTD[playerid][x]);
		}
	}
	return 1;
}

function OnPlayerLeaveGangZone(playerid, zone)
{
	new turf = GetTurfID(zone);
	new fid = PlayerInfo[playerid][Faction];
	if((Turfs[turf][Faction] == fid || Turfs[turf][Attacker] == fid) && Turfs[turf][isAttacked] == 2)
	{
		FactionInfo[fid][fOnTurf]--;
		new string[128], def, atk;
	    def = Turfs[turf][Faction];
	    atk = Turfs[turf][Attacker];
		format(string, sizeof(string), "On turf: %d - %d", FactionInfo[def][fOnTurf], FactionInfo[atk][fOnTurf]);
		foreach(Player, i)
		{
			PlayerTextDrawSetString(i, WarTD[i][3], string);
		}
		for(new x = 0; x < 7; x++)
		{
			PlayerTextDrawHide(playerid, WarTD[playerid][x]);
		}
	}
	return 1;
}

function WarTimer(turf)
{
	if(Turfs[turf][isAttacked] == 2)
	{
		Turfs[turf][tTime]++;
		new h,m,s,string1[50],sec, def, atk, string[128];
		def = Turfs[turf][Faction];
		atk = Turfs[turf][Attacker];
		sec = WAR_TIME - Turfs[turf][tTime];
		Sec2HMS(sec, h, m, s);
		if(m < 10 && s < 10)
		{
			format(string1, sizeof(string1), "War time: ~r~0%d:0%d", m, s);
		}
		else if(s < 10)
		{
			format(string1, sizeof(string1), "War time: ~r~%d:0%d", m, s);
		}
		else if(m < 10)
		{
			format(string1, sizeof(string1), "War time: ~r~0%d:%d", m, s);
		}
		else
		{
			format(string1, sizeof(string1), "War time: ~r~%d:%d", m, s);
		}
		foreach(Player, i)
		{
			new fid = PlayerInfo[i][Faction];
			if((Turfs[turf][Faction] == fid || Turfs[turf][Attacker] == fid) && Turfs[turf][isAttacked] == 2)
			{
				SetPlayerArmour(i, 0);
				PlayerTextDrawSetString(i, WarTD[i][6], string1);
			}
		}
		if(Turfs[turf][tTime] == WAR_TIME)
		{
		    GangZoneStopFlashForAll(Turfs[turf][ID]);
		    if(FactionInfo[def][fScore] >= FactionInfo[atk][fScore])
		    {
		        new best, bName[32], wName[32], worst;
		        foreach(Player, i)
		        {
		            if(PlayerInfo[i][Faction] == def && PlayerInfo[i][tKills] > best)
		            {
						format(bName, sizeof(bName), "%s", GetName(i));
		            }
		            else if(PlayerInfo[i][Faction] == atk && PlayerInfo[i][tDeaths] > worst)
		            {
						format(wName, sizeof(wName), "%s", GetName(i));
		            }
		        }
				format(string, sizeof(string), "Best: %s | Worst: %s | Winner faction: %s | Score: %i - %i", bName, wName, FactionInfo[def][fName], FactionInfo[def][fScore], FactionInfo[atk][fScore]);
				FactionMessage(def, COLOR_DARKCYAN, string);
				FactionMessage(atk, COLOR_DARKCYAN, string);
	        	Turfs[turf][Faction] = def;
		    }
		    else
		    {
		        new best, bName[32], wName[32], worst;
		        foreach(Player, i)
		        {
		            if(PlayerInfo[i][Faction] == atk && PlayerInfo[i][tKills] > best)
		            {
						format(bName, sizeof(bName), "%s", GetName(i));
		            }
		            else if(PlayerInfo[i][Faction] == def && PlayerInfo[i][tDeaths] > worst)
		            {
						format(wName, sizeof(wName), "%s", GetName(i));
		            }
		        }
				format(string, sizeof(string), "Best: %s | Worst: %s | Winner faction: %s | Score: %i - %i", bName, wName, FactionInfo[atk][fName], FactionInfo[def][fScore], FactionInfo[atk][fScore]);
				FactionMessage(def, COLOR_DARKCYAN, string);
				FactionMessage(atk, COLOR_DARKCYAN, string);
		        Turfs[turf][Faction] = atk;
		    }
			FactionInfo[def][fAttackedTurf] = 0;
	        FactionInfo[atk][fAttackedTurf] = 0;
	        FactionInfo[def][fInWar] = 0;
	        FactionInfo[atk][fInWar] = 0;
	        FactionInfo[atk][fScore] = 0;
	        FactionInfo[def][fScore] = 0;
	        FactionInfo[atk][fOnTurf] = 0;
	        FactionInfo[def][fOnTurf] = 0;
	        Turfs[turf][isAttacked] = 0;
	        Turfs[turf][tTime] = 0;
	        KillTimer(WarTimer(turf));
			GangZoneStopFlashForAll(turf);
			for(new pid = 0; pid < LastPickupID(); pid++)
			{
				DestroyDynamicPickup(PickupInfo[pid][ID]);
				PickupInfo[pid][ID] = 0;
				PickupInfo[pid][Type] = 0;
				PickupInfo[pid][Value] = 0;
				PickupInfo[pid][Amount] = 0;
			}
			foreach(Player, i)
			{
				new fid = PlayerInfo[i][Faction];
				SetPlayerTeam(i, NO_TEAM);
				if(PlayerInfo[i][tView] == 1)
				{
					GangZoneHideForPlayer(i, turf);
					GangZoneShowForPlayer(i, turf, ((FactionInfo[Turfs[turf][Faction]][fColor] & ~0xFF) | 0x99), 0x000000FF);
				}
				if((def == fid || atk == fid))
				{
					for(new x = 0; x < 7; x++)
					{
						PlayerTextDrawHide(i, WarTD[i][x]);
					}
				}
			}
	        Turfs[turf][Attacker] = 0;
	        tUpdate(turf, Factionx);
		}
		else
		{
			foreach(Player, i)
			{
				if(IsPlayerInGangZone(i, Turfs[turf][ID]))
				{
				    PlayerInfo[i][tTime]++;
				    FactionInfo[PlayerInfo[i][Faction]][fScore] = FactionInfo[PlayerInfo[i][Faction]][fScore] + PlayerInfo[i][tTime] / 60;
					format(string, sizeof(string), "%s %d - %d %s", FactionInfo[def][fName], FactionInfo[def][fScore], FactionInfo[atk][fScore], FactionInfo[atk][fName]);
					PlayerTextDrawSetString(i, WarTD[i][2], string);
				}
			}
		}
	}
	return 1;
}

function UpdateGradTag(playerid)
{
	if(playerid != INVALID_PLAYER_ID)
	{
		if(PlayerInfo[playerid][gradTag] == true)
		{
			if(PlayerInfo[playerid][Admin] > 0) SetPlayerChatBubble(playerid, "Administrator", 0x455EA8FF, 50.0, 1000);
			else if(PlayerInfo[playerid][Helper] > 0) SetPlayerChatBubble(playerid, "Helper", 0x45A85EFF, 50.0, 1000);
			else if(PlayerInfo[playerid][Leader] > 0) SetPlayerChatBubble(playerid, "Leader", 0xAFAFAFFF, 50.0, 1000);
			else if(PlayerInfo[playerid][Premium] > 0) SetPlayerChatBubble(playerid, "Premium", 0xA88F45FF, 50.0, 1000);
		}
	}
	return 1;
}

function BreakCarClan(playerid, clan, car)
{
	if(IsPlayerConnected(playerid))
	{
	    new string[128], zone[MAX_ZONE_NAME], cid;
	    cid = PlayerInfo[playerid][Clan];
	    if(clan != cid)
	    {
	        if(IsValidVehicle(car))
	        {
		    	if(PlayerInfo[playerid][breakTime] < 10)
		    	{
				    new Float:x, Float:y, Float:z;
				    GetVehiclePos(car, x, y, z);
				    if(IsPlayerInRangeOfPoint(playerid, 5.00, x, y, z))
				    {
						if(IsClanVeh(car))
						{
	    					PlayerInfo[playerid][breakTime]++;
    						if(VehInfo[car][Clan] == cid) return 1;
					        format(string, sizeof(string), "~g~Car break timer: ~w~~h~00:0%d", 10 - PlayerInfo[playerid][breakTime]);
							InfoBox(playerid, 1000, string);
						}
					}
					else
					{
						format(string, sizeof(string), "~r~You went too far away from the car!");
						InfoBox(playerid, 5000, string);
						KillTimer(ClanCarBreakTimer[playerid]);
						PlayerInfo[playerid][breakTime] = 0;
					}
				}
				else
				{
			        format(string, sizeof(string), "~b~You stole %s clan's vehicle, go park it anywhere to save it for your clan!", ClanInfo[clan][Name]);
					InfoBox(playerid, 5000, string);
					GetPlayer2DZone(playerid, zone, MAX_ZONE_NAME);
					format(string, sizeof(string), "%s v-a furat masina clanului in locatia %s", GetName(playerid), zone);
					ClanMessage(VehInfo[car][Clan], COLOR_DARKGOLD, string);
					format(string, sizeof(string), "%s a furat masina clanului %s in locatia %s", GetName(playerid), ClanInfo[VehInfo[car][Clan]][Name], zone);
					ClanMessage(cid, COLOR_DARKGOLD, string);
					VehInfo[car][Clan] = cid;
					KillTimer(ClanCarBreakTimer[playerid]);
				    PutPlayerInVehicle(playerid, car, 0);
				    PlayerInfo[playerid][breakTime] = 0;
				}
			}
	    }
	}
	return 1;
}

function Unfreeze(playerid)
{
    PlayerInfo[playerid][isTazed] = 0;
    TogglePlayerControllable(playerid, 1);
    KillTimer(Unfreeze(playerid));
    return ClearAnimations(playerid);
}

function KickPlayer(playerid) return Kick(playerid);

function CheckBannedAccount(playerid, bName[])
{
	new Rows, Fields;
	cache_get_data(Rows, Fields, mysql);
	
	if(!Rows) return InfoBox(playerid, 7000, "~r~~h~ERROR: ~w~~h~This player isn't banned");

	query[0] = '\0';
	mysql_format(mysql, query, sizeof(query), "DELETE FROM `bans` WHERE `Name` = '%s'", bName);
	mysql_query(mysql, query);
	    
	kStr[0] = '\0';
	format(kStr, sizeof(kStr), "UNBAN: Ai scos interdictia jucatorului: %s", bName);
	SCM(playerid, COLOR_LBLUE, kStr);
	return 1;
}

function CheckClans()
{
	query[0] = EOS;
	mysql_tquery(mysql, "SELECT * FROM `clans`", "CheckAllClans", "");
	return 1;
}

function CheckAllClans()
{
	new rows, fields;
	cache_get_data(rows, fields, mysql);
	
	for(new i = 0; i < rows; i++)
	{
	    if(ClanInfo[i][Days] < gettime())
	    {
	        new query2[500];
	        mysql_format(mysql, query2, sizeof(query2), "SELECT * FROM `accounts` WHERE `Clan` = '%d'", i);
	        mysql_tquery(mysql, query2, "CheckAccInClan", "i", i);

	        query[0] = '\0';
	        mysql_format(mysql, query, sizeof(query), "DELETE FROM `clans` WHERE `ID` = '%d'", ClanInfo[i][ID]);
	        mysql_query(mysql, query);
	    }
	}
	return 1;
}

function CheckAccInClan(cID)
{
	new rows, fields;
	cache_get_data(rows, fields, mysql);
	
	if(rows)
	{
	    for(new p = 0; p < rows; p++)
	    {
	        PlayerInfo[p][Clan] = 0;
	        PlayerInfo[p][cRank] = 0;
	        PlayerInfo[p][cLeader] = 0;
	        PlayerInfo[p][CWarns] = 0;
	        
	        Update(p, Clanx);
	        Update(p, cRankx);
	        Update(p, cLeaderx);
	        Update(p, CWarnsx);
	    }
	}
	return 1;
}

function UnFreezePlayer(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}

function AttachTrailer(trailerid, vehicleid)
{
	AttachTrailerToVehicle(trailerid, vehicleid);
}

function Float:GetDistanceBetweenPoints(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2) return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));

#if defined About
--------------------------------------------------------------------------------
												  _ _  _ _  _ _  _  ___
	Authors: KnowN & ImpulsE - Copyright @ 2016  | | || \ || \ || ||  _|
	RPG Project - version 1.3 - 08/08/2016       | | ||   ||   || || |_
	Started Date: 14/05/2016 - 20:34 PM          |___||_\_||_\_||_||___|

--------------------------------------------------------------------------------
				UNNIC RPG - www.unnic.ro - Script END here!
--------------------------------------------------------------------------------
#endif
