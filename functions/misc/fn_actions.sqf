/*
* Author: alganthe
* Add self made ACE3 interactions
*
* Arguments:
* None
*
* Return Value:
* nothing
*/
_actionMain = [
        "spawnPatientMain",
        "Spawn patient",
        "",
        {true},
        {true},
        {[0] call derp_fnc_childrenActions}
    ] call ace_interact_menu_fnc_createAction;
[terminal, 0, ["ACE_MainActions"], _actionMain] call ace_interact_menu_fnc_addActionToObject;

_removePatients = [
        "removePatients",
        "remove patients",
        "",
        {true},
        {true},
        {
            [[[
                "removeDeadPatients",
                "Dead",
                "",
                {
                    {deleteVehicle _x} foreach allDeadMen;
                },
                {true}
            ] call ace_interact_menu_fnc_createAction,
            [],
            terminal],

            [[
                "removeAlivePatients",
                "Alive",
                "",
                {
                    {if (!isPlayer _x) then {deleteVehicle _x}} foreach allUnits;
                },
                {true}
            ] call ace_interact_menu_fnc_createAction,
            [],
            terminal]]
        }
    ] call ace_interact_menu_fnc_createAction;
[terminal, 0, ["ACE_MainActions"], _removePatients] call ace_interact_menu_fnc_addActionToObject;

_clearLitter = [
        "clearLitter",
        "Clear litter",
        "",
        {
            {
                _x params ["", "_objects"];
                {deleteVehicle _x} forEach _objects;
                ace_medical_allCreatedLitter set [_forEachIndex, objNull];
            } forEach ace_medical_allCreatedLitter;
            ace_medical_allCreatedLitter = ace_medical_allCreatedLitter - [objNull];
        },
        {true}
    ] call ace_interact_menu_fnc_createAction;
[terminal, 0, ["ACE_MainActions"], _clearLitter] call ace_interact_menu_fnc_addActionToObject;
