//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_WINTER_RESONANCE
// FUNCTION: Resolves Winter Resonance.
//           SHATTERS the selected target.
//           SHATTER consumes all Frostbite and deals
//           3 neutral damage per Frostbite stack consumed.
//
// ARGUMENTS: _stct_card is the Winter Resonance card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_winter_resonance(_stct_card,_ref_caster,_ref_target){

	//================//
	//SHATTER//
	//================//
	scr_battle_trigger_shatter(
		_ref_target
	);
}