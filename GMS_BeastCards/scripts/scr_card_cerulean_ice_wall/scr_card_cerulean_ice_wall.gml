//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ICE_WALL
// FUNCTION: Resolves Ice Wall.
//           Summons an Ice Wall Minion on the caster.
//
// ARGUMENTS: _stct_card is the Ice Wall card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_ice_wall(_stct_card,_ref_caster,_ref_target){

	//=================//
	//SUMMON ICE WALL//
	//=================//
	scr_minion_init(
		"ICE_WALL",
		_stct_card,
		_ref_caster,
		_ref_caster
	);
}