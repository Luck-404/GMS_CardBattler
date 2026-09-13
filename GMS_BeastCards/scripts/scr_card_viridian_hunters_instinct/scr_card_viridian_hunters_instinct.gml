//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_HUNTERS_INSTINCT
// FUNCTION: Resolves Hunter's Instinct.
//           Deals linear physical damage to the selected target.
//           Deals 4 additional damage if the target is Bleeding.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_hunters_instinct(_stct_card,_ref_caster,_ref_target){

	//================//
	//CALCULATE DAMAGE//
	//================//
	var _val_damage = _stct_card._val_card_magnitude;
	var _ref_bleed = scr_status_check("BLEED",_ref_target);

	if (_ref_bleed != -1){
		_val_damage += 4;
	}

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(_val_damage,_ref_target);
}