//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SPIRIT_PIERCE
// FUNCTION: Resolves the Spirit Pierce card effect.
//           Deals armor-piercing magical damage to the selected target.
//           Damages Overhealth and HP without interacting with Armor.
//
//===============================================================================//

function scr_card_viridian_spirit_pierce(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//DEAL PIERCING DAMAGE//
	//----------------------//
	scr_battle_damage_target_armor_pierce(
		_stct_card._val_card_magnitude,
		_ref_target
	);
}