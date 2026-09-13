//===============================================================================//
//
// SCRIPT: SCR_RANCH_HEAL_BEASTS
// FUNCTION: Heals all Beasts currently stored in the Ranch.
//           Restores a percentage of each Beast's Maximum HP.
//           Healing cannot exceed Maximum HP.
//           Logs one summary of the actual HP restored.
//
// ARGUMENTS: _val_amount is the percentage of Maximum HP restored as a decimal.
// RETURNS: The total HP restored across all Ranch Beasts.
//
//===============================================================================//

function scr_ranch_heal_beasts(_val_amount){

	//====================//
	//VALIDATE RANCH LIST//
	//====================//
	if (
		!variable_global_exists("list_player_ranch") ||
		!ds_exists(global.list_player_ranch,ds_type_list)
	){
		return 0;
	}

	_val_amount = clamp(_val_amount,0,1);

	//================//
	//HEAL TRACKING//
	//================//
	var _ct_beasts_healed = 0;
	var _val_total_healing = 0;

	//===================//
	//HEAL RANCH BEASTS//
	//===================//
	for (var _it_beast = 0;_it_beast < ds_list_size(global.list_player_ranch);_it_beast++){

		var _stct_beast = ds_list_find_value(
			global.list_player_ranch,
			_it_beast
		);

		if (!is_struct(_stct_beast)){
			continue;
		}

		var _val_max_hp = max(1,_stct_beast._val_beast_hp_max);
		var _val_hp_before = clamp(_stct_beast._val_beast_hp_cur,0,_val_max_hp);
		var _val_heal_amount = ceil(_val_max_hp * _val_amount);

		_stct_beast._val_beast_hp_cur = min(
			_val_hp_before + _val_heal_amount,
			_val_max_hp
		);

		var _val_actual_healing =
			_stct_beast._val_beast_hp_cur -
			_val_hp_before;

		if (_val_actual_healing <= 0){
			continue;
		}

		_ct_beasts_healed++;
		_val_total_healing += _val_actual_healing;
	}

	//================//
	//DEBUG HEALING//
	//================//
	scr_debug_log(
		"BEASTS",
		"RANCH",
		undefined,
		"RANCH HEALING RESOLVED" +
		" | HEAL: " +
		string(round(_val_amount * 100)) +
		"% MAX HP" +
		" | BEASTS HEALED: " +
		string(_ct_beasts_healed) +
		"/" +
		string(ds_list_size(global.list_player_ranch)) +
		" | TOTAL HP: +" +
		string(_val_total_healing),
		"INFO",
		"SCR_RANCH_HEAL_BEASTS"
	);

	return _val_total_healing;
}