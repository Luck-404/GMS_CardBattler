//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_CHAR_CONVERSION
// FUNCTION: Converts accumulated Burn into permanent Char.
//           When Burn reaches the current Char threshold:
//           applies 1 Char, deals 2 immediate NEU Status damage,
//           then consumes Burn equal to the threshold.
//           Repeats while enough Burn remains for another conversion.
//           Plays Char trigger VFX/SFX once when conversion occurs.
//
// ARGUMENTS: _ref_target is the Beast whose Burn is checked.
// RETURNS: The number of Char conversions successfully resolved.
//
//===============================================================================//

function scr_status_trigger_char_conversion(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
		return 0;
	}

	if (_ref_target._val_cur_hp <= 0){
		return 0;
	}

	//================//
	//CONVERSION DATA//
	//================//
	var _ct_threshold = scr_status_get_char_threshold();
	var _ct_conversions = 0;

	var _ref_original_target = global.ref_target_beast;

	//================//
	//CONVERT BURN//
	//================//
	while (instance_exists(_ref_target) && _ref_target._val_cur_hp > 0){

		//----------//
		//GET BURN//
		//----------//
		var _ref_burn = scr_status_check("BURN",_ref_target);

		if (_ref_burn == -1 || !instance_exists(_ref_burn)){
			break;
		}

		if (_ref_burn._ct_status_stacks < _ct_threshold){
			break;
		}

		//================//
		//APPLY CHAR//
		//================//
		global.ref_target_beast = _ref_target;

		var _ref_char = scr_status_apply_debuff("CHAR",undefined,undefined,true);

		if (!instance_exists(_ref_char)){
			break;
		}

		//==================//
		//IMMEDIATE DAMAGE//
		//==================//
		var _val_damage = 2;
		var _val_damage_dealt = 0;

		//------------//
		//OVERHEALTH//
		//------------//
		if (_val_damage > 0 && _ref_target._val_overhealth > 0){

			var _val_blocked = min(_ref_target._val_overhealth,_val_damage);

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"-" + string(_val_blocked),
				undefined,
				c_green,
				_ref_target.x + irandom_range(-32,32),
				_ref_target.y - 24 + irandom_range(-32,32)
			);

			_ref_target._val_overhealth -= _val_blocked;
			_val_damage -= _val_blocked;
			_val_damage_dealt += _val_blocked;
		}

		//=========//
		//HOST HP//
		//=========//
		if (_val_damage > 0 && _ref_target._val_cur_hp > 0){

			var _val_actual_damage = min(_val_damage,_ref_target._val_cur_hp);

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"-" + string(_val_actual_damage),
				undefined,
				c_maroon,
				_ref_target.x + irandom_range(-32,32),
				_ref_target.y - 24 + irandom_range(-32,32)
			);

			_ref_target._val_cur_hp = max(0,_ref_target._val_cur_hp - _val_actual_damage);
			_val_damage_dealt += _val_actual_damage;
		}

		//================//
		//CONSUME BURN//
		//================//
		var _ct_consumed = scr_status_consume_burn(_ref_target,_ct_threshold);

		if (_ct_consumed < _ct_threshold){
			break;
		}

		_ct_conversions++;

		//================//
		//DEBUG CONVERSION//
		//================//
		scr_debug_log_battle_trigger(
			"CHAR",
			global.ref_caster_beast,
			_ref_target,
			"BURN CONSUMED: " + string(_ct_consumed) +
			" | NEU DAMAGE: " + string(_val_damage_dealt) +
			" | CHAR STACKS: " + string(_ref_char._ct_status_stacks),
			"SCR_STATUS_TRIGGER_CHAR_CONVERSION"
		);
	}

	//================//
	//CHAR FEEDBACK//
	//================//
	if (_ct_conversions > 0 && instance_exists(_ref_target)){

		//----------------//
		//CHAR VFX / SFX//
		//----------------//
		scr_battle_vfx_char(_ref_target);

		//----------//
		//NOTIFIER//
		//----------//
		var _str_char_popup = "CHAR";

		if (_ct_conversions > 1){
			_str_char_popup += " x" + string(_ct_conversions);
		}

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			_str_char_popup,
			undefined,
			c_red,
			_ref_target.x,
			_ref_target.y - 48
		);
	}

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;

	return _ct_conversions;
}