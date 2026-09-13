//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_ENDLESS_BLOOM
// FUNCTION: Resolves Endless Bloom.
//           Creates a global team-bound Buff for 6 rounds.
//           Defeated allied Minions are replaced by Dormant Seeds that inherit
//           their accumulated HP and Magnitude bonuses.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_endless_bloom(_stct_card,_ref_caster,_ref_target){

	//====================//
	//APPLY ENDLESS BLOOM//
	//====================//
	scr_status_apply_buff("ENDLESS_BLOOM",0,6);
}