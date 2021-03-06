// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: FAR_lastResort.sqf
//	@file Author: AgentRev

private ["_hasCharge", "_hasSatchel", "_hasCharge2", "_hasSatchel2", "_mineType", "_pos", "_mine"];

_hasCharge = "IEDUrbanSmall_Remote_Mag" in magazines player;
_hasSatchel = "IEDUrbanBig_Remote_Mag" in magazines player;
_hasCharge2 = "IEDLandSmall_Remote_Mag" in magazines player;
_hasSatchel2 = "IEDLandBig_Remote_Mag" in magazines player;
_hasSatchelCharge = "SatchelCharge_Remote_Mag" in magazines player;
_hasSatchelSM = "DemoCharge_Remote_Mag" in magazines player;

_shout = 
	[ // ["filename", volume, bomb timer]
		["lastresort", 0.7, 1.75],
		["yililili", 0.5, 1.9]
	] call BIS_fnc_selectRandom;

if !(player getVariable ["performingDuty", false]) then
{
	if (_hasCharge || _hasSatchel || _hasCharge2 || _hasSatchel2) then
	{
		if (["*** Allahu Akbar ***?", "", "SIM", "NÃO"] call BIS_fnc_guiMessage) then
		{
			player setVariable ["performingDuty", true];
			playSound3D [call currMissionDir + "client\sounds\" + (_shout select 0) + ".wss", vehicle player, false, getPosASL player, (_shout select 1), 1, 1000];

			switch (true) do
			{
				case (_hasCharge):
				{
					_mineType = "IEDUrbanSmall_F";
					player removeMagazine "IEDUrbanSmall_Remote_Mag";
				};
				case (_hasSatchel):
				{
					_mineType = "IEDUrbanBig_F";
					player removeMagazine "IEDUrbanBig_Remote_Mag";
				};
				case (_hasCharge2):
				{
					_mineType = "IEDLandSmall_F";
					player removeMagazine "IEDLandSmall_Remote_Mag";
				};
				case (_hasSatchel2):
				{
					_mineType = "IEDLandBig_F";
					player removeMagazine "IEDLandBig_Remote_Mag";
				};
				case (_hasSatchelCharge):
				{
					_mineType = "SatchelCharge_F";
					player removeMagazine "SatchelCharge_Remote_Mag";
				};
				case (_hasSatchelSM):
				{
					_mineType = "DemoCharge_F";
					player removeMagazine "DemoCharge_Remote_Mag";
				};
			};

			sleep 1.75;

			_pos = getPosATL player;
			_pos set [2, (_pos select 2) + 0.5];

			_mine = createMine [_mineType, _pos, [], 0];
			_mine setDamage 1;
			player setDamage 1;
			player setVariable ["performingDuty", nil];
		};
	}
	else
	{
		titleText ["Terrorista de Merda! Pegue uma Bomba da Próxima Vez!!!", "PLAIN", 0.5];
	};
};
