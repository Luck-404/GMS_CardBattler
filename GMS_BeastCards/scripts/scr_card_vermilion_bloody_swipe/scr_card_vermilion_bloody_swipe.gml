//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOODY_SWIPE
// FUNCTION: Resolves Bloody Swipe.
//           Deals linear Physical damage to the selected target.
//           Applies 2 Bleed if the target survives.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_bloody_swipe(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

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
	//APPLY 2 BLEED//
	//================//
	var _ref_original_target = global.ref_target_beast;

	global.ref_target_beast = _ref_target;

	repeat (2){
		scr_status_apply_dot("BLEED");
	}

	global.ref_target_beast = _ref_original_target;
}