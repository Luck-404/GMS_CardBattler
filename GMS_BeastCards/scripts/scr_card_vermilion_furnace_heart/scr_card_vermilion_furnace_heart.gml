//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FURNACE_HEART
// FUNCTION: Resolves Furnace Heart.
//           Grants an Infinite unstackable Furnace Heart Buff.
//           The next MAG Attack is absorbed and converted into stored power.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the caster for this Self-target Card.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_furnace_heart(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	//================//
	//STORE TARGET//
	//================//
	var _ref_original_target = global.ref_target_beast;

	//====================//
	//GAIN FURNACE HEART//
	//====================//
	global.ref_target_beast = _ref_caster;

	scr_status_apply_buff("FURNACE_HEART");

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;
}