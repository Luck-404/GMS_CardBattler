//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_INNER_FLAME
// FUNCTION: Cleanses all DoTs and Debuffs from the caster.
//           Grants +2 damage per Status removed on the next Attack.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_inner_flame(_stct_card,_ref_caster,_ref_target){

	//================//
	//COUNT STATUSES//
	//================//
	var _ct_statuses = ds_list_size(_ref_caster._list_statuses);

	//=======//
	//CLEANSE//
	//=======//
	var _stct_cleanse = scr_status_cleanse(
		_ref_caster,
		["DOT","DEBUFF"],
		"ALL"
	);

	var _ct_removed =
		_stct_cleanse._ct_statuses_removed;

	if (_ct_removed <= 0){
		return;
	}

	var _val_damage_bonus =
		_ct_removed * 2;

	scr_status_apply_buff(
		"INNER_FLAME",
		_ref_caster,
		_val_damage_bonus
	);

	//================//
	//CALCULATE BONUS//
	//================//
	var _val_damage_bonus = _ct_removed * 2;

	//================//
	//APPLY INNER FLAME//
	//================//
	scr_status_apply_buff("INNER_FLAME", _ref_caster, _val_damage_bonus);

}