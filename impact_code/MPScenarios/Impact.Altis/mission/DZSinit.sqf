/*
DZSinit
Author: Craig Vander Galien
Email: craigvandergalien@gmail.com

Any questions? Contact me at my email
Land_Pier_F
Thanks,Land_nav_pier_m_F
Craig
*/

private ["_options","_value","_side","_group","_logic","_type","_weap_type","_cur_type","_display_name","_no_pack","_optics","_weapon","_cfgweapons","_item_type","_marker","_pos","_trig","_building","_xaxis","_yaxis","_working","_allaxiss","_newPos","_townnumber","_town","_townpos","_rad","_cnps","_towns","_playerRespawn","_check2","_check1","_thing","_things","_checkVar","_dist","_dir","_armPos","_centPos","_kindOf","_filter","_res","_veh","_types","_veh_type","_vehicle","_typeNumbers","_cfgvehicles","_turret","_weapons","_magazines","_subturrets","_turrets","_EHkilled"];
//gameType = (paramsArray select 0);

[] spawn {
	_pos = getpos Player;
	waituntil {!(IsNull (findDisplay 46))};
	playsound "heartbeat";
	enableEnvironment false;
	showHUD false;
	_hndl = ppEffectCreate ["colorCorrections", 1501];
	_hndl ppEffectEnable true;
	_hndl ppEffectAdjust [0, 1.0, 0.0, [1.0, 1.0, 1.0, 0], [0.0, 1.0, 1.0, 0],[0, 1, 0, 0]];
	_hndl ppEffectCommit 0;
	waitUntil {(((getPos player) distance _pos) > 2) || time > 20};
	enableEnvironment true;
	showHUD true;
	ppEffectDestroy _hndl;
	[1,"BLACK",10,1] call BIS_fnc_fadeEffect;
	_startMessages = ["After a night of a fitful sleep you awake to an eerie quiet. A quiet unlike anything you have ever experienced before. The usual morning bustle of your neighbourhood is now an ominous silence that you must investigate. <br/> <br/>Welcome to Dynamic Zombie Sandbox","The TV you left on last night is blank, because the power is out. Not just here but everywhere in the world. A new day is dawning.<br/> <br/>Welcome to Dynamic Zombie Sandbox","As your eyelids snap open, you realize something is very wrong. <br/> <br/>Welcome to Dynamic Zombie Sandbox"];
	_message = _startMessages call BIS_fnc_selectRandom;
	parseText _message;
	[_message] call DZS_fn_displayInfo;
};
CVG_Gamemode = (paramsArray select 0);

CVG_timeToSkipTo= (paramsArray select 2);
CVG_fastTime = (paramsArray select 3);
CVG_Weather= (paramsArray select 4);
CVG_Fog =(paramsArray select 5);
CVG_Viewdist = (paramsArray select 6);
CLY_terraingrid=paramsArray select 7;
CVG_CityDestruction = (paramsArray select 8);

CVG_bandages= (paramsArray select 10);
//CVG_FoodWater = (paramsArray select 10);
CVG_Playerstart = (paramsArray select 11); 
CVG_playerWeapons = (paramsArray select 12); 
CVG_playerItems = (paramsArray select 13); 
//CVG_Aminals= (paramsArray select 14); 
CLY_friendlyfire = (paramsArray select 14);
CVG_Fuel = (paramsArray select 15);
CVG_taskType = (paramsArray select 16);
CVG_taskOption = (paramsArray select 17);

CVG_Zombietowns= (paramsArray select 19);
CVG_Zdensity = (paramsArray select 20);
 _booleanValue =(1 == (ParamsArray select 23));
CVG_horde= _booleanValue;
CVG_maxaggroradius = (paramsArray select 22);
CLY_maxAggroRadius = CVG_maxaggroradius;
CVG_minSpawnDist = (paramsArray select 23);

CVG_weapontype = (paramsArray select 25);
CVG_Weaponcount = (paramsArray select 26);
CVG_Caches = (paramsArray select 27);
vehspawntype = (paramsArray select 28);
chanceNumber = (paramsArray select 29);
CVG_VehicleStatus = (paramsArray select 30);

_booleanValue =(1 == (ParamsArray select 32));
CVG_Debug = _booleanValue;

if (CVG_timeToSkipTo == 99) then {
    CVG_timeToSkipTo = floor (random 24);
};
if (CVG_playerWeapons == 99) then {
    _options = [1,2];
    _value = floor (random (count _options));
    CVG_playerWeapons= _value;
}; 
if (CVG_playerItems == 99) then {
    _options = [1,2];
    _value = floor (random (count _options));
    CVG_playerItems= _value;
};
if (CVG_maxaggroradius == 99) then {
    CVG_maxaggroriadius=floor (random 1000);
};
if (CVG_Zdensity == 99) then {
    CVG_Zdensity = floor (random 98);
};
if (CVG_minSpawnDist == 99) then {
    CVG_minSpawnDist = floor (random 100);
};
if (CVG_Weapontype == 99) then {
    CVG_weapontype= floor (random 6);
};
if (chanceNumber == 99) then {
    chanceNumber = floor (random 30);
};
if (CVG_Fuel == 99) then {
    CVG_Fuel = floor (random 1);
};
if (CVG_Weaponcount == 99) then {
    _options = [20,50,75,101];
    _value = floor (random (count _options));
    CVG_Weaponcount= _value;
};
if (CVG_VehicleStatus == 99) then {
    _options = [1,2,3,4];
    _value = floor (random (count _options));
    CVG_VehicleStatus= _value;
};

blacklist = ["Land_nav_pier_m_F","Land_Pier_F","land_bw_SetBig_Brains_F","land_bw_SetBig_corals_F","land_bw_SetBig_TubeG_F","land_bw_SetBig_TubeY_F","land_bw_SetSmall_Brains_F","land_bw_SetSmall_TubeG_F","land_bw_SetSmall_TubeY_F"];
militarylist = ["Land_Cargo20_military_F","Land_Cargo40_military_F","Land_Cargo_HQ_V2_F","Land_Cargo_House_V1_F","Land_Cargo_House_V2_F","Land_Cargo_Patrol_V1_F","Land_Cargo_Patrol_V2_F","Land_MilOffices_V1_F","Land_Airport_Tower_F"];

_rad=20000;
_cnps = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
townlist= nearestLocations [_cnps, ["nameCity","NameCityCapital"], _rad];
buildings = [];


[] spawn DZS_fn_houseInfo;
[] call DZS_fn_processWeapons;
[] call DZS_fn_initWeapons;
[] call DZS_fn_processVehicles;
[] call DZS_fn_initVehicles;
[] call DZS_fn_initPlayer;
[] call DZS_fn_ammoCaches;

gunsComplete = 1;
if (isClass (configFile / "CfgMods" / "2017_zombies")) then {CLY_zombieclasses = ["2017_zombie"]} else{
CLY_zombieclasses = [];
_civilians = [];
_soldiers = [];
{
	_class = _x;
	if (!(_class isKindOf "woman")) then {
		_soldiers = _soldiers + [_class];
	} else {CVG_men = CVG_men - [_x];};
} forEach CVG_Men;
_civilians = ["C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_beggar_F","C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_hunter_1_F","C_man_w_worker_F","C_man_shorts_4_F","C_man_shorts_3_F","C_man_shorts_2_F","C_man_shorts_2_F_asia"];
CLY_zombieclasses = [[_civilians],[_soldiers],[_civilians],[_civilians]];
diag_log format ["CLY_zombieclasses: %1",CLY_zombieclasses];
};
DZS_initThingsDone = true;

if (isServer) then {
	//if ((CVG_Zombietowns == 1) || (CVG_Zombietowns == 2) || (CVG_Zombietowns == 3)) then {[] call DZS_fn_spawnTriggers;};
	if (CVG_Fuel == 1) then {[] call DZS_fn_destroyFuel};

};

	if (!isDedicated) then {
		if (player != player) then
		{
			waitUntil {player == player};
		};
		if (time > 1) then {
			waitUntil {local Player};
		};
	};

	if (CVG_fastTime == 1) then {
		[4] execFSM "impact_code\MPScenarios\Impact.Altis\mission\core_time.fsm";
	};

	
	screendone = 1;
	
	///This block  of code spawns the building destruction. Executes on all clients
	if (CVG_CityDestruction == 2) then {
		diag_Log  "loading building destruction";
		_newPos = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
		_buildingsToDestroy =  nearestObjects [player, ["house"], 20000];
		{_x setDamage 1} forEach _buildingsToDestroy;
	};
	
	
	
/*	//Put code for class switch dialog here
	if (!isDedicated) then {
		waituntil {!(IsNull (findDisplay 46))};
		createDialog "BuyDialog";
		ctrlSetText [1001, "Skins"];
		ctrlSetText [1701, "Put on"];
		buttonSetAction [1701, "playerChoice = 1"];
		buttonSetAction [1700, "playerChoice = 2"];
		waitUntil {!isNil "CVG_men"};
		{
			_vehicle = configFile >> "CfgVehicles" >> _x;
			_text= getText(_vehicle >> "displayName");
			_index = lbAdd [1500, _text];
			_veh_type = configName(_vehicle);
			lbSetData [1500,_index,_veh_type];
		} forEach CVG_Men;
		waitUntil {(!isNil "playerChoice") || (!dialog)};
		
		_index = lbCurSel 1500;
		_class = lbData [1500,_index];
		closeDialog 0;
		//Clear Player
		if (playerChoice == 1) then {
			_pos = getPosATL player;
			_dir = getDir player;
			_oldUnit = player;
			selectNoPlayer;
			_oldUnit setPosATL [0,0,0];
			
			if (_OldUnit == player) then {
				_oldUnit addEventHandler ["HandleDamage",{false}];
				_oldUnit enableSimulation false;
				_oldUnit disableAI "ANIM";
				_oldUnit disableAI "MOVE";
			} else {
				deleteVehicle _oldUnit;
			};

			//Create New Character
			[player] joinSilent grpNull;
			_group = 	createGroup west;
			_newUnit = _group createUnit [_class,_pos,[],50,"CAN_COLLIDE"];
			diag_log format ["%1",_class];
			_newUnit setDir _dir;
			addSwitchableUnit _newUnit;
			setPlayable _newUnit;
			
			//Move player inside
			selectPlayer _newUnit;
		};
	};
	*/
	sleep .1;
	
	//Option to set terrain detail at start
if (isMultiplayer) then
{
	if (!isDedicated) then
	{
		[] spawn
		{
			sleep 1;
			if (CLY_terraingrid == 0) then
			{
				_structure = "<t font = 'EtelkaMonospaceProBold' size = '0.8' color = '#885555ff'>";
				CLY_terrainaction0 = player addAction [_structure + "Clutter distance OK", "impact_code\MPScenarios\Impact.Altis\zombie_scripts\cly_terraingrid.sqs", 0, 2.5, true, true, "", ""];
				CLY_terrainaction1 = player addAction [_structure + "Clutter distance: no clutter", "impact_code\MPScenarios\Impact.Altis\zombie_scripts\cly_terraingrid.sqs", 50, 2.5, true, false, "", ""];
				CLY_terrainaction2 = player addAction [_structure + "Clutter distance: low", "impact_code\MPScenarios\Impact.Altis\zombie_scripts\cly_terraingrid.sqs", 25, 2.5, true, false, "", ""];
				CLY_terrainaction3 = player addAction [_structure + "Clutter distance: medium", "impact_code\MPScenarios\Impact.Altis\zombie_scripts\cly_terraingrid.sqs", 12.5, 2.5, true, false, "", ""];
				CLY_terrainaction4 = player addAction [_structure + "Clutter distance: high", "impact_code\MPScenarios\Impact.Altis\zombie_scripts\cly_terraingrid.sqs", 6.25, 2.5, true, false, "", ""];
				CLY_terrainaction5 = player addAction [_structure + "Clutter distance: very high", "impact_code\MPScenarios\Impact.Altis\zombie_scripts\cly_terraingrid.sqs", 3.125, 2.5, true, false, "", ""];
				CLY_terrainconfirmed = false;
				CLY_terrainlastchanged = time;
				waitUntil {time - CLY_terrainlastchanged > 60};
				if (!CLY_terrainconfirmed) then
				{
					[0, 0, 0, 0] exec "impact_code\MPScenarios\Impact.Altis\zombie_scripts\cly_terraingrid.sqs";
				};
			}
			else
			{
				if (CLY_terraingrid > 0) then {setTerrainGrid CLY_terraingrid};
			};
		};
	}
	else
	{
		setTerrainGrid 50;
	};
};

	if (!DZS_JIP) then {skipTime CVG_timeToSkipTo};
	
	/*if (CVG_playerWeapons == 1) then {
		diag_Log "picking starting weapon";
		removeAllWeapons player;
		[player] call DZS_fn_randomUnitWeapons;
		while {secondaryWeapon player != ""} do {
			[player] call DZS_fn_randomUnitWeapons;
		};
	};
	*/
	if (CVG_playerWeapons == 2) then {removeAllWeapons player};
	if (CVG_playerItems == 2) then {player removeWeapon "ItemMap"};
	_playerRespawn = player addMPEventHandler ["MPRespawn", {Null = _this spawn DZS_fn_playerRestart}]; 
	_EHkilled = player addEventHandler ["killed", {_this spawn DZS_fn_onDeath}];	
	removeAllAssignedItems player;
	removeUniform player;
	removeVest player;
	removeAllWeapons player;
	[] call DZS_fn_weather;
	

