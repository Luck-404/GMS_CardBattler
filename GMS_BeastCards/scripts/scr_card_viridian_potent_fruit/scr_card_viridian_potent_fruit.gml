//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_POTENT_FRUIT
// FUNCTION: Resolves Potent Fruit.
//           Applies 1 stack of Boost to the caster for 2 rounds.
//           Each Boost stack increases damage dealt by 25%.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_potent_fruit(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY BOOST//
	//================//
	scr_status_apply_buff("BOOST",25,2);
}