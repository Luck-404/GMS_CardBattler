//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_TORRENT
// FUNCTION: Resolves Torrent.
//           Deals linear magical damage to the selected Flank target.
//
// ARGUMENTS: _stct_card is the Torrent card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_torrent(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);
}