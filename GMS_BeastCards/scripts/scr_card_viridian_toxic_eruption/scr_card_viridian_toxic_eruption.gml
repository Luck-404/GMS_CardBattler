//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_TOXIC_ERUPTION
// FUNCTION: Resolves Toxic Eruption.
//           Consumes all Poison from each Beast on the selected team through
//           POISONFLOW and deals 2 neutral damage per stack consumed.
//
//===============================================================================//

function scr_card_viridian_toxic_eruption(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//GET TARGET TEAM LIST//
	//--------------------//
	var _list_targets =
		scr_get_target_team_list(
			_ref_target
		);

	if (_list_targets == undefined){
		return;
	}

	//------------------//
	//ERUPT EACH TARGET//
	//------------------//
	for (
		var _it_target = 0;
		_it_target < ds_list_size(_list_targets);
		_it_target++
	){

		var _ref_hit_target =
			ds_list_find_value(
				_list_targets,
				_it_target
			);

		if (!instance_exists(_ref_hit_target)){
			continue;
		}

		//------------//
		//POISONFLOW//
		//------------//
		var _ct_poison_consumed =
			scr_trigger_poisonflow(
				_ref_hit_target
			);

		//----------------//
		//NO POISON STACKS//
		//----------------//
		if (_ct_poison_consumed <= 0){

			scr_spawn_popup_scrolling(
				"TEXT",
				"0",
				undefined,
				c_maroon,
				_ref_hit_target.x + irandom_range(-32,32),
				_ref_hit_target.y - 24 + irandom_range(-32,32)
			);

			continue;
		}

		//------------------//
		//CALCULATE DAMAGE//
		//------------------//
		var _val_damage =
			_ct_poison_consumed *
			_stct_card._val_card_magnitude;

		//------------//
		//DEAL DAMAGE//
		//------------//
		scr_damage_target(
			_val_damage,
			_ref_hit_target
		);
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_battle_sfx_neu_hit,0,false);
}