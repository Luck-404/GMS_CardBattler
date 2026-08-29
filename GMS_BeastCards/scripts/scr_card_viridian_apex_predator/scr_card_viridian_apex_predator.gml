//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_APEX_PREDATOR
// FUNCTION: Resolves the Apex Predator Archetype card.
//           Removes all cleansable DoTs, Debuffs, and CC from allied Beasts.
//           Gains one permanent Apex stack per negative stack removed.
//           Each Apex stack grants +2 linear damage.
//           Heals the caster for 2 HP per negative stack removed.
//
//===============================================================================//
function scr_card_viridian_apex_predator(_stct_card,_ref_caster,_ref_target){

	if (!instance_exists(_ref_caster)){
		return false;
	}

	//--------------------//
	//GET ALLIED TEAM LIST//
	//--------------------//
	var _list_allies = scr_get_target_team_list(_ref_caster);

	if (_list_allies == undefined){
		return false;
	}

	var _ct_total_stacks = 0;

	//------------------------//
	//CLEANSE THE ENTIRE TEAM//
	//------------------------//
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

		_ct_total_stacks += scr_cleanse_negative_stacks(_ref_ally);
	}

	//----------------//
	//NO STACKS FOUND//
	//----------------//
	if (_ct_total_stacks <= 0){

		audio_play_sound(snd_buff,0,false);

		return true;
	}

	//----------------//
	//STORE OLD TARGET//
	//----------------//
	var _ref_original_target =
		global.ref_target_beast;

	//-------------//
	//TARGET CASTER//
	//-------------//
	global.ref_target_beast =
		_ref_caster;

	//----------------//
	//GAIN APEX STACKS//
	//----------------//
	scr_apply_buff_status(
		"APEX_PREDATOR",
		_ct_total_stacks,
		-1
	);

	//-------------//
	//HEAL CASTER//
	//-------------//
	scr_heal_target(
		_ct_total_stacks * 2,
		_ref_caster
	);

	//----------------//
	//RESTORE TARGET//
	//----------------//
	global.ref_target_beast =
		_ref_original_target;

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);

	return true;
}