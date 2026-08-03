//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_GERMINATE
// FUNCTION: Resolves Germinate.
//           Immediately hatches all existing Dormant Seeds on the target.
//           Then summons two fresh Dormant Seeds on the target.
//
//===============================================================================//
function scr_card_viridian_germinate(_stct_card,_ref_caster,_ref_target){

	if (!instance_exists(_ref_target)){
		return;
	}

	//---------------------//
	//HATCH EXISTING SEEDS//
	//---------------------//
	for (var _it_minion = ds_list_size(_ref_target._list_minions) - 1; _it_minion >= 0; _it_minion--){

		var _ref_minion = ds_list_find_value(_ref_target._list_minions,_it_minion);

		if (!instance_exists(_ref_minion)){
			continue;
		}

		if (_ref_minion._str_name != "DORMANT SEED"){
			continue;
		}

		scr_hatch_dormant_seed(_ref_minion);
	}

	//--------------------//
	//SUMMON DORMANT SEEDS//
	//--------------------//
	repeat (2){
		scr_init_minion("DORMANT_SEED",_stct_card,_ref_caster,_ref_target);
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}