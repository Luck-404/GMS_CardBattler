//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_MOLTEN_EDGE
// FUNCTION: Resolves Molten Edge.
//           Deals linear Physical damage that bypasses Armor.
//           Damage applies directly to Overhealth and HP.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_molten_edge(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target_armor_pierce(_stct_card._val_card_magnitude,_ref_target);
}