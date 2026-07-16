//===============================================================================//
//
// DRAW: OBJ_TREASURE_CHEST
// FUNCTION: Draws chest sprite and shadow.
//           Shows interaction highlight when player is nearby.
//           Opens chest and awards preset or random loot when interacted with.
//
//===============================================================================//

//----//
//DRAW//
//----//
draw_sprite_ext(spr_decor_shadow, image_index, x, y, 0.3, 0.3, 0, _c_chest, 1);
draw_sprite_ext(spr_treasure_chest, image_index, x, y, 1, 1, 0, _c_chest, 1);

//------------//
//OPENED STATE//
//------------//
if (_flag_triggered)
{
	image_index = 1;
}
else
{
	//-----------//
	//INTERACTION//
	//-----------//
	if (instance_exists(obj_player) && distance_to_object(obj_player) < 48)
	{
		draw_sprite(spr_treasure_chest_highlight,0,x,y);

		//--------------------//
		//NEARBY SPARKLE SOUND//
		//--------------------//
		if (!audio_is_playing(_val_nearby_sound_instance))
		{
			_val_nearby_sound_instance = audio_play_sound(snd_treasure_nearby,2,true);
		}

		if (keyboard_check_pressed(ord("E")))
		{
			if (audio_is_playing(_val_nearby_sound_instance))
			{
				audio_stop_sound(_val_nearby_sound_instance);
				_val_nearby_sound_instance = -1;
			}

			audio_play_sound(snd_treasure_chest_open,2,false);
			audio_play_sound(snd_treasure_claim,2,false);

			show_debug_message("\nCHEST: PLAYER HAS PRESSED 'E' ON A CHEST");
		
			_flag_triggered = true;
			image_index = 1;
		
			global.map_player_chests_opened[?_uid_chest] = true;
	
			if (_str_loot_type == "RANDOM")
			{
				show_debug_message("\nCHEST: ROLL RANDOM LOOT");
				hscr_roll_treasure_chest_reward();
			}
			else
			{
				show_debug_message("\nCHEST: ROLL SPECIFIC LOOT");
				hscr_award_custom_treasure_chest_loot();
			}
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
}