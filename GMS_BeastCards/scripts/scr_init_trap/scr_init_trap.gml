//===============================================================================//
//
// SCRIPT: SCR_INIT_TRAP
// FUNCTION: Creates and attaches a Trap to a target Beast.
//           Initializes Trap-specific data and announces that a Trap was set.
//
//===============================================================================//

function scr_init_trap(_str_trap_id,_stct_card,_ref_caster,_ref_target){

	if (!instance_exists(_ref_caster)){
		return undefined;
	}

	if (!instance_exists(_ref_target)){
		return undefined;
	}

	var _ref_new_trap =
		instance_create_layer(
			_ref_target.x,
			_ref_target.y,
			"ily_status",
			obj_battle_trap
		);

	_ref_new_trap._ref_host =
		_ref_target;

	_ref_new_trap._ref_owner =
		_ref_caster;

	_ref_new_trap._ref_source_card =
		global.ref_cast_card;

	_ref_new_trap._str_owner_team =
		_ref_caster._str_team;

	_ref_new_trap._str_trap_id =
		_str_trap_id;

	switch(_str_trap_id){

		case "PULLED_UNDER":

			_ref_new_trap._str_trap_name =
				"PULLED UNDER";

			_ref_new_trap._str_trigger_type =
				"HEALED";

			_ref_new_trap._str_trigger_phase =
				"AFTER";

			_ref_new_trap._str_trap_scope =
				"TEAM";

			_ref_new_trap._str_target_team =
				_ref_target._str_team;

			_ref_new_trap._scr_trap =
				scr_trap_pulled_under;

			_ref_new_trap._val_magnitude =
				0;

		break;

		case "THIN_ICE":

			_ref_new_trap._str_trap_name =
				"THIN ICE";

			_ref_new_trap._str_trigger_type =
				"ATTACKING";

			_ref_new_trap._scr_trap =
				scr_trap_thin_ice;

			_ref_new_trap._val_magnitude =
				_stct_card._val_card_magnitude;

		break;

		case "STORM_BEACON":

			_ref_new_trap._str_trap_name =
				"STORM BEACON";

			_ref_new_trap._str_trigger_type =
				"CASTING";

			_ref_new_trap._scr_trap =
				scr_trap_storm_beacon;

			_ref_new_trap._val_magnitude =
				_stct_card._val_card_magnitude;

		break;

		case "THORN_NET":

			_ref_new_trap._str_trap_name =
				"THORN NET";

			_ref_new_trap._str_trigger_type =
				"ATTACKING";

			_ref_new_trap._scr_trap =
				scr_trap_thorn_net;

			_ref_new_trap._val_magnitude =
				4;

		break;

		case "VENOM_BLOOM":

			_ref_new_trap._str_trap_name =
				"VENOM BLOOM";

			_ref_new_trap._str_trigger_type =
				"DEATH";

			_ref_new_trap._scr_trap =
				scr_trap_venom_bloom;

			_ref_new_trap._val_magnitude =
				0;

		break;

		case "TOXIC_SNARE":

			_ref_new_trap._str_trap_name =
				"TOXIC SNARE";

			_ref_new_trap._str_trigger_type =
				"DOT_THRESHOLD";

			_ref_new_trap._scr_trap =
				scr_trap_toxic_snare;

			_ref_new_trap._val_magnitude =
				0;

		break;

		case "ROTTING_SPORES":

			_ref_new_trap._str_trap_id =
				"ROTTING_SPORES";

			_ref_new_trap._str_trap_name =
				"ROTTING SPORES";

			_ref_new_trap._str_trigger_type =
				"HEALED";

			_ref_new_trap._scr_trap =
				scr_trap_rotting_spores;

			_ref_new_trap._val_magnitude =
				5;

		break;

		case "DISTRACTING_TRAP":

			_ref_new_trap._str_trap_name =
				"DISTRACTING TRAP";

			_ref_new_trap._str_trigger_type =
				"TARGETED";

			_ref_new_trap._scr_trap =
				scr_trap_distracting_trap;

			_ref_new_trap._val_magnitude =
				0;

		break;
	}

	//----------------//
	//REGISTER TRAP//
	//----------------//
	if (_ref_new_trap._str_trap_scope == "TEAM"){

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

	//----------------//
	//ANNOUNCE TRAP//
	//----------------//
	var _str_team_text =
		_ref_caster._str_team;

	scr_spawn_popup_trigger_banner(
		_str_team_text +
		" HAS SET A TRAP"
	);

	return _ref_new_trap;
}