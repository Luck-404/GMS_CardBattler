//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BARBED_BOLT
// FUNCTION: Resolves Barbed Bolt.
//           Deals linear Physical damage to the target.
//           Applies 1 Bleed afterward if the target survives.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_barbed_bolt(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(_stct_card._val_card_magnitude,_ref_target);

	//================//
	//APPLY BLEED//
	//================//
	if (instance_exists(_ref_target) && _ref_target._val_cur_hp > 0){

		var _ref_original_target = global.ref_target_beast;

		global.ref_target_beast = _ref_target;

		scr_status_apply_dot("BLEED");

		global.ref_target_beast = _ref_original_target;
	}
}