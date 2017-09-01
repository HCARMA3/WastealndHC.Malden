// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: superMissionController.sqf
//	@file Author: Rover047

#define MISSION_CTRL_PVAR_LIST superMissions
#define MISSION_CTRL_TYPE_NAME "Super Missions"
#define MISSION_CTRL_FOLDER "SuperMissions"
#define MISSION_CTRL_DELAY (["A3W_superMissionDelay", 20*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE superMissionColor

#include "SuperMissions\superMissionDefines.sqf"
#include "missionController.sqf";
