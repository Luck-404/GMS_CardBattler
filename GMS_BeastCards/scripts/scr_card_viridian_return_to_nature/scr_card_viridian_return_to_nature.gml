//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_RETURN_TO_NATURE
// FUNCTION: Resolves Return to Nature.
//           Sacrifices the selected corpse when available.
//           Otherwise causes the caster to lose 10 HP.
//           Generates one Mana after paying either sacrifice.
//
//===============================================================================//
function scr_card_viridian_return_to_nature(_stct_card,_ref_caster,_ref_target){

	//-------------------//
	//PAY SACRIFICE COST//
	//-------------------//
	var _flag_sacrificed = scr_sacrifice_corpse(_ref_target);

	if (!_flag_sacrificed){

		_ref_caster._val_cur_hp -= 10;
		_ref_caster._val_cur_hp = max(0,_ref_caster._val_cur_hp);

		scr_spawn_popup_scrolling(
			"TEXT",
			"-10 HP",
			undefined,
			c_red,
			_ref_caster.x,
			_ref_caster.y - 48
		);
	}

	//-------------//
	//GENERATE MANA//
	//-------------//
	obj_battle_player_controller._val_cur_mana += 1;

	scr_spawn_popup_scrolling(
		"TEXT",
		"+1 MANA",
		undefined,
		c_blue,
		_ref_caster.x,
		_ref_caster.y - 72
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}