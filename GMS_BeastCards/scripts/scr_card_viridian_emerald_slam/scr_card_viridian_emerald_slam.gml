//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_EMERALD_SLAM
// FUNCTION: Resolves Emerald Slam.
//           Applies Stun to the target for 1 round.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_emerald_slam(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY CC STATUS//
	//================//
	scr_status_apply_cc("STUN",1);
}