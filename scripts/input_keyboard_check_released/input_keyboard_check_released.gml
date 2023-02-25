/// @desc    Checks if the given key is newly deactivated this frame.
/// @param   binding

function input_keyboard_check_released(_binding)
{
    __INPUT_GLOBAL_STATIC_LOCAL
    
    if (!global.__input_keyboard_allowed || global.__input_cleared)
    {
        return false;
    }
    
    return keyboard_check_released(_binding);
}
