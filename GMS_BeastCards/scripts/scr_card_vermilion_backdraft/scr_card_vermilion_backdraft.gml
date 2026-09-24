//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BACKDRAFT
// FUNCTION: Resolves Backdraft.
//           Grants the caster one infinite Backdraft charge.
//           The next incoming direct damage instance is split between the
//           caster and its damage source.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the caster for this Self-target Card.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_backdraft(_stct_card,_ref_caster,_ref_target){

	//================//
	//GAIN BACKDRAFT//
	//================//
	scr_status_apply_buff("BACKDRAFT", _ref_target, _stct_card._val_card_magnitude);
}