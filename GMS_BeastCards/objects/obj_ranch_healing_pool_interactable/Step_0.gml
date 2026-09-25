//===============================================================================//
// STEP: OBJ_RANCH_HEALING_POOL_INTERACTABLE
// FUNCTION: Fully heals all Party Beasts when the player interacts with the
//           Healing Pool.
//           Logs the number of Beasts healed and actual HP restored.
//           Manages highlight and interaction cooldown.
//
//===============================================================================//

//================//
//HANDLE INTERACTION//
//================//
if (
    instance_exists(obj_player) &&
    distance_to_object(obj_player) < 48 &&
    !global.flag_pause
){

    image_index = 1;

    if (
        !_flag_triggered &&
        _ct_cooldown == 0 &&
        keyboard_check_pressed(ord("E"))
    ){

        audio_play_sound(snd_battle_heal,0,false);

        _flag_triggered = true;
        _ct_cooldown = 60;

        scr_overworld_spawn_text_bubble(x,y - 50,"HEALED PARTY");

//================//
//HEAL TRACKING//
//================//
        var _ct_beasts_healed = 0;
        var _val_total_healing = 0;

//================//
//HEAL PARTY//
//================//
        if (
            variable_global_exists("list_player_party") &&
            ds_exists(global.list_player_party,ds_type_list)
        ){

            for (var _it_beast = 0;_it_beast < ds_list_size(global.list_player_party);_it_beast++){

                var _stct_beast = ds_list_find_value(
                    global.list_player_party,
                    _it_beast
                );

                if (!is_struct(_stct_beast)){
                    continue;
                }

                var _val_hp_before = _stct_beast._val_beast_hp_cur;

                _stct_beast._val_beast_hp_cur =
                    _stct_beast._val_beast_hp_max;

                var _val_actual_healing =
                    _stct_beast._val_beast_hp_cur -
                    _val_hp_before;

                if (_val_actual_healing <= 0){
                    continue;
                }

                _ct_beasts_healed++;
                _val_total_healing += _val_actual_healing;
            }
        }

//================//
//DEBUG HEALING//
//================//
        var _ct_party = 0;

        if (
            variable_global_exists("list_player_party") &&
            ds_exists(global.list_player_party,ds_type_list)
        ){
            _ct_party = ds_list_size(global.list_player_party);
        }

        scr_debug_log(
            "BEASTS",
            "HEALING_POOL",
            self,
            "PARTY FULLY HEALED" +
            " | BEASTS HEALED: " +
            string(_ct_beasts_healed) +
            "/" +
            string(_ct_party) +
            " | TOTAL HP: +" +
            string(_val_total_healing),
            "INFO",
            "OBJ_HEALING_POOL_INTERACTABLE:STEP"
        );
    }
}
else{
    image_index = 0;
}

//================//
//UPDATE COOLDOWN//
//================//
if (_ct_cooldown > 0){

    _ct_cooldown--;

    if (_ct_cooldown <= 0){

        _ct_cooldown = 0;
        _flag_triggered = false;
    }
}