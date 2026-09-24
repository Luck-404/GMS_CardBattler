//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BATTLE_TRANCE
// FUNCTION: Resolves Battle Trance.
//           Draws 1 card and grants the caster 1 Rage.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the caster for this Self-target Card.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_battle_trance(_stct_card,_ref_caster,_ref_target){

	//================//
	//DRAW 1 CARD//
	//================//
	scr_battle_draw_cards(1);

	//================//
	//GAIN 1 RAGE//
	//================//
	scr_status_gain_rage(_ref_caster,1);
}