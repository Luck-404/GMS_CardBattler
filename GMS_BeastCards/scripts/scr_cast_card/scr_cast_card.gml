//===============================================================================//
//
// SCRIPT: SCR_CAST_CARD
// FUNCTION: Resolves the currently selected card.
//           Consumes applicable one-use casting statuses.
//           Executes the card and any stored Echo repetitions.
//           Triggers successful-cast effects, spends Mana,
//           moves the card to its destination, and clears selection.
//
//===============================================================================//

function scr_cast_card(){

	//----------------//
	//GET CAST DATA//
	//----------------//
	var _ref_card =
		global.ref_cast_card;

	if (!instance_exists(_ref_card)){
		return;
	}

	var _stct_card =
		_ref_card._ref_card;

	if (!is_struct(_stct_card)){
		return;
	}

	var _ref_caster =
		global.ref_caster_beast;

	var _ref_target =
		global.ref_target_beast;

	if (!instance_exists(_ref_caster)){
		return;
	}

	//------------------//
	//RESET HIT VFX DATA//
	//------------------//
	_ref_card._arr_vfx_hit_context = [];

	//----------------//
	//RESOLUTION STATE//
	//----------------//
	var _flag_card_resolved =
		false;

	//----------------//
	//SPECIAL TARGETS//
	//----------------//
	if (_stct_card._str_card_range == "ENEMY_CARD"){

		_ref_target =
			global.ref_target_card;
	}

	if (
		_stct_card._str_card_range == "CORPSE" ||
		_stct_card._str_card_range == "CORPSE_OPTIONAL"
	){

		_ref_target =
			global.ref_target_corpse;
	}

	var _fn_script =
		_stct_card._scr_card;

	var _val_cost =
		_stct_card._val_card_mana_cost;

	//---------------------//
	//CONSUME MALLEABILITY//
	//---------------------//
	var _ref_malleability_status =
		scr_check_for_status(
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
	var _flag_attack_cancelled =
		false;

	if (_stct_card._str_card_type == "ATTACK"){

		_flag_attack_cancelled =
			scr_trigger_attack_traps(
				_ref_caster,
				_ref_target,
				_stct_card
			);
	}

	//--------------------//
	//PLAY CAST ANIMATION//
	//--------------------//
	if (!_flag_attack_cancelled){

		scr_battle_vfx_cast(
			_ref_caster
		);
	}

	//================//
	//CHECK FOR ECHO//
	//================//
	var _ref_echo =
		scr_check_for_status(
			"ECHO",
			global.list_statuses
		);

	var _flag_echo_active =
	(
		_ref_caster._str_team == "PLAYER" &&
		_ref_echo != -1 &&
		instance_exists(_ref_echo) &&
		_ref_echo._ct_status_stacks > 0 &&
		_stct_card._str_card_effect_type != "ECHO"
	);

	var _ct_echo_stacks =
		0;

	if (_flag_echo_active){

		_ct_echo_stacks =
			_ref_echo._ct_status_stacks;
	}

	//===========//
	//CAST CARD//
	//===========//
	if (!_flag_attack_cancelled){

		//================//
		//ECHO RESOLUTION//
		//================//
		if (_flag_echo_active){

			//----------------//
			//ECHO TRIGGER VFX//
			//----------------//
			scr_battle_vfx(
				undefined,
				spr_battle_vfx_echo_trigger,
				room_width * 0.5,
				room_height * 0.5,
				0,
				0,
				1,
				0,
				snd_battle_sfx_echo
			);

			//----------------//
			//RESOLVE CASTS//
			//----------------//
			for (
				var _it_echo = 0;
				_it_echo < _ct_echo_stacks + 1;
				_it_echo++
			){

				var _flag_cast_cancelled =
					false;

				//-------------------//
				//CHECK TARGET TRAPS//
				//-------------------//
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

				//-------------//
				//RESOLVE CAST//
				//-------------//
				if (!_flag_cast_cancelled){

					_fn_script(
						_stct_card,
						_ref_caster,
						_ref_target
					);

					_flag_card_resolved =
						true;
				}
			}

			//--------------//
			//CONSUME ECHO//
			//--------------//
			scr_status_buff_echo(
				"CONSUME",
				_ref_echo
			);
		}

		//===================//
		//NORMAL RESOLUTION//
		//===================//
		else{

			var _flag_cast_cancelled =
				false;

			//-------------------//
			//CHECK TARGET TRAPS//
			//-------------------//
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

			//-------------//
			//RESOLVE CAST//
			//-------------//
			if (!_flag_cast_cancelled){

				_fn_script(
					_stct_card,
					_ref_caster,
					_ref_target
				);

				_flag_card_resolved =
					true;
			}
		}
	}

	//-------------------------//
	//TRIGGER CARD CAST TRAPS//
	//-------------------------//
	if (_flag_card_resolved){

		scr_trigger_card_cast_traps(
			_ref_caster,
			_ref_target,
			_stct_card
		);
	}

	//------------------------//
	//TRIGGER CARD CAST AURAS//
	//------------------------//
	if (_flag_card_resolved){

		scr_trigger_card_cast_auras(
			_ref_caster,
			_stct_card
		);
	}

	//-------------------//
	//TRIGGER ACTION DOTS//
	//-------------------//
	if (_flag_card_resolved){

		scr_trigger_stormstruck_action(
			_ref_caster
		);
	}

	//------------//
	//SPEND MANA//
	//------------//
	if (_ref_caster._str_team == "PLAYER"){

		obj_battle_player_controller._val_cur_mana -=
			_val_cost;
	}

	//----------------//
	//CARD DESTINATION//
	//----------------//
	if (_ref_caster._str_team == "PLAYER"){

		if (_stct_card._flag_card_exhausts){

			scr_exhaust_card(
				_ref_card
			);
		}
		else{

			scr_discard_card(
				_ref_card
			);
		}
	}

	//----------------//
	//CLEAR SELECTION//
	//----------------//
	global.ref_cast_card =
		undefined;

	global.ref_caster_beast =
		undefined;

	global.ref_target_beast =
		undefined;
}