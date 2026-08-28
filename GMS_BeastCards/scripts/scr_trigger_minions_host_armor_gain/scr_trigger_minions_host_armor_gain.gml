//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_MINIONS_HOST_ARMOR_GAIN
// FUNCTION: Notifies hosted Minions when their Beast successfully gains Armor.
//           Grove Spirits gain 1 Magnitude and 2 current/maximum HP per
//           successful Armor-gain event.
//
//===============================================================================//

function scr_trigger_minions_host_armor_gain(_ref_host,_val_armor_gained){

	if (!instance_exists(_ref_host)){
		return false;
	}

	if (_val_armor_gained <= 0){
		return false;
	}

	var _flag_triggered =
		false;

	//----------------//
	//CHECK MINIONS//
	//----------------//
	for (
		var _it_minion = 0;
		_it_minion < ds_list_size(_ref_host._list_minions);
		_it_minion++
	){

		var _ref_minion =
			ds_list_find_value(
				_ref_host._list_minions,
				_it_minion
			);

		if (!instance_exists(_ref_minion)){
			continue;
		}

		switch(_ref_minion._str_name){

			//-------------//
			//GROVE SPIRIT//
			//-------------//
			case "GROVE SPIRIT":

				//-------------------//
				//INCREASE MAGNITUDE//
				//-------------------//
				_ref_minion._val_magnitude++;

				//-------------//
				//INCREASE HP//
				//-------------//
				_ref_minion._val_max_hp +=
					2;

				_ref_minion._val_cur_hp +=
					2;

				_ref_minion._val_cur_hp =
					min(
						_ref_minion._val_cur_hp,
						_ref_minion._val_max_hp
					);

				//----------//
				//FEEDBACK//
				//----------//
				scr_spawn_popup_scrolling(
					"TEXT",
					"GROWTH",
					undefined,
					c_green,
					_ref_minion.x + irandom_range(-16,16),
					_ref_minion.y - 16 + irandom_range(-16,16)
				);

				_flag_triggered =
					true;

			break;
		}
	}

	return _flag_triggered;
}