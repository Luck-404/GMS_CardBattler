//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_STATIC_BARRIER
// FUNCTION: Resolves Static Barrier.
//           For 3 rounds, successful enemy Attack damage against the caster
//           applies 1 Stormstruck to the attacker.
//
// ARGUMENTS: _stct_card is the Static Barrier card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_static_barrier(_stct_card,_ref_caster,_ref_target){

	//====================//
	//APPLY STATIC BARRIER//
	//====================//
	scr_status_apply_buff("STATIC_BARRIER", _ref_target, 1, 3);
}