/*
	----------------------------------------------------------------------------------------------
	
	Copyright © 2016 soulkobk (soulkobk.blogspot.com)

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU Affero General Public License as
	published by the Free Software Foundation, either version 3 of the
	License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU Affero General Public License for more details.

	You should have received a copy of the GNU Affero General Public License
	along with this program. If not, see <http://www.gnu.org/licenses/>.

	----------------------------------------------------------------------------------------------
	
	Name: globalChatMessages.sqf
	Version: 1.0.0
	Author: soulkobk (soulkobk.blogspot.com)
	Creation Date: 5:31 PM 18/10/2016
	Modification Date: 5:31 PM 18/10/2016
	
	Description:
	For use with A3Wasteland 1.Xx mission (A3Wasteland.com).
	
	This script will show global chat messages to clients, as per the _globalChatMessages array.
	Be sure to set _globalChatMessagesSleep at minimum of 10 minutes sleep duration, else the
	script will default	back to 10 minutes sleep duration to avoid spamming globalChat and
	annoying the hell out of players.
	
	Place this script in directory...
	\client\functions\globalChatMessages.sqf
	
	Edit...
	\client\init.sqf
	
	And at the bottom of the script, paste in...
	[] execVM "client\functions\globalChatMessages.sqf";
	
	*Please note that this is a static message, so if server administrators want to modify the
	messages contained, they need to update this script within their mission.pbo each time.
	
	*Please also note that this script is based upon having a 'game logic' named 'server' within
	your mission.sqm file (it should be in the vanilla A3Wasteland mission already, if not then
	you must add a game logic to your mission and name it 'server').
	
	Parameter(s): for _globalChatMessages, use syntax -> ["<message>",<sleep time in seconds>],

	Example: none
	
	Change Log:
	1.0.0 -	original base script.
	
	----------------------------------------------------------------------------------------------
*/

_globalChatPrefix = "[HCCorp]";

_globalChatMessagesSleep = 30*60; // 30 minutes sleep per full loop.

_globalChatMessages = [
    ["Bem vindo(a) ao Wasteland HCCorp.",1],
    ["TeamSpeak -> HC.stchost.com.br",1],
    ["Uso de HACK/Meios ilícitos = BAN PERMA",30],
    ["Server restarta  as 04, 08, 12, 16, 20, 00 horas.",1],
    ["Dia/Noite ciclo é 3 horas dia, 1 hora noite.",30],
    ["Mission Changelog: github.com/HCARMA3",30],
    ["Procurando por um admim? Entre no TS: HC.stchost.com.br.",30],
   // ["Enjoy the server? Tell your friends!",30],
   // ["Want to become a part of the [KOBK] clan? You can apply via our WWW site.",30],
   // ["Want to help cover server costs? You can donate via our WWW site.",30],
    ["Há Stores Clandestinas não marcadas no mapa. Se acha-las, aproveite.",30]
];

/*	------------------------------------------------------------------------------------------
	DO NOT EDIT BELOW HERE!
	------------------------------------------------------------------------------------------	*/

if (((count _globalChatMessages) >= 1) && (hasInterface)) then
{
	if (_globalChatMessagesSleep < 600) then
	{
		_globalChatMessagesSleep = 600;
	};
	while {true} do
	{
		uiSleep _globalChatMessagesSleep;
		{
			_currentMessage = _x select 0;
			_currentSleep = _x select 1;
			server globalChat format ["%1 -> %2",_globalChatPrefix,_currentMessage];
			uiSleep _currentSleep;
		} forEach _globalChatMessages;
	};
};