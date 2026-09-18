//===============================================================================//
//
// SCRIPT: SCR_BATTLE_CAST_CARD
// FUNCTION: Resolves the currently selected battle Card.
//           Handles Whiteout, casting statuses, Traps, Echo repetitions,
//           Stormstruck action triggers, successful-cast triggers,
//           Mana cost, Card destination, and cleanup.
//           Selects the Beast cast-motion presentation from optional Card data.
//
// USES:     global.ref_cast_card, global.ref_caster_beast, selected target
//           globals, Card metadata, Statuses, Traps, VFX, and player Mana.
//           Special Card and Corpse targeting replace the normal Beast target.
//
//===============================================================================//

function scr_battle_cast_card(){

	#region CAST DATA

	//----------------//
	//GET CAST CARD//
	//----------------//
	var _ref_card = global.ref_cast_card;

	if (!instance_exists(_ref_card)){

		scr_debug_log(
			"CARDS",
			"CAST",
			undefined,
			"CARD CAST FAILED | INVALID CAST CARD INSTANCE",
			"ERROR",
			"SCR_BATTLE_CAST_CARD"
		);

		return;
	}

	var _stct_card = _ref_card._ref_card;

	if (!is_struct(_stct_card)){

		scr_debug_log(
			"CARDS",
			"CAST",
			_ref_card,
			"CARD CAST FAILED | INVALID CARD STRUCT",
			"ERROR",
			"SCR_BATTLE_CAST_CARD"
		);

		return;
	}

	//-------------------//
	//RESET PENDING MANA//
	//-------------------//
	_ref_card._ct_pending_mana_gain = 0;

	//-------------------//
	//GET CASTER / TARGET//
	//-------------------//
	var _ref_caster = global.ref_caster_beast;
	var _ref_target = global.ref_target_beast;

	if (!instance_exists(_ref_caster)){

		scr_debug_log(
			"CARDS",
			"CAST",
			_stct_card,
			"CARD CAST FAILED | INVALID CASTER | CARD: " + string_upper(_stct_card._str_card_name),
			"ERROR",
			"SCR_BATTLE_CAST_CARD"
		);

		return;
	}

	//----------------//
	//SPECIAL TARGETS//
	//----------------//
	if (_stct_card._str_card_range == "ENEMY_CARD"){
		_ref_target = global.ref_target_card;
	}

	if (_stct_card._str_card_range == "CORPSE" || _stct_card._str_card_range == "CORPSE_OPTIONAL"){
		_ref_target = global.ref_target_corpse;
	}

	//================//
	//DEBUG CARD CAST//
	//================//
	var _str_cast_team = string_upper(_ref_caster._str_team);
	var _str_card_name = string_upper(_stct_card._str_card_name);

	var _str_caster_name = "UNKNOWN";
	var _val_caster_level = 0;

	if (is_struct(_ref_caster._ref_unit)){

		_str_caster_name = string_upper(_ref_caster._ref_unit._str_beast_name);
		_val_caster_level = _ref_caster._ref_unit._val_beast_level;
	}

	var _str_target = "NONE";

	//----------------//
	//GLOBAL TARGET//
	//----------------//
	if (_ref_target == "GLOBAL"){
		_str_target = "GLOBAL";
	}

	//----------------//
	//BEAST TARGET//
	//----------------//
	else if (
		instance_exists(_ref_target) &&
		variable_instance_exists(_ref_target,"_ref_unit") &&
		is_struct(_ref_target._ref_unit) &&
		variable_struct_exists(_ref_target._ref_unit,"_str_beast_name")
	){

		var _str_target_team = string_upper(_ref_target._str_team);
		var _str_target_name = string_upper(_ref_target._ref_unit._str_beast_name);
		var _val_target_level = _ref_target._ref_unit._val_beast_level;

		_str_target =
			_str_target_team + " " +
			_str_target_name +
			" (LVL " + string(_val_target_level) + ")";

		if (
			_stct_card._str_card_range == "CORPSE" ||
			_stct_card._str_card_range == "CORPSE_OPTIONAL"
		){
			_str_target += " [CORPSE]";
		}
	}

	//----------------//
	//CARD TARGET//
	//----------------//
	else if (
		instance_exists(_ref_target) &&
		variable_instance_exists(_ref_target,"_ref_card") &&
		is_struct(_ref_target._ref_card) &&
		variable_struct_exists(_ref_target._ref_card,"_str_card_name")
	){

		var _str_target_card_team = string_upper(_ref_target._str_team);
		var _str_target_card_name = string_upper(_ref_target._ref_card._str_card_name);

		_str_target =
			_str_target_card_team +
			" CARD " +
			_str_target_card_name;
	}

	//----------------//
	//CAST MESSAGE//
	//----------------//
	scr_debug_log(
		"CARDS",
		"CAST",
		_ref_caster,
		_str_cast_team + " " +
		_str_caster_name +
		" (LVL " + string(_val_caster_level) + ")" +
		" CAST " + _str_card_name +
		" | TARGET: " + _str_target,
		"BATTLE",
		"SCR_BATTLE_CAST_CARD"
	);

	//----------------//
	//CARD RESOLUTION//
	//----------------//
	var _scr_card_effect = _stct_card._scr_card;
	var _val_mana_cost = _stct_card._val_card_mana_cost;

	var _flag_card_resolved = false;
	var _flag_whiteout_failed = false;

	#endregion

	#region PRESENTATION CONTEXT

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

	//--------------------//
	//RESET EFFECT CONTEXT//
	//--------------------//
	global.flag_card_effect_resolving = false;
	global.ref_icebreaker_target = undefined;

	#endregion

	#region WHITEOUT

	//----------------//
	//CHECK WHITEOUT//
	//----------------//
	var _ref_whiteout_status = scr_status_check("WHITEOUT",_ref_caster);

	if (_ref_whiteout_status != -1 && instance_exists(_ref_whiteout_status)){

		var _val_whiteout_chance = clamp(_ref_whiteout_status._val_status_magnitude,0,100);
		var _val_whiteout_roll = irandom_range(1,100);

		if (_val_whiteout_roll <= _val_whiteout_chance){

			_flag_whiteout_failed = true;

			scr_debug_log(
				"CARDS",
				"CAST",
				_ref_caster,
				_str_cast_team + " " +
				_str_caster_name +
				" (LVL " + string(_val_caster_level) + ")" +
				" FAILED TO CAST " + _str_card_name +
				" | WHITEOUT: " + string(_val_whiteout_roll) +
				"/" + string(_val_whiteout_chance),
				"BATTLE",
				"SCR_BATTLE_CAST_CARD"
			);

			//-------//
			//WHIFF//
			//-------//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"WHIFF",
				undefined,
				c_ltgray,
				_ref_caster.x,
				_ref_caster.y - 48
			);
		}
	}

	#endregion

	#region CAST SETUP

	if (!_flag_whiteout_failed){

		//---------------------//
		//CONSUME MALLEABILITY//
		//---------------------//
		var _ref_malleability_status = scr_status_check("MALLEABILITY",_ref_caster);

		if (_ref_malleability_status != -1){
			scr_status_buff_malleability("DEATH",_ref_malleability_status);
		}

		//----------------------//
		//CHECK ATTACKING TRAPS//
		//----------------------//
		var _flag_attack_cancelled = false;

		if (_stct_card._str_card_type == "ATTACK"){
			_flag_attack_cancelled = scr_battle_trigger_attack_traps(_ref_caster,_ref_target,_stct_card);
		}

		//====================//
		//PLAY CAST ANIMATION//
		//====================//
		if (!_flag_attack_cancelled){

			var _str_card_cast_motion = "NORMAL";

			if (variable_struct_exists(_stct_card,"_str_card_cast_motion")){
				_str_card_cast_motion = string_upper(string(_stct_card._str_card_cast_motion));
			}

			switch(_str_card_cast_motion){

				//----------------//
				//MINION-ROW CAST//
				//----------------//
				case "MINION":
					scr_battle_vfx_cast_minion(_ref_caster);
				break;

				//-----------//
				//NORMAL CAST//
				//-----------//
				default:
					scr_battle_vfx_cast(_ref_caster);
				break;
			}
		}

		//===============//
		//CHECK FOR ECHO//
		//===============//
		var _ref_echo_status = scr_status_check("ECHO",global.list_statuses);

		var _flag_echo_active = (
			_ref_caster._str_team == "PLAYER" &&
			_ref_echo_status != -1 &&
			instance_exists(_ref_echo_status) &&
			_ref_echo_status._ct_status_stacks > 0 &&
			_stct_card._str_card_effect_type != "ECHO"
		);

		var _ct_echo_stacks = 0;
		var _ct_card_resolutions = 1;

		if (_flag_echo_active){

			_ct_echo_stacks = _ref_echo_status._ct_status_stacks;
			_ct_card_resolutions += _ct_echo_stacks;
		}

		//================//
		//ECHO FEEDBACK//
		//================//
		if (!_flag_attack_cancelled && _flag_echo_active){

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
		}

		#endregion

		#region CARD RESOLUTION

		//================//
		//RESOLVE CASTS//
		//================//
		if (!_flag_attack_cancelled){

			var _flag_stormstruck_triggered = false;

			for (var _it_cast = 0; _it_cast < _ct_card_resolutions; _it_cast++){

				var _flag_cast_cancelled = false;

				//-------------------//
				//CHECK TARGET TRAPS//
				//-------------------//
				if (
					_stct_card._str_card_type == "ATTACK" &&
					is_real(_ref_target) &&
					instance_exists(_ref_target)
				){
					_flag_cast_cancelled = scr_battle_trigger_target_traps(_ref_caster,_ref_target,_stct_card);
				}

				if (_flag_cast_cancelled){
					continue;
				}

				//---------------------//
				//TRIGGER STORMSTRUCK//
				//---------------------//
				if (!_flag_stormstruck_triggered){

					scr_status_trigger_stormstruck_action(_ref_caster);
					_flag_stormstruck_triggered = true;

					if (!instance_exists(_ref_caster) || _ref_caster._val_cur_hp <= 0){
						break;
					}
				}

				//-------------------//
				//SET EFFECT CONTEXT//
				//-------------------//
				global.ref_icebreaker_target = undefined;
				global.flag_card_effect_resolving = true;

				//-------------//
				//RESOLVE CARD//
				//-------------//
				_scr_card_effect(_stct_card,_ref_caster,_ref_target);

				//========================//
				//BLOODMIST HEMORRHAGE//
				//========================//
				if (_stct_card._str_card_type == "ATTACK"){

					scr_status_trigger_bloodmist_attack(
						_ref_card,
						_ref_target
					);
				}

				//---------------------//
				//CLEAR EFFECT CONTEXT//
				//---------------------//
				global.flag_card_effect_resolving = false;

				//------------------------//
				//TRIGGER ON ATTACK BUFFS//
				//------------------------//
				if (_stct_card._str_card_type == "ATTACK"){
					scr_status_trigger_attack_statuses(_ref_caster,_ref_target,_stct_card);
				}

				global.ref_icebreaker_target = undefined;

				_flag_card_resolved = true;
			}

			//================//
			//CONSUME ECHO//
			//================//
			if (_flag_echo_active){

				var _flag_echo_consumed = scr_status_buff_echo(
					"CONSUME",
					_ref_echo_status
				);

				//------------------//
				//DEBUG ECHO TRIGGER//
				//------------------//
				if (_flag_echo_consumed){

					scr_debug_log_battle_trigger(
						"ECHO",
						_ref_caster,
						_ref_target,
						"STACKS CONSUMED: " + string(_ct_echo_stacks) +
						" | CARD RESOLUTIONS: " + string(_ct_card_resolutions),
						"SCR_BATTLE_CAST_CARD"
					);
				}
			}
		}

		#endregion
	}

	#region RESOLUTION TRIGGERS

	//--------------------------//
	//CLEAR CARD EFFECT CONTEXT//
	//--------------------------//
	global.flag_card_effect_resolving = false;
	global.ref_icebreaker_target = undefined;

	//----------------//
	//CAST TRIGGERS//
	//----------------//
	if (_flag_card_resolved){

		scr_battle_trigger_card_cast_traps(_ref_caster,_ref_target,_stct_card);
		scr_status_trigger_card_cast_auras(_ref_caster,_stct_card);
	}

	#endregion

	#region CARD COST

	//------------//
	//SPEND MANA//
	//------------//
	if (_ref_caster._str_team == "PLAYER"){

		var _val_mana_before_cost = obj_battle_player_controller._val_cur_mana;

		obj_battle_player_controller._val_cur_mana =
			max(
				0,
				obj_battle_player_controller._val_cur_mana -
				_val_mana_cost
			);

		//----------------//
		//DEBUG MANA COST//
		//----------------//
		if (_val_mana_cost > 0){

			scr_debug_log(
				"BATTLE",
				"MANA",
				_stct_card,
				"PLAYER SPENT " + string(_val_mana_cost) +
				" MANA ON " + string_upper(_stct_card._str_card_name) +
				" | " + string(_val_mana_before_cost) +
				"/" + string(obj_battle_player_controller._val_max_mana) +
				" -> " +
				string(obj_battle_player_controller._val_cur_mana) +
				"/" + string(obj_battle_player_controller._val_max_mana),
				"BATTLE",
				"SCR_BATTLE_CAST_CARD"
			);
		}
	}

	#endregion

	#region GENERATED MANA

	//----------------//
	//GET QUEUED MANA//
	//----------------//
	var _ct_pending_mana_gain = max(
		0,
		_ref_card._ct_pending_mana_gain
	);

	_ref_card._ct_pending_mana_gain = 0;

	//-------------------//
	//GAIN QUEUED MANA//
	//-------------------//
	if (_ct_pending_mana_gain > 0){
		scr_battle_gain_mana(_ct_pending_mana_gain);
	}

	#endregion

	#region CARD DESTINATION

	//----------------//
	//MOVE USED CARD//
	//----------------//
	if (_ref_caster._str_team == "PLAYER"){

		if (_stct_card._flag_card_exhausts){
			scr_battle_exhaust_card(_ref_card);
		}
		else{
			scr_battle_discard_card(_ref_card);
		}
	}

	#endregion

	#region CLEANUP

	//----------------//
	//CLEAR SELECTION//
	//----------------//
	global.flag_card_effect_resolving = false;
	global.ref_icebreaker_target = undefined;

	global.ref_cast_card = undefined;
	global.ref_caster_beast = undefined;
	global.ref_target_beast = undefined;

	#endregion
}