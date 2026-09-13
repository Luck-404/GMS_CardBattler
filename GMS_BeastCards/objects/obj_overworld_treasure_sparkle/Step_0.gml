//===============================================================================//
//
// STEP: OBJ_OVERWORLD_TREASURE_SPARKLE
// FUNCTION: Updates visibility timing and interaction state.
//           Handles proximity audio, treasure collection, and cooldown.
//           Continues updating even while the sparkle is invisible.
//
//===============================================================================//

//================//
//VISIBILITY TIMER//
//================//
if (!visible){

	hscr_overworld_treasure_sparkle_stop_nearby_sound();

	if (_ct_visibility_timer > 0){
		_ct_visibility_timer--;
	}
	else{
		hscr_overworld_treasure_sparkle_roll_visibility();
	}
}

//================//
//PLAYER INTERACTION//
//================//
if (
	visible &&
	instance_exists(obj_player) &&
	distance_to_object(obj_player) < 48 &&
	!_flag_triggered &&
	!global.flag_pause
){

	//----------------//
	//NEARBY SOUND//
	//----------------//
	if (!audio_is_playing(_val_nearby_sound_handle)){

		_val_nearby_sound_handle = audio_play_sound(
			snd_overworld_treasure_nearby,
			2,
			true
		);
	}

	//----------------//
	//COLLECT TREASURE//
	//----------------//
	if (keyboard_check_pressed(ord("E"))){

		hscr_overworld_treasure_sparkle_stop_nearby_sound();

		audio_play_sound(snd_overworld_treasure_claim,2,false);

		_flag_triggered = true;
		_ct_interaction_cooldown = 10;

		hscr_overworld_treasure_sparkle_award_reward();

		hscr_overworld_treasure_sparkle_roll_rarity();
		hscr_overworld_treasure_sparkle_roll_position();
		hscr_overworld_treasure_sparkle_roll_visibility();
	}
}
else{

	hscr_overworld_treasure_sparkle_stop_nearby_sound();
}

//================//
//INTERACTION COOLDOWN//
//================//
if (_ct_interaction_cooldown > 0){

	_ct_interaction_cooldown--;

	if (_ct_interaction_cooldown <= 0){

		_ct_interaction_cooldown = 0;
		_flag_triggered = false;
	}
}