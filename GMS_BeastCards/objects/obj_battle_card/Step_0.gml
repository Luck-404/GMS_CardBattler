//===============================================================================//
//
// STEP: OBJ_BATTLE_CARD
// FUNCTION: Updates animated Card travel, scale, flip, transition queues,
//           and destination VFX without changing logical Card-list membership.
//
//===============================================================================//

if (!_flag_card_moving){
    exit;
}

#region CARD MOVEMENT

//-----------//
//START DELAY//
//-----------//
if (_ct_card_move_delay > 0){
    _ct_card_move_delay--;

    if (_ct_card_move_delay > 0){
        exit;
    }
}

//--------//
//PLAY SFX//
//--------//
if (!_flag_card_move_sfx_played){
    _flag_card_move_sfx_played = true;

    if (_str_card_move_type == "DRAW"){
        audio_play_sound(snd_battle_card_draw,0,false);
    }
}

//-----------------//
//ADVANCE PROGRESS//
//-----------------//
_ct_card_move_timer++;
_val_card_move_progress = clamp(_ct_card_move_timer / _ct_card_move_duration,0,1);
var _val_eased = 1 - power(1 - _val_card_move_progress,3);

x = lerp(_val_card_move_start_x,_val_card_move_end_x,_val_eased);
y = lerp(_val_card_move_start_y,_val_card_move_end_y,_val_eased);

//-----------------//
//FINISH MOVEMENT//
//-----------------//
if (_val_card_move_progress >= 1){

    var _str_finished_type = _str_card_move_type;

    x = _val_card_move_end_x;
    y = _val_card_move_end_y;

    _flag_card_moving = false;
    _flag_card_move_sfx_played = false;
    _str_card_move_type = "";
    _ct_card_move_timer = 0;

    if (_str_finished_type == "DISCARD" || _str_finished_type == "EXHAUST"){
        scr_battle_vfx_expend(undefined,x,y,0);
    }

    // Finish the earlier transfer before starting any later queued transfer.
    if (array_length(_arr_card_move_queue) > 0){

        var _stct_next = _arr_card_move_queue[0];
        array_delete(_arr_card_move_queue,0,1);

        scr_battle_start_card_move_animation(
            self,
            _stct_next._str_type,
            _stct_next._val_start_x,
            _stct_next._val_start_y,
            _stct_next._val_end_x,
            _stct_next._val_end_y,
            _stct_next._ct_duration,
            _stct_next._ct_delay
        );
    }
    else if (_str_location == "HAND"){
        x = _val_card_hand_target_x;
        y = _val_card_hand_target_y;
        depth = _val_card_rest_depth;
    }
    else{
        depth = _val_card_base_depth;
    }
}

#endregion
