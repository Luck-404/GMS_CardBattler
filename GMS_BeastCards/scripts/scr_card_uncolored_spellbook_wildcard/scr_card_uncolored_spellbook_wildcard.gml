//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_SPELLBOOK_WILDCARD
// FUNCTION: Resolves Spellbook Wildcard.
//           Applies 5 randomly selected damage-over-time effects from the
//           available DoT pool.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_uncolored_spellbook_wildcard(_stct_card,_ref_caster,_ref_target){

	//================//
	//DISH OUT 5 DOTS//
	//================//
	repeat (5){
		var _str_dot = choose("BLEED","BURN","POISON","VENOM","FROSTBURN","STORMSTRUCK","FROSTBITE");
		//var _str_dot = choose("BURN");
		//var _str_dot = choose("BLEED");
		scr_status_apply_dot(_str_dot);
		//scr_status_gain_rage(_ref_target,1);
	}

}