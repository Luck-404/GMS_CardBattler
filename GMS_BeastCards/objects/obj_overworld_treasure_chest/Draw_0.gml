//===============================================================================//
//
// DRAW: OBJ_OVERWORLD_TREASURE_CHEST
// FUNCTION: Draws the treasure chest and ground shadow.
//           Shows interaction feedback while the player is nearby.
//           Logs chest opening and awards its configured loot.
//
//===============================================================================//

//================//
//DRAW CHEST//
//================//
draw_sprite_ext(
	spr_overworld_decor_shadow,
	0,
	x,
	y,
	0.3,
	0.3,
	0,
	_c_chest,
	1
);

draw_sprite_ext(
	spr_overworld_treasure_chest,
	image_index,
	x,
	y,
	1,
	1,
	0,
	_c_chest,
	1
);

//================//
//OPENED STATE//
//================//
if (_flag_triggered){

	image_index = 1;

	hscr_overworld_treasure_stop_nearby_sound();

	return;
}

//================//
//PLAYER INTERACTION//
//================//
if (
	instance_exists(obj_player) &&
	distance_to_object(obj_player) < 48 &&
	!global.flag_pause
){

	draw_sprite(
		spr_overworld_treasure_chest_highlight,
		0,
		x,
		y
	);

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
			"OBJ_OVERWORLD_TREASURE_CHEST:DRAW"
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
}
else{

	hscr_overworld_treasure_stop_nearby_sound();
}