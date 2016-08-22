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

derp_patientArray set [_arrayIndex, (derp_patientArray select _arrayIndex) select {!isNull _x}];
publicVariable "derp_patientArray";
