//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_TOXIC_HIDE
// FUNCTION: Checks a defending Beast for Toxic Hide.
//           Applies Poison to an enemy Melee attacker equal to the Buff's
//           active stack count.
//           Preserves and restores the active battle target context.
//
//===============================================================================//
function scr_trigger_toxic_hide(_ref_defender,_ref_attacker){

	if (!instance_exists(_ref_defender)){
		return false;
	}

	if (!instance_exists(_ref_attacker)){
		return false;
	}

	if (_ref_attacker._val_cur_hp <= 0){
		return false;
	}

	//-------------------//
	//MUST BE AN ENEMY//
	//-------------------//
	if (_ref_attacker._str_team == _ref_defender._str_team){
		return false;
	}

	//------------------//
	//CHECK TOXIC HIDE//
	//------------------//
	var _ref_toxic_hide =
		scr_check_for_status(
			"TOXIC_HIDE",
			_ref_defender
		);

	if (_ref_toxic_hide == -1){
		return false;
	}

	//------------------//
	//CALCULATE POISON//
	//------------------//
	var _ct_poison =
		_ref_toxic_hide._ct_status_stacks *
		_ref_toxic_hide._val_status_magnitude;

	if (_ct_poison <= 0){
		return false;
	}

	//----------------------//
	//STORE CURRENT TARGET//
	//----------------------//
	var _ref_original_target =
		global.ref_target_beast;

	//--------------------//
	//TARGET THE ATTACKER//
	//--------------------//
	global.ref_target_beast =
		_ref_attacker;

	//-------------//
	//FEEDBACK//
	//-------------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"TOXIC HIDE",
		undefined,
		c_green,
		_ref_defender.x,
		_ref_defender.y - 48
	);

	//--------------//
	//APPLY POISON//
	//--------------//
	repeat (_ct_poison){

		if (
			!instance_exists(_ref_attacker) ||
			_ref_attacker._val_cur_hp <= 0
		){
			break;
		}

		scr_apply_dot_status(
			"POISON"
		);
	}

	//----------------//
	//RESTORE TARGET//
	//----------------//
	if (instance_exists(_ref_original_target)){
		global.ref_target_beast =
			_ref_original_target;
	}
	else{
		global.ref_target_beast =
			_ref_defender;
	}

	return true;
}