//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_AVALANCHE_STRIKE
// FUNCTION: Resolves the Avalanche Strike card effect.
//           Deals physical damage to the front two living Beasts
//           on the selected enemy team.
//
//===============================================================================//

function scr_card_cerulean_avalanche_strike(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//GET TARGET TEAM LIST//
	//--------------------//
	var _list_targets = scr_get_target_team_list(_ref_target);

	if (_list_targets == undefined){
		return;
	}

	if (ds_list_size(_list_targets) <= 0){
		return;
	}

	//----------------//
	//GET FRONT TARGET//
	//----------------//
	var _ref_front_target = ds_list_find_value(_list_targets,0);

	//-----------------//
	//GET SECOND TARGET//
	//-----------------//
	var _ref_second_target = undefined;

	if (ds_list_size(_list_targets) >= 2){
		_ref_second_target = ds_list_find_value(_list_targets,1);
	}

	//-------------------//
	//DAMAGE FRONT TARGET//
	//-------------------//
	if (instance_exists(_ref_front_target)){
		scr_damage_target(_stct_card._val_card_magnitude,_ref_front_target);
	}

	//--------------------//
	//DAMAGE SECOND TARGET//
	//--------------------//
	if (instance_exists(_ref_second_target)){
		scr_damage_target(_stct_card._val_card_magnitude,_ref_second_target);
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}