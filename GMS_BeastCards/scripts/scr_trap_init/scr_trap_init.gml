//===============================================================================//
//
// SCRIPT: SCR_TRAP_INIT
// FUNCTION: Creates and attaches a Trap to a target Beast or target team.
//           Initializes Trap identity, ownership, trigger rules, callback,
//           magnitude, and announces that a Trap was set.
//
// ARGUMENTS: _str_trap_id identifies the Trap, _stct_card contains its card
//            data, _ref_caster owns the Trap, and _ref_target receives it.
// RETURNS: The newly created Trap instance, or undefined if initialization fails.
//
//===============================================================================//

function scr_trap_init(_str_trap_id,_stct_card,_ref_caster,_ref_target){

	//-----------------//
	//VALIDATE CONTEXT//
	//-----------------//
	if (!instance_exists(_ref_caster)){
		return undefined;
	}

	if (!instance_exists(_ref_target)){
		return undefined;
	}

	//======================//
	//CONFIGURE TRAP DATA//
	//======================//
	var _str_trap_name = "";
	var _str_trigger_type = "";
	var _str_trigger_phase = "BEFORE";
	var _str_trap_scope = "HOST";
	var _scr_trap_callback = undefined;
	var _val_magnitude = 0;

	switch (_str_trap_id){

		//==============//
		//VOLATILE BRAND//
		//==============//
		case "VOLATILE_BRAND":

			if (!is_struct(_stct_card)){
				return undefined;
			}

			_str_trap_name = "VOLATILE BRAND";

			_str_trigger_type = "DEATH";
			_str_trigger_phase = "BEFORE";

			_scr_trap_callback = scr_trap_volatile_brand;
			_val_magnitude = _stct_card._val_card_magnitude;

		break;

		//==========//
		//POWDER KEG//
		//==========//
		case "POWDER_KEG":

			if (!is_struct(_stct_card)){
				return undefined;
			}

			_str_trap_name = "POWDER KEG";

			_str_trigger_type = "DAMAGED";
			_str_trigger_phase = "AFTER";

			_scr_trap_callback = scr_trap_powder_keg;
			_val_magnitude = _stct_card._val_card_magnitude;

		break;

		//=============//
		//DRAGON MINE//
		//=============//
		case "DRAGON_MINE":

			if (!is_struct(_stct_card)){
				return undefined;
			}

			_str_trap_name = "DRAGON MINE";
			_str_trigger_type = "ATTACKING";

			_scr_trap_callback = scr_trap_dragon_mine;
			_val_magnitude = _stct_card._val_card_magnitude;

		break;

		//=============//
		//PULLED UNDER//
		//=============//
		case "PULLED_UNDER":

			_str_trap_name = "PULLED UNDER";
			_str_trigger_type = "HEALED";
			_str_trigger_phase = "AFTER";
			_str_trap_scope = "TEAM";

			_scr_trap_callback = scr_trap_pulled_under;

		break;

		//==========//
		//THIN ICE//
		//==========//
		case "THIN_ICE":

			if (!is_struct(_stct_card)){
				return undefined;
			}

			_str_trap_name = "THIN ICE";
			_str_trigger_type = "ATTACKING";

			_scr_trap_callback = scr_trap_thin_ice;
			_val_magnitude = _stct_card._val_card_magnitude;

		break;

		//==============//
		//STORM BEACON//
		//==============//
		case "STORM_BEACON":

			if (!is_struct(_stct_card)){
				return undefined;
			}

			_str_trap_name = "STORM BEACON";
			_str_trigger_type = "CASTING";
			_str_trigger_phase = "AFTER";

			_scr_trap_callback = scr_trap_storm_beacon;
			_val_magnitude = _stct_card._val_card_magnitude;

		break;

		//===========//
		//THORN NET//
		//===========//
		case "THORN_NET":

			_str_trap_name = "THORN NET";
			_str_trigger_type = "ATTACKING";

			_scr_trap_callback = scr_trap_thorn_net;
			_val_magnitude = 4;

		break;

		//=============//
		//VENOM BLOOM//
		//=============//
		case "VENOM_BLOOM":

			_str_trap_name = "VENOM BLOOM";
			_str_trigger_type = "DEATH";

			_scr_trap_callback = scr_trap_venom_bloom;

		break;

		//=============//
		//TOXIC SNARE//
		//=============//
		case "TOXIC_SNARE":

			_str_trap_name = "TOXIC SNARE";
			_str_trigger_type = "DOT_THRESHOLD";

			_scr_trap_callback = scr_trap_toxic_snare;

		break;

		//================//
		//ROTTING SPORES//
		//================//
		case "ROTTING_SPORES":

			_str_trap_name = "ROTTING SPORES";
			_str_trigger_type = "HEALED";

			_scr_trap_callback = scr_trap_rotting_spores;
			_val_magnitude = 5;

		break;

		//==================//
		//DISTRACTING TRAP//
		//==================//
		case "DISTRACTING_TRAP":

			_str_trap_name = "DISTRACTING TRAP";
			_str_trigger_type = "TARGETED";

			_scr_trap_callback = scr_trap_distracting_trap;

		break;

		default:
			return undefined;
	}

	//=====================//
	//VALIDATE COLLECTION//
	//=====================//
	if (_str_trap_scope == "TEAM"){

		if (!instance_exists(obj_battle_turn_controller)){
			return undefined;
		}

		if (!variable_instance_exists(obj_battle_turn_controller,"_arr_team_traps")){
			return undefined;
		}

		if (!is_array(obj_battle_turn_controller._arr_team_traps)){
			return undefined;
		}
	}
	else{

		if (!variable_instance_exists(_ref_target,"_list_traps")){
			return undefined;
		}

		if (!ds_exists(_ref_target._list_traps,ds_type_list)){
			return undefined;
		}
	}

	//================//
	//CREATE TRAP//
	//================//
	var _ref_new_trap = instance_create_layer(
		_ref_target.x,
		_ref_target.y,
		"ily_status",
		obj_battle_trap
	);

	//================//
	//TRAP OWNERSHIP//
	//================//
	_ref_new_trap._ref_host = _ref_target;
	_ref_new_trap._ref_owner = _ref_caster;
	_ref_new_trap._ref_source_card = global.ref_cast_card;

	_ref_new_trap._str_owner_team = _ref_caster._str_team;
	_ref_new_trap._str_target_team = _ref_target._str_team;

	//================//
	//TRAP IDENTITY//
	//================//
	_ref_new_trap._str_trap_id = _str_trap_id;
	_ref_new_trap._str_trap_name = _str_trap_name;

	//================//
	//TRIGGER RULES//
	//================//
	_ref_new_trap._str_trigger_type = _str_trigger_type;
	_ref_new_trap._str_trigger_phase = _str_trigger_phase;
	_ref_new_trap._str_trap_scope = _str_trap_scope;

	//================//
	//TRAP BEHAVIOR//
	//================//
	_ref_new_trap._scr_trap_callback = _scr_trap_callback;
	_ref_new_trap._val_magnitude = _val_magnitude;

	//================//
	//REGISTER TRAP//
	//================//
	if (_str_trap_scope == "TEAM"){

		array_push(
			obj_battle_turn_controller._arr_team_traps,
			_ref_new_trap
		);
	}
	else{

		ds_list_add(
			_ref_target._list_traps,
			_ref_new_trap
		);
	}

	//================//
	//DEBUG TRAP SET//
	//================//
	var _str_target = "";

	if (_str_trap_scope == "TEAM"){

		_str_target =
			"TARGET TEAM: " +
			string_upper(_ref_target._str_team);
	}
	else{

		_str_target =
			"TARGET: " +
			string_upper(_ref_target._str_team) + " " +
			string_upper(_ref_target._ref_unit._str_beast_name);
	}

	var _str_trap_message =
		string_upper(_ref_caster._str_team) + " " +
		string_upper(_ref_caster._ref_unit._str_beast_name) +
		" SET " +
		string_upper(_str_trap_name) +
		" | " + _str_target +
		" | SCOPE: " + string_upper(_str_trap_scope) +
		" | TRIGGER: " +
		string_upper(_str_trigger_type) +
		"/" +
		string_upper(_str_trigger_phase);

	if (_val_magnitude > 0){
		_str_trap_message +=
			" | MAGNITUDE: " +
			string(_val_magnitude);
	}

	scr_debug_log(
		"BATTLE",
		"TRAP",
		_ref_caster,
		_str_trap_message,
		"BATTLE",
		"SCR_TRAP_INIT"
	);

	//================//
	//ANNOUNCE TRAP//
	//================//
	scr_gui_spawn_popup_trigger_banner(
		_ref_caster._str_team + " HAS SET A TRAP"
	);

	return _ref_new_trap;
}