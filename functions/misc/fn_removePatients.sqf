/*
* Author: alganthe
* Remove patients
*
* Arguments:
* 0: mode to run in : 0 = dead; 1 = alive <NUMBER>
* 1: object to which the actions were added to <OBJECT>
* 2: Index of the units array to handle <NUMBER>
*
* Return Value:
* Nothing
*/
// Meant to be ran serverside
if !(isServer) exitWith {};

params ["_mode", "_actionObject", "_arrayIndex"];

switch (_mode) do {
    case 0: {
        {
            if (alive _x) then {
                deleteVehicle _x;
            };
        } foreach (derp_patientArray select _arrayIndex);
    };

    case 1: {
        {
            if (!alive _x) then {
                deleteVehicle _x;
            };
        } foreach (derp_patientArray select _arrayIndex);
    };
};

// Because deleteVehicle is too slow
 [{
    private _arrayIndex = _this select 0;
    derp_patientArray set [_arrayIndex, (derp_patientArray select _arrayIndex) select {!isNull _x}];
    publicVariable "derp_patientArray";
}, [_arrayIndex], 1] call CBA_fnc_waitAndExecute;
