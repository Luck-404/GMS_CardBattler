//===============================================================================//
//
// SCR_HEAL_TARGET
// FUNCTION: Restores HP to a target battle beast.
//           Healing cannot exceed the target's maximum HP.
//           Spawns a healing popup when HP is restored.
//
//===============================================================================//
function scr_heal_target(_val_amount,_ref_target){

	if (_ref_target._val_cur_hp != _ref_target._val_max_hp){

		_ref_target._val_cur_hp += _val_amount;

		if (_ref_target._val_cur_hp > _ref_target._val_max_hp){
			_ref_target._val_cur_hp = _ref_target._val_max_hp;
		}

		scr_spawn_popup_scrolling(
			"TEXT",
			"+" + string(_val_amount),
			undefined,
			c_green,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}
}