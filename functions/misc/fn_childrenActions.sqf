/*
* Author: alganthe
* Add self made ACE3 interactions children.
* DO NOT call, this is used only to return the children actions in derp_fnc_actions
*
* Arguments:
* 0: How far in the tree we are <NUMBER>
* 1: Arguments passed internally <ARRAY>
*
* Return Value:
* children actions (warning massive array)
*/
params [["_actionMode", 0], "_actionObject", "_spawnObject", ["_passedArgs", []]];

private _actions = [];
switch (_actionMode) do {
    case 0: {
        {
            _actions pushback [
                [

                    [_x, "mainNode"] joinString "",
                    [_x, "damage"] joinString " ",
                    "",
                    {true},
                    {true},
                    {
                        params ["", "", "_args"];
                        _args params ["_actionObject", "_spawnObject", "_damageType"];
                        [1, _actionObject, _spawnObject, [_damageType]] call derp_fnc_childrenActions;
                    },
                    [_actionObject, _spawnObject, _x]
                ] call ace_interact_menu_fnc_createAction,
                [],
                _actionObject
            ];
        } foreach ((configfile >> "ACE_Medical_Advanced" >> "Injuries" >> "damageTypes") call BIS_fnc_getCfgSubClasses);
        _actions
    };

    case 1: {
        _passedArgs params ["_currentDamageType"];
        {
            _actions pushback [
                [
                    [_currentDamageType, _x, "Node"] joinString "",
                    _x,
                    "",
                    {true},
                    {true},
                    {
                        params ["", "", "_args"];
                        _args params ["_actionObject", "_spawnObject", "_currentDamageType", "_currentSelection"];
                        [2, _actionObject, _spawnObject, [_currentDamageType, _currentSelection]] call derp_fnc_childrenActions;
                    },
                    [_actionObject, _spawnObject, _currentDamageType, _x]
                ] call ace_interact_menu_fnc_createAction,
                [],
                _actionObject
            ],
        } foreach ["head", "body", "hand_r", "hand_l", "leg_l", "leg_r"];
        _actions
    };

    case 2: {
        {
            _passedArgs params ["_currentDamageType", "_currentSelection"];
            _actions pushback [
                [
                    [_currentDamageType, _currentSelection, ((str _x) splitString ".") select 1, "Node"] joinString "",
                    str _x,
                    "",
                    {
                        params ["", "", "_args"];
                        _args params ["_spawnObject", "_damage", "_currentSelection", "_currentDamageType"];
                        [_spawnObject, _damage, _currentSelection, _currentDamageType] call derp_fnc_spawnPatient;
                    },
                    {true},
                    {},
                    [_spawnObject, _x, _currentSelection, _currentDamageType]
                ] call ace_interact_menu_fnc_createAction,
                [],
                _actionObject
            ];
        } foreach [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8];
        _actions
    };
};
