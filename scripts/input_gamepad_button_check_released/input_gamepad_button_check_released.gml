/// @param gamepadIndex
/// @param GMconstant

function input_gamepad_button_check_released(_index, _gm)
{
    var _gamepad = global.__input_gamepads[_index];
    if (!is_struct(_gamepad)) return false;
    return _gamepad.get_released(_gm);
}