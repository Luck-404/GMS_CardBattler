//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_SECOND_WIND
// FUNCTION: Cleanses all CC from the caster.
//           Heals 15% of the caster's maximum HP.
//           Grants +50% direct damage to the caster's next Attack.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_second_wind(_stct_card,_ref_caster,_ref_target){

	if (_ref_caster._val_cur_hp <= 0){
		return;
	}

	//================//
	//CLEANSE ALL CC//
	//================//
	scr_status_cleanse(
		_ref_caster,
		"CC",
		"ALL"
	);


	//================//
	//CALCULATE HEAL//
	//================//
	var _val_healing = ceil(
		_ref_caster._val_max_hp *
		(_stct_card._val_card_magnitude / 100)
	);

	//================//
	//HEAL CASTER//
	//================//
	scr_battle_heal_target(
		"FIXED",
		_val_healing,
		_ref_caster
	);

	//================//
	//APPLY SECOND WIND//
	//================//
	scr_status_apply_buff("SECOND_WIND", _ref_caster, 50);

}