//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FURNACE_HEART
// FUNCTION: Resolves Furnace Heart.
//           Grants an Infinite unstackable Furnace Heart Buff.
//           The next MAG Attack is absorbed and converted into stored power.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the caster for this Self-target Card.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_furnace_heart(_stct_card,_ref_caster,_ref_target){


	//====================//
	//GAIN FURNACE HEART//
	//====================//

	scr_status_apply_buff("FURNACE_HEART", _ref_caster);

}