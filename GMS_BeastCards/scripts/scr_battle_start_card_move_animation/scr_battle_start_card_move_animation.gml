//===============================================================================//
//
// SCRIPT: SCR_BATTLE_START_CARD_MOVE_ANIMATION
// FUNCTION: Animates movement, growth, shrinkage, and optional flips.
//           Queues transitions when a Card is already moving.
//
//===============================================================================//

function scr_battle_start_card_move_animation(_ref_card,_str_move_type,_val_start_x,_val_start_y,_val_end_x,_val_end_y,_ct_move_duration=8,_ct_move_delay=0){

    if (!instance_exists(_ref_card)){
        return false;
    }

    // This queue is per Card; game-state list transfers remain synchronous.
    if (_ref_card._flag_card_moving){

        array_push(_ref_card._arr_card_move_queue,{
            _str_type : _str_move_type,
            _val_start_x : _val_start_x,
            _val_start_y : _val_start_y,
            _val_end_x : _val_end_x,
            _val_end_y : _val_end_y,
            _ct_duration : max(1,_ct_move_duration),
            _ct_delay : max(0,_ct_move_delay)
        });

        return true;
    }

    _ref_card._flag_card_moving = true;
    _ref_card._flag_card_move_sfx_played = false;
    _ref_card._str_card_move_type = _str_move_type;

    _ref_card._ct_card_move_timer = 0;
    _ref_card._ct_card_move_duration = max(1,_ct_move_duration);
    _ref_card._ct_card_move_delay = max(0,_ct_move_delay);

    _ref_card._val_card_move_start_x = _val_start_x;
    _ref_card._val_card_move_start_y = _val_start_y;
    _ref_card._val_card_move_end_x = _val_end_x;
    _ref_card._val_card_move_end_y = _val_end_y;
    _ref_card._val_card_move_progress = 0;

    // Pile cards are small; Cards entering the Hand grow to idle size.
    switch (_str_move_type){

        case "DRAW":
            _ref_card._val_card_move_scale_start = 0.08;
            _ref_card._val_card_move_scale_end = 0.30;
            _ref_card._flag_card_move_flip = true;
        break;

        case "DISCARD":
        case "EXHAUST":
        case "RETURN":
            _ref_card._val_card_move_scale_start = 0.30;
            _ref_card._val_card_move_scale_end = 0.08;
            _ref_card._flag_card_move_flip = true;
        break;

        default:
            _ref_card._val_card_move_scale_start = 0.08;
            _ref_card._val_card_move_scale_end = 0.08;
            _ref_card._flag_card_move_flip = false;
        break;
    }

    _ref_card.x = _val_start_x;
    _ref_card.y = _val_start_y;
    _ref_card.depth = -3000;

    return true;
}
