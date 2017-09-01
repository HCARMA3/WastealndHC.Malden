//***************************************************************
//***************************************************************
//Coded by calibaan www.nomercykillers.com

//***************************************************************
//***************************************************************
private ["_MessagesToAnnounceStringArray","_DisplayTimesCheckArray","_MinimumSleepTimeScalar","_DisplayReadyMessageStringsArray","_MiniumTimeBetweenAnnouncementsScalar","_CurrentAnnouncementTimeCounterScalar","_UpdatedAnnouncementTimeScalar","_CompiledMessageDisplayString"];

/*
	The message announcement array has the following format: [Message to display, format String, Time between announcements, format scalar]
	For example:
	["Testmessage1 here!", 60], ["This is testmessage 2 displayed every 90 seconds!", 90]
*/

_MessagesToAnnounceStringArray = 

[
["Precisa de suporte? TS3: HC.stchost.com.br", 300],
["Este servidor restarta a cada 4 horas para garantir o desempenho do cliente", 600],
//["Uso de Hack/Meios ilícitos= BAN PERMA", 1400],
//["Este servidor é monitorado por vários admins mesmo fora do jogo", 1200],
//["Dúvidas,reclamações e suporte, entre no TS3 (HC.stchost.com.br)", 1500]
["Há Gun Stores Clandestinas não marcadas no mapa que mudam de posição a cada restart.Se acha-las,aproveite.", 900]

];

if ((count _MessagesToAnnounceStringArray) == 0) exitWith 
	{
	diag_log format ["** Automatic message announcement not used, the array is empty. **"];
	};

if (isNil ("CGV_MessageAnnouncementArray")) then
	{
		CGV_MessageAnnouncementArray = [];
	};

_DisplayTimesCheckArray = [];
{
CGV_MessageAnnouncementArray set [count CGV_MessageAnnouncementArray, [_x select 0, _x select 1, 0]];
_DisplayTimesCheckArray set [count _DisplayTimesCheckArray, _x select 1];
} forEach _MessagesToAnnounceStringArray;

_MinimumSleepTimeScalar = [_DisplayTimesCheckArray, 0] call BIS_fnc_findExtreme;
if (_MinimumSleepTimeScalar > 300) then 
	{
	_MinimumSleepTimeScalar = 300;
	};
_MinimumSleepTimeScalar = 5;

while {(true)} do 
	{
	_DisplayReadyMessageStringsArray = [];
	
		{
		_DisplayMessageString = _x select 0;
		_MiniumTimeBetweenAnnouncementsScalar = _x select 1;
		_CurrentAnnouncementTimeCounterScalar = _x select 2;
		
		if (_CurrentAnnouncementTimeCounterScalar >= _MiniumTimeBetweenAnnouncementsScalar) then 
			{
			_DisplayReadyMessageStringsArray set [count _DisplayReadyMessageStringsArray, _DisplayMessageString];
			_UpdatedAnnouncementTimeScalar = 0;
			}
			else
			{
			_UpdatedAnnouncementTimeScalar = _CurrentAnnouncementTimeCounterScalar + _MinimumSleepTimeScalar;
			};
		
		[CGV_MessageAnnouncementArray, [_forEachIndex, 2], _UpdatedAnnouncementTimeScalar] call BIS_fnc_setNestedElement;
		} forEach CGV_MessageAnnouncementArray;
	
	if ((count _DisplayReadyMessageStringsArray) != 0) then 
		{
		_CompiledMessageDisplayString = "";
		
			{
			_CompiledMessageDisplayString = _CompiledMessageDisplayString + _x;
			} forEach _DisplayReadyMessageStringsArray;
		
		cutText [_CompiledMessageDisplayString, "PLAIN DOWN", 2, false];
		};
	
	sleep _MinimumSleepTimeScalar;
	};