//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_EXSANGUINATE
// FUNCTION: Resolves Exsanguinate.
//           Attempts HEMORRHAGE on the selected target.
//           Then applies 3 Bleed if the target survives.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_exsanguinate(_stct_card,_ref_caster,_ref_target){

	//================//
	//HEMORRHAGE//
	//================//
	scr_battle_trigger_hemorrhage(_ref_target);

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	if (_ref_target._val_cur_hp <= 0){
		return;
	}

	//================//
	//APPLY 3 BLEED//
	//================//


	repeat (3){
		scr_status_apply_dot("BLEED", _ref_target);
	}

}