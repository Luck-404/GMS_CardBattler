//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SNOWFORT
// FUNCTION: Resolves Snowfort.
//           Grants 6 Armor to every living allied Beast.
//
//===============================================================================//

function scr_card_cerulean_snowfort(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//GET ALLIED TEAM LIST//
	//--------------------//
	var _list_allies = scr_get_target_team_list(_ref_caster);

	if (_list_allies == undefined){
		return;
	}

	//----------------//
	//GRANT TEAM ARMOR//
	//----------------//
	for (var _it_ally = 0; _it_ally < ds_list_size(_list_allies); _it_ally++){

		var _ref_ally = ds_list_find_value(_list_allies,_it_ally);

		if (!instance_exists(_ref_ally)){
			continue;
		}

		if (
			_ref_ally._str_list != "ALIVE" ||
			_ref_ally._val_cur_hp <= 0
		){
			continue;
		}

		scr_armor_target(_stct_card._val_card_magnitude,_ref_ally);
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_battle_sfx_armor,0,false);
}