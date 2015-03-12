DZS_fn_spawnTriggers = {

	_xA = 0;
	_yA = 0;
	_w = true;
	_set = false;
	while {_w} do {
		_yA = _yA + 1000;
		if (_yA == 20000) then {
			_xA = _xA + 1000;
			_yA = 0;
		};

		_pos = [_xA,_yA];
		if (!surfaceIsWater _pos || _set) then {
			_trig = createTrigger ["EmptyDetector", _pos];
			_trig setTriggerArea [500,500,0,true];
			_trig setTriggerActivation ["NONE", "PRESENT", FALSE];
			if (CVG_Horde) then {
				_trig setTriggerStatements ["true", "0=[thisTrigger,CVG_Zdensity] execVM 'impact_code\MPScenarios\Impact.Altis\zombie_scripts\cly_z_generatorhorde.sqf';", ""];
			} else {
				_trig setTriggerStatements ["true", "0=[thisTrigger,CVG_Zdensity] execVM 'impact_code\MPScenarios\Impact.Altis\zombie_scripts\cly_z_generator.sqf';", ""];
			};
			if (CVG_Debug) then {
				_marker=createMarker [format ["mar%1",random 100000],getpos _trig];
				_marker setMarkerType "mil_dot";
				_marker setMarkerColor "ColorRed";
				_marker setMarkerSize [1,1];
			};
			if (_set) then {_set = false} else {_set = true};
		} else {_set = false};
		_AA = _xA + _yA;
		if (_AA == 40000) then {_w = false};
	};
};
DZS_fn_processWeapons = {
	CVG_Rifles = [];
	CVG_scoped = [];
	CVG_heavy = [];
	CVG_launchers = [];
	CVG_pistols = [];
	CVG_Explosives = [];
	CVG_Binoculars = [];
	CVG_SmallItems = [];

	{
		_cfgweapons = configFile >> "cfgWeapons";

		_type = 1;
		_item_type = _x;
		switch (_item_type) do {
			case 0: {_type = [1];};//CVG_Rifles
			case 1: {_type = [1];};//scoped CVG_Rifles
			case 2: {_type = [1,5];};//heavy
			case 3: {_type = [4];};//secondary weapon
			case 4: {_type = [2];};//pistol
			case 5: {_type = [0];};//put/throw
			case 6: {_type = [4096];};//BinocularSlot
			case 7: {_type = [131072];};//SmallItems
			default {_type = [1];};
		};

		for "_i" from 0 to (count _cfgweapons)-1 do {
			_weapon = _cfgweapons select _i;
			if (isClass _weapon) then {
				_weap_type = configName(_weapon);
				_cur_type = getNumber(_weapon >> "type");
				_display_name = getText(_weapon >> "displayName");
				_no_pack = getNumber(_weapon >> "ACE_nopack");
				_optics = getText(_weapon >> "ModelOptics");

				if (((((getNumber(_weapon >> "scope")==2)&&(getText(_weapon >> "model")!="")&&(_display_name!=""))||((_item_type==5)&&(getNumber(_weapon >> "scope")>0)))&&(_cur_type in _type)&&(_display_name!=""))
				&&
				((_item_type in [3,4,5,6,7])||((_item_type==0)&&(_no_pack!=1)&&((_optics=="-")))||((_item_type==1)&&(_no_pack!=1)&&((_optics!="-")))||((_item_type==2)&&((_cur_type==5)||((_no_pack==1)&&(_cur_type in _type)))))) then {

					if (_item_type == 0) then {
						CVG_Rifles set [(count CVG_Rifles),_weap_type];//CVG_Rifles
					};
					if (_item_type == 1) then {
						CVG_Scoped set [(count CVG_Scoped),_weap_type];//CVG_Scoped
					};
					if (_item_type == 2) then {
						CVG_Heavy set [(count CVG_Heavy),_weap_type];//CVG_Heavy
					};
					if (_item_type == 3) then {
						CVG_Launchers set [(count CVG_Launchers),_weap_type];//CVG_Launchers
					};
					if (_item_type == 4) then {
						CVG_Pistols set [(count CVG_Pistols),_weap_type];//CVG_Pistols
					};
					if (_item_type == 5) then {
						CVG_Explosives set [(count CVG_Pistols),_weap_type];//CVG_Pistols
					};
					if (_item_type == 5) then {
						CVG_Explosives set [(count CVG_Explosives),_weap_type];//CVG_Explosives
					};
					if (_item_type == 6) then {
						CVG_Binoculars set [(count CVG_Binoculars),_weap_type];//CVG_Binoculars
					};
					if (_item_type == 7) then {
						CVG_SmallItems set [(count CVG_SmallItems),_weap_type];//CVG_Binoculars
					};

				};
			};
		};
	} forEach [0,1,2,3,4,5,6,7];
};
DZS_fn_processVehicles = {
	#define KINDOF_ARRAY(a,b) [##a,##b] call {_veh = _this select 0;_types = _this select 1;_res = false; {if (_veh isKindOf _x) exitwith { _res = true };} forEach _types;_res}
	CVG_statics = [];
	CVG_Cars = [];
	CVG_trucks = [];
	CVG_APCs = [];
	CVG_tanks = [];
	CVG_Helicopters = [];
	CVG_Planes = [];
	CVG_Ships = [];
	CVG_Men = [];
	{
		_veh_type = [];
		_typeNumbers = _x;
		_kindOf = ["tank"];
		_filter = [];
		switch (_typeNumbers) do {
			case 0: {_kindOf = ["staticWeapon"];};
			case 1: {_kindOf = ["car"];_filter = ["truck","Wheeled_APC"];};
			case 2: {_kindOf = ["truck"];};
			case 3: {_kindOf = ["Wheeled_APC","Tracked_APC"];};
			case 4: {_kindOf = ["tank"];_filter = ["Tracked_APC"];};
			case 5: {_kindOf = ["helicopter"];_filter = ["ParachuteBase"];};
			case 6: {_kindOf = ["plane"];_filter = ["ParachuteBase"];};
			case 7: {_kindOf = ["ship"];};
			case 8: {_kindOf = ["man"];};
			default {_kindOf = ["tank"];_filter = [];};
		};
		_cfgvehicles = configFile >> "cfgVehicles";
		for "_i" from 0 to (count _cfgvehicles)-1 do {
			_vehicle = _cfgvehicles select _i;
			if (isClass _vehicle) then {
				_veh_type = configName(_vehicle);
				if ((getNumber(_vehicle >> "scope")==2)and(getText(_vehicle >> "picture")!="")and(KINDOF_ARRAY(_veh_type,_kindOf))and!(KINDOF_ARRAY(_veh_type,_filter))) then {

					if (_typeNumbers == 0) then {
						CVG_statics set [(count CVG_statics),_veh_type];//CVG_statics
					};
					if (_typeNumbers == 1) then {
						CVG_Cars set [(count CVG_Cars),_veh_type];//CVG_Cars
					};
					if (_typeNumbers == 2) then {
						CVG_Trucks set [(count CVG_Trucks),_veh_type];//CVG_Trucks
					};
					if (_typeNumbers == 3) then {
						CVG_APCs set [(count CVG_APCs),_veh_type];//CVG_APCs
					};
					if (_typeNumbers == 4) then {
						CVG_Tanks set [(count CVG_Tanks),_veh_type];//CVG_tanks
					};
					if (_typeNumbers == 5) then {
						CVG_Helicopters set [(count CVG_Helicopters),_veh_type];//CVG_Helis
					};
					if (_typeNumbers == 6) then {
						CVG_Planes set [(count CVG_Planes),_veh_type];//CVG_planes
					};
					if (_typeNumbers == 7) then {
						CVG_Ships set [(count CVG_Ships),_veh_type];//CVG_Ships
					};
							if (_typeNumbers == 8) then {
						CVG_Men set [(count CVG_Men),_veh_type];//CVG_men
					};
				};
			};
		};
	} forEach [1,2,3,5,7,8];
};
DZS_fn_processClasses = {
	CLY_zombieclasses = [];
	_civilians = [];
	_soldiers = [];
	{
		_class = _x;
		if (!(_class isKindOf "woman")) then {
			if (_class isKindOf "civilian") then {_civilians = _civilians + [_class]} else {_soldiers = _soldiers + [_class]};
		} else {CVG_men = CVG_men - [_x];};
	} forEach CVG_Men;
	CLY_zombieclasses = [_civilians,_soldiers];
};
DZS_fn_initVehicles = {
	cars = [];
	trucks = [];
	militaryvehs = [];
    switch (vehSpawnType) do
    {
        case 0:
        {
			{
				_magazines = [];
				_vehicle = configFile >> "CfgVehicles" >> _x;
				_weapons =  getArray(_vehicle >> "weapons");
				_turrets= (_vehicle >> "Turrets");
				for "_i" from 0 to (count _turrets)-1 do {
					_turret = _turrets select _i;
					_weapons = _weapons + getArray(_turret >> "weapons");
					_magazines = _magazines + getArray(_turret >> "magazines");
					_subturrets = _turret >> "Turrets";
					for "_j" from 0 to (count _subturrets)-1 do {
						_turret = _subturrets select _j;
						_weapons = _weapons + getArray(_turret >> "weapons");
						_magazines = _magazines + getArray(_turret >> "magazines");
					};
				};
				if ((count _weapons) < 2) then {Cars = cars + [_x]} else {MilitaryVehs = MilitaryVehs + [_x]};

			} forEach CVG_Cars;
			{
				_vehicle = configFile >> "CfgVehicles" >> _x;
				_weapons =  getArray(_vehicle >> "weapons");
				_turrets= (_vehicle >> "Turrets");
				for "_i" from 0 to (count _turrets)-1 do {
					_turret = _turrets select _i;
					_weapons = _weapons + getArray(_turret >> "weapons");
					_magazines = _magazines + getArray(_turret >> "magazines");
					_subturrets = _turret >> "Turrets";
					for "_j" from 0 to (count _subturrets)-1 do {
						_turret = _subturrets select _j;
						_weapons = _weapons + getArray(_turret >> "weapons");
						_magazines = _magazines + getArray(_turret >> "magazines");
					};
				};
				if ((count _weapons) < 2) then {trucks = trucks + [_x]} else {MilitaryVehs = MilitaryVehs + [_x]};

			} forEach CVG_Trucks

        };
        case 1:
        {
            cars = CVG_Cars;
        };
        case 2:
        {
            cars = CVG_Trucks;
        };
        case 3:
        {
			{
				_vehicle = configFile >> "CfgVehicles" >> _x;
				_side = getNumber(_vehicle >> "side");
				if ((_side == 1) || (_side == 2) || (_side == 0)) then {cars = cars + [_x];};
			} forEach CVG_Cars;
		};
        case 4:
        {
			cars = CVG_trucks + CVG_cars;
		};
        case 5:
        {
			cars = CVG_trucks + CVG_cars;
			_standard_Vehicles = [];

			{
				if (_x in _standard_Vehicles) then {cars = cars - [_x]};
			} forEach cars;
		};
    };
};
DZS_fn_initWeapons = {
  Switch (CVG_weapontype) do {
        case 1: {
            //allweapons
            CVG_weapons = [];
            CVG_weapons = CVG_rifles;
            CVG_weapons = CVG_weapons + CVG_Scoped;
            CVG_weapons = CVG_weapons + CVG_Heavy;
            CVG_weapons = CVG_weapons + CVG_pistols;
            CVG_weapons = CVG_weapons + CVG_Launchers;

        };
        case 2: {
            //Farmer Guns
            CVG_weapons = [];

        };
        case 3: {
            //Blufor Weapons
            CVG_weapons = [];

        };
        case 4: {
            //OpFor Weapons
            CVG_weapons = [];

        };
        case 5:
        {
            //pistols
            CVG_weapons = CVG_pistols;
        };

        case 6:
        {

        };
		case 8:
		{
			_original_Config = [];
			CVG_weapons = [];
            CVG_weapons = CVG_rifles;
            CVG_weapons = CVG_weapons + CVG_Scoped;
            CVG_weapons = CVG_weapons + CVG_Heavy;
            CVG_weapons = CVG_weapons + CVG_pistols;
            CVG_weapons = CVG_weapons + CVG_Launchers;
			{
				if (_x in _original_Config) then {CVG_Weapons = CVG_Weapons - [_x]};
			} forEach CVG_Weapons
		};
    };
};
DZS_fn_initPlayer = {
	diag_Log "Picking Location";
    _towns= townlist;
    if (CVG_Playerstart == 50) then {
        if ((count _towns) != 0) then {
            _townnumber = floor (random (count _towns));
            _town = _towns select _townnumber;
            _townpos = (position _town);
            _group = createGroup sideLogic;
            _logic = _group createUnit ["Logic",_townpos, [], 100, "NONE"];
            _newPos = position _logic;
			if ((_newPos select 0) != 0) then {
            player setpos _newPos;
			} else {
			player setpos _townPos
			};
            diag_Log format ["location chosen, %1",_town];

        }
        else
        {

            if ((count buildings) != 0) then {
                _building = (round(random(count buildings)));
                _newpos = position (buildings select _building);
                _newpos = [_newPos,0,50,1,0,20,0] call BIS_fnc_findSafePos;
                player setpos _newpos;
            }
            else
            {
                _things = nearestObjects [player, [], 200000];
                if ((count _things) != 0) then {
                    _thing = (round(random(count _things)));
                    _newpos = position (_things select _thing);
                    player setpos _newpos;
                }
                else
                {
                    _newpos = [(random 1000),(random 1000)];
                    player setpos _newpos;
                };
            };
        };
		deleteVehicle _logic;
		if (surfaceIsWater _newPos) then {[] call DZS_fn_initPlayer} else {diag_Log format ["location chosen, %1",_newPos]};
    };

    if (CVG_playerstart == 100) then {
        _townnumber = floor (random (count _towns));
        _town = _towns select _townnumber;
        _townpos = getpos _town;
        _checkVar = 0;
        _armPos = getArray(configFile >> "CfgWorlds" >> worldName >> "Armory" >> "positionStart");
        _centPos = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
	        while {_checkVar < 1} do{
            _dist = 1500;
            _dir = random 360;
            _pos = [(_townpos select 0) + (sin _dir) * _dist, (_townpos select 1) + (cos _dir) * _dist, 0];
            _pos = [_pos,0,40,4,0,20,0] call BIS_fnc_findSafePos;
            _check1 = [_pos, _armPos] call arrayCompare;
            _check2 = [_pos,_centPos] call arrayCompare;
            if ((!_check1) && (!_check2) && ((_pos distance (getpos _town)) > 1000)) then { _checkVar = 1};
        };
        player setpos _pos;
        diag_Log format ["location chosen, %1",_townpos];
    };

    if (CVG_playerstart == 150) then {

        if (isServer) then {
				if (count _towns != 0) then {
				_townnumber = floor (random (count _towns));
				_town = _towns select _townnumber;
				newPos = (position _town);
			}
			else
			{
				if ((count buildings) != 0) then {
					_building = (round(random(count buildings)));
					_newpos = position (buildings select _building);
					newPos = [_newPos,0,50,1,0,20,0] call BIS_fnc_findSafePos;
				}
				else
				{
					_things = nearestObjects [player, [], 200000];
					if ((count _things) != 0) then {
						_thing = (round(random(count _things)));
						newPos = position (_things select _thing);
					}
					else
					{
						newPos = [(random 1000),(random 1000),0];
					};
				};
			};
		publicVariable "newPos";
        };
		waitUntil {!(isNil "newPos")};
		player setpos newPos;
        diag_Log format ["location chosen, %1",_newPos];
		};

	if (CVG_playerstart == 200) then {
		if (count _towns != 0) then {
			_town = _towns select (floor random count _towns);
			_builds = nearestObjects [position _town, ["house"], 500];
			DZS_bPos = [];
			_pos = 0;
			_build = _builds select 0;
			while {!(count DZS_bPos > 1) || isNil "_pos"|| (damage _build) == 1 || (typeOf _build) in blacklist || !(isNil {_build getVariable "Destroyed"})} do {
				Playerbuild = _builds call BIS_fnc_selectRandom;
				DZS_bPos = Playerbuild call fn_getBuildingPositions;
				_pos = DZS_bPos call BIS_fnc_selectRandom;
			};
		};
		DZS_bPos = DZS_bPos - [_pos];
		_veh = DZS_weapons call BIS_fnc_selectRandom;
		_wep = _veh select 0;
		_mag = _veh select 1;
		_bPos = DZS_bPos call BIS_fnc_selectRandom;
		_invObj = "GroundWeaponHolder" createVehicle _bPos;
		_invObj setPos _bPos;
		_invObj setDir (random 360);
		_invObj addMagazineCargoGlobal [_mag, (round random 4)];
		_invObj addWeaponCargoGlobal [_wep, 1];

		_clothes = DZS_milClothes + DZS_clothes;
		_cloth = _clothes call BIS_fnc_selectRandom;
		if (count nearestObjects [_bPos, ["GroundWeaponHolder"], 1] < 1) then {
			_invObj addItemCargoGlobal [_cloth, 1];
		} else {
			_bPos = DZS_bPos call BIS_fnc_selectRandom;
			_invObj = "GroundWeaponHolder" createVehicle _bPos;
			_invObj setPos _bPos;
			_invObj setDir (random 360);
			_invObj addItemCargoGlobal [_cloth, 1];
		};
		if ((_pos select 0 == (getMarkerPos "respawn_civilian") select 0 )||(_pos select 0 == (getMarkerPos "respawn_west") select 0 )||( _pos select 0 == (getMarkerPos "respawn_east") select 0)||( _pos select 0 == (getMarkerPos "respawn_civ") select 0)||(_pos select 0 == (getMarkerPos "respawn_civ") select 0)) then {
			[] call DZS_fn_initPlayer;
		} else {
			player setPos _pos;
			player setDir (random 360);
		};
		diag_Log format ["location chosen, %1",_pos];
	};
	
	if (CVG_playerstart == 250) then {
			if (isServer) then {
				if (count _towns != 0) then {
				_town = _towns select (floor random count _towns);
				_builds = nearestObjects [position _town, ["house"], 500];
				DZS_bPos = [];
				_pos = 0;
				_build = _builds select 0;
				while {!(count DZS_bPos > 1) || isNil "_pos"|| (damage _build) == 1 || (typeOf _build) in blacklist || !(isNil {_build getVariable "Destroyed"})} do {
					Playerbuild = _builds call BIS_fnc_selectRandom;
					DZS_bPos = Playerbuild call fn_getBuildingPositions;
					_pos = DZS_bPos call BIS_fnc_selectRandom;
				};
				spawnPos = _pos;
				publicVariable "spawnPos";
			};
			DZS_bPos = DZS_bPos - [_pos];
			_veh = DZS_weapons call BIS_fnc_selectRandom;
			_wep = _veh select 0;
			_mag = _veh select 1;
			_bPos = DZS_bPos call BIS_fnc_selectRandom;
			_invObj = "GroundWeaponHolder" createVehicle _bPos;
			_invObj setPos _bPos;
			_invObj setDir (random 360);
			_invObj addMagazineCargoGlobal [_mag, (round random 4)];
			_invObj addWeaponCargoGlobal [_wep, 1];

			_clothes = DZS_milClothes + DZS_clothes;
			_cloth = _clothes call BIS_fnc_selectRandom;
			if (count nearestObjects [_bPos, ["GroundWeaponHolder"], 1] < 1) then {
				_invObj addItemCargoGlobal [_cloth, 1];
			} else {
				_bPos = DZS_bPos call BIS_fnc_selectRandom;
				_invObj = "GroundWeaponHolder" createVehicle _bPos;
				_invObj setPos _bPos;
				_invObj setDir (random 360);
				_invObj addItemCargoGlobal [_cloth, 1];
			};
		} else {waitUntil {!isNil "spawnPos"};};
		if ((_pos select 0 == (getMarkerPos "respawn_civilian") select 0 )||(_pos select 0 == (getMarkerPos "respawn_west") select 0 )||( _pos select 0 == (getMarkerPos "respawn_east") select 0)||( _pos select 0 == (getMarkerPos "respawn_civ") select 0)||(_pos select 0 == (getMarkerPos "respawn_civ") select 0)) then {
			[] call DZS_fn_initPlayer;
		} else {
			player setPos spawnPos;
			player setDir (random 360);
		};
		diag_Log format ["location chosen, %1",_pos];
	};
	
	DZS_playerInitDone = true;
};
DZS_fn_ammoCaches = {
	if (isServer) then {
		if (CVG_Caches == 1) then {
			_towns = townlist;
			_boxes = (count _towns) * 2;
			_num = _boxes / .7;
			_boxes = _boxes - (round(random _num));

			while {_boxes > 0} do {
				_boxess = ["Box_NATO_WpsSpecial_F","Box_NATO_Wps_F","Box_NATO_Support_F","Box_NATO_Grenades_F","Box_NATO_AmmoOrd_F","Box_NATO_Ammo_F","Box_East_WpsSpecial_F","Box_East_Wps_F","Box_East_Support_F","Box_East_Grenades_F","Box_East_AmmoOrd_F","Box_East_Ammo_F"];
				_town = _towns call BIS_fnc_selectRandom;
				_newpos = getpos _town;
				_townpos = [_newpos, 10, 100, 1, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
				_numb = (count _boxess);
				_boxnum = floor (random _numb);
				_box = _boxess select _boxnum;
				_box = createVehicle [_box,_townpos,[], 0, "NONE"];
				clearWeaponCargoGlobal _box;
				clearMagazineCargoGlobal _box;
				clearItemCargoGlobal _box;
				clearBackpackCargoGlobal _box;
				_boxes = _boxes - 1;
				[_box] call DZS_fn_fillBoxes;
				if (CVG_Debug) then {
					_marker=createMarker [format ["mar%1",random 100000],_townpos];
					_marker setMarkerType "mil_dot";
					_marker setMarkerColor "ColorBrown";
					_marker setMarkerSize [1,1];
				};
			};
		};

	};
	};
DZS_fn_destroyFuel = {
	_Pos = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
	_stations = nearestObjects [_pos, ["Land_FuelStation_Build_F","Land_FuelStation_Feed_F","Land_FuelStation_Shed_F"], 50000];
	{_x setdamage 1} forEach _stations;
};
DZS_fn_weather = {
    switch (CVG_Weather) do {
        case 1:
        {0 setFog 0;
        0 setOvercast 0;};
        case 2:
        {
            0 setFog 0;
            0 setOvercast 1;
        };
        case 3:
        {
            0 setFog 0.5;
            0 setOvercast 0.5;
        };
        case 4:
        {
            0 setFog 1;
            0 setOvercast 1;
        };
        case 5:
        {
        	if (isServer) then
        	{
        		fogNumber = (random 1);
        		overcastNumber = (random 1);
        		publicVariable "fogNumber";
        		publicVariable "overcastNumber";
        	};
        	waitUntil {(!(isNil "fogNumber")) && (!(isNil "overcastNumber"))};
        	0 setFog fogNumber;
        	0 setOvercast overcastNumber;
        };
    };
	setViewDistance CVG_Viewdist;
	if (CVG_fog == 1) then {[player,100,11,30,3,7,-0.3,0.1,0.5,1,1,1,13,12,15,false,2,2.1,0.1,1,1,0,0,24] execFSM "impact_code\MPScenarios\Impact.Altis\mission\Fog.fsm"};
};
fn_getBuildingPositions = {

    private ["_building","_positions","_i","_next"];
    _building = _this;
    _positions = [];

    // search more positions
    _i = 1;
    while {_i > 0} do
    {
        _next = _building buildingPos _i;
        if (((_next select 0) == 0) && ((_next select 1) == 0) && ((_next select 2) == 0)) then
        {
            _i = 0;
        } else {
            _positions set [(count _positions), _next];
            _i = _i + 1;
        };
    };

    // return positions
    _positions
};
arrayCompare = {
    private ["_array1","_array2","_i","_return"];

    _array1 = _this select 0;
    _array2 = _this select 1;

    _return = true;
    if ( (count _array1) != (count _array2) ) then
    {
        _return = false;
    }
    else
    {
        _i = 0;
        while {_i < (count _array1) && _return} do
        {
            if ( (typeName (_array1 select _i)) != (typeName (_array2 select _i)) ) then
            {
                _return = false;
            }
            else
            {
                if (typeName (_array1 select _i) == "ARRAY") then
                {
                    if (!([_array1 select _i, _array2 select _i] call arrayCompare)) then
                    {
                        _return = false;
                    };
                }
                else
                {
                    if ((_array1 select _i) != (_array2 select _i)) then
                    {
                        _return = false;
                    };
                };
            };
            _i = _i + 1;
        };
    };

    _return
};
DZS_fn_ZinBuildings = {
	if (isNil "DZS_playerInitDone") then {waitUntil {!isNil "DZS_playerInitDone"}};
	Playerbuild setVariable ["Infested",false,true];
	_zSpawnNum = 0;
	_things = _this select 0;
	_num = 10;
	if ((count _things) > 20) then {
		for "_i" from 0 to (_num) do
		{
			_things = _things - [_things select _i];
		};
	};
	{
	
		if (_x getVariable "Infested" && ((_zSpawnNum + ((count nearestObjects [(getPos _x), ["man"], 200]) - _zSpawnNum))< CVG_Zdensity)) then {
			_housePs = _x call fn_getBuildingPositions;
			_build = _x;
            if (count _housePs != 0) then {
				_num =  (count _housePs / (10 + (ceil random 2)));
				for "_i" from 0 to (_num) do
				{
					_pos = _housePs call bis_fnc_selectRandom;
					_housePs = _housePs - [_pos];
					_side=east;
					if ({side _x==east} count allGroups>=144) then {_side=west};
					if (_side==west and {side _x==west} count allGroups>=144) then {_side=resistance};
					_group=createGroup _side;
					_class = call CLY_randomzombie;
					if (!isNil "_class") then {
						_zombie= _group createUnit [_class,getPos zombiespawner,[],50,"NONE"];
						_zSpawnNum = _zSpawnNum + 1;
						_build setVariable ["Infested",false,true];
						_zombie enableSimulation false;
						if (typeName _pos == "ARRAY") then {
							[_zombie,"passive",objNull,false,0,[_pos select 0, _pos select 1, _pos select 2],true] exec "impact_code\MPScenarios\Impact.Altis\zombie_scripts\cly_z_init.sqs";
						} else {deleteVehicle _zombie};
					} else {deleteGroup _group};
				};
				/*_num = random 100;
				if (_num < 30) then {
					_rds = _build nearRoads 10;
					_pos = _rds call bis_fnc_selectRandom;
					if (count _rds > 0) then {
						_pos = getpos _pos;
						_side=east;	
						if ({side _x==east} count allGroups>=144) then {_side=west};
						if (_side==west and {side _x==west} count allGroups>=144) then {_side=resistance};
						_group=createGroup _side;
						_class = call CLY_randomzombie;
						if (!isNil "_class" && not (isNil "_pos")) then {
							_zombie= _group createUnit [_class,getPos zombiespawner,[],50,"NONE"];
							_zombie enableSimulation false;
							_zSpawnNum = _zSpawnNum + 1;
							_build setVariable ["Infested",false,true];
							[_zombie,"passive",objNull,false,0,[_pos select 0, _pos select 1],true] exec "impact_code\MPScenarios\Impact.Altis\zombie_scripts\cly_z_init.sqs";
							
						} else {deleteGroup _group};
					};
				};*/
			};
		};
	} forEach _things;
};
DZS_fn_LinBuildings = {
	_things = _this select 0;
	private ["_array","_num","_veh","_mag","_invObj","_bPoss","_bPos","_b"];
	{
		_b = _x;
		if (!isNil {_b getVariable "Loot"}) then {
			if ((_b getVariable "Loot") == "Civilian") then {
				_num = random 100;
				if (_num < 30) then {_array = DZS_clothes};
				if (_num < 50 && _num > 30) then {_array = DZS_mines + DZS_throw + DZS_miscSpawn};
				if (_num < 80 && _num > 50) then {_array = DZS_weapons};
				if (_num <100 && _num > 80) then {_array = DZS_attachments};
				if (isNil "_array") then {_array = DZS_weapons};
			};
			if ((_b getVariable "Loot") == "Military") then {
				_num = random 100;
				if (_num < 30) then {_array = DZS_milclothes};
				if (_num < 50 && _num > 30) then {_array = DZS_mines + DZS_throw + DZS_miscSpawn};
				if (_num < 80 && _num > 50) then {_array = DZS_weapons};
				if (_num <100 && _num > 80) then {_array = DZS_attachments};
				if (isNil "_array") then {_array = DZS_weapons};
			};
			_bPoss = _b call fn_getBuildingPositions;
			_bPos = _bPoss call bis_fnc_selectRandom;
			if (count nearestObjects [_bPos, ["GroundWeaponHolder"], 1] < 1) then {
				_invObj = "GroundWeaponHolder" createVehicle _bPos;
				_invObj setPos _bPos;
				_invObj setDir (random 360);
				if (typeName (_array select 0) == "ARRAY") then {
					_veh = _array select (floor random count _array);
					_wep = _veh select 0;
					_mag = _veh select 1;
					_invObj addMagazineCargoGlobal [_mag, (round random 4)];
					_invObj addWeaponCargoGlobal [_wep, 1];
				};
				if (typeName (_array select 0) == "STRING") then {
					if (_array select 0 == DZS_mines select 0) then {
						_veh = _array call BIS_fnc_selectRandom;
						_invObj addMagazineCargoGlobal [_veh, round random 2];
					} else {
						_veh = _array call BIS_fnc_selectRandom;
						_invObj addItemCargoGlobal [_veh, round random 2];
					};
				};
			};
		};
	} forEach _things;
};
DZS_fn_randomUnitWeapons = {
	/*
	Weapons script by Craig
	Free to use and modify, crediting not required
	Classnames put into string form (a very annoying/laborous task) by Dominic/Genesis
	*/

	private ["_man","_weapons","_mags","_rnd","_weapon","_mag","_num","_i","_currweapon","_type","_muzzles","_hasRightWeapon"];
	if (player != player) then {
		waitUntil {player == player};
		waitUntil {time > 10};
	};


	sleep .1;
	waitUntil {local Player};
	_man = _this select 0;
	removeAllWeapons _man;

	//Does some randomnessness

	if (CVG_weapontype == 6) then {
		_num = floor (random 100);
		if (_num < 100) then {CVG_weapons = CVG_pistols};
		if (_num < 50) then {CVG_weapons = CVG_Rifles};
		if (_num < 25) then {CVG_weapons = CVG_Scoped};
		if (_num < 10) then {CVG_weapons = CVG_Heavy};
	};
	while {isNil "_mag"} do {
		_rnd = floor random (count CVG_weapons);
		_weapon = CVG_weapons select _rnd;
		_mag=(getArray (configFile/"CfgWeapons"/_weapon/"magazines")) select 0;
	};


	//Add guns and magazines, note the Global at the end...
	removeAllWeapons _man;
	_n = round random 7;
	for "_i" from 0 to _n-1 do {_man addMagazine _mag};
	_man addWeapon _weapon;

	_type = _weapon;
	// check for multiple muzzles (eg: GL)
	_muzzles = getArray(configFile >> "cfgWeapons" >> _type >> "muzzles");

	if (count _muzzles > 1) then
	{
		player selectWeapon (_muzzles select 0);
	}
	else
	{
		player selectWeapon _type;
	};

	if (CVG_debug) then {player sidechat FORMAT ["Weapon chosen, %1",_weapon]};

	_hasRightWeapon = 0;
	while {_hasRightWeapon == 0} do {
		_currweapon = currentWeapon player;
		sleep 0.001;
		if (_currweapon != _type) then {
			diag_log "Player does not have correct weapon";
			if (count _muzzles > 1) then
			{
				player selectWeapon (_muzzles select 0);
			}
			else
			{
				player selectWeapon _type;
			};
		}
		else
		{
			_hasRightWeapon = 1;
		};
	};
	diag_log "Player has the correct weapon";
};
DZS_fn_randomWeapons = {
	//Random weapons script by Craig Vander Galien

	private ["_man","_rnd","_weapon","_mag","_num"];
	if (!isServer) exitWith {};
	_man = _this select 0;

	if (CVG_weapontype == 6) then {
		_num = floor (random 100);
		if (_num < 100) then {CVG_weapons = CVG_pistols};
		if (_num < 50) then {CVG_weapons = CVG_Rifles};
		if (_num < 25) then {CVG_weapons = CVG_Scoped};
		if (_num < 10) then {CVG_weapons = CVG_Heavy};
	};

	//Does some randomessness
	while {isNil "_mag"} do {
		_rnd = floor random (count CVG_weapons);
		_weapon = CVG_weapons select _rnd;
		_mag=(getArray (configFile/"Cfgweapons"/_weapon/"magazines")) select 0;
	};
	//Add guns and magazines, note the Global at the end...
	_man addMagazineCargoGlobal [_mag,(random 7)];
	_man addWeaponCargoGlobal [_weapon,1];
};
DZS_fn_vehicleSpawn = {
//determines the vehicles random properties

private ["_marker","_cartype","_car","_num","_tipped","_carpos","_type","_townpos","_number"];
	_type = _this select 1;
	_townpos = _this select 0;
	if (_type == 0) then {
		if (vehSpawnType == 0) then {
			_num = random 100;
			if (_num < 30) then {_cartype = cars call BIS_fnc_selectRandom;} else {_cartype = cars call BIS_fnc_selectRandom;};
		} else {
			while {(typeOf _carType) != "LandVehicle"} do {
				_cartype = cars call BIS_fnc_selectRandom; //picks a cartype
			};
		};
	    _car = createVehicle [_cartype,_townpos,[], 30,"None"] ; 	// creates car
		clearWeaponCargoGlobal _car;
		clearMagazineCargoGlobal _car;
		clearItemCargoGlobal _car;
		clearBackpackCargoGlobal _car;
	    if (cvg_debug) then {
	        _marker=createMarker [format ["mark%1",random 100000],getpos _car];
	        _marker setMarkerType "mil_dot";
	        _marker setMarkerColor "ColorBlue";
	        _marker setMarkerSize [1,1];
	    };
	    switch (CVG_VehicleStatus) do {
	        case 1:
	        {
	            _car setFuel ((random .2)+.6);
	            _car setDamage (random .2);
	        };
	        case 2:
	        {
	            _car setFuel ((random .3)+.3);
	            _car setDamage ((random .1)+.3);
	        };
	        case 3:
	        {
				_car setFuel ((random .2) +.1);
	            _car setDamage ((random .3) +.3);

	        };
	        case 4:
	        {
				_car setFuel ((random .9)+.1);
	            _car setDamage (random .8);
	        }
	    };
	    _car setDir (random 360);
		_pos = getpos _car;
		_normalpos = surfaceNormal [_pos select 0, _pos select 1];
		_car setpos [(_pos select 0) + (_normalpos select 0),(_pos select 1) + (_normalpos select 1),(_pos select 2) + (_normalpos select 2)];
	    _num = (random 100);

	    if (_num < 5) then { _car addWeaponCargoGlobal ["ItemMap",1];};
	    _car setVehicleAmmo (random .2);
	    _tipped = (random 100);
	    if (_tipped < 10) then {_car setVectorUp [0,1,0]};//simulates chaos, rioting, zombies pushing cars over

	    if (CVG_weaponcount != 101) then {
	        _number = floor (random 100);
	        if (_number < CVG_weaponcount) then {
	            [_car] call DZS_fn_randomWeapons;
	        };
	    } else {
	        [_car] call DZS_fn_randomWeapons;
	    };

	} ;

	if (_type == 1) then {
	    if (vehspawntype == 0) then {
	        _cartype = militaryvehs call BIS_fnc_selectRandom; //picks a cartype
	    } else {
	        while {(typeOf _carType) != "LandVehicle"} do {
				_cartype = cars call BIS_fnc_selectRandom; //picks a cartype
			};
	    };
	    _car = createVehicle [_cartype,_townpos, [], 30, "None"] ; 	// creates car
		_pos = getpos _car;
		_pos = surfaceNormal [_pos select 0, _pos select 1];

		clearWeaponCargoGlobal _car;
		clearMagazineCargoGlobal _car;
		clearItemCargoGlobal _car;
		clearBackpackCargoGlobal _car;
	    if (cvg_debug) then {
	        _marker=createMarker [format ["mark%1",random 100000],getpos _car];
	        _marker setMarkerType "mil_dot";
	        _marker setMarkerColor "ColorBlack";
	        _marker setMarkerSize [1,1];
	    };

	      switch (CVG_VehicleStatus) do {
	        case 1:
	        {
	            _car setFuel ((random .2)+.6);
	            _car setDamage (random .2);
	        };
	        case 2:
	        {
	            _car setFuel ((random .3)+.3);
	            _car setDamage ((random .3)+.3);
	        };
	        case 3:
	        {
				_car setFuel ((random .2) +.1);
	            _car setDamage ((random .4) +.5);

	        };
	        case 4:
	        {
				_car setFuel ((random .9)+.1);
	            _car setDamage (random .9);
	        }
	    };

	    _car setDir (random 360);
	    _car setpos _pos;
	    _num = (random 100);
	    if (_num < 1) then { _car addWeaponCargoGlobal ["ItemMap",1];};
	    _car setVehicleAmmo (random .2);
	    _tipped = (random 100);
	    if (_tipped < 10) then {_car setVectorUp [0,1,0]};//simulates chaos, rioting, zombies pushing cars over

	    if (CVG_weaponcount != 101) then {
	        _number = floor (random 100);
	        if (_number < CVG_weaponcount) then {
	            [_car] call DZS_fn_randomWeapons;
	        };
	    };
	    _carpos = getpos _car;
	    _car setpos _carpos;
	};


	_car
};
DZS_fn_fillBoxes = {
    private ["_weapon","_mag","_randomNumberToSpawn","_weapons","_crate","_WeaponNumber"];
    _crate = _this select 0;
    _weapons = CVG_Weapons;

    _WeaponNumber = (round (CVG_WeaponCount / 3));

    _randomNumberToSpawn = ((round (random 10)) + _WeaponNumber);

    while {_randomNumberToSpawn != 0} do
    {
        //Pick a random weapons from the already defined list of weapons (defined in startup.sqf)
    	while {isNil "_mag"} do {
			_weapon = _weapons call BIS_fnc_selectRandom;
			_mag=(getArray (configFile/"Cfgweapons"/_weapon/"magazines")) select 0;
		};

    	_crate addMagazineCargoGlobal [_mag,(round(random(12)))];
    	_crate addWeaponCargoGlobal [_weapon,1];
    	_randomNumberToSpawn = _randomNumberToSpawn - 1;
    };
};
DZS_fn_displayInfo = {
	_build = _this select 0;
	if (typeName _build == "STRING") then {[["User", "Usermade",(_build + ".")]] call DZS_fn_hints;} else {
		_buildMessage = _build getVariable "Message";
		
		if (!isNil "_buildMessage") then {
			[["User", "Usermade",(_buildMessage + ".")]] call DZS_fn_hints;
		} else {
			_buildMessage = [_build] call DZS_fn_houseNotes;
			waitUntil {!isNil "_buildMessage"};
			[["User", "Usermade",(_buildMessage + ".")]] call DZS_fn_hints;
			_build setVariable ["Message",_buildMessage,true];
		};
	};
};
DZS_fn_houseInfo = {
	
	while {alive player} do {
		_builds = nearestObjects [(getpos vehicle player), ["house"], 400];
		{
		_housePs = _x call fn_getBuildingPositions;
			if ((count _housePs) != 0 && !((typeOf _x) in militarylist) && (isNil {_x getVariable "Processed"})) then {
				_house = _x;
				_houseStanding = true;
				if (!(isNil {_house getVariable "Destroyed"})) then {_houseStanding = false} else {
					_houseStanding = true;
				};
				
				if ((random 100) < 20 || !(_houseStanding)) then {_houseStanding = false;} else {_houseStanding = true};
				if (!_houseStanding) then {
					_house setVariable ["Destroyed",true,true];
					_house setDamage 1;
					_housePos = getPos _house;
					[_house] spawn {
						_house = _this select 0;
						_housePos = getPos _house;
						waitUntil {(count nearestObjects [_housePos,["Ruins_F"],50]) > 0};
						_nearBuilds = nearestObjects [_housePos,["Ruins_F"],50];
						_ruinBuild = _nearBuilds select 0;
						_ruinBuild setVariable ["Destroyed",true,true];
						_house setVariable ["Destroyed",true,true];
						_ruinBuild setVariable ["Processed",true, true];
						//[[[_ruinBuild],DZS_fn_addAction],"BIS_fnc_call",false,true] spawn BIS_fnc_MP;
					};
				}
				else
				{
					//[[[_house],DZS_fn_addAction],"BIS_fnc_call",false,true] spawn BIS_fnc_MP;
					if ((random 100) <  chanceNumber) then {
						_vehPos = (getPos _house) findEmptyPosition[ 1 , 20 ,"LandVehicle"];
						[_vehPos,0] call DZS_fn_vehicleSpawn;
					};
					if ((random 100) < 90) then {_house setVariable ["Infested",true,true]};
					_house setVariable ["Loot","Civilian",false];
					_house setVariable ["Processed",true, true];
				};
			};
			if (count _housePs > 2 && ((typeOf _x) in militarylist) && not (_x getVariable "Processed")) then {
				_house = _x;
				_houseStanding = true;
				if ((random 100) < 20) then {_house setdamage 1;_houseStanding = false;} else {_houseStanding = true};
				if (!_houseStanding) then {
					_house setDamage 1;
					_housePos = getPos _house;
					[_house] spawn {
						_house = _this select 0;
						_housePos = getPos _house;
						waitUntil {(count nearestObjects [_housePos,["Ruins_F"],20]) > 0};
						_nearBuilds = nearestObjects [_housePos,["Ruins_F"],50];
						_ruinBuild = _nearBuilds select 0;
						_ruinBuild setVariable ["Destroyed",true,true];
						_ruinBuild setVariable ["Processed",true, true];
					};
				}
				else
				{
					//[[[_house],DZS_fn_addAction],"BIS_fnc_call",false,true] spawn BIS_fnc_MP;
					if ((random 100) <  chanceNumber) then {
						_vehPos = (getPos _house) findEmptyPosition[ 1 , 20 ,"LandVehicle"];
						[_vehPos,1] call DZS_fn_vehicleSpawn;
					};
					_house setVariable ["Infested",true,true];
					_house setVariable ["Loot","Military",true];
					_house setVariable ["Processed",true, true];
				};
			};
		} forEach _builds;
		[_builds] spawn DZS_fn_ZinBuildings;
		[_builds] call DZS_fn_LinBuildings;
		_waiting = true;
		_Playerpos = position (vehicle player);
		while {_waiting} do {
			sleep 5;
			if (position vehicle player distance _Playerpos > 50) then {_waiting = false};
		};
	};
};
DZS_fn_hints = {
/*
	File: advHint.sqf
	Author: Borivoj Hlava

	Description:
	Advanced hint system

	Parameter(s):
	_this select 0: Array - Array in format ["hint mainclass","hint class"]
	_this select 1: Number (optional) - Duration of short version of hint in seconds
	_this select 2: String (optional) - Condition for hiding of short version of hint
	_this select 3: Number (optional) - Duration of full version of hint in seconds !!!not implemented now!!!
	_this select 4: String (optional) - Condition for hiding of full version of hint !!!not implemented now!!!
	_this select 5: Bool (optional) - True shows hint even if tutorial hints are disabled via game settings !!!not implemented now!!!
	_this select 6: Bool (optional) - True shows directly the full hint without using of the short hint
	_this select 7: Bool (optional) - Show the hint in a mission only once (true) or multiple times (false)

	Returned value:
	None. Create variable BIS_fnc_advHint_hint:
	BIS_fnc_advHint_hint select 0: String - Class of hint
	BIS_fnc_advHint_hint select 1: String - Structured text of full hint
	BIS_fnc_advHint_hint select 2: String - Structured text of short hint
	BIS_fnc_advHint_hint select 3: Number - Duration of short hint in seconds
	BIS_fnc_advHint_hint select 4: String - Condition for hiding of short hint (default: "false")
	BIS_fnc_advHint_hint select 5: Number - Duration of full hint in seconds
	BIS_fnc_advHint_hint select 6: String - Condition for hiding of full hint (default: "false")
	BIS_fnc_advHint_hint select 7: Bool - True shows directly full hint (default: "false")

	Note: Hint must be defined in CfgHints.
*/

	if (isTutHintsEnabled) then {

		if (isNil {BIS_fnc_advHint_shownList}) then {BIS_fnc_advHint_shownList = []};
		_onlyOnceCheck = true;
		_onlyOnce = [_this,8,false] call BIS_fnc_param;				//show only once or multiple times

		if ((count BIS_fnc_advHint_shownList) != 0) then {
			_class = _this select 0;
			{
				if ((_x select 1) == (_class select 1)) then {
					if ((_x select 0) == (_class select 0)) then {
						_onlyOnceCheck = false
					} else {
					BIS_fnc_advHint_shownList = BIS_fnc_advHint_shownList + [_class];
					};
				} else {
					BIS_fnc_advHint_shownList = BIS_fnc_advHint_shownList + [_class];
				};
			} forEach BIS_fnc_advHint_shownList;
		};

		if (!_onlyOnce || _onlyOnceCheck) then {
			_this spawn {
				// ========== Parameters ==========
				_class = _this select 0;									//classes, 2 requires
				_showT = [_this,1,15,[0]] call BIS_fnc_param;				//duration of short hint
				_cond = [_this,2,"false",[""]] call BIS_fnc_param;			//hide condition of short hint
				_showTF = [_this,3,35,[0]] call BIS_fnc_param;				//duration of full hint
				_condF = [_this,4,"false",[""]] call BIS_fnc_param;			//hide condition of full hint
				_show = [_this,5,false] call BIS_fnc_param;					//show even if its disabled in options
				_onlyFull = [_this,6,false] call BIS_fnc_param;				//show directly full hint

				if (_showT == 0) then {_showT = 15};
				if (_cond == "") then {_cond = "false"};
				if (_showTF == 0) then {_showTF = 35};
				if (_condF == "") then {_condF = "false"};

				// ========== Basic variables ==========
				_topicCfg = [["CfgHints",(_class select 0)],configfile >> "CfgHints" >> "Empty"] call bis_fnc_loadClass;
				_titleCfg = _topicCfg >> (_class select 1);
				if !(isclass _titleCfg) exitwith {["Hint 'CfgHints >> %1 >> %2' does not exist",_class select 0,_class select 1] call bis_fnc_error;};

				//_topicName = getText (_topicCfg >> "displayName");	//temporary disabled
				_titleClass = _class select 1;
				_titleName = getText (_titleCfg >> "displayName");
				_titleNameShort = getText (_titleCfg >> "displayNameShort");
				_desc = _this select 0 select 2;
				_tipString = getText (_titleCfg >> "tip");
				_arg = getArray (_titleCfg >> "arguments");
				_image = getText (_titleCfg >> "image");

				if (isNil {player getVariable "BIS_fnc_advHint_HActiveF"}) then {
					player setVariable ["BIS_fnc_advHint_HActiveF",""]
				};
				if (isNil {player getVariable "BIS_fnc_advHint_HActiveS"}) then {
					player setVariable ["BIS_fnc_advHint_HActiveS",""]
				};

				// Control if paramater image is used
				_imageVar = false;
				if (_image != "") then {
					_imageVar = true;
				};


				// ========== Hint creation ==========
				// -- Info string creation and variables compilation --
				_keyColor = (["GUI", "BCG_RGB"] call BIS_fnc_displayColorGet) call BIS_fnc_colorRGBtoHTML;
				//_elementColor = (["IGUI", "TEXT_RGB"] call BIS_fnc_displayColorGet) call BIS_fnc_colorRGBtoHTML;
				_infoString = _desc;
				// Info + arguments processing
				//_infoString = [_infoString] call BIS_fnc_advHintInfo;		//optimalization
				_argArray = [_arg, _keyColor] call BIS_fnc_advHintArg;

				_titleName = toUpper (format ([_titleName] + _argArray));
				_titleNameShort = format ([_titleNameShort] + _argArray);
				_infoArray = [_infoString] + _argArray;
				_info = format _infoArray;
				disableSerialization;

				waitUntil {!(isNull call BIS_fnc_displayMission)};
				BIS_fnc_advHint_HPressed = nil;

				// -- Hint recalling --
				if (isNil "BIS_fnc_advHint_hintRecall") then {
					_display = [] call BIS_fnc_displayMission;

					BIS_fnc_advHint_hintRecall = _display displayAddEventHandler [
						"KeyDown",
						"
							_key = _this select 1;

							if (_key in actionkeys 'help') then {
								BIS_fnc_advHint_HPressed = true;
								[true] call BIS_fnc_AdvHintCall;
								true;
							};
						"
					];
				};

				// -- Build hint --
				_textSizeSmall = 1;			// derived from default hint font size 0.8; final size = (0.8 * 1) = 0.8
				_textSizeNormal = 1.25;		// derived from default hint font size 0.8; final size = (0.8 * 1.25) = 1.0
				_invChar05 = "<img image='#(argb,8,8,3)color(0,0,0,0)' size='0.5' />";		//invisible object for small spaces
				_invChar02 = "<img image='#(argb,8,8,3)color(0,0,0,0)' size='0.2' />";		//invisible object for small spaces
				_shadowColor = "#999999";

				_helpKey = "";
				_helpArray = actionKeysNamesArray "help";
				if (count _helpArray != 0) then {
					_helpKey = _helpArray select 0
				} else {
					//wrong name of action or undefined key, actionKeysNamesArray return empty array
					_helpKey = localize "STR_A3_Hints_undefined"
				};

				_keyString = format ["<t color = '%1'>[%2]</t>", _keyColor, _helpKey];
				_partString = format [localize "STR_A3_Hints_recall", _keyString];
				_partShortString = format [localize "STR_A3_Hints_moreinfo", _keyString];

				_startPartString = "";
				if (_titleNameShort == "") then {
					_titleNameShort = _titleName;
					_startPartString = "";	// from start to image
				} else {
					_startPartString = format ["<t size = '%3' align='center' color = '%5'>""%2""</t><br/>", _titleName, _titleNameShort, _textSizeNormal, _keyColor, _shadowColor];	// from start to image
				};
				_middlePartString = format ["<t align='left' size='%2'>%1</t><br/>", _info, _textSizeSmall];	// from image to tip
				_endPartString = format ["%4<br/><t size = '%2' color = '%3'>%1</t>", _partString, _textSizeSmall, _shadowColor, _invChar02];	// from tip to end
				_tipPartString = "";
				if (_tipString != "") then {
					//_tipString = [_tipString] call BIS_fnc_advHintInfo;		//optimalization
					_tipArray = [_tipString] + _argArray;
					_tip = format _tipArray;
					_tipPartString = format ["<t align='left' size='%2' color='%3'>%1</t><br/>", _tip, _textSizeSmall, _shadowColor]
				};

				_shortHint = format ["<t size = '%5' color = '%6'>%2</t>", _titleName, _partShortString, _textSizeNormal, _keyColor, _textSizeSmall, _shadowColor];


				if (_imageVar) then {		// hint with image
					if (_tipString != "") then {			// hint with tip
						_hint = format ["%1<img image = '%5' size = '5' shadow = '0' align='center' /><br/>%2<br/>%3%4", _startPartString, _middlePartString, _tipPartString, _endPartString, _image];
						BIS_fnc_advHint_hint = [_titleClass, [_titleName,_hint], [_titleNameShort,_shortHint], _showT, _cond, _showTF, _condF, _onlyFull];
					} else {						// hint without tip
						_hint = format ["%1<img image = '%4' size = '5' shadow = '0' align='center' /><br/>%2%3", _startPartString, _middlePartString, _endPartString, _image];
						BIS_fnc_advHint_hint = [_titleClass, [_titleName,_hint], [_titleNameShort,_shortHint], _showT, _cond, _showTF, _condF, _onlyFull];
					}
				} else {					// hint without image
					if (_tipString != "") then {			// hint with tip
						_hint = format ["%1<br/>%5<br/>%2<br/>%3%4", _startPartString, _middlePartString, _tipPartString, _endPartString, _invChar02];
						BIS_fnc_advHint_hint = [_titleClass, [_titleName,_hint], [_titleNameShort,_shortHint], _showT, _cond, _showTF, _condF, _onlyFull];
					} else {						// hint without tip
						_hint = format ["%1<t size='0.05'><br/>a<br/>a<br/></t>%2%3", _startPartString, _middlePartString, _endPartString];
						BIS_fnc_advHint_hint = [_titleClass, [_titleName,_hint], [_titleNameShort,_shortHint], _showT, _cond, _showTF, _condF, _onlyFull];
					}
				};

				[false] call BIS_fnc_AdvHintCall;
			};
		};
	};
};
DZS_fn_processHuman = {


	_male = ["Jim","James","John","Craig","Cal","Al","Sam","Bill","Mel","Mike","Michael","Philip","Paul","Charlie","Jay","Nathan","Carter","Kent","Peter","Pete","Steve","Tom","Bob","Trent","Travis","Andrew","Andy","Dean","Carl","Carlos","Ben","Trent","Dan","Tim","Juan","Trey","Jon","Don","Ron","Aaron","Adam","Alex","Austin","Brad","Brady","Bradon","Bret","Chad","Chris","Clay","Cody","Connor","Colton","Daniel","David","Devon","Derek","Doug","Danny","Fred","Glen","Grant","Greg","Jacob","Jake","Jordan","Jared","Jason","Joe","Josh","Justin","Kyle","Luke","Lukas","Lucas","Mark","Martin","Marty","Matt","Matthew","Martin","Noah","Nick","Rixhard","Rich","Sean","Shawn","Thomas","Tylor","Tyler","Trevor","Wesley","Wes","Zach","Zach"];
	_female = ["Emily","Madison","Emma","Hannah","Abigail","Olivia","Ashley","Samantha","Alexis","Sarah","Elizabeth","Elisabeth","Isabella","Alyssa","Grace","Lauren","Taylor","Jessica","Brianna","Kayla","Sophia","Anna","Natalie","Victoria","Chloe","Sydney","Jasmine","Hailey","Megan","Rachel","Morgan","Sami","Kennedy","Julia","Destiny","Ava","Jennifer","Mia","Katherine","Alexandra","Haley","Savannah","Nicole","Maria","Allison","Mackenzie","Stephanie","Brooke","Amanda","Ella","Faith","Keylee","Jenna","Andrea","Mary","Jordan","Gabrielle","Rebecca","Paige","Madeline","Kimberly","Trinity","Zoe","Michelle","Sara","Lily","Kylie","Alexa","Caroline","Vanessa","Amber","Angelina","Gabriella","Lillian","Riley","Sierra","Danielle","Leah","Jada","Autumn","Erin","Maya","Ariana","Audrey","Isabel","Sofia","Marissa","Bailey","Jacqueline","Melissa","Claire","Evelyn","Shelby","Jocelyn","Mariah","Avery","Leslie","Melanie","Arianna","Aaliyah"];
	_last = ["Smith","Johnson","Williams","Jones","Brown","Davis","Miller","Wilson","Moore","Taylor","Anderson","Thomas","Jackson","White","Harris","Martin","Thompson","Garcia","Martinez","Robinson","Clark","Rodriguez","Lewis","Lee","Walker","Hall","Allen","Young","King","Wright","Hill","Scott","Green","Adams","Baker","Nelson","Carter","Mitchell","Roberts","Turner","Philips","Campbell","Parker","Evans","Edwards","Collins","Morris","Rogers","Reed","Cook","Morgan","Bell","Murphy","Bailey","Cooper","Vander Galien"];

	_bio = "After digging through his pants you found his wallet and drivers license. They revealed the following info: <br/> <br/>";
	_name = _male call bis_fnc_selectRandom;
	_name = _bio + _name;
	_name = _name + " " + (_last select (floor random count _last));

	_locations = ["New York, New York","Chicago, Illinois","Madison, Wisconsin","Tampa Bay,Florida","Los Angeles, California","Sacramento, California","Dallas, Texas","Philadelphia, Pennsylvania","San Diego, California",["Randolph, WI","Victor, Colorado","Lola, Kansas","Chapman, Kansas","Paris, Kentucky","Great Falls, South Carolina","Spearfish, South Dakota","Pepin, Wisconsin","Souix Center, Iowa","Dyersville, Iowa","Halfway, Oregon"],["London, United Kingdom","Birmingham, United Kingdom","Leeds, United Kingdom"]];

	_location = _locations select (floor random (count _locations));
	while {(typeName _location) == "ARRAY"} do
	{
		_location = _location select (floor random (count _location));
	};

	_bio = _name + " was born in " + _location;


	_months = ["January","February","March","April","May","June","July","August","September","October","November","December"];
	_days = 30;
	_month = _months call BIS_fnc_selectRandom;
	if (_month == "February") then {_days = 28};
	_day = ceil random _days;
	_year = 1950 + (round random 50);
	if ((round random 100) < 50) then {
		_bio = _bio + " on " + _month + " " + (str _day) + " " + (str _year)+ ".  ";
	} else {
		if ((round random 100) < 50) then {
			_bio = _bio + " on " + _month + " " + (str _day) + " of the year " + (str _year)+ ".  ";}
		else 
		{
			_bio = _bio + " on " + _month + " " + (str _day) + " the year of our Lord " + (str _year)+ ".  ";
		};
	};
	if (_month == "July" && _day == 5 && _year == 1995) then {
		player sideChat "THIS PERSON'S BIRHTDAY IS THE SAME AS THE CREATOR, CRAIG VANDER GALIEN! YOU HAVE BEEN GRANTED A GIFT! Look Down!";
		_invObj = "GroundWeaponHolder" createVehicle (getPos player);
		_invObj setDir (random 360);
		_invObj setPos (getPos player);
		_invObj addWeaponCargoGlobal ["LMG_Mk200_pointer_F",1];
		_invObj addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer",5];
	};
	_bio
};
DZS_fn_tensify = {
	private ["_i","_verb","_tense","_verbs"];
	_verb = _this select 0;
	_tense = _this select 1;
	_verbs = ["is","was","will be"];

	_i = _verbs find _verb;

	switch (_tense) do
	{
		case "Present":
		{
			_i
		};
		case "Past":
		{
		_i = _i + 1;
		};
		case "Future":
		{
		_i = _i + 2;
		};
	};
	_verb = _verbs select _i;
	_verb
};
DZS_fn_buildingPart = {
	_section = ["side","corner"];
	_section = _section call BIS_fnc_selectRandom;
	_sides = ["north","south","east","west"];
	_corners = ["northeast","northwest","southeast","southwest"];
    switch (_section) do {
		case "side":
		{
			_message =  (_sides call BIS_fnc_selectRandom)+ _section;
		};
		case "corner":
		{
			_message = (_corners call BIS_fnc_selectRandom) + _section;
		};
	};
	_message
};
DZS_fn_processWallet = {
    private ["_cards","_num","_ran","_toRemove","_count","_counts","_ind","_message","_cash","_runs","_bio"];
    _runs = ceil (random 2);
	_ran = 0;
    _cards = [];
	while {_ran <= _runs} do {
		_num = random 100;
		if (_num <= 40) then {
			//Visa
			_num = random 100;
			if (_num <= 30) then {
                _cards = _cards + ["Standard Visa Card"];
			};
			if ((_num > 30) && (_num < 80)) then {
                _cards = _cards + ["Visa Rewards Card"];
			};
			if (_num > 80) then {
                _cards = _cards + ["Platinum Visa Rewards Card"];
			};
		};
		if ((_num <=80) && (_num > 40)) then {
			//MasterCard
			_num = random 100;
			if (_num <= 40) then {
                _cards = _cards + ["Standard MasterCard"];
			};
			if ((_num > 40) && (_num <= 70)) then {
                _cards = _cards + ["Gold MasterCard"];
			};
			if ((_num > 70) && (_num <= 80)) then {
                _cards = _cards + ["Platinum MasterCard"];
			};
			if ((_num > 80) && (_num <= 90)) then {
                _cards = _cards + ["World MasterCard"];
			};
			if (_num > 90) then {
                _cards = _cards + ["World Elite MasterCard"];
			};
		};
		if ((_num <= 90) && (_num > 80)) then {
		//Discover
            _cards = _cards + ["Discover Card"];
		};
		if ((_num <= 100) && (_num > 90)) then {
		//American Express
            _cards = _cards + ["American Express Card"];
		};
		_ran = _ran + 1;
	};
	_toRemove = [];
	_counts = [];
	{
		_card = _x;
		if (_card in _toRemove) then {_cards = _cards - [_card]};
        _count = {_card == _x} count _cards;
		if (_count > 1) then {_toRemove = _toRemove + [_card]};

		_counts = _counts + [_count];
	} forEach _cards;
	_message = "The following things are in his wallet:<br/>";
	{
		_c = _x;
		_ind = _cards find _c;
		_num = _counts select _ind;
		if (_num > 1) then {_c = _c + "s"};
		if (_num != 0)then {
			_message = _message + " " + (str _num) + ": " + _c+ ", <br/>";
		};
	} forEach _cards;
	_num = random 100;
	if (_num <= 50) then {_cash = round random 50};
	if (_num > 50 && _num <= 75) then {_cash = ((round random 50) + 50)};
	if (_num > 75 && _num <= 10) then {_cash = ((round random 100) + 100)};
	if (_num > 99) then {_cash = ((round random 500) + 500)};
	if (_num > 85 && _num <= 99) then {_cash = 0};
	if (isNil "_cash") then {_cash = round random 50};
	_message = _message + " and $" + (str _cash) + " in cash.";

	if ((random 100) < 80) then {
		_pocket = [" right "," left "," back left ", " back right "] call BIS_fnc_selectRandom;
		_state = [" brand new "," slightly used "," worn out "," well kept "] call BIS_fnc_selectRandom;
		_phone = ["Galaxy S4","Galaxy S3","Galaxy S2","Motorola X","Nexus 4","LG Optimus","Droid Maxx","HTC One","iPhone 4S","iPhone 5","Galaxy Note 2","Galaxy Note","iPhonen 4"] call BIS_fnc_selectRandom;
		_message = _message + "<br/>Also within his" + _pocket + "pocket he has a" + _state + _phone;
		/*if (random 100 < 30) then {
			_message = _message + ".  Despite its waning battery power you decide to check out his recent messages. They were to a man by the same last name. <br/> <br/>";
			_texts = ["Dude this shit is getting crazy, alright if I get out of town and head over to your house? You basically have an arsenal of weapons...","Hey! get over here, a military truck crashed outside, and we took their weapons"];
			_text = _texts call BIS_fnc_selectRandom;
			if (_text == _texts select 0) then {
			
			};
		};*/
	};
	
	_bio = [] call DZS_fn_processHuman;
	_message = _bio + " "+ _message;
	parseText _message;
	_message
};
DZS_fn_onDeath = {
	private ["_h","_unit","_message"];
	_unit = _this select 0;

	_h=getPosATL _unit nearObjects ["logic",0.1];
	if (count _h>0) then {deleteVehicle (_h select 0)};
	_message = [] call DZS_fn_processWallet;
	_unit setVariable ["Message", _message, true];
	[[[0,_unit],DZS_fn_addAction],"BIS_fnc_call",false,true] spawn BIS_fnc_MP;
	sleep 300;
	hideBody _unit;
	sleep 10;
	deleteVehicle _unit;

};
DZS_fn_processWorldObjects = {
_num = ((count townlist) * 5);
while {_it != _num} do {


};
};
DZS_fn_playerRestart = {
/*
Player Respawn script
by Craig
*/

private ["_townnumber","_town","_townpos","_group","_logic","_newPos","_building","_thing","_things","_checkVar","_dist","_dir","_pos","_check1","_check2","_armPos","_centPos","_unit","_towns"];
_unit = _this select 0;

    _towns= townlist;
	diag_Log "Picking Location";
    if (CVG_Playerstart == 50) then {
        if ((count _towns) != 0) then {
            _townnumber = floor (random (count _towns));
            _town = _towns select _townnumber;
            _townpos = (position _town);
            _group = createGroup sideLogic;
            _logic = _group createUnit ["Logic",_townpos, [], 100, "NONE"];
            _newPos = position _logic;
			if ((_newPos select 0) != 0) then {
            _unit setpos _newPos;
			} else {
			_unit setpos _townPos
			};
            diag_Log format ["location chosen, %1",_town];

        }
        else
        {

            if ((count buildings) != 0) then {
                _building = (round(random(count buildings)));
                _newpos = position (buildings select _building);
                _newpos = [_newPos,0,50,1,0,20,0] call BIS_fnc_findSafePos;
                _unit setpos _newpos;
            }
            else
            {
                _things = nearestObjects [_unit, [], 200000];
                if ((count _things) != 0) then {
                    _thing = (round(random(count _things)));
                    _newpos = position (_things select _thing);
                    _unit setpos _newpos;
                }
                else
                {
                    _newpos = [(random 1000),(random 1000)];
                    _unit setpos _newpos;
                };
            };
        };
		deleteVehicle _logic;
		if (surfaceIsWater _newPos) then {[] call DZS_fn_initPlayer} else {diag_Log format ["location chosen, %1",_newPos]};
    };

    if (CVG_playerstart == 100) then {
        _townnumber = floor (random (count _towns));
        _town = _towns select _townnumber;
        _townpos = getpos _town;
        _checkVar = 0;
        _armPos = getArray(configFile >> "CfgWorlds" >> worldName >> "Armory" >> "positionStart");
        _centPos = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
	        while {_checkVar < 1} do{
            _dist = 1500;
            _dir = random 360;
            _pos = [(_townpos select 0) + (sin _dir) * _dist, (_townpos select 1) + (cos _dir) * _dist, 0];
            _pos = [_pos,0,40,4,0,20,0] call BIS_fnc_findSafePos;
            _check1 = [_pos, _armPos] call arrayCompare;
            _check2 = [_pos,_centPos] call arrayCompare;
            if ((!_check1) && (!_check2) && ((_pos distance (getpos _town)) > 1000)) then { _checkVar = 1};
        };
        _unit setpos _pos;
        diag_Log format ["location chosen, %1",_townpos];
    };

    if (CVG_playerstart == 150) then {

        if (isServer) then {
				if (count _towns != 0) then {
				_townnumber = floor (random (count _towns));
				_town = _towns select _townnumber;
				newPos = (position _town);
			}
			else
			{
				if ((count buildings) != 0) then {
					_building = (round(random(count buildings)));
					_newpos = position (buildings select _building);
					newPos = [_newPos,0,50,1,0,20,0] call BIS_fnc_findSafePos;
				}
				else
				{
					_things = nearestObjects [_unit, [], 200000];
					if ((count _things) != 0) then {
						_thing = (round(random(count _things)));
						newPos = position (_things select _thing);
					}
					else
					{
						newPos = [(random 1000),(random 1000),0];
					};
				};
			};
		publicVariable "newPos";
        };
		waitUntil {!(isNil "newPos")};
		_unit setpos newPos;
        diag_Log format ["location chosen, %1",_newPos];
	};

	if (CVG_playerstart == 200) then {
		if (count _towns != 0) then {
			_town = _towns select (floor random count _towns);
			_builds = nearestObjects [position _town, ["house"], 500];
			DZS_bPos = [];
			_pos = 0;
			_build = _builds select 0;
			while {!(count DZS_bPos > 1) || isNil "_pos"|| (damage _build) == 1 || (typeOf _build) in blacklist || !(isNil {_build getVariable "Destroyed"})} do {
				Playerbuild = _builds call BIS_fnc_selectRandom;
				DZS_bPos = Playerbuild call fn_getBuildingPositions;
				_pos = DZS_bPos call BIS_fnc_selectRandom;
			};
		};
		DZS_bPos = DZS_bPos - [_pos];
		_veh = DZS_weapons call BIS_fnc_selectRandom;
		_wep = _veh select 0;
		_mag = _veh select 1;
		_bPos = DZS_bPos call BIS_fnc_selectRandom;
		_invObj = "GroundWeaponHolder" createVehicle _bPos;
		_invObj setPos _bPos;
		_invObj setDir (random 360);
		_invObj addMagazineCargoGlobal [_mag, (round random 4)];
		_invObj addWeaponCargoGlobal [_wep, 1];

		_clothes = DZS_milClothes + DZS_clothes;
		_cloth = _clothes call BIS_fnc_selectRandom;
		if (count nearestObjects [_bPos, ["GroundWeaponHolder"], 1] < 1) then {
			_invObj addItemCargoGlobal [_cloth, 1];
		} else {
			_bPos = DZS_bPos call BIS_fnc_selectRandom;
			_invObj = "GroundWeaponHolder" createVehicle _bPos;
			_invObj setPos _bPos;
			_invObj setDir (random 360);
			_invObj addItemCargoGlobal [_cloth, 1];
		};

		_unit setPos _pos;
		diag_Log format ["location chosen, %1",_pos];
	};
	DZS_playerInitDone = true;

	_newPos = getPos player;
	diag_log format ["Respawn: %1 respawned at %2",name _unit, _newpos];


	if (CVG_fog == 1) then {[player,100,11,30,3,7,-0.3,0.1,0.5,1,1,1,13,12,15,false,2,2.1,0.1,1,1,0,0,24] execFSM "impact_code\MPScenarios\Impact.Altis\mission\Fog.fsm"};


	if (CVG_playerItems == 2) then
	{
		_unit removeWeapon "itemMap";
		if (_unit hasWeapon "itemMap") then {
			diag_log "Removing Map Failed, Trying again";
			while {_unit hasWeapon "itemMap"} do {
				_unit addWeapon "itemMap";
				diag_log "Trying to remove Map again";
			};
		};
		diag_log "Map removed successfully";
	};

	if (CVG_ZombieTowns == 4) then {
		[] execVM "craigs_scripts\zombieGenerator.sqf";
	};

	/*
	if (CVG_playerWeapons == 1) then {
		if (CVG_debug) then {
			_unit sidechat "picking respawnweapon";
		};
		removeAllWeapons _unit;
		[_unit] call DZS_fn_randomUnitWeapons;

	};
	*/

	if (CVG_playerWeapons == 2) then
	{
		removeAllWeapons _unit;
		if (currentWeapon _unit != "") then {
			diag_log "First try at removing weapons failed. Trying again";
			while {currentWeapon _unit != ""} do {
				removeAllWeapons _unit;
				diag_log "Trying to remove weapons again";
			};
		};
		diag_log "Weapons Successfully Removed";
	};

	removeAllAssignedItems player;
	removeUniform player;
	removeVest player;
	removeAllWeapons player;
	player setcaptive true;
	
	_startMessages = ["After the worst dream of your life, one that was plagued by a constant fear of something evil chasing you, you awaken.","Your bed is slick with sweat, a direct result of the intense fear you were just feeling","It's time to face the day"];
	_message = _startMessages call BIS_fnc_selectRandom;
	[_message] call DZS_fn_displayInfo;
	
	player execVM "impact_code\MPScenarios\Impact.Altis\zombie_scripts\cly_z_victim.sqf";
	
	[] spawn DZS_fn_houseInfo;
};
DZS_fn_parseLoot = {
	//Item Name, Chance array [min,max]
	DZS_clothes =
	["U_B_HeliPilotCoveralls","U_B_Wetsuit","U_O_CombatUniform_ocamo","U_O_GhillieSuit","U_O_PilotCoveralls","U_O_Wetsuit","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite","U_C_Commoner1_1","U_C_Commoner1_2","U_C_Commoner1_3","U_Rangemaster","U_B_PilotCoveralls",
	"U_I_pilotCoveralls","U_I_HeliPilotCoveralls","U_Competitor","U_NikosBody","U_MillerBody","U_KerryBody","U_OrestesBody","U_AttisBody","U_AntigonaBody","U_IG_Menelaos","U_C_Novak","U_OI_Scientist","H_BandMask_khk","H_BandMask_reaper","H_BandMask_demon","H_Bandanna_camo","H_StrawHat_dark","H_Watchcap_camo","H_Hat_checker"
	];

	DZS_milClothes =
	["V_BandollierB_rgr","V_BandollierB_cbr","V_BandollierB_oli","V_TacVest_brn","V_TacVest_oli","V_TacVest_blk","V_TacVest_camo","V_TacVest_blk_POLICE","V_RebreatherIR","V_RebreatherIA","V_Rangemaster_belt","V_PlateCarrier1_cbr","V_PlateCarrier1_blk","V_PlateCarrier2_cbr","V_PlateCarrier2_blk","V_PlateCarrierGL_cbr","V_PlateCarrierGL_blk","V_ChestrigF_oli","V_HarnessO_gry","V_HarnessOGL_gry","V_HarnessOSpec_gry","V_HarnessOGL_brn","V_PlateCarrierSpec_cbr","V_TacVestIR_blk","V_HarnessOSpec_brn","V_TacVestCamo_khk","V_PlateCarrierIA2_dgtl","V_PlateCarrierIAGL_dgtl","U_B_CombatUniform_mcam_worn","U_B_CombatUniform_wdl","U_B_CombatUniform_wdl_tshirt","U_B_CombatUniform_wdl_vest","U_B_CombatUniform_sgg","U_B_CombatUniform_sgg_tshirt","U_B_CombatUniform_sgg_vest","U_B_SpecopsUniform_sgg","U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest","U_B_GhillieSuit",
	"U_O_CombatUniform_oucamo","U_O_SpecopsUniform_ocamo","U_O_SpecopsUniform_blk","U_O_OfficerUniform_ocamo","U_I_CombatUniform","U_I_CombatUniform_tshirt","U_I_CombatUniform_shortsleeve","U_I_GhillieSuit","U_I_OfficerUniform","U_I_Wetsuit","H_Shemag_tan","H_Beret_red","H_Beret_brn_SF",
	"H_Booniehat_mcamo","H_Booniehat_dirty","H_HelmetB_paint","H_Cap_blu_POLICE","H_Cap_tan","H_Cap_blk_CMMG","H_Cap_blk_Raven","H_PilotHelmetHeli_O"


	];

	DZS_attachments =
	[
	"muzzle_snds_H_MG",
	"muzzle_snds_L",
	"muzzle_snds_H",
	"optic_Hamr",
	"acc_pointer_IR",
	"optic_Holosight",
	"acc_flashlight",
	"optic_ACO_grn",
	"optic_Aco",
	"optic_Arco",
	"optic_SOS",
	"optic_MRCO",
	"muzzle_snds_B",
	"muzzle_snds_M",
	"Zasleh2"
	];

	DZS_mines = ["ATMine_Range_Mag","ClaymoreDirectionalMine_Remote_Mag","APERSMine_Range_Mag","APERSBoundingMine_Range_Mag","SLAMDirectionalMine_Wire_Mag","APERSTripMine_Wire_Mag"];
	DZS_throw = ["Chemlight_blue","Chemlight_red","Chemlight_yellow","Chemlight_green","SmokeShellBlue","SmokeShellOrange","SmokeShell","MiniGrenade","HandGrenade"];
	DZS_miscSpawn = ["Binocular","Laserdesignator","NVgoggles"];

	DZS_weapons =
	[
		["launch_NLAW_F",				 "NLAW_F",					[1,2]],
		["launch_RPG32_F",				 "RPG32_F",					[1,2]],
		["srifle_EBR_F",				 "20Rnd_762x51_Mag",		[1,5]],
		["srifle_EBR_ACO_F", 		 "20Rnd_762x51_Mag",		[1,5]],
		["srifle_EBR_ARCO_pointer_F",  "20Rnd_762x51_Mag",		[1,5]],
		["srifle_EBR_SOS_F", 		 "20Rnd_762x51_Mag",		[1,5]],
		["srifle_EBR_MRCO_pointer_F", "20Rnd_762x51_Mag",		[1,5]],
		["LMG_Mk200_F",   	"200Rnd_65x39_cased_Box_Tracer",		[1,3]],
		["LMG_Mk200_MRCO_F", "200Rnd_65x39_cased_Box_Tracer", [1,3]],
		["LMG_Mk200_pointer_F", "200Rnd_65x39_cased_Box_Tracer", [1,3]],
		["hgun_P07_F",					 "16Rnd_9x21_Mag",			[1,6]],
		["hgun_Rook40_F",			 "16Rnd_9x21_Mag",				[1,6]],
		["arifle_Katiba_ACO_F",		"30Rnd_65x39_caseless_green",	[1,5]],
		["arifle_Katiba_ACO_pointer_F","30Rnd_65x39_caseless_green",[1,5]],
		["arifle_Katiba_ARCO_F","30Rnd_65x39_caseless_green",[1,5]],
		["arifle_Katiba_C_ACO_F","30Rnd_65x39_caseless_green",[1,5]],
		["arifle_Katiba_C_ACO_pointer_F","30Rnd_65x39_caseless_green",[1,5]],
		["arifle_Katiba_C_F","30Rnd_65x39_caseless_green",[1,5]],
		["arifle_Katiba_F","30Rnd_65x39_caseless_green",[1,5]],
		["arifle_MXC_F",				 "30Rnd_65x39_caseless_mag", [1,5]],
		["arifle_MX_F",					"30Rnd_65x39_caseless_mag", [1,5]],
		["arifle_MXM_F",					"20Rnd_762x51_Mag",		[1,3]],
		["arifle_MX_ACO_pointer_F",	"30Rnd_65x39_caseless_mag", [1,5]],
		["arifle_MXC_Holo_F",			"30Rnd_65x39_caseless_mag", [1,5]],
		["arifle_MX_Holo_pointer_F","30Rnd_65x39_caseless_mag", [1,5]],
		["arifle_MX_SW_Hamr_pointer_F", "100Rnd_65x39_caseless_mag_Tracer",[1,3]],
		["arifle_SDAR_F",				"30Rnd_556x45_Stanag",		[1,4]],
		["arifle_TRG21_F",			"30Rnd_556x45_Stanag",	[1,5]],
		["arifle_TRG21_GL_ACO_pointer_F","30Rnd_556x45_Stanag",[1,5]],
		["arifle_TRG20_Holo_F",		"30Rnd_556x45_Stanag",	[1,5]],
		["arifle_TRG21_ARCO_pointer_F","30Rnd_556x45_Stanag",	[1,5]],
		["arifle_TRG20_Holo_F","30Rnd_556x45_Stanag",	[1,5]],
		["arifle_Mk20_ACO_F",				 "30Rnd_556x45_Stanag", [1,5]],
		["arifle_Mk20_F",				 "30Rnd_556x45_Stanag", [1,5]],
		["arifle_Mk20_ACO_pointer_F",				 "30Rnd_556x45_Stanag", [1,5]],
		["arifle_Mk20_GL_ACO_F",				 "30Rnd_556x45_Stanag", [1,5]],
		["arifle_Mk20_GL_F",				 "30Rnd_556x45_Stanag", [1,5]],
		["arifle_Mk20_Holo_F",				 "30Rnd_556x45_Stanag", [1,5]],
		["arifle_Mk20C_ACO_F",				 "30Rnd_556x45_Stanag", [1,5]],
		["arifle_Mk20C_F",				 "30Rnd_556x45_Stanag", [1,5]],
		["LMG_Zafir_F",				 "150Rnd_762x51_Box", [1,5]]
	];
};
DZS_fn_houseNotes = {
	_build = _this select 0;
	
	_Fight = [["There are signs of a battle","Bullet holes are scattered across the wall","The door has been destroyed by what looks like a battering ram","Windows have bullet holes in them","The door lock has been shot","Empty shell casings litter the inside near the windows","Bandages litter the floor inside"],["The house has been destroyed by explosives","Most of the structure has been annihilated","Battle damage has destroyed this building","Building destroyed in an attempt to stop apocalypse"]];
	_Fire = [["There are signs of a fire","There are scorch marks above the windows","The wallpaper has been burned to a crisp","The walls have been burned"],["Half the building was destroyed by fire","The building has collapsed by what looks like fire","This building has burned down","Nobody was around to put out the fire"]];
	_Age = [["The roof is caving in","The paint has completely fallen off","Siding has fallen off","Rain has damaged the inside of the building","There are plants growing inside"],["Rain damage and general age has collapsed the building","Some buildings just can't handle the apocalypse"]];
	_Defense = [["There is a barricade in front of the door","The windows are boarded","Metal bars cover the windows","This building has been barricaded like a prison","There are remains of a machine gun nest on the roof","A firing port is in every window","Craters from exploded mines litter the ground around the building"],[]];
	_Occupied = [["There are empty cans of food everywhere inside","A latrine is set up in the back","Solar panels are on the roof","Many pots and pans are on the roof","Empty boxes of cereal are inside"],[]];
	_mMessages = ["This building was just another cog in the military machine","This building was merely another cog in the military machine","Weapons were stored here during the outbreak, but they've undoubtedly been stolen, or have they?","Someone held out here","Someone held out in this building","The soldiers in here fought well, but now they have become the enemy"];

		_m1 = [_Fight,_Fire,_Age,_Defense,_Occupied];
		_m1 = _m1 call BIS_fnc_selectRandom;
		_m1 = _m1 select 0;
		_m1 = _m1 call BIS_fnc_selectRandom;
		_m1
};
DZS_fn_addAction = {
	_ruinBuild = _this select 0;
	if (_ruinBuild == 0) then {
		(_this select 1) addAction ["Investigate Body",{[_this select 0] call DZS_fn_displayInfo}];
	} else {
		_ruinBuild addAction ["Analyze building",{[_this select 0] call DZS_fn_displayInfo}];
	};
};

fnDone = true;
