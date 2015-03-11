diag_log [diag_frameno, diag_ticktime, time, "Executing server_init.sqf"];

call compile preprocessFileLineNumbers "impact_code\init\server_variables.sqf";
execVM "Impact_code\compile\impact_loot\lootspawner.sqf";

diag_log [diag_frameno, diag_ticktime, time, "Executing server_init.sqf succes"];