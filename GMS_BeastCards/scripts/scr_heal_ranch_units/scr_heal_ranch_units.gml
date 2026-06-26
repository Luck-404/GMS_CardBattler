//===============================================================================//
//
// SCRIPT: SCR_HEAL_RANCH_UNITS
// FUNCTION: Heals all beasts currently stored in the ranch.
//           Restores a percentage of each beast's maximum HP.
//           Will not heal beyond maximum HP.
//
//===============================================================================//
function scr_heal_ranch_units(_val_amount){
    // _amount expected as decimal percent
    // Example:
    // 0.33 = 33%
    // 0.50 = 50%
    // 1.00 = full heal

	for (var _it_beast = 0; _it_beast < ds_list_size(global.player_ranch); _it_beast++){
		var _stct_beast = ds_list_find_value(global.player_ranch,_it_beast);

		if (_stct_beast == undefined){
			continue;
		}

		var _val_max_hp = _stct_beast.beast_hp_max;
		var _val_cur_hp = _stct_beast.beast_hp_cur;

		var _val_heal_amount = ceil(_val_max_hp * _val_amount);

		_val_cur_hp += _val_heal_amount;
		_val_cur_hp = min(_val_cur_hp,_val_max_hp);

		_stct_beast.beast_hp_cur = _val_cur_hp;
	}
}