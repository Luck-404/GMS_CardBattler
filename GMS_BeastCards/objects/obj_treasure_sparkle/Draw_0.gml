//===============================================================================//
//
// DRAW: OBJ_TREASURE_SPARKLE
// FUNCTION: Draws the treasure sparkle.
//           Handles visibility reroll timing while hidden.
//           Allows nearby player interaction to collect and reroll treasure.
//
//===============================================================================//

//----//
//DRAW//
//----//
draw_sprite_ext(spr_treasure_sparkle,image_index,x,y,1,1,0,_c_sparkle,1);

//----------------------//
//VISIBILITY TIMER/REROLL//
//----------------------//
if (!visible)
{
	if (_val_visibility_timer > 0)
	{
		_val_visibility_timer--;
	}
	else
	{
		hscr_roll_treasure_sparkle_visibility();
	}
}

//-----------//
//INTERACTION//
//-----------//
if (instance_exists(obj_player) && distance_to_object(obj_player) < 48 && !_flag_triggered)
{
	draw_sprite(spr_treasure_sparkle_highlight,0,x,y);
	
	//--------------------//
	//NEARBY SPARKLE SOUND//
	//--------------------//
	if (!audio_is_playing(_val_nearby_sound_instance))
	{
		_val_nearby_sound_instance = audio_play_sound(snd_treasure_nearby,2,true);
	}
	
	if (keyboard_check_pressed(ord("E")) && !_flag_triggered)
	{
		if (audio_is_playing(_val_nearby_sound_instance))
		{
			audio_stop_sound(_val_nearby_sound_instance);
			_val_nearby_sound_instance = -1;
		}
		
		audio_play_sound(snd_treasure_claim,2,false);

		_flag_triggered = true;
		_ct_cooldown = 10;
		
		hscr_roll_treasure_sparkle_reward();
		
		hscr_roll_treasure_sparkle_rarity();
		hscr_roll_treasure_sparkle_position();
		hscr_roll_treasure_sparkle_visibility();
	}
}
else
{
	if (audio_is_playing(_val_nearby_sound_instance))
	{
		audio_stop_sound(_val_nearby_sound_instance);
		_val_nearby_sound_instance = -1;
	}
}

//---------//
//COOLDOWNS//
//---------//
if (_ct_cooldown > 0)
{
	_ct_cooldown--;

	if (_ct_cooldown <= 0)
	{
		_ct_cooldown = 0;
		_flag_triggered = false;
	}
}