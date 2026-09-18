//===============================================================================//
//
// SCRIPT: SCR_BATTLE_MOVE_CARD_BETWEEN_PILES
// FUNCTION: Routes a Card through the four standardized pile/Hand centers.
//           Chooses the corresponding grow/shrink/flip movement type.
//
//===============================================================================//

function scr_battle_move_card_between_piles(_ref_card,_str_from,_str_to,_ct_duration=8,_ct_delay=0){

    if (!instance_exists(_ref_card)){
        return false;
    }

    var _stct_from = scr_battle_get_card_pile_position(_str_from);
    var _stct_to = scr_battle_get_card_pile_position(_str_to);

    if (_str_from == "HAND"){
        _stct_from._val_x = _ref_card.x;
        _stct_from._val_y = _ref_card.y;
    }

    if (_str_to == "HAND"){
        _stct_to._val_x = _ref_card._val_card_hand_target_x;
        _stct_to._val_y = _ref_card._val_card_hand_target_y;
    }

    var _str_type = "TRANSFER";

    if (_str_to == "HAND"){
        _str_type = "DRAW";
    }
    else if (_str_from == "HAND"){
        _str_type = (_str_to == "DECK") ? "RETURN" : _str_to;
    }
    else if (_str_from == "DISCARD" && _str_to == "DECK"){
        _str_type = "GATHER";
    }
    else if (_str_from == "EXHAUST" && _str_to == "DECK"){
        _str_type = "RECOVER";
    }

    return scr_battle_start_card_move_animation(
        _ref_card,
        _str_type,
        _stct_from._val_x,
        _stct_from._val_y,
        _stct_to._val_x,
        _stct_to._val_y,
        _ct_duration,
        _ct_delay
    );
}
