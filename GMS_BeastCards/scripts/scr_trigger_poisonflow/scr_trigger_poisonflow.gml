//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_POISONFLOW
// FUNCTION: Consumes Poison stacks from the target Beast.
//           Consumes all stacks when no amount is supplied.
//           Removes the Poison status when no stacks remain.
//           Displays POISONFLOW when at least one stack is consumed.
//           Returns the number of Poison stacks consumed.
//
//===============================================================================//

function scr_trigger_poisonflow(_ref_target,_ct_amount=undefined){

	if (!instance_exists(_ref_target)){
		return 0;
	}

	//----------------//
	//CHECK FOR POISON//
	//----------------//
	var _ref_poison =
		scr_check_for_status(
			"POISON",
			_ref_target
		);

	if (_ref_poison == -1){
		return 0;
	}

	//---------------------//
	//GET AVAILABLE STACKS//
	//---------------------//
	var _ct_available =
		_ref_poison._ct_status_stacks;

	if (_ct_available <= 0){
		return 0;
	}

	//------------------//
	//CALCULATE CONSUME//
	//------------------//
var _ct_consumed = _ct_available;

	if (_ct_amount != undefined){

		_ct_consumed =
			clamp(
				_ct_amount,
				0,
				_ct_available
			);
	}

	if (_ct_consumed <= 0){
		return 0;
	}

	//---------------//
	//CONSUME POISON//
	//---------------//
	_ref_poison._ct_status_stacks -=
		_ct_consumed;

	if (_ref_poison._ct_status_stacks <= 0){

		scr_destroy_status(
			_ref_poison
		);
	}

	//------------------//
	//POISONFLOW VFX/SFX//
	//------------------//
	scr_battle_vfx(
		_ref_target,
		spr_battle_vfx_poisonflow,
		undefined,
		undefined,
		0,
		0,
		1,
		0,
		snd_battle_sfx_poisonflow
	);

	//----------//
	//NOTIFIER//
	//----------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"POISONFLOW",
		undefined,
		c_lime,
		_ref_target.x,
		_ref_target.y - 48
	);

	return _ct_consumed;
}