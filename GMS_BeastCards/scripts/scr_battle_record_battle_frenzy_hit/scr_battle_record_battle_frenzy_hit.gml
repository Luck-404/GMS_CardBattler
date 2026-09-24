//===============================================================================//
//
// SCRIPT: SCR_BATTLE_RECORD_BATTLE_FRENZY_HIT
// FUNCTION: Records one resolved direct-damage hit for Battle Frenzy.
//           Only records damage from the active Attack's original Card effect.
//           Does not record damage from the later Frenzy repetitions.
//
// ARGUMENTS: _ref_caster is the Beast responsible for the Attack.
//            _ref_target is the Beast that actually received the hit.
//            _val_damage is the total damage actually distributed.
//            _ref_card is the Card instance whose Frenzy hit ledger is active.
// RETURNS: True if a hit was recorded; otherwise false.
//
//===============================================================================//

function scr_battle_record_battle_frenzy_hit(_ref_caster,_ref_target,_val_damage,_ref_card=undefined){

	//================//
	//VALIDATION//
	//================//
	if (!instance_exists(_ref_caster)){
		return false;
	}

	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_val_damage <= 0){
		return false;
	}

	

	if (_ref_card == -1 || !instance_exists(_ref_card)){
		return false;
	}

	//================//
	//CHECK RECORDING//
	//================//
	if (!variable_instance_exists(_ref_card,"_flag_battle_frenzy_recording")){
		return false;
	}

	if (!_ref_card._flag_battle_frenzy_recording){
		return false;
	}

	if (_ref_card._ref_battle_frenzy_caster != _ref_caster){
		return false;
	}

	if (_ref_card._ref_card._str_card_type != "ATTACK"){
		return false;
	}

	//================//
	//ENSURE HIT ARRAY//
	//================//
	if (!is_array(_ref_card._arr_battle_frenzy_hits)){
		_ref_card._arr_battle_frenzy_hits = [];
	}

	//================//
	//RECORD HIT//
	//================//
	array_push(
		_ref_card._arr_battle_frenzy_hits,
		{
			_ref_target : _ref_target,
			_val_damage : _val_damage
		}
	);

	return true;
}