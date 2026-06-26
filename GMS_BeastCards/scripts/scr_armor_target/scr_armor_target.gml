//===============================================================================//
//
// SCR_ARMOR_TARGET
// FUNCTION: Adds armor to a target battle beast.
//           Spawns armor gain popup text at the target.
//
//===============================================================================//
function scr_armor_target(_val_amount,_ref_target){

	_ref_target._val_armor += _val_amount;

	scr_spawn_popup_scrolling(
		"TEXT",
		"+" + string(_val_amount),
		undefined,
		c_blue,
		_ref_target.x + irandom_range(-32,32),
		_ref_target.y - 24 + irandom_range(-32,32)
	);
}