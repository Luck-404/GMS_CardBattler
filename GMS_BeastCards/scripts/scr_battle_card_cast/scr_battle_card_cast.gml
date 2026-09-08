//===============================================================================//
//
// SCRIPT: scr_battle_card_cast
// FUNCTION: Resolves the currently selected card.
//           Checks Whiteout before the card fires.
//           Consumes applicable one-use casting statuses.
//           Executes the card and any stored Echo repetitions.
//           Handles card-resolution context.
//           Triggers On Attack effects after successful Attack resolutions.
//           Triggers successful-cast effects, spends Mana,
//           moves the card to its destination, and clears selection.
//
//===============================================================================//

function scr_battle_card_cast(){

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

	//----------------//
	//RESET VFX DATA//
	//----------------//
	_ref_card._arr_vfx_hit_context = [];

	_ref_card._flag_buff_sfx_played = false;
	_ref_card._flag_debuff_sfx_played = false;
	_ref_card._flag_cc_sfx_played = false;
	_ref_card._flag_heal_sfx_played = false;
	_ref_card._flag_cleanse_sfx_played = false;
	_ref_card._flag_aura_sfx_played = false;

	//----------------//
	//RESOLUTION STATE//
	//----------------//
	var _flag_card_resolved =
		false;

	var _flag_whiteout_failed =
		false;

	global.flag_card_effect_resolving =
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

	//================//
	//CHECK WHITEOUT//
	//================//
	var _ref_whiteout =
		scr_status_check(
			"WHITEOUT",
			_ref_caster
		);

	if (
		_ref_whiteout != -1 &&
		instance_exists(_ref_whiteout)
	){

		var _val_whiteout_chance =
			clamp(
				_ref_whiteout._val_status_magnitude,
				0,
				100
			);

		var _val_whiteout_roll =
			irandom_range(1,100);

		if (
			_val_whiteout_roll <=
			_val_whiteout_chance
		){

			_flag_whiteout_failed =
				true;

			//-------//
			//WHIFF//
			//-------//
			scr_spawn_popup_scrolling(
				"TEXT",
				"WHIFF",
				undefined,
				c_ltgray,
				_ref_caster.x,
				_ref_caster.y - 48
			);
		}
	}

	//====================//
	//CARD CAST SUCCEEDED//
	//====================//
	if (!_flag_whiteout_failed){

		//---------------------//
		//CONSUME MALLEABILITY//
		//---------------------//
		var _ref_malleability_status =
			scr_status_check(
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
				scr_trap_trigger_attack(
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
			scr_status_check(
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
					snd_battle_echo
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
						is_real(_ref_target) &&
						instance_exists(_ref_target)
					){

						_flag_cast_cancelled =
							scr_trap_trigger_target(
								_ref_caster,
								_ref_target,
								_stct_card
							);
					}

					//-------------//
					//RESOLVE CAST//
					//-------------//
					if (!_flag_cast_cancelled){

						global.ref_icebreaker_target =
							undefined;

						global.flag_card_effect_resolving =
							true;

						_fn_script(
							_stct_card,
							_ref_caster,
							_ref_target
						);

						global.flag_card_effect_resolving =
							false;

						//------------------------//
						//TRIGGER ON ATTACK BUFFS//
						//------------------------//
						if (_stct_card._str_card_type == "ATTACK"){

							scr_trigger_on_attack_buffs(
								_ref_caster,
								_ref_target,
								_stct_card
							);
						}

						global.ref_icebreaker_target =
							undefined;

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
					is_real(_ref_target) &&
					instance_exists(_ref_target)
				){

					_flag_cast_cancelled =
						scr_trap_trigger_target(
							_ref_caster,
							_ref_target,
							_stct_card
						);
				}

				//-------------//
				//RESOLVE CAST//
				//-------------//
				if (!_flag_cast_cancelled){

					global.ref_icebreaker_target =
						undefined;

					global.flag_card_effect_resolving =
						true;

					_fn_script(
						_stct_card,
						_ref_caster,
						_ref_target
					);

					global.flag_card_effect_resolving =
						false;

					//------------------------//
					//TRIGGER ON ATTACK BUFFS//
					//------------------------//
					if (_stct_card._str_card_type == "ATTACK"){

						scr_trigger_on_attack_buffs(
							_ref_caster,
							_ref_target,
							_stct_card
						);
					}

					global.ref_icebreaker_target =
						undefined;

					_flag_card_resolved =
						true;
				}
			}
		}
	}

	//--------------------------//
	//CLEAR CARD EFFECT CONTEXT//
	//--------------------------//
	global.flag_card_effect_resolving =
		false;

	global.ref_icebreaker_target =
		undefined;

	//-------------------------//
	//TRIGGER CARD CAST TRAPS//
	//-------------------------//
	if (_flag_card_resolved){

		scr_trap_trigger_card_cast(
			_ref_caster,
			_ref_target,
			_stct_card
		);
	}

	//------------------------//
	//TRIGGER CARD CAST AURAS//
	//------------------------//
	if (_flag_card_resolved){

		scr_status_trigger_card_cast_auras(
			_ref_caster,
			_stct_card
		);
	}

	//-------------------//
	//TRIGGER ACTION DOTS//
	//-------------------//
	if (_flag_card_resolved){

		scr_status_trigger_stormstruck_action(
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

			scr_battle_card_exhaust(
				_ref_card
			);
		}
		else{

			scr_battle_card_discard(
				_ref_card
			);
		}
	}

	//----------------//
	//CLEAR SELECTION//
	//----------------//
	global.flag_card_effect_resolving =
		false;

	global.ref_icebreaker_target =
		undefined;

	global.ref_cast_card =
		undefined;

	global.ref_caster_beast =
		undefined;

	global.ref_target_beast =
		undefined;
}