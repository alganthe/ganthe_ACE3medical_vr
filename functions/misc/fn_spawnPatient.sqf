/*
* Author: alganthe
* Spawn a unit and apply damage to it.
*
* Arguments:
* 0: Spawn position
* 1: Damage to add <NUMBER>
* 2: Selection ("head", "body", "hand_l", "hand_r", "leg_l", "leg_r") <STRING> default: "body"
* 3: Damage type ("bullet", "grenade", "explosive", "shell", "vehiclecrash", "backblast", "stab", "punch", "falling", "ropeburn", "unknown") <STRING> default: "bullet"
* 4: Object used to spawn the patient <OBJECT> (Used to set the public var used to delete it)
*
* Return Value:
* Unit
*
* Example:
* [spawnArea1, 0.8, "leg_r", "bullet", terminal1] call derp_fnc_spawnPatient;
* [position dude1, 0.7, "body", "grenade", terminal1] call derp_fnc_spawnPatient;
*/
params ["_spawnObject","_damage", ["_selection", "body"], ["_damageType", "bullet"], "_actionObject"];

private _group = createGroup west;
private _unit = _group createUnit ["b_survivor_F", _spawnObject, [], 0, "NONE"];
_unit disableAI "PATH";
_unit disableAI "AUTOTARGET";
_unit disableAI "AUTOCOMBAT";
{_x addCuratorEditableObjects [[_unit],false]} foreach allCurators;
[_unit, _damage, _selection, _damageType] call ace_medical_fnc_addDamageToUnit;

private _isObjectAlreadyInArray = derp_patientArray find _actionObject;

if (_isObjectAlreadyInArray isEqualTo -1) then {
    derp_patientArray pushBackUnique _actionObject;
    derp_patientArray pushBackUnique [_unit];

} else {
    derp_patientArray set [_isObjectAlreadyInArray + 1, (derp_patientArray select (_isObjectAlreadyInArray + 1)) + [_unit]];
};


publicVariable "derp_patientArray";

_unit
