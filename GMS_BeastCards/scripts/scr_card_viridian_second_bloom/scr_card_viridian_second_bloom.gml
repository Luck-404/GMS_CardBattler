//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SECOND_BLOOM
// FUNCTION: Resolves Second Bloom.
//           Grants Second Life to the selected target for 4 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_second_bloom(_stct_card,_ref_caster,_ref_target){

	//==================//
	//APPLY SECOND LIFE//
	//==================//
	scr_status_apply_buff("SECOND_LIFE",0,4);
}