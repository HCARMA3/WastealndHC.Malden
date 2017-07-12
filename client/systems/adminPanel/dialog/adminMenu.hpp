// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
#define adminMenu_dialog 50000
#define adminMenu_option 50001

class AdminMenu
{
	idd = adminMenu_dialog;
	movingEnable=1;
	onLoad = "uiNamespace setVariable ['AdminMenu', _this select 0]";

	class controlsBackground {

		class AdminMenu_background: IGUIBack
		{
			idc=-1;
			colorText[] = {0, 38, 255, 1};
			colorBackground[] = {0,0,0,0.6};

			x = 0.0375;
			y = 0.04;
			w = 0.9125;
			h = 0.92;
		};
		
		class TopBar: IGUIBack
		{
			idc = -1;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {A3W_UICOLOR_R, A3W_UICOLOR_G, A3W_UICOLOR_B, 0.8};

			x = 0.0375;
			y = 0.04;
			w = 0.9125;
			h = 0.08;
		};

		class Admi:RscText
		{
			idc=-1;
			text = "Rocha Admin Menu";
			x = 0.05;
			y = 0.052;
			w = 0.25;
			h = 0.06;
		};
		
		class auth: RscText
		{
			idc=-1;
			text = "by Rocha"; 
			x = 0.805;
			y = 0.052;
			w = 0.1375;
			h = 0.06;
		}; 
	};

	class controls {

		class AdminMenu_options:w_Rsclist
		{
			idc = adminMenu_option;
			colorText[] = {0, 38, 255, 1};
			x = 0.0625;
			y = 0.14;
			w = 0.6875;
			h = 0.8;
		};

		class AdminMenu_activate:w_RscButton
		{
			idc=-1;
			text="Select Action";
			onButtonClick = "[1] execVM 'client\systems\adminPanel\optionSelect.sqf'";
			x = 0.775;
			y = 0.14;
			w = 0.15;
			h = 0.08;
		};

		class but2: w_RscButton
		{
			idc=-1;
			text = "TBC"; //--- ToDo: Localize;
			//onButtonClick = "execVM 'client\systems\adminPanel\tools\toolUp.sqf'";
			x = 0.775;
			y = 0.368;
			w = 0.15;
			h = 0.08;
		};
		class but3: w_RscButton
		{
			idc=-1;
			text = "TBC"; //--- ToDo: Localize;
			x = 0.775;
			y = 0.48;
			w = 0.15;
			h = 0.08;
		};
		class but4: w_RscButton
		{
			idc=-1;
			text = "LMG Gear"; //--- ToDo: Localize;
			onButtonClick = "execVM 'client\systems\adminPanel\tools\lmgLoadout.sqf'";
			x = 0.775;
			y = 0.588;
			w = 0.15;
			h = 0.08;
		};
		class but5: w_RscButton
		{		
			idc=-1;
			text = "Sniper Gear"; //--- ToDo: Localize;
			onButtonClick = "execVM 'client\systems\adminPanel\tools\sniperLoadout.sqf'";
			x = 0.775;
			y = 0.7;
			w = 0.15;
			h = 0.08;
		};
		class but6: w_RscButton
		{
			idc=-1;
			text = "Grunt Gear"; //--- ToDo: Localize;
			onButtonClick = "execVM 'client\systems\adminPanel\tools\gruntLoadout.sqf'";
			x = 0.775;
			y = 0.812;
			w = 0.15;
			h = 0.08;
		};
	};
};

