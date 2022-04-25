/// @param [array]
/// @param [playerIndex]

function input_check_press_most_recent(_verb_names = all, _player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _verbs_struct = global.__input_players[_player_index].verbs;
    if (!is_array(_verb_names)) _verb_names = global.__input_verb_array;
    
    var _max_time = -1;
    var _max_verb = undefined;
    var _i = 0;
    repeat(array_length(_verb_names))
    {
        var _verb = _verb_names[_i];
        var _verb_struct = _verbs_struct[$ _verb];
        
        if ((_verb_struct.press_time > _max_time) && input_check(_verb, _player_index))
        {
            _max_time = _verb_struct.press_time;
            _max_verb = _verb;
        }
        
        ++_i;
    }
    
    return _max_verb;
}