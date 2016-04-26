/*
* Author: alganthe
* Add self made ACE3 interactions
*
* Arguments:
* 0: Object to add the actions to <OBJECT>
* 1: Object to spawn the unit on <OBJECT>
*
* Return Value:
* nothing
*/
params ["_actionObject", "_spawnObject"];

_actionMain = [
        "spawnPatientMain",
        "Spawn patient",
        "",
        {true},
        {true},
        {
            params ["", "", "_args"];
            _args params ["_actionObject", "_spawnObject"];
            [0, _actionObject, _spawnObject] call derp_fnc_childrenActions;
        },
        [_actionObject, _spawnObject]
    ] call ace_interact_menu_fnc_createAction;
[_actionObject, 0, ["ACE_MainActions"], _actionMain] call ace_interact_menu_fnc_addActionToObject;

_removePatients = [
        "removePatients",
        "remove patients",
        "",
        {true},
        {true},
        {
            params ["", "", "_args"];
            _args params ["_actionObject"];
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
            _actionObject],

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
            _actionObject]]
        },
        [_actionObject]
    ] call ace_interact_menu_fnc_createAction;
[_actionObject, 0, ["ACE_MainActions"], _removePatients] call ace_interact_menu_fnc_addActionToObject;

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
[_actionObject, 0, ["ACE_MainActions"], _clearLitter] call ace_interact_menu_fnc_addActionToObject;
