//===============================================================================//
//
// STEP: OBJ_OVERWORLD_TREASURE_CHEST
// FUNCTION: Manages treasure chest proximity audio and interaction input.
//           Starts the nearby loop only while the player is in range.
//           Stops it immediately when the player leaves range, the game pauses,
//           the player disappears, or the chest has already been opened.
//           Opens the chest once when the nearby player presses E.
//           Logs the opening and awards the configured loot.
//
//===============================================================================//

//===============================================================================//
// PROXIMITY AUDIO
//===============================================================================//

var _flag_play_nearby_sound = false;

if (
    !_flag_triggered &&
    instance_exists(obj_player) &&
    !global.flag_pause &&
    distance_to_object(obj_player) < 48
){
    _flag_play_nearby_sound = true;
}

//================//
//START SOUND//
//================//
if (_flag_play_nearby_sound){

    if (
        _val_nearby_sound_handle == -1 ||
        !audio_is_playing(_val_nearby_sound_handle)
    ){

        _val_nearby_sound_handle = audio_play_sound(
            snd_overworld_treasure_nearby,
            2,
            true
        );
    }
}

//================//
//STOP SOUND//
//================//
else{

    hscr_overworld_treasure_stop_nearby_sound();
}

//===============================================================================//
// INTERACTION
//===============================================================================//

//================//
//VALIDATE STATE//
//================//
if (_flag_triggered){
    exit;
}

if (!instance_exists(obj_player)){
    exit;
}

if (global.flag_pause){
    exit;
}

if (distance_to_object(obj_player) >= 48){
    exit;
}

//================//
//OPEN CHEST//
//================//
if (keyboard_check_pressed(ord("E"))){

    hscr_overworld_treasure_stop_nearby_sound();

    audio_play_sound(
        snd_overworld_treasure_chest_open,
        2,
        false
    );

    audio_play_sound(
        snd_overworld_treasure_claim,
        2,
        false
    );

    _flag_triggered = true;
    image_index = 1;

    global.map_player_chests_opened[? _uid_chest] = true;

//================//
//DEBUG OPEN//
//================//
    scr_debug_log(
        "OVERWORLD",
        "TREASURE",
        self,
        "TREASURE CHEST OPENED" +
        " | UID: " + string(_uid_chest) +
        " | CHEST ID: " + string_upper(_str_chest_id) +
        " | LOOT TYPE: " + string_upper(_str_loot_type) +
        " | RARITY: " + string_upper(_str_rarity) +
        " | ROOM: " + room_get_name(room) +
        " | POSITION: (" +
        string(round(x)) + "," +
        string(round(y)) + ")",
        "REWARD",
        "OBJ_OVERWORLD_TREASURE_CHEST:STEP"
    );

//================//
//AWARD LOOT//
//================//
    if (_str_loot_type == "RANDOM"){

        hscr_overworld_treasure_award_random_loot();
    }
    else{

        hscr_overworld_treasure_award_custom_loot();
    }
}