/*
* Author: alganthe
* Spawn a unit and apply damage to it.
*
* Arguments:
* 0: Spawn position
* 1: Damage to add <NUMBER>
* 2: Selection ("head", "body", "hand_l", "hand_r", "leg_l", "leg_r") <STRING> default: "body"
* 3: Damage type ("bullet", "grenade", "explosive", "shell", "vehiclecrash", "backblast", "stab", "punch", "falling", "ropeburn", "unknown") <STRING> default: "bullet"
*
* Return Value:
* Unit
*
* Example:
* [0.8, "leg_r", "bullet"] call derp_fnc_spawnPatient;
* [0.7, "body", "grenade"] call derp_fnc_spawnPatient;
*/
params ["_spawnObject","_damage", ["_selection", "body"], ["_damageType", "bullet"]];

_group = createGroup west;
_unit = _group createUnit ["b_survivor_F", _spawnObject, [], 0, "NONE"];
_unit disableAI "TARGET";
_unit disableAI "AUTOTARGET";
_unit disableAI "AUTOCOMBAT";
{_x addCuratorEditableObjects [[_unit],false]} foreach allCurators;
[_unit, _damage, _selection, _damageType] call ace_medical_fnc_addDamageToUnit;

_unit
