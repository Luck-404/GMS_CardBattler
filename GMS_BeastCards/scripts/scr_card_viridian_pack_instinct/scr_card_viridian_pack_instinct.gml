//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PACK_INSTINCT
// FUNCTION: Resolves the Pack Instinct card effect.
//           Applies Pack Instinct to every living allied Beast for 4 rounds.
//           Each affected Beast gains bonuses based on its living Minion count.
//
//===============================================================================//
function scr_card_viridian_pack_instinct(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//GET ALLIED TEAM//
	//----------------//
	var _list_allies = scr_get_target_team_list(_ref_caster);

	if (_list_allies == undefined){
		return;
	}

	//----------------------//
	//STORE CURRENT TARGET//
	//----------------------//
	var _ref_original_target = global.ref_target_beast;

	//-----------------------//
	//APPLY TO ALLIED BEASTS//
	//-----------------------//
	for (var _it_ally = 0; _it_ally < ds_list_size(_list_allies); _it_ally++){

		var _ref_ally = ds_list_find_value(_list_allies,_it_ally);

		if (!instance_exists(_ref_ally)){
			continue;
		}

		if (_ref_ally._val_cur_hp <= 0){
			continue;
		}

		global.ref_target_beast = _ref_ally;

		scr_apply_buff_status("PACK_INSTINCT",2,4);
	}

	//----------------//
	//RESTORE TARGET//
	//----------------//
	global.ref_target_beast = _ref_original_target;

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}