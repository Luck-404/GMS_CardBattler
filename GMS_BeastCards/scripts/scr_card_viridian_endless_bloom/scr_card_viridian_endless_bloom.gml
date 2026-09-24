
//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_ENDLESS_BLOOM
// FUNCTION: Resolves Endless Bloom.
//           Creates a global team-bound Buff for 5 rounds.
//           Defeated or sacrificed allied Minions are replaced by Dormant
//           Seeds that inherit accumulated HP and Magnitude bonuses.
//
// ARGUMENTS: _stct_card is the Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_endless_bloom(_stct_card,_ref_caster,_ref_target){

	//====================//
	//APPLY ENDLESS BLOOM//
	//====================//
	scr_status_apply_buff("ENDLESS_BLOOM",_ref_target,0,5);
}