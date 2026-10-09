//===============================================================================//
//
// SCRIPT: SCR_BATTLE_CAST_SIMULATED_CARD
// FUNCTION: Executes one Cheats-only simulated Card cast using a fresh default
//           Card struct from SCR_CARD_GET_INFO. Creates an invisible compatibility
//           OBJ_BATTLE_CARD so existing Card-context consumers, traps, damage
//           records, VFX/SFX gates, and persistent source references remain valid.
//
//           The compatibility Card is not inserted into a hand/deck/pile and is
//           left invisible for the remainder of the battle when the cast is
//           admitted because some persistent Statuses/Traps retain source-Card refs.
//           Battle room teardown destroys these debug-only instances normally.
//
//           SCR_BATTLE_CAST_CARD(true) retains normal caster requirements,
//           action locks, targeting rules, Whiteout, Traps, Stormstruck, Echo,
//           Held Item modifiers, Card-cast triggers, and generated Mana, but skips
//           turn/hand ownership, Mana cost, and discard/exhaust destination.
//
// ARGUMENTS: _str_card_id is the Card definition ID.
//            _ref_caster is the selected living Player or Enemy Beast.
//            _ref_target is the selected Beast, Corpse, Card, GLOBAL token, or
//            undefined for an allowed empty CORPSE_OPTIONAL cast.
// RETURNS: True when the simulated cast is admitted; false when rejected.
//
//===============================================================================//

function scr_battle_cast_simulated_card(_str_card_id,_ref_caster,_ref_target=undefined){

	#region VALIDATION

	//================//
	//ACTIVE BATTLE//
	//================//
	if (
		room != rm_battle ||
		!instance_exists(obj_battle_player_controller) ||
		!instance_exists(obj_battle_enemy_controller) ||
		!instance_exists(obj_battle_turn_controller)
	){
		return false;
	}

	//================//
	//CARD DEFINITION//
	//================//
	_str_card_id = string_upper(string(_str_card_id));

	var _stct_card =
		scr_card_get_info(
			_str_card_id
		);

	if (
		!is_struct(_stct_card) ||
		!variable_struct_exists(_stct_card,"_str_card_name") ||
		_stct_card._str_card_name == "DEFAULT" ||
		!variable_struct_exists(_stct_card,"_scr_card") ||
		!is_callable(_stct_card._scr_card)
	){
		scr_debug_log(
			"CARDS",
			"SIMULATED_CAST",
			undefined,
			"SIMULATED CARD CAST REJECTED | INVALID CARD: " + _str_card_id,
			"ERROR",
			"SCR_BATTLE_CAST_SIMULATED_CARD"
		);

		return false;
	}

	//================//
	//CASTER//
	//================//
	if (
		!instance_exists(_ref_caster) ||
		_ref_caster.object_index != obj_battle_beast
	){
		return false;
	}

	#endregion

	#region COMPATIBILITY CARD

	//==========================//
	//CREATE INVISIBLE CONTEXT//
	//==========================//
	var _ref_simulated_card =
		instance_create_depth(
			-10000,
			-10000,
			0,
			obj_battle_card
		);

	_ref_simulated_card.visible = false;
	_ref_simulated_card._flag_simulated_card = true;

	_ref_simulated_card._ref_card = _stct_card;
	_ref_simulated_card._ref_unit = _ref_caster;
	_ref_simulated_card._str_team = _ref_caster._str_team;
	_ref_simulated_card._str_location = "SIMULATED";
	_ref_simulated_card._flag_card_disabled = false;

	if (variable_struct_exists(_stct_card,"_spr_card")){
		_ref_simulated_card._spr_card = _stct_card._spr_card;
	}

	if (variable_struct_exists(_stct_card,"_uid_card")){
		_ref_simulated_card._uid_card = _stct_card._uid_card;
	}

	#endregion

	#region CAST CONTEXT

	//================//
	//SHARED REFERENCES//
	//================//
	global.ref_cast_card = _ref_simulated_card;
	global.ref_caster_beast = _ref_caster;

	global.ref_target_beast = undefined;
	global.ref_target_card = undefined;
	global.ref_target_corpse = undefined;

	var _str_range =
		string_upper(
			string(_stct_card._str_card_range)
		);

	if (_str_range == "ENEMY_CARD"){
		global.ref_target_card = _ref_target;
	}
	else if (
		_str_range == "CORPSE" ||
		_str_range == "CORPSE_OPTIONAL"
	){
		global.ref_target_corpse = _ref_target;
	}
	else{
		global.ref_target_beast = _ref_target;
	}

	#endregion

	#region RESOLUTION

	//================//
	//SIMULATED CAST//
	//================//
	var _flag_cast_admitted =
		scr_battle_cast_card(true);

	// Rejected casts cannot have created a persistent source dependency.
	if (!_flag_cast_admitted){
		if (instance_exists(_ref_simulated_card)){
			instance_destroy(_ref_simulated_card);
		}

		return false;
	}

	scr_debug_log(
		"CARDS",
		"SIMULATED_CAST",
		_ref_caster,
		"SIMULATED CARD CAST COMPLETE" +
		" | CARD: " + string_upper(_stct_card._str_card_name) +
		" | TEAM: " + string_upper(_ref_caster._str_team),
		"BATTLE",
		"SCR_BATTLE_CAST_SIMULATED_CARD"
	);

	#endregion

	return true;
}
