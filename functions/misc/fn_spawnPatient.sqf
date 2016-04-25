/*
* Author: alganthe
* Spawn a unit and apply damage to it.
*
* Arguments:
* 0: Damage to add <NUMBER>
* 1: Selection ("head", "body", "hand_l", "hand_r", "leg_l", "leg_r") <STRING> default: "body"
* 2: Damage type ("bullet", "grenade", "explosive", "shell", "vehiclecrash", "backblast", "stab", "punch", "falling", "ropeburn", "unknown") <STRING> default: "bullet"
*
* Return Value:
* Unit
*
* Example:
* [0.8, "leg_r", "bullet"] call derp_fnc_spawnPatient;
* [0.7, "body", "grenade"] call derp_fnc_spawnPatient;
*/
params ["_damage", ["_selection", "body"], ["_damageType", "bullet"]];
diag_log format ["%1 %2 %3", _damage, _selection, _damageType];

_group = createGroup west;
_unit = _group createUnit ["B_HeavyGunner_F", spawnThingy, [], 0, "NONE"];
_unit setCaptive true;
[_unit, _damage, _selection, _damageType] call ace_medical_fnc_addDamageToUnit;

_unit
