#define _ARMA_

class CfgPatches
{
	class A3_Impact_server
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {};
	};
};
class CfgFunctions
{
	class Impact
	{
		class impact_code
		{
			class init
			{
				preInit = 1;
			};
			class postinit
			{
				postInit = 1;
			};
		};
	};
};
class CfgMissions
{
	class MPMissions
	{
		class Impact
		{
			briefingName = "Impact Altis";
			directory = "impact_code\MPScenarios\Impact.Altis";
			author = "SirBlastelot";
		};
	};
};