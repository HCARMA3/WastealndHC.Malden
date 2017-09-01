// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_SmugglerPlane.sqf
//	@file Author: Firewall-BR Jul 4th 2017

if (!isServer) exitwith {};
#include "superMissionDefines.sqf";

private ["_planeChoices", "_convoyVeh", "_veh1", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_drop_item", "_drugpile",
	"_box1", "_smoke1", "_boxesArray", "_cashpile", "_cashamount", "_cash", "_para", "_getPos"];

_altitude = 800;
	
_setupVars =
{
	_missionType = "Flying Smuggler";
	_locationsArray = nil;
};

_setupObjects =
{
	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

	_planeChoices =
	[
		["I_C_Plane_Civil_01_F"],
		["I_C_Heli_Light_01_civil_F"]
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

		// add pilot
		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;
		// lock the vehicle untill the mission is finished and initialize cleanup on it

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles = [];
	_vehicles set [0, [_veh1, _missionPos, 14, _aiGroup] call _createVehicle]; // static value update when porting to different maps	

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "AWARE";
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = "FULL";

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 55;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "AWARE";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1 >> "displayName");
	_missionHintText = format ["A <t color='%2'>%1</t> is transporting stolen weapons and cash. Shoot it down and kill the pilot to recover the money and weapons!", _vehicleName, superMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_drop_item = 
{
	private["_item", "_pos"];
	_item = _this select 0;
	_pos = _this select 1;

	if (isNil "_item" || {typeName _item != typeName [] || {count(_item) != 2}}) exitWith {};
	if (isNil "_pos" || {typeName _pos != typeName [] || {count(_pos) != 3}}) exitWith {};

	private["_id", "_class"];
	_id = _item select 0;
	_class = _item select 1;

	private["_obj"];
	_obj = createVehicle [_class, _pos, [], 5, "None"];
	_obj setPos ([_pos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
	_obj setVariable ["mf_item_id", _id, true];
};

_successExec =
{
	// Mission completed

	_geoPos = _lastPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);		
	
	//SuperBox
	_box1 = createVehicle [selectRandom A3W_SuperBoxes,[(_geoPos select 0), (_geoPos select 1), _altitude],[], 0, "NONE"];	
	_box1 setDir random 360;
	[_box1, "mission_HVSniper"] call fn_refillbox;

	_boxesArray = [_box1];	
	
	_para = createVehicle [format ["I_parachute_02_F"], [0,0,999999], [], 0, ""];

	_para setDir getDir _box1;
	_para setPosATL getPosATL _box1;

	_para attachTo [_box1, [0, 0, 0]];

	detach _para;
	_box1 attachTo [_para, [0, 0, 0]];

	while {(getPos _box1) select 2 > 3 && attachedTo _box1 == _para} do
	{
		_para setVectorUp [0,0,1];
		uiSleep 0.1;
	};

	waitUntil
	{
		sleep 0.1;
		_pos = getPos _box1;
		(isTouchingGround _box1 || _pos select 2 < 5) && {vectorMagnitude velocity _box1 < [1,5] select surfaceIsWater _pos}
	};	
	
	// Unlock
	{ _x setVariable ["allowDamage", true, true] } forEach _boxesArray;			
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach _boxesArray;	
	{ _x setVariable ["A3W_inventoryLockR3F", false, true] } forEach _boxesArray;	

	uiSleep 2;	
	
	_smoke1 = "SmokeShellYellow" createVehicle getPos _box1;
	_smoke1 attachto [_box1,[0,0,-0.5]];
	
	_cashpile = selectRandom [2,3,5];	
	// $$$
	_cashamount = A3W_SmallMoney;

	for "_i" from 1 to _cashpile do
	{
		_cash = createVehicle ["Land_Money_F",[(_lastPos select 0), (_lastPos select 1) - 5,0],[], 0, "NONE"];
		_cash setPos ([getPos _box1, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", _cashamount / _cashpile, true];
		_cash setVariable ["owner", "world", true];
	};

	for "_i" from 1 to _cashpile do
	{
		private["_item"];
		_item = selectRandom [["lsd", "Land_WaterPurificationTablets_F"],["marijuana", "Land_VitaminBottle_F"],["cocaine","Land_PowderedMilk_F"],["heroin", "Land_PainKillers_F"]];
		[_item, getPos _box1] call _drop_item;
	};	

	_successHintMessage = "The smuggler was taken out! Ammo crates and money have fallen near the pilot.";
};

_this call superMissionProcessor;
