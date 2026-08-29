//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PREDATORY_SCENT
// FUNCTION: Resolves Predatory Scent.
//           Applies Focus to the selected enemy Beast for 3 rounds.
//           POISONFLOW consumes 3 Poison to grow all Minions on the caster.
//
//===============================================================================//

function scr_card_viridian_predatory_scent(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//APPLY FOCUS//
	//-----------//
	scr_apply_debuff_status("FOCUS",3);

	//------------//
	//POISONFLOW//
	//------------//
	if (
		instance_exists(_ref_caster) &&
		instance_exists(_ref_target) &&
		ds_list_size(_ref_caster._list_minions) > 0
	){

		var _ref_poison = scr_check_for_status("POISON",_ref_target);

		if (
			_ref_poison != -1 &&
			_ref_poison._ct_status_stacks >= 3
		){

			var _ct_poison_consumed = scr_trigger_poisonflow(_ref_target,3);

			if (_ct_poison_consumed == 3){

				for (var _it_minion = 0; _it_minion < ds_list_size(_ref_caster._list_minions); _it_minion++){

					var _ref_minion = ds_list_find_value(_ref_caster._list_minions,_it_minion);

					if (!instance_exists(_ref_minion)){
						continue;
					}

					scr_grow_minion(_ref_minion,1);
				}
			}
		}
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_debuff,0,false);
}