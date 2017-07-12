	// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: igEsp.sqf v2.0
//	@file Author: Matt76 @CCG

_uid = getPlayerUID player;

if (_uid call isAdmin) then {

	matt76_e5p = {
		if (isnil("stopcopyandpastingmyshit")) then {
			stopcopyandpastingmyshit = 0;
		};
		if (stopcopyandpastingmyshit == 0) then {
			stopcopyandpastingmyshit = 1;
			hint "In game E5P ON";
			CCGLogger = ["AdminLog", format["Turned ESP On [%1 (%2)]", name player, getPlayerUID player]];
			publicVariableServer "CCGLogger";			
		} else {
			stopcopyandpastingmyshit = 0;
			hint "In game E5P OFF";
			CCGLogger = ["AdminLog", format["Turned Map Off [%1 (%2)]", name player, getPlayerUID player]];
			publicVariableServer "CCGLogger";				
		};
		if (stopcopyandpastingmyshit == 1) then {
			onEachFrame {
				_l49 = nearestobjects[player, ["CAManBase"], 1500]; {

					if ((getPlayerUID _x != "") && (alive _x) && ((player distance _x) < 1500)) then {	

							switch ((side _x)) do {

							case west:       { drawIcon3D["", [0.047,0.502,1,1], [visiblePosition _x select 0, visiblePosition _x select 1, (getPosATL _x select 2) + 1], 0.1, 0.1, 45, (format["%2 : %1m", round(player distance _x), name _x]), 1, 0.04, "TahomaB"]; };
							case east:       { drawIcon3D["", [1,0.17,0.17,1], [visiblePosition _x select 0, visiblePosition _x select 1, (getPosATL _x select 2) + 1], 0.1, 0.1, 45, (format["%2 : %1m", round(player distance _x), name _x]), 1, 0.04, "TahomaB"]; };
							case resistance: { drawIcon3D["", [0,0.65,0,1], [visiblePosition _x select 0, visiblePosition _x select 1, (getPosATL _x select 2) + 1], 0.1, 0.1, 45, (format["%2 : %1m", round(player distance _x), name _x]), 1, 0.04, "TahomaB"]; };
							case civilian:   { drawIcon3D["", [0.67,0.97,0.97,1], [visiblePosition _x select 0, visiblePosition _x select 1, (getPosATL _x select 2) + 1], 0.1, 0.1, 45, (format["%2 : %1m", round(player distance _x), name _x]), 1, 0.04, "TahomaB"]; };
						};	
					};
				}
				foreach playableUnits;
			};
		} else {
			onEachFrame {
				nil
			};
		};
	};

	[] spawn matt76_e5p
};	