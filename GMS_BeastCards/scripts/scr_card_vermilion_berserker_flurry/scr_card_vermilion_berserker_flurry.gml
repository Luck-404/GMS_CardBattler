//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BERSERKER_FLURRY
// FUNCTION: Resolves Berserker Flurry.
//           Deals linear Physical damage to the target three times.
//           Stops resolving additional hits if the target dies.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_berserker_flurry(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	repeat (3){

		if (!instance_exists(_ref_target) || _ref_target._val_cur_hp <= 0){
			break;
		}

		scr_battle_damage_target(_stct_card._val_card_magnitude,_ref_target);
	}
}