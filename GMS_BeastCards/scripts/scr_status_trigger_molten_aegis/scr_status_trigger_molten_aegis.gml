//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_MOLTEN_AEGIS
// FUNCTION: Checks an attacking Beast for Molten Aegis.
//           Consumes the Buff on the host's next successfully resolved Attack
//           and applies its Burn magnitude to each living Beast affected.
//
// ARGUMENTS: _ref_attacker is the attacking Beast.
//            _ref_primary_target is the Attack's selected primary target.
//            _stct_card is the resolving Attack Card.
// RETURNS: True when Molten Aegis is consumed.
//
//===============================================================================//

function scr_status_trigger_molten_aegis(_ref_attacker,_ref_primary_target,_stct_card){

	//-------------------//
	//VALIDATE ATTACKER//
	//-------------------//
	if (!instance_exists(_ref_attacker)){
		return false;
	}

	//--------------//
	//VALIDATE CARD//
	//--------------//
	if (!is_struct(_stct_card)){
		return false;
	}

	if (_stct_card._str_card_type != "ATTACK"){
		return false;
	}

	//===================//
	//CHECK MOLTEN AEGIS//
	//===================//
	var _ref_molten_aegis = scr_status_check("MOLTEN_AEGIS",_ref_attacker);

	if (
		_ref_molten_aegis == -1 ||
		!instance_exists(_ref_molten_aegis)
	){
		return false;
	}

	var _ct_burn = max(1,floor(_ref_molten_aegis._val_status_magnitude));

	//====================//
	//GET ATTACK TARGETS//
	//====================//
	var _arr_targets = scr_battle_get_card_preview_targets(
		_stct_card,
		_ref_primary_target
	);

	if (
		array_length(_arr_targets) <= 0 &&
		instance_exists(_ref_primary_target)
	){
		array_push(_arr_targets,_ref_primary_target);
	}

	//================//
	//CONSUME BUFF//
	//================//
	scr_status_buff_molten_aegis("DEATH",_ref_molten_aegis);

	//================//
	//STORE TARGET//
	//================//
	var _ref_original_target = global.ref_target_beast;

	//================//
	//APPLY BURN//
	//================//
	for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

		var _ref_target = _arr_targets[_it_target];

		if (!instance_exists(_ref_target)){
			continue;
		}

		if (
			_ref_target._str_list != "ALIVE" ||
			_ref_target._val_cur_hp <= 0
		){
			continue;
		}

		global.ref_target_beast = _ref_target;

		repeat (_ct_burn){
			scr_status_apply_dot("BURN");
		}
	}

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;

	return true;
}