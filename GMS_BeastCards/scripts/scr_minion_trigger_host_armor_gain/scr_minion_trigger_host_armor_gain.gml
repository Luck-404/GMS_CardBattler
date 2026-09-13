//===============================================================================//
//
// SCRIPT: SCR_MINION_TRIGGER_HOST_ARMOR_GAIN
// FUNCTION: Notifies hosted Minions when their Beast successfully gains Armor.
//           Grove Spirits gain 1 Magnitude and 2 current/maximum HP per
//           successful Armor-gain event.
//           Logs the Grove Spirit's resulting growth.
//
// INPUTS:   _ref_host         - Beast whose hosted Minions receive the trigger.
//           _val_armor_gained - Amount of Armor successfully gained.
//
//===============================================================================//

function scr_minion_trigger_host_armor_gain(_ref_host,_val_armor_gained){

	//---------------//
	//VALIDATE HOST//
	//---------------//
	if (!instance_exists(_ref_host)){
		return false;
	}

	if (_val_armor_gained <= 0){
		return false;
	}

	//--------------------//
	//VALIDATE MINION LIST//
	//--------------------//
	if (!ds_exists(_ref_host._list_minions,ds_type_list)){
		return false;
	}

	var _flag_triggered = false;

	//----------------//
	//CHECK MINIONS//
	//----------------//
	for (var _it_minion = 0;_it_minion < ds_list_size(_ref_host._list_minions);_it_minion++){

		var _ref_minion = ds_list_find_value(
			_ref_host._list_minions,
			_it_minion
		);

		if (!instance_exists(_ref_minion)){
			continue;
		}

		if (_ref_minion._val_cur_hp <= 0){
			continue;
		}

		switch (_ref_minion._str_name){

			//-------------//
			//GROVE SPIRIT//
			//-------------//
			case "GROVE SPIRIT":

				//----------------//
				//STORE OLD STATS//
				//----------------//
				var _val_old_hp = _ref_minion._val_cur_hp;
				var _val_old_max_hp = _ref_minion._val_max_hp;
				var _val_old_magnitude = _ref_minion._val_magnitude;

				//-------------------//
				//INCREASE MAGNITUDE//
				//-------------------//
				_ref_minion._val_magnitude++;

				//-------------//
				//INCREASE HP//
				//-------------//
				_ref_minion._val_max_hp += 2;
				_ref_minion._val_cur_hp += 2;

				_ref_minion._val_cur_hp =
					min(
						_ref_minion._val_cur_hp,
						_ref_minion._val_max_hp
					);

				//----------------//
				//GROWTH VFX/SFX//
				//----------------//
				scr_battle_vfx_minion_growth(_ref_minion);

				//----------//
				//FEEDBACK//
				//----------//
				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"GROWTH",
					undefined,
					c_green,
					_ref_minion.x + irandom_range(-16,16),
					_ref_minion.y - 16 + irandom_range(-16,16)
				);

				//================//
				//DEBUG GROWTH//
				//================//
				scr_debug_log(
					"MINIONS",
					"GROWTH",
					_ref_minion,
					string_upper(_ref_minion._str_team) + " " +
					string_upper(_ref_minion._str_name) +
					" GREW FROM HOST ARMOR" +
					" | ARMOR GAIN EVENT: " + string(_val_armor_gained) +
					" | HP: " +
					string(_val_old_hp) +
					" -> " +
					string(_ref_minion._val_cur_hp) +
					" | MAX HP: " +
					string(_val_old_max_hp) +
					" -> " +
					string(_ref_minion._val_max_hp) +
					" | MAGNITUDE: " +
					string(_val_old_magnitude) +
					" -> " +
					string(_ref_minion._val_magnitude),
					"BATTLE",
					"SCR_MINION_TRIGGER_HOST_ARMOR_GAIN"
				);

				_flag_triggered = true;

			break;
		}
	}

	return _flag_triggered;
}