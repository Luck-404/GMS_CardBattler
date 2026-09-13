//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SPIRIT_FANG
// FUNCTION: Resolves Spirit Fang.
//           Deals linear magical damage to the selected target.
//           Applies 1 Venom stack if the target survives.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_spirit_fang(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(_stct_card._val_card_magnitude,_ref_target);

	//================//
	//APPLY VENOM//
	//================//
	if (instance_exists(_ref_target) && _ref_target._val_cur_hp > 0){
		scr_status_apply_dot("VENOM");
	}
}