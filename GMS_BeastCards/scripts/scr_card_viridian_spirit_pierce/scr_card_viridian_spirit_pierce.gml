//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SPIRIT_PIERCE
// FUNCTION: Resolves Spirit Pierce.
//           Deals armor-piercing magical damage to the selected target.
//           Damages Overhealth and HP without interacting with Armor.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_spirit_pierce(_stct_card,_ref_caster,_ref_target){

	//======================//
	//DEAL PIERCING DAMAGE//
	//======================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{card: _stct_card, pierce_armor: true, card_instance: global.ref_cast_card}
	);
}
