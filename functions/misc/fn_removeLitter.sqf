/*
* Author: alganthe
* Remove litter objects
*
* Arguments:
* None
*
* Return Value:
* Nothing
*/
{
    _x params ["", "_objects"];
    {deleteVehicle _x} forEach _objects;
    ace_medical_allCreatedLitter set [_forEachIndex, objNull];
} forEach ace_medical_allCreatedLitter;

ace_medical_allCreatedLitter = ace_medical_allCreatedLitter - [objNull];
