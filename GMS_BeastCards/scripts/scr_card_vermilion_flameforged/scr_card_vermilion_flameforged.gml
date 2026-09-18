//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FLAMEFORGED
// FUNCTION: Resolves Flameforged.
//           Summons a Flameguard (7 HP / 0 Magnitude) on the caster.
//           The Flameguard's passive makes its host Taunt while it lives.
//
// ARGUMENTS: _stct_card is the Flameforged Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is unused for this Self-target Card.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_flameforged(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (_ref_caster._val_cur_hp <= 0){
		return;
	}

	//==================//
	//SUMMON FLAMEGUARD//
	//==================//
	scr_minion_init(
		"FLAMEGUARD",
		_stct_card,
		_ref_caster,
		_ref_caster
	);
}