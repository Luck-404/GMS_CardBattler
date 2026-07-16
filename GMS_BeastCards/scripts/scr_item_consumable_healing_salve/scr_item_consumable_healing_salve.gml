//===============================================================================//
//
// SCRIPT: SCR_ITEM_CONSUMABLE_HEALING_SALVE
// FUNCTION: Applies healing salve to a target party beast.
//           Restores up to 10 HP without exceeding max HP.
//           Spawns popup feedback and returns whether the item was used.
//
//===============================================================================//
function scr_item_consumable_healing_salve(_stct_item,_stct_target_unit,_val_popup_x,_val_popup_y){

	if (_stct_target_unit == undefined){
		return false;
	}

	if (_stct_target_unit._val_beast_hp_cur >= _stct_target_unit._val_beast_hp_max){

		scr_spawn_popup_scrolling(
			"TEXT",
			"FULL HP",
			undefined,
			c_white,
			_val_popup_x,
			_val_popup_y
		);

		return false;
	}

	var _val_hp_before = _stct_target_unit._val_beast_hp_cur;

	_stct_target_unit._val_beast_hp_cur += 10;

	if (_stct_target_unit._val_beast_hp_cur > _stct_target_unit._val_beast_hp_max){
		_stct_target_unit._val_beast_hp_cur = _stct_target_unit._val_beast_hp_max;
	}

	var _val_healed = _stct_target_unit._val_beast_hp_cur - _val_hp_before;

	scr_spawn_popup_scrolling(
		"TEXT",
		"+" + string(_val_healed) + " HP",
		undefined,
		c_green,
		_val_popup_x,
		_val_popup_y
	);

	audio_play_sound(snd_heal,0,false);

	return true;
}