//Victim-based zombie aggro script

_unit = _this;
_maxaggro = CLY_maxaggroradius max CLY_altmaxaggroradius;

sleep 5;
//player sideChat "here we go:";
_unit setVariable ["zombievictim", true, true];

while {local _unit && alive _unit} do
{
	//player sideChat "here we go1:";
	if (_unit getVariable ["zombievictim", false] && getPos vehicle _unit select 2 < 10 && _unit getVariable ["zombievictim", true]) then
	{
		//player sideChat "here we go2:";
		//Find out aggro multiplier
		_vehicle = vehicle _unit;
		_isvehicle = _vehicle != _unit && isEngineOn _vehicle && getNumber (configFile / "CfgVehicles" / (typeOf _vehicle) / "isbicycle") == 0;
		_unarmed = currentWeapon _vehicle == "" && !_isvehicle;
		_multiplier = 1;
		if (_isvehicle) then
		{
			_multiplier = CLY_vehicleaggromultiplier;
		};
		if (_unarmed) then
		{
			_multiplier = CLY_unarmedaggromultiplier;
		};
		
		//Check for zombies that can attack
		_units = getPosATL _vehicle nearEntities ["Man", _maxaggro * _multiplier];
		{
				//player sideChat "here we go:3";
				_zombie = _x;
				_victim = _zombie getVariable ["victim", objNull];
				if (_victim != _vehicle) then
				{
				//player sideChat "here we go4:";
					if (_victim != _unit) then
					{
					//player sideChat "here we go5:";
						if ((_zombie knowsAbout _vehicle >= CLY_minaggroknowsabout ||!(_zombie getVariable "zombietype" in ["normal", "surprise", "passive", "creeper", "walker", "armored", "slow armored"]) || _zombie getVariable "horde")) then
						{
						//player sideChat "here we go:6";
							_dist = _vehicle distance _zombie;
							if (_dist < (_zombie getVariable "aggroradius") * _multiplier) then
							{
							//player sideChat "here we go7:";
								if (isNull _victim) then
								{
								//player sideChat "here we go:8";
									_zombie setVariable ["victim", _unit, true];
								}
								else
								{
								//player sideChat "here we go:9";
									if (_dist < (_zombie distance vehicle _victim) * 0.5) then
									{
									//player sideChat "here we go:10";
										_zombie setVariable ["victim", _unit, true];
									};
								};
							};
						};
					};
				};
			
		} forEach _units;
	};
	sleep 1;
};