//===============================================================================//
//
// SCRIPT: SCR_CAST_CARD
// FUNCTION: Resolves the currently selected card.
//           Consumes applicable one-use casting statuses.
//           Executes the card, handles Echo, spends mana,
//           moves the card to its destination, and clears selection.
//
//===============================================================================//
function scr_cast_card(){

	var _ref_card = global.ref_cast_card;
	var _stct_card = _ref_card._ref_card;

	var _ref_caster = global.ref_caster_beast;
	var _ref_target = global.ref_target_beast;

	if (_stct_card._str_card_range == "ENEMY_CARD"){
		_ref_target = global.ref_target_card;
	}

	if (
		_stct_card._str_card_range == "CORPSE" ||
		_stct_card._str_card_range == "CORPSE_OPTIONAL"
	){
		_ref_target = global.ref_target_corpse;
	}

	var _fn_script = _stct_card._scr_card;
	var _val_cost = _stct_card._val_card_mana_cost;

	//------------------------//
	// CONSUME MALLEABILITY
	//------------------------//
	var _ref_malleability_status = scr_check_for_status(
		"MALLEABILITY",
		_ref_caster
	);

	if (_ref_malleability_status != -1){

		scr_status_buff_malleability(
			"DEATH",
			_ref_malleability_status
		);
	}

	//----------------------//
	//CHECK ATTACKING TRAPS//
	//----------------------//
	var _flag_attack_cancelled = false;

	if (_stct_card._str_card_type == "ATTACK"){

		_flag_attack_cancelled = scr_trigger_attack_traps(
			_ref_caster,
			_ref_target,
			_stct_card
		);
	}

	//-----------//
	// CAST CARD
	//-----------//
	if (!_flag_attack_cancelled){
		if (
			_ref_caster._str_team == "PLAYER" &&
			global.ct_echo != 0 &&
			_stct_card._str_card_effect_type != "ECHO"
		){
			for (
				var _it_echo = 0;
				_it_echo < global.ct_echo + 1;
				_it_echo++
			){

				var _flag_cast_cancelled =
					false;

				if (
					_stct_card._str_card_type == "ATTACK" &&
					instance_exists(_ref_target)
				){

					_flag_cast_cancelled =
						scr_trigger_target_traps(
							_ref_caster,
							_ref_target,
							_stct_card
						);
				}

				if (!_flag_cast_cancelled){

					_fn_script(
						_stct_card,
						_ref_caster,
						_ref_target
					);
				}
			}

			global.ct_echo = 0;
		}
		else{

			var _flag_cast_cancelled =
				false;

			if (
				_stct_card._str_card_type == "ATTACK" &&
				instance_exists(_ref_target)
			){

				_flag_cast_cancelled =
					scr_trigger_target_traps(
						_ref_caster,
						_ref_target,
						_stct_card
					);
			}

			if (!_flag_cast_cancelled){

				_fn_script(
					_stct_card,
					_ref_caster,
					_ref_target
				);
			}
		}
	}

	//------------//
	// SPEND MANA
	//------------//
	if (_ref_caster._str_team == "PLAYER"){

		obj_battle_player_controller._val_cur_mana -=
			_val_cost;
	}

	//-----------------//
	// CARD DESTINATION
	//-----------------//
	if (_ref_caster._str_team == "PLAYER"){

		if (_stct_card._flag_card_exhausts){
			scr_exhaust_card(_ref_card);
		}
		else{
			scr_discard_card(_ref_card);
		}
	}

	//-----------------//
	// CLEAR SELECTION
	//-----------------//
	global.ref_cast_card = undefined;
	global.ref_caster_beast = undefined;
	global.ref_target_beast = undefined;
}