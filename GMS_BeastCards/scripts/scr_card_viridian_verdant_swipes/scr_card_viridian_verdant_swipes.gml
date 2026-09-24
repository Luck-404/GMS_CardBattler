//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_VERDANT_SWIPES
// FUNCTION: Resolves Verdant Swipes.
//           Deals 3 separate damage hits to the selected target.
//           Stops early if the target dies.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_verdant_swipes(_stct_card,_ref_caster,_ref_target){

	//====================//
	//DEAL DAMAGE 3 TIMES//
	//====================//
	repeat (3){

		if (!instance_exists(_ref_target) || _ref_target._val_cur_hp <= 0){
			break;
		}

		scr_battle_damage_target(
			"LINEAR",
			_ref_caster,
			_ref_target,
			_stct_card._val_card_magnitude,
			{card: _stct_card, card_instance: global.ref_cast_card}
		);
	}
}