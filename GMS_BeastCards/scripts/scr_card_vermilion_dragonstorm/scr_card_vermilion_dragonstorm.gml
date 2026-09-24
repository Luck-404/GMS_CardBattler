//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_DRAGONSTORM
// FUNCTION: Deals 2 NEU damage 20 times to random living Beasts on the
//           selected team, with 5 frames between each hit.
//
//           Not Burning: Apply 1 Burn.
//           Already Burning: Apply 1 Char.
//
//===============================================================================//

function scr_card_vermilion_dragonstorm(_stct_card,_ref_caster,_ref_target){

	//================//
	//VALIDATION//
	//================//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!instance_exists(_ref_target)){
		return;
	}

	if (!instance_exists(global.ref_cast_card)){
		return;
	}

	//================//
	//CREATE SEQUENCE//
	//================//
	var _stct_sequence = {
		_ref_card : global.ref_cast_card,
		_ref_caster : _ref_caster,
		_str_target_team : _ref_target._str_team,
		_ct_hits_remaining : max(0,floor(_stct_card._val_card_magnitude)),
		_val_hit_damage : 2
	};

	if (_stct_sequence._ct_hits_remaining <= 0){
		return;
	}

	//================//
	//FIRST HIT//
	//================//
	var _flag_continue = scr_card_vermilion_dragonstorm_hit(
		_stct_sequence
	);

	if (!_flag_continue){
		return;
	}

	//================//
	//CREATE WAIT//
	//================//
	var _ref_wait = instance_create_layer(
		room_width * 0.5,
		room_height * 0.5,
		"ily_fx",
		obj_battle_wait
	);

	//================//
	//SET WAIT DATA//
	//================//
	_ref_wait._ct_life = 5;

	_ref_wait._stct_dragonstorm = _stct_sequence;

	_ref_wait._scr_on_complete =
		scr_card_vermilion_dragonstorm_wait_step;
}
