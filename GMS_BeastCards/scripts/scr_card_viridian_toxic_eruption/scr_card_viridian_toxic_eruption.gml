//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_TOXIC_ERUPTION
// FUNCTION: Resolves the Toxic Eruption card effect.
//           Consumes all Poison from each Beast on the selected team.
//           Deals 2 neutral damage per Poison stack consumed from each Beast.
//
//===============================================================================//

function scr_card_viridian_toxic_eruption(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//GET TARGET TEAM LIST//
	//--------------------//
	var _list_targets = scr_get_target_team_list(_ref_target);

	if (_list_targets == undefined){
		return;
	}

	//----------------------//
	//ERUPT EACH UNIT'S POISON//
	//----------------------//
	for (
		var _it_target = 0;
		_it_target < ds_list_size(_list_targets);
		_it_target++
	){

		var _ref_hit_target = ds_list_find_value(
			_list_targets,
			_it_target
		);

		if (!instance_exists(_ref_hit_target)){
			continue;
		}

		//----------------//
		//CHECK FOR POISON//
		//----------------//
		var _ref_poison = scr_check_for_status(
			"POISON",
			_ref_hit_target
		);

		//----------------//
		//NO POISON STACKS//
		//----------------//
		if (_ref_poison == -1){

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

		//-------------------//
		//SNAPSHOT POISON//
		//-------------------//
		var _ct_poison_stacks =
			_ref_poison._ct_status_stacks;

		var _val_damage =
			_ct_poison_stacks *
			_stct_card._val_card_magnitude;

		//------------//
		//DEAL DAMAGE//
		//------------//
		scr_damage_target(
			_val_damage,
			_ref_hit_target
		);

		//----------------//
		//CONSUME POISON//
		//----------------//
		if (instance_exists(_ref_poison)){
			scr_destroy_status(_ref_poison);
		}

		//----------------//
		//PLAY ANIMATION//
		//----------------//
	}

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}