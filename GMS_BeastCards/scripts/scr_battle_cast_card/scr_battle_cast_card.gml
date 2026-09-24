//===============================================================================//
//
// SCRIPT: SCR_BATTLE_CAST_CARD
// FUNCTION: Validates one normal player/enemy Card cast before any cast effects.
//           Resolves the existing Whiteout/Trap/Stormstruck/Echo sequence,
//           deducts player Mana AFTER resolution, then applies queued Mana.
//           Invalid attempts release selection without spending resources.
//
// ARGUMENTS: No arguments.
// RETURNS: True for an admitted cast attempt (including Whiteout or Trap
//          cancellation); false when initial validation rejects the action.
//
//===============================================================================//
function scr_battle_cast_card(){
	#region PREFLIGHT

	//==================//
	//SNAPSHOT REQUEST//
	//==================//
	var _ref_card = global.ref_cast_card;
	var _ref_caster = global.ref_caster_beast;
	var _ref_target = global.ref_target_beast;
	var _stct_card = undefined;
	var _scr_card_effect = undefined;
	var _val_mana_cost = 0;
	var _str_failure = "";
	var _flag_player_cast = false;
	var _list_caster_team = undefined;
	var _list_opposing_team = undefined;
	var _str_range = undefined;

	//========================//
	//CARD AND EFFECT CALLBACK//
	//========================//
	if (!instance_exists(_ref_card)){
		_str_failure = "INVALID CARD INSTANCE";
	}
	else if (!variable_instance_exists(_ref_card,"_ref_card") || !is_struct(_ref_card._ref_card)){
		_str_failure = "INVALID CARD STRUCT";
	}
	else{
		_stct_card = _ref_card._ref_card;
		if (!variable_struct_exists(_stct_card,"_scr_card") || !is_callable(_stct_card._scr_card)){
			_str_failure = "INVALID EFFECT CALLBACK";
		}
		else if (!variable_struct_exists(_stct_card,"_val_card_mana_cost") || !is_real(_stct_card._val_card_mana_cost) || _stct_card._val_card_mana_cost < 0){
			_str_failure = "INVALID MANA COST";
		}
		else if (!variable_struct_exists(_stct_card,"_str_card_range") || !is_string(_stct_card._str_card_range)){
			_str_failure = "INVALID CARD RANGE";
		}
		else if (!variable_struct_exists(_stct_card,"_str_card_name") || !variable_struct_exists(_stct_card,"_str_card_type") || !variable_struct_exists(_stct_card,"_str_card_effect_type") || !variable_struct_exists(_stct_card,"_str_card_target_count") || !variable_struct_exists(_stct_card,"_arr_card_colors") || !variable_struct_exists(_stct_card,"_str_card_archetype_req") || !variable_struct_exists(_stct_card,"_str_card_class_req") || !variable_struct_exists(_stct_card,"_flag_card_exhausts")){
			_str_failure = "INCOMPLETE CARD METADATA";
		}
		else{
			_scr_card_effect = _stct_card._scr_card;
			_val_mana_cost = _stct_card._val_card_mana_cost;
		}
	}

	//===================//
	//CONTROLLERS / CASTER//
	//===================//
	if (_str_failure == ""){
		if (!instance_exists(obj_battle_player_controller) || !instance_exists(obj_battle_enemy_controller) || !instance_exists(obj_battle_turn_controller)){
			_str_failure = "MISSING BATTLE CONTROLLER";
		}
		else if (!obj_battle_turn_controller._flag_started_game || obj_battle_turn_controller._flag_battle_ended){
			_str_failure = "BATTLE NOT ACTIVE";
		}
		else if (!instance_exists(_ref_caster) || !variable_instance_exists(_ref_caster,"_ref_unit") || !is_struct(_ref_caster._ref_unit)){
			_str_failure = "INVALID CASTER";
		}
		else if (_ref_caster._str_list != "ALIVE" || _ref_caster._val_cur_hp <= 0 || scr_cc_is_action_locked(_ref_caster)){
			_str_failure = "CASTER CANNOT ACT";
		}
		else if (_ref_caster._str_team != "PLAYER" && _ref_caster._str_team != "ENEMY"){
			_str_failure = "INVALID CASTER TEAM";
		}
	}

	//=====================//
	//TURN / CARD OWNERSHIP//
	//=====================//
	if (_str_failure == ""){
		_flag_player_cast = (_ref_caster._str_team == "PLAYER");
		_list_caster_team = _flag_player_cast ? obj_battle_player_controller._list_beasts_alive : obj_battle_enemy_controller._list_beasts_alive;
		_list_opposing_team = _flag_player_cast ? obj_battle_enemy_controller._list_beasts_alive : obj_battle_player_controller._list_beasts_alive;

		if (!ds_exists(_list_caster_team,ds_type_list) || !ds_exists(_list_opposing_team,ds_type_list)){
			_str_failure = "INVALID BEAST LIST";
		}
		else if (ds_list_find_index(_list_caster_team,_ref_caster) == -1){
			_str_failure = "CASTER NOT IN LIVING TEAM";
		}
		else if (!variable_instance_exists(_ref_card,"_str_team") || !variable_instance_exists(_ref_card,"_str_location") || !variable_instance_exists(_ref_card,"_flag_card_disabled") || _ref_card._str_team != _ref_caster._str_team || _ref_card._str_location != "HAND" || _ref_card._flag_card_disabled){
			_str_failure = "CARD NOT PLAYABLE";
		}
		else if (_flag_player_cast){
			if (obj_battle_turn_controller._val_turn_tracker != 0 || obj_battle_player_controller._state_player != ENUM_PLAYER_STATE.CARD_EXECUTE){
				_str_failure = "NOT PLAYER CAST PHASE";
			}
			else if (!ds_exists(obj_battle_player_controller._list_battle_hand,ds_type_list) || ds_list_find_index(obj_battle_player_controller._list_battle_hand,_ref_card) == -1){
				_str_failure = "CARD NOT IN PLAYER HAND";
			}
			else if (obj_battle_player_controller._val_cur_mana < _val_mana_cost){
				_str_failure = "INSUFFICIENT MANA";
			}
		}
		else{
			if (obj_battle_turn_controller._val_turn_tracker != 1 || obj_battle_enemy_controller._state_enemy != ENUM_ENEMY_STATE.CAST_CARDS){
				_str_failure = "NOT ENEMY CAST PHASE";
			}
			else if (!ds_exists(_ref_caster._list_deck,ds_type_list) || _ref_caster._val_hand_pos < 0 || _ref_caster._val_hand_pos >= ds_list_size(_ref_caster._list_deck) || ds_list_find_value(_ref_caster._list_deck,_ref_caster._val_hand_pos) != _ref_card){
				_str_failure = "CARD NOT ENEMY ACTIVE HAND";
			}
		}
	}

	//=====================//
	//CASTER REQUIREMENTS//
	//=====================//
	if (_str_failure == "" && !_ref_caster._flag_ignore_caster_requirements){
		var _stct_unit = _ref_caster._ref_unit;
		if (!variable_struct_exists(_stct_unit,"_arr_beast_colors") || !variable_struct_exists(_stct_unit,"_str_beast_archetype") || !variable_struct_exists(_stct_unit,"_str_beast_class") || !is_array(_stct_card._arr_card_colors) || array_length(_stct_card._arr_card_colors) < 2 || !is_array(_stct_unit._arr_beast_colors) || array_length(_stct_unit._arr_beast_colors) < 2){
			_str_failure = "INVALID COLOR DATA";
		}
		else{
			var _str_card_color_1 = _stct_card._arr_card_colors[0];
			var _str_card_color_2 = _stct_card._arr_card_colors[1];
			var _str_beast_color_1 = _stct_unit._arr_beast_colors[0];
			var _str_beast_color_2 = _stct_unit._arr_beast_colors[1];
			var _flag_color_match = (
				_str_card_color_1 == "UNCOLORED" ||
				_str_beast_color_1 == "UNCOLORED" ||
				_str_beast_color_2 == "UNCOLORED" ||
				(_str_card_color_1 != undefined && (_str_card_color_1 == _str_beast_color_1 || _str_card_color_1 == _str_beast_color_2)) ||
				(_str_card_color_2 != undefined && (_str_card_color_2 == _str_beast_color_1 || _str_card_color_2 == _str_beast_color_2))
			);
			if (!_flag_color_match){
				_str_failure = "COLOR REQUIREMENT FAILED";
			}
			else if (_stct_card._str_card_archetype_req != undefined && _stct_card._str_card_archetype_req != _stct_unit._str_beast_archetype){
				_str_failure = "ARCHETYPE REQUIREMENT FAILED";
			}
			else if (_stct_card._str_card_class_req != undefined && _stct_card._str_card_class_req != _stct_unit._str_beast_class){
				_str_failure = "CLASS REQUIREMENT FAILED";
			}
		}
	}

	//=======================//
	//RESOLVE INITIAL TARGET//
	//=======================//
	if (_str_failure == ""){
		_str_range = _stct_card._str_card_range;

		//----------------//
		//ENEMY CARD TARGET//
		//----------------//
		if (_str_range == "ENEMY_CARD"){
			_ref_target = global.ref_target_card;
			if (!instance_exists(_ref_target) || !variable_instance_exists(_ref_target,"_ref_card") || !is_struct(_ref_target._ref_card)){
				_str_failure = "INVALID ENEMY CARD TARGET";
			}
			else if (_ref_target._str_team != "ENEMY" || _ref_target._str_team == _ref_caster._str_team || _ref_target._str_location != "HAND" || _ref_target._flag_card_disabled){
				_str_failure = "ENEMY CARD NOT TARGETABLE";
			}
		}

		//---------------//
		//CORPSE TARGET//
		//---------------//
		else if (_str_range == "CORPSE" || _str_range == "CORPSE_OPTIONAL"){
			_ref_target = global.ref_target_corpse;
			if (!instance_exists(_ref_target)){
				var _flag_allow_empty = false;
				if (_str_range == "CORPSE_OPTIONAL"){
					_flag_allow_empty = !scr_battle_has_corpse();
					if (variable_struct_exists(_stct_card,"_flag_allow_empty_corpse_target")){
						_flag_allow_empty = _flag_allow_empty || _stct_card._flag_allow_empty_corpse_target;
					}
				}
				if (_flag_allow_empty){
					_ref_target = undefined;
				}
				else{
					_str_failure = "MISSING REQUIRED CORPSE";
				}
			}
			else if (_ref_target._str_list != "DEAD" || _ref_target._val_cur_hp > 0 || _ref_target._flag_captured || _ref_target._flag_corpse_consumed){
				_str_failure = "INVALID CORPSE STATE";
			}
			else{
				var _list_graveyard = (_ref_target._str_team == "PLAYER") ? obj_battle_player_controller._list_beasts_graveyard : obj_battle_enemy_controller._list_beasts_graveyard;
				if (!ds_exists(_list_graveyard,ds_type_list) || ds_list_find_index(_list_graveyard,_ref_target) == -1){
					_str_failure = "CORPSE NOT IN GRAVEYARD";
				}
			}
		}

		//--------------//
		//GLOBAL TARGET//
		//--------------//
		else if (_str_range == "GLOBAL"){
			if (_ref_target != "GLOBAL"){
				_str_failure = "INVALID GLOBAL TARGET";
			}
		}

		//--------------//
		//BEAST TARGET//
		//--------------//
		else if (_str_range == "SELF" || _str_range == "TEAM" || _str_range == "MELEE" || _str_range == "RANGED" || _str_range == "BACK" || _str_range == "FLANK" || _str_range == "ENEMY"){
			if (!instance_exists(_ref_target) || !variable_instance_exists(_ref_target,"_ref_unit") || !is_struct(_ref_target._ref_unit)){
				_str_failure = "INVALID BEAST TARGET";
			}
			else if (_ref_target._str_list != "ALIVE" || _ref_target._val_cur_hp <= 0){
				_str_failure = "TARGET NOT ALIVE";
			}
			else if (_str_range == "SELF" && _ref_target != _ref_caster){
				_str_failure = "SELF TARGET MISMATCH";
			}
			else if (_str_range == "TEAM" && (_ref_target._str_team != _ref_caster._str_team || (!_flag_player_cast && _ref_target == _ref_caster))){
				_str_failure = "INVALID TEAM TARGET";
			}
			else if (_str_range == "SELF" && _ref_target._str_team != _ref_caster._str_team){
				_str_failure = "INVALID SELF TEAM";
			}
			else if (_ref_target._str_team != _ref_caster._str_team && _ref_target._str_team != (_flag_player_cast ? "ENEMY" : "PLAYER")){
				_str_failure = "INVALID TARGET TEAM";
			}
			else{
				var _flag_friendly = (_ref_target._str_team == _ref_caster._str_team);
				var _list_target_team = _flag_friendly ? _list_caster_team : _list_opposing_team;
				if (ds_list_find_index(_list_target_team,_ref_target) == -1){
					_str_failure = "TARGET NOT IN LIVING FORMATION";
				}

				// Friendly range is deliberately unrestricted on the player side.
				if (_str_failure == "" && !_flag_friendly){
					var _flag_hostile_rule = scr_battle_is_hostile_card_target(_stct_card);
					var _flag_override = false;
					if (_flag_hostile_rule){
						var _ref_taunt = scr_status_get_taunt_target(_list_opposing_team);
						if (instance_exists(_ref_taunt)){
							_flag_override = true;
							if (_ref_target != _ref_taunt){
								_str_failure = "TAUNT TARGET MISMATCH";
							}
						}
						else{
							var _str_blind_mode = scr_cc_get_blind_attack_target_mode(_ref_caster,_stct_card);
							if (_str_blind_mode == "BLOCK"){
								_str_failure = "BLIND BLOCKED ATTACK";
							}
							else if (_str_blind_mode == "FRONT"){
								_flag_override = true;
								for (var _it_front = 0;_it_front < ds_list_size(_list_opposing_team);_it_front++){
									var _ref_front = ds_list_find_value(_list_opposing_team,_it_front);
									if (instance_exists(_ref_front) && _ref_front._str_list == "ALIVE" && _ref_front._val_cur_hp > 0){
										if (_ref_target != _ref_front){
											_str_failure = "BLIND FRONT TARGET MISMATCH";
										}
										break;
									}
								}
							}
						}
					}

					// Apply front/back restrictions only in the absence of Taunt/Blind redirection.
					if (_str_failure == "" && !_flag_override && (_str_range == "MELEE" || _str_range == "BACK" || _str_range == "FLANK")){
						var _ref_formation_target = undefined;
						if (_str_range == "MELEE"){
							for (var _it_front = 0;_it_front < ds_list_size(_list_opposing_team);_it_front++){
								var _ref_front = ds_list_find_value(_list_opposing_team,_it_front);
								if (instance_exists(_ref_front) && _ref_front._str_list == "ALIVE" && _ref_front._val_cur_hp > 0){
									_ref_formation_target = _ref_front;
									break;
								}
							}
						}
						else{
							for (var _it_back = ds_list_size(_list_opposing_team) - 1;_it_back >= 0;_it_back--){
								var _ref_back = ds_list_find_value(_list_opposing_team,_it_back);
								if (instance_exists(_ref_back) && _ref_back._str_list == "ALIVE" && _ref_back._val_cur_hp > 0){
									_ref_formation_target = _ref_back;
									break;
								}
							}
						}
						if (_ref_target != _ref_formation_target){
							_str_failure = "TARGET OUT OF RANGE";
						}
					}
				}
			}
		}
		else{
			_str_failure = "UNKNOWN TARGET RANGE";
		}
	}

	//==================//
	//REJECT BEFORE MUTATION//
	//==================//
	if (_str_failure != ""){
		scr_debug_log("CARDS","CAST",_ref_card,"CARD CAST REJECTED | " + _str_failure,"ERROR","SCR_BATTLE_CAST_CARD");
		global.ref_cast_card = undefined;
		global.ref_caster_beast = undefined;
		global.ref_target_beast = undefined;
		global.ref_target_card = undefined;
		global.ref_target_corpse = undefined;
		return false;
	}

	#endregion

	#region CAST DATA

	//-------------------//
	//RESET PENDING MANA//
	//-------------------//
	_ref_card._ct_pending_mana_gain = 0;

	//================================//
	//SNAPSHOT RELENTLESS PROTECTION//
	//================================//
	var _flag_relentless_prevent_exhaust = false;
	var _ref_relentless = scr_status_check("RELENTLESS",_ref_caster);
	if (_ref_relentless != -1 && instance_exists(_ref_relentless)){
		_flag_relentless_prevent_exhaust = (_ref_relentless._val_status_lifetime > 0 && _ref_relentless._str_status_command != "DEATH");
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

		//========================//
		//RESOLVE CONFUSED TARGET//
		//========================//
		_ref_target = scr_cc_get_confused_target(
			_ref_caster,
			_ref_target,
			_stct_card
		);

		//---------------------//
		//UPDATE SHARED TARGET//
		//---------------------//

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

			//=======================//
			//CHECK BATTLE FRENZY//
			//=======================//
			var _ref_battle_frenzy = scr_status_check(
				"BATTLE_FRENZY",
				_ref_caster
			);

			var _flag_battle_frenzy_active = (
				_stct_card._str_card_type == "ATTACK" &&
				_ref_battle_frenzy != -1 &&
				instance_exists(_ref_battle_frenzy) &&
				_ref_battle_frenzy._ct_status_stacks > 0
			);

			//===================//
			//INITIALIZE CAPTURE//
			//===================//
			if (_flag_battle_frenzy_active){

				_ref_card._arr_battle_frenzy_hits = [];

				_ref_card._ref_battle_frenzy_caster = _ref_caster;

				_ref_card._flag_battle_frenzy_recording = false;
			}

			for (var _it_cast = 0; _it_cast < _ct_card_resolutions; _it_cast++){

				// A prior Echo resolution may have killed the caster or removed the Card.
				if (!instance_exists(_ref_card) || !instance_exists(_ref_caster) || _ref_caster._str_list != "ALIVE" || _ref_caster._val_cur_hp <= 0){
					break;
				}

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

				// Target Traps and earlier Echo repetitions can invalidate a target.
				// Skip only that callback; retain the original post-resolution trigger order.
				var _flag_skip_effect = false;
				if (_str_range == "SELF" || _str_range == "TEAM" || _str_range == "MELEE" || _str_range == "RANGED" || _str_range == "BACK" || _str_range == "FLANK" || _str_range == "ENEMY"){
					_flag_skip_effect = (!instance_exists(_ref_target) || _ref_target._str_list != "ALIVE" || _ref_target._val_cur_hp <= 0);
				}
				else if (_str_range == "ENEMY_CARD"){
					// Thoughtsteal disables the chosen enemy Card on the first resolution.
					_flag_skip_effect = (!instance_exists(_ref_target) || _ref_target._str_location != "HAND" || _ref_target._flag_card_disabled);
				}

				//-------------------//
				//SET EFFECT CONTEXT//
				//-------------------//
				global.ref_icebreaker_target = undefined;
				global.flag_card_effect_resolving = true;

				//========================//
				//PREPARE ATTACK RESULTS//
				//========================//
				if (_stct_card._str_card_type == "ATTACK"){

					//----------------------//
					//RESET DAMAGE RESULTS//
					//----------------------//
					_ref_card._arr_damage_results = [];
					_ref_card._stct_last_damage_result = undefined;

					//-------------------------//
					//RESET ADJACENT TARGETS//
					//-------------------------//
					_ref_card._ref_flaming_lashes_left = undefined;
					_ref_card._ref_flaming_lashes_right = undefined;

					//======================//
					//CHECK FLAMING LASHES//
					//======================//
					var _ref_flaming_lashes = scr_status_check(
						"FLAMING_LASHES",
						_ref_caster
					);

					if (
						_ref_flaming_lashes != -1 &&
						instance_exists(_ref_flaming_lashes)
					){

						//-------------------------//
						//EXCLUDE GLOBAL / NO TARGET//
						//-------------------------//
						if (
							_ref_target != undefined &&
							!is_string(_ref_target)
						){

							if (instance_exists(_ref_target)){

								//---------------------//
								//HOSTILE TARGET ONLY//
								//---------------------//
								if (_ref_target._str_team != _ref_caster._str_team){

									//=======================//
									//SNAPSHOT LEFT AND RIGHT//
									//=======================//
									var _ref_left = scr_battle_get_left_target(_ref_target);
									var _ref_right = scr_battle_get_right_target(_ref_target);

									//------------//
									//STORE LEFT//
									//------------//
									if (instance_exists(_ref_left)){

										if (
											_ref_left._str_list == "ALIVE" &&
											_ref_left._val_cur_hp > 0 &&
											_ref_left._str_team != _ref_caster._str_team
										){
											_ref_card._ref_flaming_lashes_left = _ref_left;
										}
									}

									//-------------//
									//STORE RIGHT//
									//-------------//
									if (instance_exists(_ref_right)){

										if (
											_ref_right._str_list == "ALIVE" &&
											_ref_right._val_cur_hp > 0 &&
											_ref_right._str_team != _ref_caster._str_team
										){
											_ref_card._ref_flaming_lashes_right = _ref_right;
										}
									}
								}
							}
						}
					}
				}

				//============================//
				//ACTIVATE INNER FLAME BONUS//
				//============================//
				var _ref_inner_flame = -1;
				var _flag_inner_flame_activated = false;

				if (_stct_card._str_card_type == "ATTACK"){

					_ref_inner_flame = scr_status_check(
						"INNER_FLAME",
						_ref_caster
					);

					if (
						_ref_inner_flame != -1 &&
						instance_exists(_ref_inner_flame)
					){

						_flag_inner_flame_activated = scr_status_buff_inner_flame(
							"ACTIVATE",
							_ref_inner_flame
						);
					}
				}

				//=======================//
				//BEGIN FRENZY RECORDING//
				//=======================//
				if (_flag_battle_frenzy_active){
					_ref_card._flag_battle_frenzy_recording = true;
				}

				//===========================//
				//ACTIVATE SECOND WIND BUFF//
				//===========================//
				var _ref_second_wind = -1;

				if (_stct_card._str_card_type == "ATTACK"){

					_ref_second_wind = scr_status_check(
						"SECOND_WIND",
						_ref_caster
					);

					if (
						_ref_second_wind != -1 &&
						instance_exists(_ref_second_wind)
					){

						scr_status_buff_second_wind(
							"ACTIVATE",
							_ref_second_wind
						);
					}
				}

				//-------------//
				//RESOLVE CARD//
				//-------------//
				if (!_flag_skip_effect){
					_scr_card_effect(_stct_card,_ref_caster,_ref_target);
				}

				//===========================//
				//CONSUME SECOND WIND BUFF//
				//===========================//
				if (
					_stct_card._str_card_type == "ATTACK" &&
					instance_exists(_ref_second_wind)
				){

					scr_status_buff_second_wind(
						"CONSUME",
						_ref_second_wind
					);
				}

				//=====================//
				//END FRENZY RECORDING//
				//=====================//
				if (_flag_battle_frenzy_active){
					_ref_card._flag_battle_frenzy_recording = false;
				}
				
				//=========================//
				//CONSUME INNER FLAME BONUS//
				//=========================//
				if (
					_flag_inner_flame_activated &&
					instance_exists(_ref_inner_flame)
				){

					scr_status_buff_inner_flame(
						"DEATH",
						_ref_inner_flame
					);
				}				
				
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
			
			//=======================//
			//TRIGGER BATTLE FRENZY//
			//=======================//
			if (_flag_battle_frenzy_active){

				//------------------//
				//RESOLVED ATTACK//
				//------------------//
				if (
					_flag_card_resolved &&
					instance_exists(_ref_battle_frenzy)
				){

					scr_status_buff_battle_frenzy(
						"TRIGGER",
						_ref_battle_frenzy,
						undefined,
						_ref_card
					);
				}

				//================//
				//CLEAR CAPTURE//
				//================//
				_ref_card._flag_battle_frenzy_recording = false;
				_ref_card._arr_battle_frenzy_hits = [];

				_ref_card._ref_battle_frenzy_caster = undefined;
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

		//================//
		//CHECK EXHAUST//
		//================//
		var _flag_should_exhaust = (
			_stct_card._flag_card_exhausts &&
			!_flag_relentless_prevent_exhaust
		);

		//================//
		//EXHAUST CARD//
		//================//
		if (_flag_should_exhaust){

			scr_battle_exhaust_card(_ref_card);
		}

		//================//
		//DISCARD CARD//
		//================//
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
	global.ref_target_card = undefined;
	global.ref_target_corpse = undefined;

	#endregion
	return true;
}