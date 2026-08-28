//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_APEX_PREDATOR
// FUNCTION: Resolves the Apex Predator Archetype card.
//           Removes all cleansable DoTs, Debuffs, and CC from every living
//           allied Beast.
//           Counts every individual status stack removed.
//           For each stack consumed, permanently grants the caster +2 linear
//           damage for the remainder of battle and heals the caster for 2 HP.
//
//===============================================================================//

function scr_card_viridian_apex_predator(_stct_card,_ref_caster,_ref_target){

	if (!instance_exists(_ref_caster)){
		return false;
	}

	//--------------------//
	//GET ALLIED TEAM LIST//
	//--------------------//
	var _list_allies =
		scr_get_target_team_list(
			_ref_caster
		);

	if (_list_allies == undefined){
		return false;
	}

	var _ct_total_stacks =
		0;

	//------------------------//
	//CLEANSE THE ENTIRE TEAM//
	//------------------------//
	for (
		var _it_ally = 0;
		_it_ally < ds_list_size(_list_allies);
		_it_ally++
	){

		var _ref_ally =
			ds_list_find_value(
				_list_allies,
				_it_ally
			);

		if (!instance_exists(_ref_ally)){
			continue;
		}

		if (
			_ref_ally._str_list != "ALIVE" ||
			_ref_ally._val_cur_hp <= 0
		){
			continue;
		}

		//----------------------//
		//CLEANSE + COUNT STACKS//
		//----------------------//
		_ct_total_stacks +=
			scr_cleanse_negative_stacks(
				_ref_ally
			);
	}

	//----------------//
	//NO STACKS FOUND//
	//----------------//
	if (_ct_total_stacks <= 0){

		audio_play_sound(
			snd_buff,
			0,
			false
		);

		return true;
	}

	//-----------------------//
	//CALCULATE APEX REWARD//
	//-----------------------//
	var _val_apex_bonus =
		_ct_total_stacks *
		2;

	//-------------------------//
	//PERMANENT DAMAGE INCREASE//
	//-------------------------//
	_ref_caster._val_dmg_linear_bonus +=
		_val_apex_bonus;

	//-------------//
	//HEAL CASTER//
	//-------------//
	scr_heal_target(
		_val_apex_bonus,
		_ref_caster
	);

	//----------------//
	//BUFF FEEDBACK//
	//----------------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"APEX +" +
			string(_val_apex_bonus) +
			" DAMAGE",
		undefined,
		c_green,
		_ref_caster.x + irandom_range(-32,32),
		_ref_caster.y - 48 + irandom_range(-16,16)
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_buff,
		0,
		false
	);

	return true;
}