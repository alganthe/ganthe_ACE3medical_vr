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
            params ["_target", "", "_args"];
            _args params ["_actionObject"];
            [[[
                "removeDeadPatients",
                "Dead",
                "",
                {
                    params ["", "", "_params"];
                    private _actionObject = _params select 0;

                    private _isObjectAlreadyInArray = derp_patientArray find _actionObject;

                    if !(_isObjectAlreadyInArray isEqualTo -1) then {
                        [1, _actionObject, _isObjectAlreadyInArray + 1] remoteExecCall ["derp_fnc_removePatients", 2];
                    };
                },
                {true},
                {},
                [_actionObject]
            ] call ace_interact_menu_fnc_createAction,
            [],
            _actionObject],

            [[
                "removeAlivePatients",
                "Alive",
                "",
                {
                    params ["", "", "_params"];
                    private _actionObject = _params select 0;

                    private _isObjectAlreadyInArray = derp_patientArray find _actionObject;

                    if !(_isObjectAlreadyInArray isEqualTo -1) then {
                        [0, _actionObject, _isObjectAlreadyInArray + 1] remoteExecCall ["derp_fnc_removePatients", 2];
                    };
                },
                {true},
                {},
                [_actionObject]
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
            remoteExecCall ["derp_fnc_removeLitter", -2];
        },
        {true}
    ] call ace_interact_menu_fnc_createAction;
[_actionObject, 0, ["ACE_MainActions"], _clearLitter] call ace_interact_menu_fnc_addActionToObject;
