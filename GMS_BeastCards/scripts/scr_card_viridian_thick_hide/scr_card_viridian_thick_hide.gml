//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_THICK_HIDE
// FUNCTION: Resolves Thick Hide.
//           Grants the caster base Armor plus 1 additional Armor
//           for each status currently hosted by the caster.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_thick_hide(_stct_card,_ref_caster,_ref_target){

	//======================//
	//CALCULATE ARMOR GAIN//
	//======================//
	var _ct_statuses = ds_list_size(_ref_caster._list_statuses);
	var _val_armor_gain = _stct_card._val_card_magnitude + _ct_statuses;

	//================//
	//GRANT ARMOR//
	//================//
	scr_battle_armor_target(_val_armor_gain,_ref_caster);
}