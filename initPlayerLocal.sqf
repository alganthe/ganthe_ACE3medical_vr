[terminal1, spawnArea1] call derp_fnc_actions;
[terminal2, spawnArea2] call derp_fnc_actions;
[terminal3, spawnArea3] call derp_fnc_actions;
[terminal4, spawnArea4] call derp_fnc_actions;

player allowDamage false;

if ("Debug" call BIS_fnc_getParamValue == 1) then {
    private _debugAction = [
            "ShowMedicalDebugInfo",
            "Toggle medical debug info",
            "",
            {
                [cursorObject, true] call derp_fnc_medicalDebugInfo;
            },
            {cursorObject isKindOf "CAManBase" || {!isNil "derp_debug_medicalInfoToggle"}}
        ] call ace_interact_menu_fnc_createAction;
    [Player, 1, ["ACE_SelfActions"], _debugAction] call ace_interact_menu_fnc_addActionToObject;
};
