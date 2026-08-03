//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_FUNGAL_RECYCLING
// FUNCTION: Resolves Fungal Recycling.
//           Sacrifices the selected corpse when available.
//           Otherwise causes the caster to lose 10 HP.
//           Returns a random exhausted Viridian card to the draw pile.
//
//===============================================================================//

function scr_card_viridian_fungal_recycling(_stct_card,_ref_caster,_ref_target){

	//-------------------//
	//PAY SACRIFICE COST//
	//-------------------//
	var _flag_sacrificed =
		scr_sacrifice_corpse(_ref_target);

	if (!_flag_sacrificed){

		_ref_caster._val_cur_hp -= 10;

		_ref_caster._val_cur_hp =
			max(
				0,
				_ref_caster._val_cur_hp
			);

		scr_spawn_popup_scrolling("TEXT","-10 HP",undefined,c_red,_ref_caster.x,_ref_caster.y - 48);
	}

	//----------------------//
	//RECOVER VIRIDIAN CARD//
	//----------------------//
	var _ref_recovered =
		scr_recover_random_exhausted_card(
			"VIRIDIAN"
		);

	if (instance_exists(_ref_recovered)){

		scr_spawn_popup_scrolling(
			"TEXT",
			"RECOVERED: " +
				string(
					_ref_recovered
						._ref_card
						._str_card_name
				),
			undefined,
			c_green,
			room_width * 0.5,
			room_height * 0.5
		);
	}
	else{

		scr_spawn_popup_scrolling(
			"TEXT",
			"NO VIRIDIAN CARD TO RECOVER",
			undefined,
			c_ltgray,
			room_width * 0.5,
			room_height * 0.5
		);
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}