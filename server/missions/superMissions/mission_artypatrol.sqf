// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_artyPatrol.sqf
//	@file Author: WitchDoctor [GGO]

if (!isServer) exitwith {};
#include "superMissionDefines.sqf";

private ["_convoyVeh","_veh1","_veh2","_veh3","_veh4","_veh5","_veh6","_veh7","_veh8","_veh9","_veh10","_createVehicle1","_createVehicle2","_createVehicle3","_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints",
	"_box1", "_box2", "_box3", "_box4", "_box5", "_box6", "_box7", "_box8", "_box9", "_smoke1", "_boxesArray", "_cashpile", "_cashamount", "_cash"];
 
_setupVars =
{
	_missionType = "Artillery Patrol";
	_locationsArray = artyConvoyPaths;
};

_setupObjects =
{
	private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	// Pick the vehicles for the patrol. Only one set at the moment. Will add more later.
	_convoyVeh =
	[
		//NATO Patrols
		["B_APC_Wheeled_01_cannon_F", "B_Heli_Attack_01_F", "B_MBT_01_TUSK_F", "B_APC_Tracked_01_AA_F", "B_Heli_Light_01_armed_F", "B_MBT_01_mlrs_F", "B_APC_Tracked_01_AA_F", "B_Heli_Light_01_armed_F", "B_MBT_01_TUSK_F", "B_APC_Tracked_01_CRV_F"], // Light Patrol
		

		//CSAT Patrols
		["O_APC_Wheeled_02_rcws_F", "O_Heli_Attack_02_F", "O_MBT_02_cannon_F", "O_APC_Tracked_02_AA_F", "O_Heli_Light_02_F", "B_MBT_01_arty_F", "O_APC_Tracked_02_AA_F", "O_Heli_Light_02_F", "O_MBT_02_cannon_F", "O_APC_Tracked_02_cannon_F"],

		//AAF Patrols
		["I_APC_Wheeled_03_cannon_F", "B_Heli_Attack_01_F", "I_MBT_03_cannon_F", "O_APC_Tracked_02_AA_F", "I_Heli_light_03_F", "B_MBT_01_arty_F", "O_APC_Tracked_02_AA_F", "I_Heli_light_03_F", "I_MBT_03_cannon_F", "O_APC_Tracked_02_cannon_F"]

		
	] call BIS_fnc_selectRandom;

	_veh1 = _convoyVeh select 0;
	_veh2 = _convoyVeh select 1;
	_veh3 = _convoyVeh select 2;
	_veh4 = _convoyVeh select 3;
	_veh5 = _convoyVeh select 4;
	_veh6 = _convoyVeh select 5;
	_veh7 = _convoyVeh select 6;
	_veh8 = _convoyVeh select 7;
	_veh9 = _convoyVeh select 8;
	_veh10 = _convoyVeh select 9;
	

	_createVehicle1 = {
		private ["_type","_position","_direction","_vehicle","_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;
		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInCommander _vehicle;
		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInCargo [_vehicle, 0];
		_vehicle setVehicleLock "UNLOCKED";  // force vehicles to be unlocked
		_vehicle setVariable ["R3F_LOG_disabled", false, true]; // force vehicles to be unlocked
		_vehicle
	};

	_createVehicle2 = {
		private ["_type","_position","_direction","_vehicle","_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "FLY"];
		[_vehicle] call vehicleSetup;

		_vel = [velocity _vehicle, -(_direction)] call BIS_fnc_rotateVector2D; // Added to make it fly
		_vehicle setDir _direction;
		_vehicle setVelocity _vel; // Added to make it fly
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;
		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInGunner _vehicle;
		_vehicle setVehicleLock "UNLOCKED";  // force vehicles to be unlocked
		_vehicle setVariable ["R3F_LOG_disabled", false, true]; // force vehicles to be unlocked
		_vehicle
	};

		_createVehicle3 = {
		private ["_type","_position","_direction","_vehicle","_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;
		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInCargo [_vehicle, 0];
		_vehicle setVehicleLock "UNLOCKED";  // force vehicles to be unlocked
		_vehicle setVariable ["R3F_LOG_disabled", false, true]; // force vehicles to be unlocked
		_vehicle
	};
	
    	_createVehicle4 = {
		private ["_type","_position","_direction","_vehicle","_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;
		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInCargo [_vehicle, 0];
		_vehicle setVehicleLock "UNLOCKED";  // force vehicles to be unlocked
		_vehicle setVariable ["R3F_LOG_disabled", false, true]; // force vehicles to be unlocked
		_vehicle
	};

		_createVehicle5 = {
		private ["_type","_position","_direction","_vehicle","_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "FLY"];
		[_vehicle] call vehicleSetup;

		_vel = [velocity _vehicle, -(_direction)] call BIS_fnc_rotateVector2D; // Added to make it fly
		_vehicle setDir _direction;
		_vehicle setVelocity _vel; // Added to make it fly
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;
		_vehicle setVehicleLock "UNLOCKED";  // force vehicles to be unlocked
		_vehicle setVariable ["R3F_LOG_disabled", false, true]; // force vehicles to be unlocked
		_vehicle
	};
	
		_createVehicle6 = {
		private ["_type","_position","_direction","_vehicle","_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;
		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInCargo [_vehicle, 0];
		_vehicle setVehicleLock "UNLOCKED";  // force vehicles to be unlocked
		_vehicle setVariable ["R3F_LOG_disabled", false, true]; // force vehicles to be unlocked
		_vehicle
	};
	
		_createVehicle7 = {
		private ["_type","_position","_direction","_vehicle","_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;
		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInCargo [_vehicle, 0];
		_vehicle setVehicleLock "UNLOCKED";  // force vehicles to be unlocked
		_vehicle setVariable ["R3F_LOG_disabled", false, true]; // force vehicles to be unlocked
		_vehicle
	};
		_createVehicle8 = {
		private ["_type","_position","_direction","_vehicle","_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "FLY"];
		[_vehicle] call vehicleSetup;

		_vel = [velocity _vehicle, -(_direction)] call BIS_fnc_rotateVector2D; // Added to make it fly
		_vehicle setDir _direction;
		_vehicle setVelocity _vel; // Added to make it fly
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;
		_vehicle setVehicleLock "UNLOCKED";  // force vehicles to be unlocked
		_vehicle setVariable ["R3F_LOG_disabled", false, true]; // force vehicles to be unlocked
		_vehicle
	};
	
	_createVehicle9 = {
		private ["_type","_position","_direction","_vehicle","_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;
		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInCargo [_vehicle, 0];
		_vehicle setVehicleLock "UNLOCKED";  // force vehicles to be unlocked
		_vehicle setVariable ["R3F_LOG_disabled", false, true]; // force vehicles to be unlocked
		_vehicle
	};
	
	_createVehicle10 = {
		private ["_type","_position","_direction","_vehicle","_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;
		
		// add a driver/pilot/captain to the vehicle
		// the little bird, orca, and hellcat do not require gunners and should not have any passengers
		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInDriver _vehicle;


		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;
		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInCargo [_vehicle, 0];
		_vehicle setVehicleLock "UNLOCKED";  // force vehicles to be unlocked
		_vehicle setVariable ["R3F_LOG_disabled", false, true]; // force vehicles to be unlocked
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles =
	[
		[_veh1, _starts select 0, _startDirs select 0] call _createVehicle2,
		[_veh2, _starts select 1, _startDirs select 1] call _createVehicle2,
		[_veh3, _starts select 2, _startDirs select 2] call _createVehicle2,
		[_veh4, _starts select 3, _startDirs select 3] call _createVehicle2,
		[_veh5, _starts select 4, _startDirs select 4] call _createVehicle2,
		[_veh6, _starts select 5, _startDirs select 5] call _createVehicle2,
		[_veh7, _starts select 6, _startDirs select 6] call _createVehicle2,
		[_veh8, _starts select 7, _startDirs select 7] call _createVehicle2,
		[_veh9, _starts select 8, _startDirs select 8] call _createVehicle2,
		[_veh10, _starts select 9, _startDirs select 9] call _createVehicle2
	];

	

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup setCombatMode "GREEN"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };
	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "FILE";
		_waypoint setWaypointSpeed _speedMode;
	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh6 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh2 >> "displayName");
	_vehicleName2 = getText (configFile >> "CfgVehicles" >> _veh6 >> "displayName");
	_vehicleName3 = getText (configFile >> "CfgVehicles" >> _veh9 >> "displayName");

	_missionHintText = format ["A convoy containing at least a <t color='%4'>%1</t>, a <t color='%4'>%2</t> and a <t color='%4'>%3</t> is patrolling a high value location! Stop the partol and collect the high value weapons crate and money!", _vehicleName, _vehicleName2, _vehicleName3, superMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{
	// Mission completed

	_cashpile = selectRandom [2,3,5];	
	// $$$
	_cashamount = A3W_MediumMoney;

	for "_i" from 1 to _cashpile do
	{
		_cash = createVehicle ["Land_Money_F",[(_lastPos select 0), (_lastPos select 1) - 5,0],[], 0, "NONE"];
		_cash setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", _cashamount / _cashpile, true];
		_cash setVariable ["owner", "world", true];
	};

	//SuperBox
	_box1 = createVehicle [selectRandom A3W_SuperBoxes, _lastPos, [], 2, "None"];
	_box1 setDir random 360;
	[_box1, "WOD_SuperBox"] call fn_refillbox;
	_box2 = createVehicle [selectRandom A3W_LargeBoxes, _lastPos, [], 2, "None"];
	_box2 setDir random 360;
	_box3 = createVehicle [selectRandom A3W_LargeBoxes, _lastPos, [], 2, "None"];
	_box3 setDir random 360;
	_box4 = createVehicle [selectRandom A3W_LargeBoxes, _lastPos, [], 2, "None"];
	_box4 setDir random 360;
	_box5 = createVehicle [selectRandom A3W_MediumBoxes, _lastPos, [], 2, "None"];
	_box5 setDir random 360;	
	_box6 = createVehicle [selectRandom A3W_MediumBoxes, _lastPos, [], 2, "None"];
	_box6 setDir random 360;	
	_boxesArray = [_box1, _box2, _box3, _box4, _box5, _box6];	

	// Unlock
	{ _x setVariable ["allowDamage", true, true] } forEach _boxesArray;			
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach _boxesArray;	
	{ _x setVariable ["A3W_inventoryLockR3F", false, true] } forEach _boxesArray;	
	
	sleep 5;
	_smoke1 = "SmokeShellYellow" createVehicle getPos _box1;
	_smoke1 attachto [_box1,[0,0,-0.5]];	

	_successHintMessage = "The patrol has been stopped, the money, crates and vehicles are yours to take.";
};

_this call superMissionProcessor;
