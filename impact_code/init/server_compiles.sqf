diag_log [diag_frameno, diag_ticktime, time, "Executing server_compiles.sqf"];

fn_getBuildingstospawnLoot = 			compile preProcessFileLineNumbers "Impact_code\compile\impact_functions\fn_getbuildingstospawnLoot.sqf"; 
fn_Lootdeleter = 						compile preProcessFileLineNumbers "Impact_code\compile\impact_functions\fn_lootdeleter.sqf";

diag_log [diag_frameno, diag_ticktime, time, "Executing server_compiles.sqf succes"];