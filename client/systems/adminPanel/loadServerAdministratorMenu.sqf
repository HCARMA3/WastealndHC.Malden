// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: loadServerAdministratorMenu.sqf
//	@file Author: [404] Deadbeat
//	@file Created: 20/11/2012 05:19
//	@file Args:

#define adminMenu_option 50001
disableSerialization;

private ["_start","_panelOptions","_displayAdmin","_adminSelect"];
_uid = getPlayerUID player;
if ([_uid, 3] call isAdmin) then {
	_start = createDialog "AdminMenu";

	_displayAdmin = uiNamespace getVariable "AdminMenu";
	_adminSelect = _displayAdmin displayCtrl adminMenu_option;

	_panelOptions = ["Target Player Menu (Spectate/Unlock/TP/Kick/kill/Remove Cash)",
					"Map Markers Log (This only works when in game)",
					"Toggle Vehicle Markers",
					"Toggle Map ESP",
					"Toggle ESP",
					"Toggle God-mode",
					"Toggle Vehicle God-mode",
					"Toggle Invisible-mode",
					"Map Teleport",
	                "Unlock all Objects 60m around you",
	                "Delete all Unlocked Objects 60m around you",
	                "Relock all Objects 60m around you",
	                "Add 10k Money to self",
	                "Vehicle Management (Check/delete hacked vehicles)",
	                "Object Search",
	                "Heal Self",
	                "Delete Cursor Target",
	                "Repair Cursor Target",
	                "Artillery Strike on map target",
	                "Toggle Rocket Bullets",
	                "Load Gun Store Menu",
	                "Load Gen Store Menu",
	                "Load ATM Menu",
	                "Toggle AI ESP",
	                "Toggle Terrain Height",
	                "BIS FreeRoam Cam (Pres ESCAPE to exit!! Do NOT press F1)",
	                "Unlimited Ammo"                
	];

	{
		_adminSelect lbAdd _x;
	} forEach _panelOptions;
};
