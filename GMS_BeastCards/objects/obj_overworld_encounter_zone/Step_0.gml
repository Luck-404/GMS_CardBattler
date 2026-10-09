//===============================================================================//
//
// STEP: OBJ_OVERWORLD_ENCOUNTER_ZONE
// FUNCTION: Rolls random encounters while the player moves through the zone.
//           Rolls natural Elite metadata only after successfully claiming the
//           battle transition, then stores battle-return and encounter state.
//           Generates plant-litter traversal effects.
//
//===============================================================================//

//================//
//VALIDATE PLAYER//
//================//
if (!instance_exists(obj_player)){
    exit;
}

if (!place_meeting(x,y,obj_player) || !obj_player._flag_player_moving){
    exit;
}

//================//
//ENCOUNTER ATTEMPT//
//================//
if (
    _ct_encounter_attempt_cooldown <= 0 &&
    !instance_exists(obj_transition) &&
    !instance_exists(obj_transition_fader)
){

    var _val_encounter_roll = irandom_range(1,100);

    if (_val_encounter_roll <= _val_encounter_chance){

//================//
//CLAIM TRANSITION//
//================//
        var _ref_transition =
            scr_transition_trigger(
                rm_battle
            );

        if (!instance_exists(_ref_transition)){
            _ct_encounter_attempt_cooldown = 30;
            exit;
        }

//========================//
//ROLL ENCOUNTER SCALING//
//========================//
        var _stct_encounter_scaling =
            scr_overworld_roll_encounter_scaling(
                room
            );

        if (!is_struct(_stct_encounter_scaling)){
            with (_ref_transition){
                instance_destroy();
            }

            _ct_encounter_attempt_cooldown = 30;
            exit;
        }

//================//
//ROLL ELITE//
//================//
        var _stct_elite_roll =
            scr_overworld_roll_elite_encounter();

        if (is_struct(_stct_elite_roll)){
            _stct_encounter_scaling._flag_elite_encounter =
                _stct_elite_roll._flag_elite;

            _stct_encounter_scaling._str_elite_modifier =
                _stct_elite_roll._str_elite_modifier;

            _stct_encounter_scaling._val_elite_risk_tier =
                _stct_elite_roll._val_elite_risk_tier;

            _stct_encounter_scaling._val_elite_chance_percent =
                _stct_elite_roll._val_elite_chance_percent;

            _stct_encounter_scaling._val_elite_roll =
                _stct_elite_roll._val_elite_roll;

            _stct_encounter_scaling._str_elite_source_item_id =
                _stct_elite_roll._str_elite_source_item_id;
        }
        else{
            _stct_encounter_scaling._flag_elite_encounter = false;
            _stct_encounter_scaling._str_elite_modifier = "";
            _stct_encounter_scaling._val_elite_risk_tier = 0;
            _stct_encounter_scaling._val_elite_chance_percent = 4;
            _stct_encounter_scaling._val_elite_roll = -1;
            _stct_encounter_scaling._str_elite_source_item_id = "BASE";
        }

//----------------//
//SHOW FEEDBACK//
//----------------//
        scr_gui_spawn_popup(
            "TEXT",
            "BATTLE TRIGGERED",
            undefined,
            c_black,
            obj_player.x,
            obj_player.y
        );

//--------------------//
//STORE SOURCE DETAILS//
//--------------------//
        var _str_source_room = string_upper(room_get_name(room));
        var _val_source_x = round(obj_player.x);
        var _val_source_y = round(obj_player.y);

        var _str_loot_zone_id = "UNASSIGNED";

        if (
            variable_instance_exists(
                id,
                "_str_loot_zone_id"
            ) &&
            is_string(
                self._str_loot_zone_id
            ) &&
            self._str_loot_zone_id != ""
        ){
            _str_loot_zone_id =
                string_upper(
                    self._str_loot_zone_id
                );
        }

//------------------//
//STORE RETURN STATE//
//------------------//
        global.val_last_player_x = obj_player.x;
        global.val_last_player_y = obj_player.y;

        global.rm_last_player = room;
        global.arr_last_enemy_pool = _arr_encounter_beasts;
        global.str_last_loot_zone_id = _str_loot_zone_id;

// Grass encounters never force a visible overworld Beast into slot 0.
        global.stct_forced_enemy_unit = undefined;

        global.stct_encounter_scaling =
            _stct_encounter_scaling;

//----------------//
//DEBUG BATTLE ENTRY//
//----------------//
        scr_debug_log(
            "BATTLE",
            "ENTRY",
            obj_player,
            "PLAYER ENTERED BATTLE FROM " + _str_source_room +
            " (" + string(_val_source_x) + "," + string(_val_source_y) + ")" +
            " | TRIGGER: GRASS" +
            " | ENCOUNTER POOL: " + string(array_length(_arr_encounter_beasts)) +
            " | LOOT ZONE: " + _str_loot_zone_id +
            " | DIFFICULTY: " + _stct_encounter_scaling._str_difficulty +
            " | ELITE: " +
            (
                _stct_encounter_scaling._flag_elite_encounter
                ? "YES (" +
                    _stct_encounter_scaling._str_elite_modifier +
                    ")"
                : "NO"
            ) +
            " | ELITE ROLL: " +
            string(
                _stct_encounter_scaling._val_elite_roll
            ) +
            "/100" +
            " | ELITE CHANCE: " +
            string(
                _stct_encounter_scaling
                    ._val_elite_chance_percent
            ) +
            "%" +
            " | ELITE SOURCE: " +
            _stct_encounter_scaling
                ._str_elite_source_item_id +
            " | RISK TIER: " +
            string(
                _stct_encounter_scaling
                    ._val_elite_risk_tier
            ) +
            " | ENEMIES: " + string(_stct_encounter_scaling._ct_enemy_beasts) +
            " | ZONE LEVELS: " +
            string(_stct_encounter_scaling._val_zone_level_min) +
            "-" +
            string(_stct_encounter_scaling._val_zone_level_max) +
            " | LEVEL TARGET: " +
            string(_stct_encounter_scaling._val_enemy_level_target),
            "TRANSITION",
            "OBJ_OVERWORLD_ENCOUNTER_ZONE:STEP"
        );

//----------------//
//LOCK PLAYER//
//----------------//
        scr_player_set_movement_state("STOP");

        obj_player.visible = false;

//----------------//
//START BATTLE//
//----------------//
        audio_play_sound(
            snd_overworld_encounter_trigger,
            0,
            false
        );
    }

    _ct_encounter_attempt_cooldown = 30;
}
else if (_ct_encounter_attempt_cooldown > 0){
    _ct_encounter_attempt_cooldown--;
}

//================//
//PLANT LITTER FX//
//================//
if (_ct_scene_fx_litter_timer <= 0){

    _ct_scene_fx_litter_timer = 20;

    scr_overworld_spawn_vfx_plant_litter();
}
else{
    _ct_scene_fx_litter_timer--;
}