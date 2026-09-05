//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_DROP_ANCHOR
// FUNCTION: Resolves the Drop Anchor card effect.
//           Grants all allied Beasts Immovable for 2 rounds.
//
//===============================================================================//
function scr_card_cerulean_drop_anchor(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//GET ALLIED TEAM//
	//----------------//
	var _list_targets =
		scr_get_target_team_list(_ref_caster);

	//----------------//
	//APPLY IMMOVABLE//
	//----------------//
	for (
		var _it_target = 0;
		_it_target < ds_list_size(_list_targets);
		_it_target++
	){

		global.ref_target_beast =
			ds_list_find_value(
				_list_targets,
				_it_target
			);

		scr_apply_buff_status(
			"IMMOVABLE",
			0,
			2
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