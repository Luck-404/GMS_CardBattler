//===============================================================================//
//
// SCRIPT: SCR_LEVEL_UP_BEAST
// FUNCTION: Levels up a beast.
//           Recalculates maximum HP while preserving the current HP percentage.
//
//===============================================================================//

function scr_level_up_beast(_stct_beast){

	// DEAD BEASTS DO NOT GAIN LEVELS
	if (_stct_beast.beast_hp_cur <= 0){
		exit;
	}

	//
	// LEVEL
	//
	_stct_beast.beast_level++;

	//
	// STORE CURRENT HP RATIO
	//
	var _val_old_cur_hp = _stct_beast.beast_hp_cur;
	var _val_old_max_hp = _stct_beast.beast_hp_max;

	var _val_hp_ratio = 1;

	if (_val_old_max_hp > 0){
		_val_hp_ratio = _val_old_cur_hp / _val_old_max_hp;
	}

	//
	// RECALCULATE MAX HP
	//
	var _val_hp_modifier = scr_get_beast_grade_modifier(_stct_beast.beast_hp_stat);

	var _val_new_max_hp = ceil(
		10 + ((_val_hp_modifier * 10) * _stct_beast.beast_level) / 4
	);

	_stct_beast.beast_hp_max = _val_new_max_hp;

	//
	// PRESERVE HP PERCENTAGE
	//
	var _val_new_cur_hp = ceil(_val_new_max_hp * _val_hp_ratio);

	_val_new_cur_hp = clamp(_val_new_cur_hp,1,_val_new_max_hp);

	_stct_beast.beast_hp_cur = _val_new_cur_hp;
}