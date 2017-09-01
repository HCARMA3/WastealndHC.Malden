// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_SupplyDrop.sqf
//	@file Author: Firewall-BR Jun 15th 2017

if (!isServer) exitwith {};
#include "superMissionDefines.sqf";

private ["_planeChoices", "_convoyVeh", "_veh1", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_box1", "_box2", "_box3", "_box4", "_box5", "_box6", "_box7", "_box8", "_box9", 
	"_smoke1", "_boxesArray", "_cashpile", "_cashamount", "_cash"];

_textureDir = "client\images\vehicleTextures\";
_vehTexture = ["stripes.paa","stripes2.paa","urban.paa"] call BIS_fnc_selectRandom;

_altitude = 800;
	
_setupVars =
{
	_missionType = "Supply Drop";
	_locationsArray = nil;
};

_setupObjects =
{
	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

	_planeChoices =
	[
		["B_T_VTOL_01_vehicle_F"],
		["O_T_VTOL_02_infantry_dynamicLoadout_F"]
	];

	_convoyVeh = _planeChoices call BIS_fnc_selectRandom;

	_veh1 = _convoyVeh select 0;

	_createVehicle =
	{
		private ["_type","_position","_direction","_vehicle","_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "FLY"]; // Added to make it fly
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		_vel = [velocity _vehicle, -(_direction)] call BIS_fnc_rotateVector2D; // Added to make it fly
		_vehicle setDir _direction;
		_vehicle setVelocity _vel; // Added to make it fly
		_vehicle flyInHeight _altitude;								
		_vehicle setVariable [call vChecksum, true, false];
		_aiGroup addVehicle _vehicle;

		[_vehicle, _textureDir + _vehTexture, [0,1,2,3]] call applyVehicleTexture;		
		
		// add pilot
		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInDriver _vehicle;
		// lock the vehicle untill the mission is finished and initialize cleanup on it

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles = [];
	_vehicles set [0, [_veh1, _missionPos, 14, _aiGroup] call _createVehicle]; 

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "SAFE";
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "LIMITED" } else { "FULL" };

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 55;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1 >> "displayName");
	_missionHintText = format ["A <t color='%2'>%1</t> is patrolling the island. Shoot it down and kill the pilot to recover the money and weapons!", _vehicleName, superMissionColor];

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
	_cashamount = A3W_SmallMoney;

	for "_i" from 1 to _cashpile do
	{
		_cash = createVehicle ["Land_Money_F",[(_lastPos select 0), (_lastPos select 1) - 5,0],[], 0, "NONE"];
		_cash setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", _cashamount / _cashpile, true];
		_cash setVariable ["owner", "world", true];
	};

	for "_i" from 1 to _cashpile do
	{
		private["_item"];
		_item = selectRandom [["lsd", "Land_WaterPurificationTablets_F"],["marijuana", "Land_VitaminBottle_F"],["cocaine","Land_PowderedMilk_F"],["heroin", "Land_PainKillers_F"]];
		[_item, _lastPos] call _drop_item;
	};
			
	//SuperBox
	_box1 = createVehicle [selectRandom A3W_SuperBoxes, _lastPos, [], 2, "None"];
	_box1 setDir random 360;
	[_box1, "mission_HVSniper"] call fn_refillbox;
	_box2 = createVehicle [selectRandom A3W_LargeBoxes, _lastPos, [], 2, "None"];
	_box2 setDir random 360;
	_box3 = createVehicle [selectRandom A3W_LargeBoxes, _lastPos, [], 2, "None"];
	_box3 setDir random 360;
	/*_box4 = createVehicle [selectRandom A3W_LargeBoxes, _lastPos, [], 2, "None"];
	_box4 setDir random 360;
	_box5 = createVehicle [selectRandom A3W_MediumBoxes, _lastPos, [], 2, "None"];
	_box5 setDir random 360;	
	_box6 = createVehicle [selectRandom A3W_MediumBoxes, _lastPos, [], 2, "None"];
	_box6 setDir random 360;	
	_box7 = createVehicle [selectRandom A3W_MediumBoxes, _lastPos, [], 2, "None"];
	_box7 setDir random 360;	
	_box8 = createVehicle [selectRandom A3W_SmallBoxes, _lastPos, [], 2, "None"];
	_box8 setDir random 360;	
	_box9 = createVehicle [selectRandom A3W_SmallBoxes, _lastPos, [], 2, "None"];
	_box9 setDir random 360;*/	
	_boxesArray = [_box1, _box2, _box3/*, _box4, _box5, _box6, _box7, _box8, _box9*/];	

	// Unlock
	{ _x setVariable ["allowDamage", true, true] } forEach _boxesArray;			
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach _boxesArray;	
	{ _x setVariable ["A3W_inventoryLockR3F", false, true] } forEach _boxesArray;	
	
	sleep 2;
	_smoke1 = "SmokeShellYellow" createVehicle getPos _box1;
	_smoke1 attachto [_box1,[0,0,-0.5]];		

	_successHintMessage = "The sky is clear again, the enemy supply drop was taken out! Ammo crates and LOTS of money have fallen near the pilot.";
};

_this call superMissionProcessor;
