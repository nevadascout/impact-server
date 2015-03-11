diag_log [diag_frameno, diag_ticktime, time, "Executing fn_postinit.sqf"];

call compile preprocessFileLineNumbers "impact_code\init\server_init.sqf";

diag_log [diag_frameno, diag_ticktime, time, "Executing fn_postinit.sqf succes"];
