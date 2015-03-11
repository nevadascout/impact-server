class CfgPatches
{
	class impact__characters
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {};
		version = 0.1;
	};
};
class CfgVehicleClasses
{
	class Impact_Survivor_Shirt
	{
		displayName = "Impact Survivor";
	};
};
class CfgVehicles
{
	class Civilian_F;
	class Impact_Survivor: Civilian_F
	{
		scope = 2;
		displayName = "Impact Survivor";
		vehicleClass = "Impact_Survivor_Shirt";
		uniformAccessories[] = {};
		nakedUniform = "U_BasicBody";
		uniformClass = "Impact_Survivor_Basic";
		model = "\A3\Characters_F\Civil\c_poloshirt";
		weapons[] = {};
		magazines[] = {};
		respawnWeapons[] = {};
		respawnMagazines[] = {};
		items[] = {};
		linkeditems[] = {};
		respawnlinkeditems[] = {};
		};
	};
class cfgWeapons
{
	class Uniform_Base;
	class UniformItem;
	class Impact_Survivor_Basic: Uniform_Base
	{
		scope = 2;
		displayName = "Survivor Clothing";
		picture = "\A3\characters_f\data\ui\icon_U_BasicBody_ca.paa";
		model = "\A3\Characters_F\Common\Suitpacks\suitpack_civilian_F";
		class ItemInfo: UniformItem
		{
			uniformModel = "-";
			uniformClass = "Impact_Survivor";
			containerClass = "Supply20";
			mass = 40;
		};
	};
};