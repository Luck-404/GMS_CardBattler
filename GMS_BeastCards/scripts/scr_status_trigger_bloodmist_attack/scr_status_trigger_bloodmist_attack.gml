//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_BLOODMIST_ATTACK
// FUNCTION: Triggers HEMORRHAGE on every enemy Beast affected by one Attack
//           resolution while Bloodmist is active.
//
//           Uses the Card's VFX hit context to collect all struck targets,
//           allowing AoE and Armor-only hits to trigger HEMORRHAGE.
//           Also includes the selected primary Beast so non-damaging Attacks
//           still trigger correctly.
//
//           Each Beast can trigger HEMORRHAGE only once per Attack resolution.
//
// ARGUMENTS: _ref_card is the resolving Card instance.
//            _ref_primary_target is the selected primary target.
// RETURNS: Number of targets that triggered HEMORRHAGE.
//
//===============================================================================//

function scr_status_trigger_bloodmist_attack(_ref_card,_ref_primary_target){

	//================//
	//CHECK BLOODMIST//
	//================//
	var _ref_bloodmist = scr_status_get_bloodmist();

	if (
		_ref_bloodmist == -1 ||
		!instance_exists(_ref_bloodmist)
	){
		return 0;
	}

	//----------------//
	//VALIDATE CARD//
	//----------------//
	if (!instance_exists(_ref_card)){
		return 0;
	}

	if (!is_struct(_ref_card._ref_card)){
		return 0;
	}

	var _stct_card = _ref_card._ref_card;

	//---------------------//
	//ATTACKS ONLY//
	//---------------------//
	if (_stct_card._str_card_type != "ATTACK"){
		return 0;
	}

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	var _ref_caster = global.ref_caster_beast;

	if (!instance_exists(_ref_caster)){
		return 0;
	}

	//================//
	//TARGET SNAPSHOT//
	//================//
	var _arr_targets = [];

	//========================//
	//ADD PRIMARY BEAST TARGET//
	//========================//
	if (
		instance_exists(_ref_primary_target) &&
		variable_instance_exists(_ref_primary_target,"_str_team") &&
		_ref_primary_target._str_team != _ref_caster._str_team
	){

		array_push(
			_arr_targets,
			_ref_primary_target
		);
	}

	//=====================//
	//ADD ALL HIT TARGETS//
	//=====================//
	if (
		variable_instance_exists(
			_ref_card,
			"_arr_vfx_hit_context"
		) &&
		is_array(_ref_card._arr_vfx_hit_context)
	){

		for (
			var _it_hit = 0;
			_it_hit < array_length(_ref_card._arr_vfx_hit_context);
			_it_hit++
		){

			var _stct_hit = _ref_card._arr_vfx_hit_context[_it_hit];

			if (!is_struct(_stct_hit)){
				continue;
			}

			if (
				!variable_struct_exists(
					_stct_hit,
					"_ref_target"
				)
			){
				continue;
			}

			var _ref_target = _stct_hit._ref_target;

			if (!instance_exists(_ref_target)){
				continue;
			}

			if (
				!variable_instance_exists(
					_ref_target,
					"_str_team"
				)
			){
				continue;
			}

			//----------------------//
			//ENEMY TARGETS ONLY//
			//----------------------//
			if (_ref_target._str_team == _ref_caster._str_team){
				continue;
			}

			//================//
			//AVOID DUPLICATES//
			//================//
			var _flag_duplicate = false;

			for (
				var _it_check = 0;
				_it_check < array_length(_arr_targets);
				_it_check++
			){

				if (_arr_targets[_it_check] == _ref_target){

					_flag_duplicate = true;

					break;
				}
			}

			if (!_flag_duplicate){

				array_push(
					_arr_targets,
					_ref_target
				);
			}
		}
	}

	//======================//
	//TRIGGER HEMORRHAGE//
	//======================//
	var _ct_triggered = 0;

	for (
		var _it_target = 0;
		_it_target < array_length(_arr_targets);
		_it_target++
	){

		var _ref_target = _arr_targets[_it_target];

		if (!instance_exists(_ref_target)){
			continue;
		}

		if (
			_ref_target._str_list != "ALIVE" ||
			_ref_target._val_cur_hp <= 0
		){
			continue;
		}

		scr_battle_trigger_hemorrhage(
			_ref_target
		);

		_ct_triggered++;
	}

	return _ct_triggered;
}