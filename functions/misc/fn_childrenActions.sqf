params [["_actionMode", 0], ["_passedArgs", []]];

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
                        _args params ["_damageType"];
                        [1, [_damageType]] call derp_fnc_childrenActions
                    },
                    [_x]
                ] call ace_interact_menu_fnc_createAction,
                [],
                terminal
            ];
        } foreach ["bullet", "grenade", "explosive", "shell", "vehiclecrash", "backblast"];
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
                        _args params ["_currentDamageType", "_currentSelection"];
                        [2, [_currentDamageType, _currentSelection]] call derp_fnc_childrenActions
                    },
                    [_currentDamageType, _x]
                ] call ace_interact_menu_fnc_createAction,
                [],
                terminal
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
                        _args params ["_damage", "_currentSelection", "_currentDamageType"];
                        [_damage, _currentSelection, _currentDamageType] call derp_fnc_spawnPatient
                    },
                    {true},
                    {},
                    [_x, _currentSelection, _currentDamageType]
                ] call ace_interact_menu_fnc_createAction,
                [],
                terminal
            ];
        } foreach [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8];
        _actions
    };
};
