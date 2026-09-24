//===============================================================================//
//
// SCRIPT: SCR_CARD_SUMMON_FOCUS_MINION
// FUNCTION: Summons a random Minion from the requested color pool.
//
//           UNCOLORED combines all three color pools into a temporary
//           DS list, chooses one random Minion, and destroys the list.
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

	//================//
	//VALIDATE CASTER//
	//================//
	if (!instance_exists(_ref_caster)){
		return undefined;
	}

	if (
		_ref_caster._str_list != "ALIVE" ||
		_ref_caster._val_cur_hp <= 0
	){
		return undefined;
	}

	//================//
	//VALIDATE CARD//
	//================//
	if (!is_struct(_stct_card)){
		return undefined;
	}

	#endregion

	#region SELECT POOL

	//================//
	//POOL DATA//
	//================//
	var _list_pool = undefined;
	var _flag_temporary_pool = false;

	switch (_str_color){

		//==========//
		//VIRIDIAN//
		//==========//
		case "VIRIDIAN":

			if (variable_global_exists("list_pool_viridian_minions")){

				_list_pool = global.list_pool_viridian_minions;
			}

		break;

		//==========//
		//CERULEAN//
		//==========//
		case "CERULEAN":

			if (variable_global_exists("list_pool_cerulean_minions")){

				_list_pool = global.list_pool_cerulean_minions;
			}

		break;

		//===========//
		//VERMILION//
		//===========//
		case "VERMILION":

			if (variable_global_exists("list_pool_vermilion_minions")){

				_list_pool = global.list_pool_vermilion_minions;
			}

		break;

		//===========//
		//UNCOLORED//
		//===========//
		case "UNCOLORED":

			//=====================//
			//CREATE TEMPORARY POOL//
			//=====================//
			_list_pool = ds_list_create();

			_flag_temporary_pool = true;

			//================//
			//COLLECT POOLS//
			//================//
			var _arr_pools = [];

			if (variable_global_exists("list_pool_viridian_minions")){

				array_push(
					_arr_pools,
					global.list_pool_viridian_minions
				);
			}

			if (variable_global_exists("list_pool_cerulean_minions")){

				array_push(
					_arr_pools,
					global.list_pool_cerulean_minions
				);
			}

			if (variable_global_exists("list_pool_vermilion_minions")){

				array_push(
					_arr_pools,
					global.list_pool_vermilion_minions
				);
			}

			//================//
			//COPY ALL ENTRIES//
			//================//
			for (
				var _it_pool = 0;
				_it_pool < array_length(_arr_pools);
				_it_pool++
			){

				var _list_source = _arr_pools[_it_pool];

				if (
					_list_source == undefined ||
					!ds_exists(_list_source,ds_type_list)
				){
					continue;
				}

				for (
					var _it_minion = 0;
					_it_minion < ds_list_size(_list_source);
					_it_minion++
				){

					var _str_minion_id = ds_list_find_value(
						_list_source,
						_it_minion
					);

					ds_list_add(
						_list_pool,
						_str_minion_id
					);
				}
			}

		break;

		default:
			return undefined;
	}

	#endregion

	#region RANDOM SELECTION

	//================//
	//VALIDATE POOL//
	//================//
	if (
		_list_pool == undefined ||
		!ds_exists(_list_pool,ds_type_list)
	){
		return undefined;
	}

	//================//
	//GET POOL SIZE//
	//================//
	var _ct_pool_size = ds_list_size(_list_pool);

	//================//
	//EMPTY POOL//
	//================//
	if (_ct_pool_size <= 0){

		if (_flag_temporary_pool){
			ds_list_destroy(_list_pool);
		}

		return undefined;
	}

	//================//
	//SELECT RANDOM ID//
	//================//
	var _it_selection = irandom(
		_ct_pool_size - 1
	);

	var _str_selected_minion = ds_list_find_value(
		_list_pool,
		_it_selection
	);

	//======================//
	//DESTROY TEMPORARY POOL//
	//======================//
	if (_flag_temporary_pool){

		ds_list_destroy(
			_list_pool
		);
	}

	#endregion

	#region SUMMON

	//================//
	//VALIDATE ID//
	//================//
	if (
		!is_string(_str_selected_minion) ||
		_str_selected_minion == ""
	){
		return undefined;
	}

	//================//
	//SUMMON ON CASTER//
	//================//
	return scr_minion_init(
		_str_selected_minion,
		_stct_card,
		_ref_caster,
		_ref_caster
	);

	#endregion
}