class CfgPatches
{
	class impact_weapons_cfg
	{
		units[] = {};
		weapons[] = {};
		requiredaddons[] = {"A3_Data_F","A3_UI_F","A3_Anims_F","A3_Anims_F_Config_Sdr","A3_Weapons_F",};
		version = "0.1.0";
		author = "Impact Dev Team";
	};
};
class Mode_SemiAuto;
class Mode_Burst;
class Mode_FullAuto;
class CowsSlot;
class PointerSlot;
class SlotInfo;
class ItemCore;
class InventoryFlashLightItem_Base_F;
class InventoryMuzzleItem_Base_F;
class InventoryOpticsItem_Base_F;
class CfgVehicles{};
class CfgAmmo
{
	class Default;
	class BulletCore;
	class BulletBase;
	class B_9x19_Ball: BulletBase
	{
		hit = 7;
		cartridge = "FxCartridge_65_caseless";
		cost = 100;
		typicalSpeed = 390;
		airFriction = -0.0014;
		caliber = 1.7;
		deflecting = 45;
		model = "\A3\Weapons_f\Data\bullettracer\tracer_white";
		tracerScale = 0.5;
		tracerStartTime = 0.05;
		tracerEndTime = 1;
		nvgOnly = 1;
		visibleFire = 3;
		audibleFire = 5;
	};
};
class CfgCloudlets
{
	class Default;
	class IM_PistolCartridge1: Default
	{
		interval = 0.0595;
		circleRadius = 0;
		circleVelocity[] = {0,0,0};
		particleShape = "\A3\weapons_f\ammo\cartridge_small.p3d";
		particleFSNtieth = 1;
		particleFSIndex = 0;
		particleFSFrameCount = 1;
		particleFSLoop = 0;
		angleVar = 0;
		animationName = "";
		particleType = "SpaceObject";
		timerPeriod = 0.75;
		lifeTime = 20;
		moveVelocity[] = {"-directionX * 3","- directionY * 3","- directionZ * 3"};
		rotationVelocity = 1;
		weight = 6;
		volume = 1;
		rubbing = 0.0;
		size[] = {1.1};
		color[] = {{ 0.9,0.9,0.9,1 }};
		animationSpeed[] = {1000};
		randomDirectionPeriod = 0.1;
		randomDirectionIntensity = 0.05;
		onTimerScript = "";
		beforeDestroyScript = "";
		destroyOnWaterSurface = 1;
		bounceOnSurface = 0.25;
		bounceOnSurfaceVar = 0.2;
		blockAIVisibility = 0;
		sizeCoef = 1;
		colorCoef[] = {1,1,1,1};
		animationSpeedCoef = 1;
		position[] = {"positionX","positionY","positionZ"};
		lifeTimeVar = 0;
		positionVar[] = {0,0,0};
		MoveVelocityVar[] = {0.25,0.25,0.25};
		rotationVelocityVar = 5;
		sizeVar = 0;
		colorVar[] = {0,0,0,0};
		randomDirectionPeriodVar = 0;
		randomDirectionIntensityVar = 0;
	};
	class IM_PistolAmmoCloud1: Default
	{
		interval = 0.005;
		circleRadius = 0;
		circleVelocity[] = {0,0,0};
		particleShape = "\A3\data_f\ParticleEffects\Universal\Universal";
		particleFSNtieth = 16;
		particleFSIndex = 12;
		particleFSFrameCount = 8;
		particleFSLoop = 1;
		angleVar = 0.5;
		animationName = "";
		particleType = "Billboard";
		timerPeriod = 1;
		lifeTime = 0.45;
		moveVelocity[] = {"-0.15*directionX","-0.15*directionY","-0.15*directionZ"};
		rotationVelocity = 1;
		weight = 0.053;
		volume = 0.04;
		rubbing = 0.1;
		size[] = {0.25,0.5};
		color[] = {{ 0.1,0.1,0.1,0.3 },{ 0.1,0.1,0.1,0.15 },{ 0.1,0.1,0.1,0.06 },{ 0.1,0.1,0.1,0.01 }};
		animationSpeed[] = {1.2};
		randomDirectionPeriod = 0.1;
		randomDirectionIntensity = 0.08;
		onTimerScript = "";
		beforeDestroyScript = "";
		destroyOnWaterSurface = 1;
		blockAIVisibility = 0;
		sizeCoef = 0.2;
		colorCoef[] = {1,1,1,0.6};
		animationSpeedCoef = 1;
		position[] = {"positionX","positionY","positionZ"};
		lifeTimeVar = 0;
		positionVar[] = {0,0,0};
		MoveVelocityVar[] = {0.03,0.03,0.03};
		rotationVelocityVar = 20;
		sizeVar = 0;
		colorVar[] = {0,0,0,0};
		randomDirectionPeriodVar = 0;
		randomDirectionIntensityVar = 0;
	};
	class IM_SmokeTrail1: Default
	{
		interval = 0.005;
		circleRadius = 0;
		circleVelocity[] = {0,0,0};
		particleShape = "\A3\data_f\ParticleEffects\Universal\Refract";
		particleFSNtieth = 1;
		particleFSIndex = 0;
		particleFSFrameCount = 1;
		particleFSLoop = 0;
		angleVar = 1;
		animationName = "";
		particleType = "Billboard";
		timerPeriod = 1.1;
		lifeTime = 3;
		moveVelocity[] = {"-0.15*directionX","-0.15*directionY","-0.15*directionZ"};
		rotationVelocity = 1;
		weight = 1.2;
		volume = 1.0;
		rubbing = 0.1;
		size[] = {0.1,0.15};
		color[] = {{ 0.06,0.06,0.06,0.32 },{ 0.3,0.3,0.3,0.28 },{ 0.3,0.3,0.3,0.25 },{ 0.3,0.3,0.3,0.22 },{ 0.3,0.3,0.3,0.1 }};
		colorCoef[] = {1,1,1,1};
		animationSpeed[] = {2,1};
		randomDirectionPeriod = 0.1;
		randomDirectionIntensity = 0.05;
		onTimerScript = "";
		beforeDestroyScript = "";
		destroyOnWaterSurface = 1;
		blockAIVisibility = 0;
		sizeCoef = 0.5;
		animationSpeedCoef = 1;
		position[] = {"positionX","positionY","positionZ"};
		lifeTimeVar = 0;
		positionVar[] = {0,0,0};
		MoveVelocityVar[] = {0.0,0.0,0.0};
		rotationVelocityVar = 20;
		sizeVar = 0.05;
		colorVar[] = {0,0,0,0};
		randomDirectionPeriodVar = 0;
		randomDirectionIntensityVar = 0;
	};
};
class IM_PistolCartridge
{
	class IM_PistolCartridge
	{
		simulation = "particles";
		type = "IM_PistolCartridge1";
		position[] = {0,0,0};
		intensity = 1;
		interval = 1;
		lifeTime = 0.05;
	};
};
class IM_PistolAmmoCloud
{
	class IM_PistolAmmoCloud
	{
		simulation = "particles";
		type = "IM_PistolAmmoCloud1";
		position[] = {0,0,0};
		intensity = 1;
		interval = 1;
		lifeTime = 0.05;
	};
};
class RH_SmokeTrail
{
	class RH_SmokeTrail
	{
		simulation = "particles";
		type = "RH_SmokeTrail1";
		position[] = {0,0,0};
		intensity = 1;
		interval = 1;
		lifeTime = 0.05;
	};
};
class CfgMagazines
{
	class Default;
	class CA_Magazine;
	class 30Rnd_556x45_Magazine: CA_Magazine
	{
		scope = 2;
		displayName = "30Rnd 5.56x45mm Magazine";
		picture = "\impact_weapons\icons\gear_l85a2_mag_x_ca.paa";
		ammo = "B_556x45_Ball";
		model = "\impact_weapons\models\L85A2_mag.p3d";
		count = 30;
		initSpeed = 700;
		descriptionshort = "Used in: L85A2, Steyr AUG";
	};	
	class 15Rnd_9x19_Magazine: CA_Magazine
	{
		scope = 2;
		displayName = "15Rnd 9x19mm Magazine";
		picture = "\impact_weapons\icons\m9_mag_x_ca.paa";
		ammo = "B_9x19_Ball";
		model = "\impact_weapons\models\M9_mag.p3d";	
		count = 15;
		initSpeed = 390;
		descriptionshort = "Used in: M9";
	};
};
class CfgWeapons
{
	class Rifle;
	class UGL_F;
	class Rifle_Base_F: Rifle
	{
		class WeaponSlotsInfo;
		class GunParticles;
	};
	class Pistol;
	class Pistol_Base_F: Pistol
	{
		class WeaponSlotsInfo;
		class GunParticles;
	};
	class IM_Pistol_Base_F: Pistol_Base_F
	{
		bullet1[] = {"A3\sounds_f\weapons\shells\9mm\metal_9mm_01",1.1,1,15};
		bullet2[] = {"A3\sounds_f\weapons\shells\9mm\metal_9mm_02",1.1,1,15};
		bullet3[] = {"A3\sounds_f\weapons\shells\9mm\metal_9mm_03",1.1,1,15};
		bullet4[] = {"A3\sounds_f\weapons\shells\9mm\metal_9mm_04",1.1,1,15};
		bullet5[] = {"A3\sounds_f\weapons\shells\9mm\dirt_9mm_01",1.1,1,15};
		bullet6[] = {"A3\sounds_f\weapons\shells\9mm\dirt_9mm_02",1.1,1,15};
		bullet7[] = {"A3\sounds_f\weapons\shells\9mm\dirt_9mm_03",1.1,1,15};
		bullet8[] = {"A3\sounds_f\weapons\shells\9mm\dirt_9mm_04",1.1,1,15};
		bullet9[] = {"A3\sounds_f\weapons\shells\9mm\grass_9mm_01",1.1,1,15};
		bullet10[] = {"A3\sounds_f\weapons\shells\9mm\grass_9mm_02",1.1,1,15};
		bullet11[] = {"A3\sounds_f\weapons\shells\9mm\grass_9mm_03",1.1,1,15};
		bullet12[] = {"A3\sounds_f\weapons\shells\9mm\grass_9mm_04",1.1,1,15};
		soundBullet[] = {"bullet1",0.083,"bullet2",0.083,"bullet3",0.083,"bullet4",0.083,"bullet5",0.083,"bullet6",0.083,"bullet7",0.083,"bullet8",0.083,"bullet9",0.083,"bullet10",0.083,"bullet11",0.083,"bullet12",0.083};
		class GunParticles
		{
			class FirstEffect
			{
				effectName = "PistolCloud";
				positionName = "Usti hlavne";
				directionName = "Konec hlavne";
			};
			class EjectEffect
			{
				positionName = "Nabojnicestart";
				directionName = "Nabojniceend";
				effectName = "IM_PistolCartridge";
			};
			class PistolAmmoCloud
			{
				positionName = "Nabojnicestart";
				directionName = "Nabojniceend";
				effectName = "IM_PistolAmmoCloud";
			};
			class SmokeEffect
			{
				positionName = "usti hlavne";
				directionName = "usti hlavne";
				effectName = "IM_SmokeTrail";
			};
		};
	};
	class L85A2: Rifle_Base_F
	{
		scope = 2;
		model = "\impact_weapons\models\L85A2.p3d";
		picture = "\impact_weapons\icons\gear_l85a2_x_ca.paa";
		inertia = 0.5;
		magazines[] = {"30Rnd_556x45_Magazine"};
		drySound[] = {"A3\sounds_f\weapons\Other\dry_1",0.56234133,1,10};
		handAnim[] = {"OFP2_ManSkeleton","\impact_weapons\anim\L85A2_HandAnim.rtm"};
		maxZeroing = 400;
		reloadAction = "GestureReloadL85A2";
		descriptionShort = "Assualt Rifle";
		displayName = "L85A2";
		reloadMagazineSound[] = {"A3\sounds_f\weapons\reloads\new_MX",1.0,1,30};
		class WeaponSlotsInfo: WeaponSlotsInfo
		{
			class MuzzleSlot: SlotInfo
			{
				linkProxy = "\A3\data_f\proxies\weapon_slots\MUZZLE";
				compatibleItems[] = {};
			};
			class CowsSlot
			{

				compatibleItems[] = {};
			};
			class PointerSlot
			{
				compatibleItems[] = {};
			};
		};	
		changeFiremodeSound[] = {"A3\sounds_f\weapons\closure\firemode_changer_2",0.17782794,1,5};
		modes[] = {"Single","FullAuto"};
		class Single: Mode_SemiAuto
		{
		sounds[] = {0,1};
		class BaseSoundModeType
			{
				weaponSoundEffect = "DefaultRifle";
				closure1[] = {"A3\sounds_f\weapons\closure\closure_rifle_6",0.3,1,10};
				closure2[] = {"A3\sounds_f\weapons\closure\closure_rifle_7",0.3,1,10};
				soundClosure[] = {"closure1",0.5,"closure2",0.5};
			};
			class 0: BaseSoundModeType
			{
				begin1[] = {"\impact_weapons\sounds\Fire1",1.0,1,1200};
				begin2[] = {"\impact_weapons\sounds\Fire2",1.0,1,1200};
				begin3[] = {"\impact_weapons\sounds\Fire3",1.0,1,1200};
				begin4[] = {"\impact_weapons\sounds\Fire4",1.0,1,1200};
				soundBegin[] = {"begin1",0.5,"begin2",0.5,"begin3",0.5,"begin4",0.5};
			};
			class 1: BaseSoundModeType
			{
				begin1[] = {"A3\sounds_f\weapons\silenced\silent-18",0.7943282,1,100};
				begin2[] = {"A3\sounds_f\weapons\silenced\silent-19",0.7943282,1,100};
				begin3[] = {"A3\sounds_f\weapons\silenced\silent-11",0.7943282,1,100};
				soundBegin[] = {"begin1",0.333,"begin2",0.333,"begin3",0.333};
			};
			reloadTime = 0.096;
			recoil = "recoil_single_mx";
			recoilProne = "recoil_single_prone_mx";
			dispersion = 0.00087;
		};
		class FullAuto: Mode_FullAuto
		{
		sounds[] = {0,1};
			class BaseSoundModeType
			{
				weaponSoundEffect = "DefaultRifle";
				closure1[] = {"A3\sounds_f\weapons\closure\closure_rifle_6",0.3,1,10};
				closure2[] = {"A3\sounds_f\weapons\closure\closure_rifle_7",0.3,1,10};
				soundClosure[] = {"closure1",0.5,"closure2",0.5};
			};
			class 0: BaseSoundModeType
			{
				begin1[] = {"\impact_weapons\sounds\Fire1",1.0,1,1200};
				begin2[] = {"\impact_weapons\sounds\Fire2",1.0,1,1200};
				begin3[] = {"\impact_weapons\sounds\Fire3",1.0,1,1200};
				begin4[] = {"\impact_weapons\sounds\Fire4",1.0,1,1200};
				soundBegin[] = {"begin1",0.5,"begin2",0.5,"begin3",0.5,"begin4",0.5};
			};
			class 1: BaseSoundModeType
			{
				begin1[] = {"A3\sounds_f\weapons\silenced\silent-18",0.7943282,1,100};
				begin2[] = {"A3\sounds_f\weapons\silenced\silent-19",0.7943282,1,100};
				begin3[] = {"A3\sounds_f\weapons\silenced\silent-11",0.7943282,1,100};
				soundBegin[] = {"begin1",0.333,"begin2",0.333,"begin3",0.333};
			};
			reloadTime = 0.096;
			recoil = "recoil_auto_mx";
			recoilProne = "recoil_auto_prone_mx";
			dispersion = 0.00087;
		};	
	};
	class Steyr_AUG: Rifle_Base_F
	{
		scope = 2;
		model = "\impact_weapons\models\AUGA1.p3d";
		picture = "\impact_weapons\icons\gear_auga1_x_ca";
		inertia = 0.4;
		magazines[] = {"30Rnd_556x45_Magazine"};
		drysound[] = {"\impact_weapons\sounds\AUG_empty",1,1,10};
		handanim[] = {"OFP2_ManSkeleton","\impact_weapons\anim\AUG_Handanim.rtm"};
		maxZeroing = 400;
		reloadAction = "GestureReloadAUG";
		descriptionShort = "Assault Rifle";
		displayName = "Steyr AUG";
		reloadMagazineSound[] = {"\impact_weapons\sounds\AUG_reload",1,1,30};
		class WeaponSlotsInfo: WeaponSlotsInfo
		{
			class MuzzleSlot: SlotInfo
			{
				linkProxy = "\A3\data_f\proxies\weapon_slots\MUZZLE";
				compatibleItems[] = {};
			};
			class CowsSlot
			{
				compatibleItems[] = {};
			};
			class PointerSlot
			{
				compatibleItems[] = {};
			};
		};	
		changeFiremodeSound[] = {"A3\sounds_f\weapons\closure\firemode_changer_2",0.17782794,1,5};
		modes[] = {"Single","FullAuto"};
		class Single: Mode_SemiAuto
		{
			sounds[] = {0,1};
			class BaseSoundModeType
			{
				weaponSoundEffect = "DefaultRifle";
				closure1[] = {"\impact_weapons\sounds\AUG_closure",1,1,10};
				closure2[] = {"\impact_weapons\sounds\AUG_closure",1,1,10};
				soundClosure[] = {"closure1",0.5,"closure2",0.5};
			};
			class 0: BaseSoundModeType
			{
				begin1[] = {"\impact_weapons\sounds\AUG_fire",1,1,1200};
				begin2[] = {"\impact_weapons\sounds\AUG_fire",1,1,1200};
				begin3[] = {"\impact_weapons\sounds\AUG_fire",1,1,1200};
				soundBegin[] = {"begin1",0.33,"begin2",0.33,"begin3",0.34};
			};
			class 1: BaseSoundModeType
			{
				begin1[] = {"\impact_weapons\sounds\AUG_sil",1,1,200};
				begin2[] = {"\impact_weapons\sounds\AUG_sil",1,1,200};
				soundBegin[] = {"begin1",0.5,"begin2",0.5};
			};
			reloadTime = 0.091;
			recoil = "recoil_auto_primary_3outof10";
			recoilProne = "recoil_auto_primary_prone_3outof10";
			dispersion = 0.000308356;
		};
		class FullAuto: Mode_FullAuto
		{
			sounds[] = {0,1};
			class BaseSoundModeType
			{
				weaponSoundEffect = "DefaultRifle";
				closure1[] = {"\impact_weapons\sounds\AUG_closure",1,1,10};
				closure2[] = {"\impact_weapons\sounds\AUG_closure",1,1,10};
				soundClosure[] = {"closure1",0.5,"closure2",0.5};
			};
			class 0: BaseSoundModeType
			{
				begin1[] = {"\impact_weapons\sounds\AUG_fire",1,1,1200};
				begin2[] = {"\impact_weapons\sounds\AUG_fire",1,1,1200};
				begin3[] = {"\impact_weapons\sounds\AUG_fire",1,1,1200};
				soundBegin[] = {"begin1",0.33,"begin2",0.33,"begin3",0.34};
			};
			class 1: BaseSoundModeType
			{
				begin1[] = {"\impact_weapons\sounds\AUG_sil",1,1,200};
				begin2[] = {"\impact_weapons\sounds\AUG_sil",1,1,200};
				soundBegin[] = {"begin1",0.5,"begin2",0.5};
			};
			reloadTime = 0.091;
			recoil = "recoil_auto_mk20";
			recoilProne = "recoil_auto_prone_mk20";
			dispersion = 0.000308356;
		};		
	};
	class M9: IM_Pistol_Base_F
	{
		scope = 2;
		model = "\impact_weapons\models\M9.p3d";
		modelOptics = "-";
		optics = 1;
		distanceZoomMin = 56;
		distanceZoomMax = 56;
		class WeaponSlotsInfo: WeaponSlotsInfo
		{
			mass = 20;
			class MuzzleSlot: SlotInfo
			{
				linkProxy = "\A3\data_f\proxies\weapon_slots\MUZZLE";
				compatibleItems[] = {};
			};
			class CowsSlot{};
			class PointerSlot: SlotInfo
			{
				linkProxy = "\A3\data_f\proxies\weapon_slots\SIDE";
				displayName = "$STR_A3_PointerSlot0";
				compatibleItems[] = {};
			};
		};
		dexterity = 1.75;
		displayName = "M9 Pistol";
		picture = "\impact_weapons\icons\m9_x_ca.paa";
		reloadMagazineSound[] = {"\impact_weapons\sounds\M9_reload",1.0,1,30};
		drySound[] = {"A3\sounds_f\weapons\other\dry1",0.7,1,20};
		magazines[] = {"15Rnd_9x19_Magazine"};
		inertia = 0.1;
		modes[] = {"Single"};
		class Single: Mode_SemiAuto
		{
			sounds[] = {"StandardSound","SilencedSound"};
			class BaseSoundModeType
			{
				closure1[] = {"A3\sounds_f\weapons\closure\closure_handgun_4",1.0,1,30};
				closure2[] = {"A3\sounds_f\weapons\closure\closure_handgun_5",1.0,1,30};
				soundClosure[] = {"closure1",0.5,"closure2",0.5};
				weaponSoundEffect = "DefaultHandgun";
			};
			class StandardSound: BaseSoundModeType
			{
				begin1[] = {"impact_weapons\sounds\M9_fire",1.0,1,700};
				begin2[] = {"impact_weapons\sounds\M9_fire",1.0,1,700};
				soundBegin[] = {"begin1",0.5,"begin2",0.5};
			};
			class SilencedSound: BaseSoundModeType
			{
				begin1[] = {"A3\sounds_f\weapons\silenced\silent-07",1.0,1,200};
				begin2[] = {"A3\sounds_f\weapons\silenced\silent-08",1.0,1,200};
				soundBegin[] = {"begin1",0.5,"begin2",0.5};
			};
			soundContinuous = 0;
			dispersion = 0.011;
			reloadTime = 0.05;
			recoil = "recoil_pistol_light";
			recoilProne = "recoil_prone_pistol_light";
		};
	};
};
class CfgMovesBasic
{
	class Default;
	class ManActions
	{
		GestureReloadL85A2[] = {"GestureReloadL85A2","Gesture"};
		GestureReloadL85A2Prone[] = {"GestureReloadL85A2Prone","Gesture"};
		GestureReloadAUG[] = {"GestureReloadAUG","Gesture"};
	};
	class Actions
	{
		class NoActions: ManActions
		{
			GestureReloadL85A2[] = {"GestureReloadL85A2","Gesture"};
			GestureReloadAUG[] = {"GestureReloadAUG","Gesture"};
		};
		class RifleBaseStandActions;
		class RifleProneActions: RifleBaseStandActions
		{
			GestureReloadL85A2[] = {"GestureReloadL85A2Prone","Gesture"};
			GestureReloadAUG[] = {"GestureReloadAUGProne","Gesture"};
		};
	};
};
class CfgGesturesMale
{
	class Default;
	class States
	{
		class GestureReloadL85A2: Default
		{
			file = "\impact_weapons\anim\L85A2_Reload_anim.rtm";
			looped = 0;
			speed = 0.3;
			mask = "handsWeapon";
			canPullTrigger = 0;
			rightHandIKBeg = 0;
			rightHandIKEnd = 0;
			rightHandIKCurve[] = {0,1};
			leftHandIKBeg = 1;
			leftHandIKEnd = 1;
			leftHandIKCurve[] = {0,1,0.016667,1,0.02459,0,0.983333,0,0.991667,1};
		};
		class GestureReloadL85A2Prone: Default
		{
			file = "\impact_weapons\anim\L85A2_Reload_anim_prone.rtm";
			looped = 0;
			speed = 0.3;
			mask = "handsWeapon";
			canPullTrigger = 0;
			rightHandIKBeg = 0;
			rightHandIKEnd = 0;
			rightHandIKCurve[] = {0,1};
			leftHandIKBeg = 1;
			leftHandIKEnd = 1;
			leftHandIKCurve[] = {0,1,0.016667,1,0.02459,0,0.983333,0,0.991667,1};
		};
		class GestureReloadAUG: Default
		{
			file = "\impact_weapons\anim\AUG_Reload_anim.rtm";
			speed = 0.18181819;
			looped = 0;
			mask = "handsWeapon";
			headBobStrength = 0.22;
			headBobMode = 2;
			rightHandIKCurve[] = {1};
			leftHandIKBeg = 1;
			leftHandIKEnd = 1;
			leftHandIKCurve[] = {0,1,0.036363635,0,0.8363636,0,0.8727273,1};
		};
		class GestureReloadAUGprone: Default
		{
			file = "\impact_weapons\anim\AUG_Reload_anim_prone.rtm";
			speed = 0.18181819;
			looped = 0;
			mask = "handsWeapon";
			headBobStrength = 0.22;
			headBobMode = 2;
			rightHandIKCurve[] = {1};
			leftHandIKBeg = 1;
			leftHandIKEnd = 1;
			leftHandIKCurve[] = {0,1,0.036363635,0,0.8363636,0,0.8727273,1};
		};
	};
};

