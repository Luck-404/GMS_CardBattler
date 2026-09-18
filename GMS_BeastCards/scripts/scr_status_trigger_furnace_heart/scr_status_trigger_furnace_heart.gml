//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_FURNACE_HEART
// FUNCTION: Checks whether final resolved direct MAG Attack damage should be
//           absorbed by Furnace Heart.
//           The supplied damage has already passed through normal outgoing
//           modifiers, Power scaling, redirect, Defense mitigation, and final
//           damage rounding.
//
// ARGUMENTS: _ref_target is the effective damage recipient.
//            _val_final_damage is the damage that would otherwise resolve.
// RETURNS: True when Furnace Heart absorbs the damage.
//
//===============================================================================//

function scr_status_trigger_furnace_heart(_ref_target,_val_final_damage){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	//----------------//
	//VALIDATE DAMAGE//
	//----------------//
	_val_final_damage = max(0,ceil(_val_final_damage));

	if (_val_final_damage <= 0){
		return false;
	}

	//---------------//
	//VALIDATE CARD//
	//---------------//
	var _ref_cast_card = global.ref_cast_card;

	if (!instance_exists(_ref_cast_card)){
		return false;
	}

	if (!is_struct(_ref_cast_card._ref_card)){
		return false;
	}

	var _stct_card = _ref_cast_card._ref_card;

	//----------------//
	//ATTACKS ONLY//
	//----------------//
	if (_stct_card._str_card_type != "ATTACK"){
		return false;
	}

	//----------------//
	//MAG ONLY//
	//----------------//
	if (_stct_card._str_card_stat != "MAG"){
		return false;
	}

	//================//
	//FURNACE HEART//
	//================//
	var _ref_furnace_heart = scr_status_check("FURNACE_HEART",_ref_target);

	if (
		_ref_furnace_heart == -1 ||
		!instance_exists(_ref_furnace_heart)
	){
		return false;
	}

	if (_ref_furnace_heart._flag_furnace_heart_charged){
		return false;
	}

	//==========//
	//FEEDBACK//
	//==========//
	scr_battle_vfx_blocked(_ref_target);

	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"FURNACE HEART",
		undefined,
		c_red,
		_ref_target.x,
		_ref_target.y - 48
	);

	//================//
	//ABSORB DAMAGE//
	//================//
	var _flag_absorbed = scr_status_buff_furnace_heart(
		"ABSORB",
		_ref_furnace_heart,
		_val_final_damage
	);

	if (!_flag_absorbed){
		return false;
	}

	//================//
	//DEBUG TRIGGER//
	//================//
	scr_debug_log_battle_trigger(
		"FURNACE HEART",
		_ref_target,
		_ref_target,
		"ABSORBED MAG DAMAGE: " +
		string(_val_final_damage) +
		" | STORED NEU: " +
		string(_ref_furnace_heart._ct_status_stacks),
		"SCR_STATUS_TRIGGER_FURNACE_HEART"
	);

	return true;
}