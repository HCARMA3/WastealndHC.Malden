// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: superMissionProcessor.sqf
//	@file Author: Rover047

#define MISSION_PROC_TYPE_NAME "Super Missions"
#define MISSION_PROC_TIMEOUT (["A3W_superMissionTimeout", 60*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE superMissionColor

#include "SuperMissions\SuperMissionDefines.sqf"
#include "missionProcessor.sqf";
