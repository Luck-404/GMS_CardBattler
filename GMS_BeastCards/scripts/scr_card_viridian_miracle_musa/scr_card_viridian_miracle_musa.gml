//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_MIRACLE_MUSA
// FUNCTION: Resolves Miracle Musa.
//           Grants the caster MAG-scaled temporary Overhealth for 3 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_miracle_musa(_stct_card,_ref_caster,_ref_target){

	//======================//
	//CALCULATE OVERHEALTH//
	//======================//
	var _val_mpow_stat = _ref_caster._ref_unit._val_beast_mpow_stat;
	var _val_mpow_mod = scr_beast_get_grade_modifier(_val_mpow_stat);
	var _val_overhealth = ceil(_stct_card._val_card_magnitude * _val_mpow_mod);

	//==================//
	//APPLY OVERHEALTH//
	//==================//
	scr_status_apply_buff("OVERHEALTH", _ref_target, _val_overhealth, 3);
}
