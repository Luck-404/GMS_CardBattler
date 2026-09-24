//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_MANAVINE
// FUNCTION: Resolves Manavine.
//           Applies the Manavine global Mana Buff for 3 rounds.
//           Manavine remains independent from Inspiration so both can stack.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_manavine(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY MANA BUFF//
	//================//
	scr_status_apply_buff("MANAVINE", _ref_target, 1, 3);
}