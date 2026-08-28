//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_NATURAL_CYCLE
// FUNCTION: Resolves Natural Cycle.
//           Sacrifices the oldest Minion on the selected allied Beast.
//           Heals its host and draws two cards.
//           Fails if the selected Beast has no Minions.
//
//===============================================================================//
function scr_card_viridian_natural_cycle(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	//----------------//
	//CHECK MINIONS//
	//----------------//
	if (ds_list_size(_ref_target._list_minions) <= 0){

		audio_play_sound(snd_error,0,false);
		scr_spawn_popup_error("NO MINIONS",60);

		return false;
	}

	//------------------//
	//GET OLDEST MINION//
	//------------------//
	var _ref_minion = ds_list_find_value(
		_ref_target._list_minions,
		0
	);

	if (!instance_exists(_ref_minion)){

		audio_play_sound(snd_error,0,false);
		scr_spawn_popup_error("NO MINIONS",60);

		return false;
	}

	//----------------//
	//SACRIFICE MINION//
	//----------------//
	scr_destroy_minion(_ref_minion,"SACRIFICE");

	//-----------//
	//HEAL HOST//
	//-----------//
	scr_heal_target(_stct_card._val_card_magnitude,_ref_target);

	//-----------//
	//DRAW CARDS//
	//-----------//
	scr_draw_cards(2);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_heal,0,false);

	return true;
}