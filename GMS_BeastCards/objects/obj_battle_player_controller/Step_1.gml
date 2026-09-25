//===============================================================================//
//
// BEGIN STEP: OBJ_BATTLE_PLAYER_CONTROLLER
// FUNCTION: Chooses focused Cards before selection input and applies
//           explicit left-to-right GUI depth, with hover above all.
//
//===============================================================================//

//================//
//CHEATS GUI LOCK//
//================//
if (
    instance_exists(global.ref_active_gui) &&
    variable_instance_exists(global.ref_active_gui,"_str_type") &&
    global.ref_active_gui._str_type == "CHEATS"
){

    if (
        global.ref_active_gui._str_state == "TOOL" &&
        (
            global.ref_active_gui._str_tool == "DISCARD_CARD" ||
            global.ref_active_gui._str_tool == "EXHAUST_CARD"
        )
    ){
        _ref_hover_card =
            scr_battle_get_hovered_hand_card();
    }
    else{
        _ref_hover_card = undefined;
    }

    exit;
}

_ref_hover_card = scr_battle_get_hovered_hand_card();

for (var _it_card = 0; _it_card < ds_list_size(_list_battle_hand); _it_card++){

    var _ref_card = ds_list_find_value(_list_battle_hand,_it_card);

    if (!instance_exists(_ref_card) || _ref_card._flag_card_moving){
        continue;
    }

    var _val_new_depth = -1000 - _it_card;

    if (_ref_card == _ref_hover_card){
        _val_new_depth = -4000;
    }

    _ref_card._val_card_rest_depth = -1000 - _it_card;

    if (_ref_card.depth != _val_new_depth){
        _ref_card.depth = _val_new_depth;
    }
}
