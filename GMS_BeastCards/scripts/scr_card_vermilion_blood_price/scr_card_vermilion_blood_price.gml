//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOOD_PRICE
// FUNCTION: Resolves Blood Price.
//           The caster loses 8 HP directly.
//           Then deals linear Physical damage to the selected target.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_blood_price(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	//================//
	//LOSE 8 HP//
	//================//
	var _val_hp_loss = min(
		8,
		_ref_caster._val_cur_hp
	);

	_ref_caster._val_cur_hp = max(
		0,
		_ref_caster._val_cur_hp - _val_hp_loss
	);

	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"-" + string(_val_hp_loss) + " HP",
		undefined,
		c_red,
		_ref_caster.x,
		_ref_caster.y - 48
	);

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);
}