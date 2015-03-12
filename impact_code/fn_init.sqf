diag_log [diag_frameno, diag_ticktime, time, "Executing fn_init.sqf"];

call compile preprocessFileLineNumbers "impact_code\init\server_compiles.sqf";

diag_log [diag_frameno, diag_ticktime, time, "Executing fn_init.sqf succes"];