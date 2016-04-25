//------------------------------------------- Main nodes
_actionMain = ["spawnPatientMain", "Spawn patient", "", {true}, {true}, {[0] call derp_fnc_childrenActions}] call ace_interact_menu_fnc_createAction;
[terminal, 0, ["ACE_MainActions"], _actionMain] call ace_interact_menu_fnc_addActionToObject;

_removeAlivePatients = ["removeAlivePatients", "remove alive patients", "", {

    {
        if (!isPlayer _x) then {
            deleteVehicle _x;
        };
    } foreach allUnits;
}, {true}] call ace_interact_menu_fnc_createAction;
[terminal, 0, ["ACE_MainActions"], _removeAlivePatients] call ace_interact_menu_fnc_addActionToObject;

_removeDeadPatients = ["removeDeadPatients", "remove dead patients", "", {
    {
        deleteVehicle _x;
    } foreach allDeadMen;
}, {true}] call ace_interact_menu_fnc_createAction;
[terminal, 0, ["ACE_MainActions"], _removeDeadPatients] call ace_interact_menu_fnc_addActionToObject;
