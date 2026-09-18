//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_HOVERED_HAND_CARD
// FUNCTION: Finds the frontmost Hand Card under the mouse for controller input.
//           Uses its existing native sprite collision, not a custom mask,
//           visual rectangle, or retained hover state.
//
//===============================================================================//

function scr_battle_get_hovered_hand_card(_ref_previous=undefined){

    //------------------//
    //VALIDATE CONTROLLER//
    //------------------//
    if (!instance_exists(obj_battle_player_controller)){
        return undefined;
    }

    if (instance_exists(obj_gui_end_battle_pane)){
        return undefined;
    }

    var _list_hand = obj_battle_player_controller._list_battle_hand;

    if (!ds_exists(_list_hand,ds_type_list)){
        return undefined;
    }

    var _val_mouse_x = device_mouse_x_to_gui(0);
    var _val_mouse_y = device_mouse_y_to_gui(0);

    //------------------//
    //KEEP PILES CLEAR//
    //------------------//
    if (_val_mouse_x < 96 || _val_mouse_x > 960 || _val_mouse_y < 857 || _val_mouse_y > 1055){
        return undefined;
    }

    //-------------------------//
    //FIND FRONTMOST HAND CARD//
    //-------------------------//
    for (var _it_card = ds_list_size(_list_hand) - 1; _it_card >= 0; _it_card--){

        var _ref_card = ds_list_find_value(_list_hand,_it_card);

        if (!instance_exists(_ref_card)){
            continue;
        }

        if (
            _ref_card._str_team != "PLAYER" ||
            _ref_card._str_location != "HAND" ||
            _ref_card._flag_card_moving
        ){
            continue;
        }

        // Checks the object's actual spr_battle_card_hitbox collision sprite.
        // The artwork stored in _spr_card is never assigned to sprite_index.
        if (collision_point(_val_mouse_x,_val_mouse_y,_ref_card,false,true) == _ref_card){
            return _ref_card;
        }
    }

    return undefined;
}
