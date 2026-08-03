//===============================================================================//
//
// SCRIPT: SCR_LOSE_HP
// FUNCTION: Directly removes HP from a Beast.
//           Bypasses Dodge, Armor, Overhealth, power, and defense calculations.
//
//===============================================================================//

function scr_lose_hp(_val_amount,_ref_target){

	if (!instance_exists(_ref_target)){
		return;
	}

	_val_amount = max(0,_val_amount);

	_ref_target._val_cur_hp -= _val_amount;

	_ref_target._val_cur_hp =
		max(
			0,
			_ref_target._val_cur_hp
		);

	scr_spawn_popup_scrolling(
		"TEXT",
		"-" + string(_val_amount) + " HP",
		undefined,
		c_red,
		_ref_target.x,
		_ref_target.y - 48
	);
}