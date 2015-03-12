DZS_JIP = if (time > 0) then { true } else { false };  
fnDone = false;
[] execVM "impact_code\MPScenarios\Impact.Altis\mission\functions.sqf";

waitUntil {fnDone};

if (local player) then { 
   player enableFatigue false; 
   player addMPEventhandler ["MPRespawn", {player enableFatigue false}]; 
};

CVG_Debug = true;
CVG_Horde = false;
[] call DZS_fn_parseLoot;
[] execVM "impact_code\MPScenarios\Impact.Altis\mission\DZSinit.sqf";
[] execVM  "impact_code\MPScenarios\Impact.Altis\zombie_scripts\zombiesinit.sqf";
[] exec "impact_code\MPScenarios\Impact.Altis\zombie_scripts\zombiesinit.sqs";