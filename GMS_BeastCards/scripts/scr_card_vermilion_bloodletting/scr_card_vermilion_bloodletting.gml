//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOODLETTING
// FUNCTION: Resolves Bloodletting.
//           Deals Physical damage equal to a percentage of the target's
//           Maximum HP, then triggers HEMORRHAGE.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_bloodletting(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target_percent(_stct_card._val_card_magnitude,_ref_target);

	//================//
	//HEMORRHAGE//
	//================//
	if (instance_exists(_ref_target) && _ref_target._val_cur_hp > 0){
		scr_battle_trigger_hemorrhage(_ref_target);
	}
}