//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_RAGING_SPARK
// FUNCTION: Resolves Raging Spark.
//           Consumes 1 Rage from the caster.
//           If Rage was successfully consumed, applies 2 Burn to the target.
//           If the caster has no Rage, nothing happens.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_raging_spark(_stct_card,_ref_caster,_ref_target){

	//================//
	//CONSUME RAGE//
	//================//
	var _ct_rage_consumed = scr_status_consume_rage(_ref_caster,1);

	if (_ct_rage_consumed < 1){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"NO RAGE, NOTHING HAPPENS",
			undefined,
			c_white,
			_ref_caster.x,
			_ref_caster.y - 48
		);

		return;
	}

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
	//APPLY BURN//
	//================//
	var _ref_original_target = global.ref_target_beast;

	global.ref_target_beast = _ref_target;

	repeat (2){
		scr_status_apply_dot("BURN");
	}

	global.ref_target_beast = _ref_original_target;
}