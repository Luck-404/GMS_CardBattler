//===============================================================================//
//
// SCRIPT: SCR_BATTLE_REPOSITION_HAND
// FUNCTION: Clamps the complete player Hand within X96-960, Y857-1055.
//           Reflows in-flight and queued draws without teleporting Cards.
//
//===============================================================================//

function scr_battle_reposition_hand(){

    if (!instance_exists(obj_battle_player_controller)){
        return;
    }

    var _list_hand = obj_battle_player_controller._list_battle_hand;
    var _ct_hand = ds_list_size(_list_hand);

    if (_ct_hand <= 0){
        return;
    }

    // 400x600 sprites at 0.30 occupy 120x180 pixels.
    // Card centers must remain inside the card area at idle scale.
    var _val_min_x = 96 + 60;
    var _val_max_x = 960 - 60;
    var _val_center_x = (96 + 960) * 0.5;
    var _val_center_y = (857 + 1055) * 0.5;

    // Up to six Cards use familiar spacing. Larger Hands overlap progressively.
    var _val_step = 135;

    if (_ct_hand > 1){
        _val_step = min(135,(_val_max_x - _val_min_x) / (_ct_hand - 1));
    }

    var _val_start_x = _val_center_x - ((_ct_hand - 1) * _val_step * 0.5);

    for (var _it_card = 0; _it_card < _ct_hand; _it_card++){

        var _ref_card = ds_list_find_value(_list_hand,_it_card);

        if (!instance_exists(_ref_card)){
            continue;
        }

        var _val_target_x = clamp(_val_start_x + (_it_card * _val_step),_val_min_x,_val_max_x);
        var _val_target_y = _val_center_y;

        _ref_card._val_card_hand_target_x = _val_target_x;
        _ref_card._val_card_hand_target_y = _val_target_y;
        _ref_card._val_card_rest_depth = -1000 - _it_card;

        if (_ref_card._flag_card_moving){

            // An active draw may already be travelling toward a previous slot.
            if (_ref_card._str_card_move_type == "DRAW"){
                _ref_card._val_card_move_end_x = _val_target_x;
                _ref_card._val_card_move_end_y = _val_target_y;
            }

            // A gathered Card can have its next draw queued already.
            for (var _it_move = 0; _it_move < array_length(_ref_card._arr_card_move_queue); _it_move++){

                if (_ref_card._arr_card_move_queue[_it_move]._str_type == "DRAW"){
                    _ref_card._arr_card_move_queue[_it_move]._val_end_x = _val_target_x;
                    _ref_card._arr_card_move_queue[_it_move]._val_end_y = _val_target_y;
                }
            }
        }
        else{
            _ref_card.x = _val_target_x;
            _ref_card.y = _val_target_y;
            _ref_card.depth = _ref_card._val_card_rest_depth;
        }
    }
}
