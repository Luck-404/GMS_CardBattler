//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ANCHOR_STONE
// FUNCTION: Resolves Anchor Stone.
//           Summons an Anchor Stone on the selected allied Beast.
//           While it remains active, all allied Beasts are Immovable.
//
// ARGUMENTS: _stct_card is the Anchor Stone card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_anchor_stone(_stct_card,_ref_caster,_ref_target){

	//===================//
	//SUMMON ANCHOR STONE//
	//===================//
	scr_minion_init(
		"ANCHOR_STONE",
		_stct_card,
		_ref_caster,
		_ref_target
	);
}