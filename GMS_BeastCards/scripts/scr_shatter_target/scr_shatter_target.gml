//===============================================================================//
//
// SCRIPT: SCR_SHATTER_TARGET
// FUNCTION: Resolves the Cerulean SHATTER mechanic.
//           Consumes all Frostbite stacks from the target.
//           Restores Maximum HP suppressed by the consumed Frostbite.
//           Deals 3 NEU damage per Frostbite stack consumed.
//           Returns the number of Frostbite stacks consumed.
//
//===============================================================================//

function scr_shatter_target(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (_ref_target._val_cur_hp <= 0){
		return 0;
	}

	//-----------------//
	//CHECK FROSTBITE//
	//-----------------//
	var _ref_frostbite =
		scr_check_for_status(
			"FROSTBITE",
			_ref_target
		);

	if (_ref_frostbite == -1){
		return 0;
	}

	//----------------//
	//GET STACK COUNT//
	//----------------//
	var _ct_frostbite =
		_ref_frostbite._ct_status_stacks;

	if (_ct_frostbite <= 0){
		return 0;
	}

	//----------------//
	//SHATTER POPUP//
	//----------------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"SHATTER",
		undefined,
		c_aqua,
		_ref_target.x,
		_ref_target.y - 48
	);

	//------------------//
	//CONSUME FROSTBITE//
	//------------------//
	scr_status_dot_frostbite(
		"DEATH",
		_ref_frostbite
	);

	//----------------//
	//SHATTER DAMAGE//
	//----------------//
	var _val_shatter_damage =
		_ct_frostbite * 3;

	//----------------------//
	//STORE ORIGINAL STAT//
	//----------------------//
	var _stct_card =
		global.ref_cast_card._ref_card;

	var _str_original_stat =
		_stct_card._str_card_stat;

	//----------------//
	//SET NEU DAMAGE//
	//----------------//
	_stct_card._str_card_stat =
		"NEU";

	scr_damage_target(
		_val_shatter_damage,
		_ref_target
	);

	//-----------------//
	//RESTORE CARD STAT//
	//-----------------//
	_stct_card._str_card_stat =
		_str_original_stat;

	return _ct_frostbite;
}