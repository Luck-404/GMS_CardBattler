//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_LIVING_FLAME
// FUNCTION: Resolves Living Flame.
//           Summons a Living Flame (3 HP / 1 Magnitude) on the selected Beast.
//
// ARGUMENTS: _stct_card is the Living Flame Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is the selected Minion host.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_living_flame(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	if (
		_ref_target._str_list != "ALIVE" ||
		_ref_target._val_cur_hp <= 0
	){
		return;
	}

	//====================//
	//SUMMON LIVING FLAME//
	//====================//
	scr_minion_init(
		"LIVING_FLAME",
		_stct_card,
		_ref_caster,
		_ref_target
	);
}