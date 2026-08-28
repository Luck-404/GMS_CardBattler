//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_CULTIVATE
// FUNCTION: Resolves the Cultivate card effect.
//           Increases current HP, maximum HP, and Magnitude of every minion
//           attached to the selected Beast for the remainder of battle.
//           Refreshes Blooming Sprite's passive after its Magnitude changes.
//
//===============================================================================//
function scr_card_viridian_cultivate(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	if (!ds_exists(_ref_target._list_minions,ds_type_list)){
		return;
	}

	//----------------//
	//BUFF ALL MINIONS//
	//----------------//
	for (
		var _it_minion = 0;
		_it_minion < ds_list_size(_ref_target._list_minions);
		_it_minion++
	){

		var _ref_minion =
			ds_list_find_value(
				_ref_target._list_minions,
				_it_minion
			);

		if (!instance_exists(_ref_minion)){
			continue;
		}

		//-------------//
		//INCREASE HP//
		//-------------//
		scr_grow_minion(
			_ref_minion,
			_stct_card._val_card_magnitude
		);

		//-------------------------//
		//REFRESH PASSIVE MINIONS//
		//-------------------------//
		if (
			_ref_minion._str_name ==
			"BLOOMING SPRITE"
		){
			scr_status_buff_blooming_sprite(
				"APPLY",
				undefined,
				_ref_minion
			);
		}

		//-------------//
		//SPAWN POPUP//
		//-------------//
		scr_spawn_popup_scrolling(
			"TEXT",
			"+" +
				string(_stct_card._val_card_magnitude) +
				"/+" +
				string(_stct_card._val_card_magnitude),
			undefined,
			c_green,
			_ref_minion.x + irandom_range(-16,16),
			_ref_minion.y - 16 + irandom_range(-16,16)
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