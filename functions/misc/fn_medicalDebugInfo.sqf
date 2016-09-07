/*
* Author: alganthe
* Used to show medical debug info
*
* Arguments:
* 0: Unit to monitor each frame <UNIT>
* 1: Display info <BOOL>
*
* Return Value:
* nothing
*/
params ["_target", "_show"];


if (_show && {isNil "derp_debug_medicalInfoToggle"}) then {
    derp_debug_medicalInfoToggle = true;
    [{
        params ["_args", "_pfhID"];
        _args params ["_unit"];

        if (!alive _unit || {!derp_debug_medicalInfoToggle}) then {
            hintSilent "";
            derp_debug_medicalInfoToggle = nil;
            _pfhID call CBA_fnc_removePerFrameHandler;

        } else {
            // Retrieve medical data first
            private _BP = _unit getVariable "ace_medical_bloodPressure";
            private _HR = _unit getVariable "ace_medical_heartRate";
            private _bloodVolume = _unit getVariable "ace_medical_bloodVolume";
            private _pain = _unit getVariable "ace_medical_pain";
            private _bleedState = _unit getVariable "ace_medical_isBleeding";
            private _cardiacArrest = _unit getVariable "ace_medical_inCardiacArrest";
            private _isUnconscious = _unit getVariable "ACE_isUnconscious";
            private _IVBags = _unit getVariable ["ace_medical_ivBags", 'None used'];
            private _painSuppressed = _unit getVariable "ace_medical_painSuppress";
            private _inReviveState = _unit getVariable ["ace_medical_inReviveState", false];
            private _peripheral_resistance = _unit getVariable "ace_medical_peripheralResistance";

            private _roundBabyRoundRound = {
                params ["_n"];
                round (_n * 100) / 100
            };

            private _text = parseText format ["
                <t align='center' size='1.8'>%1</t> <br />
                <t align='left' size='1.4'>Heart rate:</t> <t align='right' size='1.4'>%2</t> <br />
                <t align='left' size='1.4'>Blood pressure:</t> <t align='right' size='1.4'>%3 / %4</t> <br />
                <t align='left' size='1.4'>Volume of blood:</t> <t align='right' size='1.4'>%5</t> <br />
                <t align='left' size='1.4'>Amount of pain:</t> <t align='right' size='1.4'>%6</t> <br />
                <t align='left' size='1.4'>Suppressed pain:</t> <t align='right' size='1.4'>%7</t> <br />
                <t align='left' size='1.4'>Is bleeding:</t> <t align='right' size='1.4'>%8</t> <br />
                <t align='left' size='1.4'>Is unconsious:</t> <t align='right' size='1.4'>%9</t> <br />
                <t align='left' size='1.4'>Cardiac arrest:</t> <t align='right' size='1.4'>%10</t> <br />
                <t align='left' size='1.4'>Is in revive state:</t> <t align='right' size='1.4'>%11</t> <br />
                <t align='left' size='1.4'>IV bags:</t> <t align='right' size='1.4'>%12</t> <br />
                <t align='left' size='1.4'>Peripheral resistance:</t> <t align='right' size='1.4'>%13</t> <br />

                ",
                name _unit,
                _HR call _roundBabyRoundRound,
                _BP select 1 call _roundBabyRoundRound,
                _BP select 0 call _roundBabyRoundRound,
                _bloodVolume call _roundBabyRoundRound,
                _pain call _roundBabyRoundRound,
                _painSuppressed call _roundBabyRoundRound,
                _bleedState,
                _isUnconscious,
                _cardiacArrest,
                _inReviveState,
                _IVBags,
                _peripheral_resistance call _roundBabyRoundRound

            ];
            hintSilent _text;
        };
    }, 0, [_target]] call CBA_fnc_addPerFrameHandler;

} else {
    derp_debug_medicalInfoToggle = false;
};
