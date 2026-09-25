//===============================================================================//
//
// STEP: OBJ_OVERWORLD_TREASURE_SPARKLE
// FUNCTION: Updates visibility timing and interaction state.
//           Owns the looping treasure proximity sound.
//           Stops the loop immediately when the player leaves range, the game
//           pauses, the sparkle is hidden/claimed, or the player disappears.
//           Handles treasure collection and interaction cooldown.
//
//===============================================================================//

//===============================================================================//
// VISIBILITY TIMER
//===============================================================================//

if (!visible){

    hscr_overworld_treasure_sparkle_stop_nearby_sound();

    if (_ct_visibility_timer > 0){
        _ct_visibility_timer--;
    }
    else{
        hscr_overworld_treasure_sparkle_roll_visibility();
    }
}

//===============================================================================//
// PROXIMITY AUDIO
//===============================================================================//

var _flag_play_nearby_sound = false;

if (
    visible &&
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

    hscr_overworld_treasure_sparkle_stop_nearby_sound();
}

//===============================================================================//
// PLAYER INTERACTION
//===============================================================================//

if (
    visible &&
    instance_exists(obj_player) &&
    distance_to_object(obj_player) < 48 &&
    !_flag_triggered &&
    !global.flag_pause
){

//================//
//COLLECT TREASURE//
//================//
    if (keyboard_check_pressed(ord("E"))){

        hscr_overworld_treasure_sparkle_stop_nearby_sound();

        audio_play_sound(
            snd_overworld_treasure_claim,
            2,
            false
        );

        _flag_triggered = true;
        _ct_interaction_cooldown = 10;

        hscr_overworld_treasure_sparkle_award_reward();

        hscr_overworld_treasure_sparkle_roll_rarity();
        hscr_overworld_treasure_sparkle_roll_position();
        hscr_overworld_treasure_sparkle_roll_visibility();
    }
}

//===============================================================================//
// INTERACTION COOLDOWN
//===============================================================================//

if (_ct_interaction_cooldown > 0){

    _ct_interaction_cooldown--;

    if (_ct_interaction_cooldown <= 0){

        _ct_interaction_cooldown = 0;
        _flag_triggered = false;
    }
}