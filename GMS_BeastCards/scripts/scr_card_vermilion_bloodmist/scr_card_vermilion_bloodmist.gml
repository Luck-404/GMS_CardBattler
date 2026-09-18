//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOODMIST
// FUNCTION: Begins the Bloodmist Event.
//           At the end of each round, every living Beast heals 5 HP
//           and gains 1 Bleed.
//           While active, all Beasts are Blind and all Attacks HEMORRHAGE.
//           Bloodmist lasts 3 rounds.
//
// ARGUMENTS: _stct_card is the Card struct.
//            _ref_caster and _ref_target are the casting and target references.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_bloodmist(_stct_card,_ref_caster,_ref_target){

	//================//
	//BEGIN BLOODMIST//
	//================//
	scr_status_apply_event("BLOODMIST",3);
}