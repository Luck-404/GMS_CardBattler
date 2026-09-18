//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_TOXIC_RECLAIMATION
// FUNCTION: Resolves Toxic Reclaimation.
//           METABOLIZE 3 consumes exactly 3 Poison from the target.
//           If successful, draws 2 cards.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_toxic_reclaimation(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	//================//
	//CHECK POISON//
	//================//
	var _ref_poison = scr_status_check(
		"POISON",
		_ref_target
	);

	if (
		_ref_poison == -1 ||
		!instance_exists(_ref_poison) ||
		_ref_poison._ct_status_stacks < 3
	){
		return;
	}

	//================//
	//METABOLIZE 3//
	//================//
	var _ct_poison_consumed = scr_battle_trigger_metabolize(
		_ref_target,
		3
	);

	if (_ct_poison_consumed != 3){
		return;
	}

	//================//
	//DRAW 2 CARDS//
	//================//
	scr_battle_draw_cards(2);
}