//===============================================================================//
//
// SCRIPT: SCR_CARD_SUMMON_FOCUS_MINION
// FUNCTION: Summons a random Minion from the requested color pool.
//           UNCOLORED combines all three color pools into a temporary array.
//
// INPUT:    _stct_card - Card responsible for the summon.
//           _ref_caster - Beast receiving the Minion.
//           _str_color - VIRIDIAN, CERULEAN, VERMILION, or UNCOLORED.
//
// RETURNS: Spawned Minion instance, or undefined.
//
//===============================================================================//

function scr_card_summon_focus_minion(_stct_card,_ref_caster,_str_color){

	#region VALIDATION

	if (!instance_exists(_ref_caster)){
		return undefined;
	}

	if (
		_ref_caster._str_list != "ALIVE" ||
		_ref_caster._val_cur_hp <= 0
	){
		return undefined;
	}

	if (!is_struct(_stct_card)){
		return undefined;
	}

	#endregion

	#region SELECT POOL

	var _arr_pool = [];

	switch (_str_color){

		case "VIRIDIAN":

			if (
				variable_global_exists("arr_pool_viridian_minions") &&
				is_array(global.arr_pool_viridian_minions)
			){
				_arr_pool =
					global.arr_pool_viridian_minions;
			}

		break;

		case "CERULEAN":

			if (
				variable_global_exists("arr_pool_cerulean_minions") &&
				is_array(global.arr_pool_cerulean_minions)
			){
				_arr_pool =
					global.arr_pool_cerulean_minions;
			}

		break;

		case "VERMILION":

			if (
				variable_global_exists("arr_pool_vermilion_minions") &&
				is_array(global.arr_pool_vermilion_minions)
			){
				_arr_pool =
					global.arr_pool_vermilion_minions;
			}

		break;

		case "UNCOLORED":

			var _arr_pools = [
				global.arr_pool_viridian_minions,
				global.arr_pool_cerulean_minions,
				global.arr_pool_vermilion_minions
			];

			for (
				var _it_pool = 0;
				_it_pool < array_length(_arr_pools);
				_it_pool++
			){

				var _arr_source =
					_arr_pools[_it_pool];

				if (!is_array(_arr_source)){
					continue;
				}

				for (
					var _it_minion = 0;
					_it_minion < array_length(_arr_source);
					_it_minion++
				){
					array_push(
						_arr_pool,
						_arr_source[_it_minion]
					);
				}
			}

		break;

		default:
			return undefined;
	}

	#endregion

	#region RANDOM SELECTION

	var _ct_pool_size =
		array_length(_arr_pool);

	if (_ct_pool_size <= 0){
		return undefined;
	}

	var _it_selection =
		irandom(
			_ct_pool_size - 1
		);

	var _str_selected_minion =
		_arr_pool[_it_selection];

	#endregion

	#region SUMMON

	if (
		!is_string(_str_selected_minion) ||
		_str_selected_minion == ""
	){
		return undefined;
	}

	return scr_minion_init(
		_str_selected_minion,
		_stct_card,
		_ref_caster,
		_ref_caster
	);

	#endregion
}