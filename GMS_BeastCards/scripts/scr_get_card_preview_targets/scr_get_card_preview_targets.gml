//===============================================================================//
//
// SCRIPT: SCR_GET_CARD_PREVIEW_TARGETS
// FUNCTION: Returns every living Beast that would be affected if the hovered
//           Beast were selected as the card's primary target.
//           Supports ST, FRONT2, ADJACENT, and TEAMWIDE target patterns.
//
//===============================================================================//

function scr_get_card_preview_targets(_stct_card,_ref_primary_target){

	var _arr_targets = [];

	if (_stct_card == undefined){
		return _arr_targets;
	}

	if (!instance_exists(_ref_primary_target)){
		return _arr_targets;
	}

	switch(_stct_card._str_card_target_count){

		//---------------//
		// SINGLE TARGET //
		//---------------//
		case "ST":

			array_push(
				_arr_targets,
				_ref_primary_target
			);

		break;

		//----------------//
		// FRONT TWO      //
		//----------------//
		case "FRONT2":

			var _list_targets =
				scr_get_target_team_list(
					_ref_primary_target
				);

			if (_list_targets == undefined){
				return _arr_targets;
			}

			var _ct_targets = min(
				2,
				ds_list_size(_list_targets)
			);

			for (
				var _it_target = 0;
				_it_target < _ct_targets;
				_it_target++
			){

				var _ref_target =
					ds_list_find_value(
						_list_targets,
						_it_target
					);

				if (!instance_exists(_ref_target)){
					continue;
				}

				if (
					_ref_target._str_list != "ALIVE" ||
					_ref_target._val_cur_hp <= 0
				){
					continue;
				}

				array_push(
					_arr_targets,
					_ref_target
				);
			}

		break;

		//-----------------//
		// TARGET + SIDES  //
		//-----------------//
		case "ADJACENT":

			var _ref_left_target =
				scr_get_left_target(
					_ref_primary_target
				);

			var _ref_right_target =
				scr_get_right_target(
					_ref_primary_target
				);

			if (instance_exists(_ref_left_target)){
				array_push(
					_arr_targets,
					_ref_left_target
				);
			}

			array_push(
				_arr_targets,
				_ref_primary_target
			);

			if (instance_exists(_ref_right_target)){
				array_push(
					_arr_targets,
					_ref_right_target
				);
			}

		break;

		//----------------//
		// ENTIRE TEAM    //
		//----------------//
		case "TEAMWIDE":

			var _list_targets =
				scr_get_target_team_list(
					_ref_primary_target
				);

			if (_list_targets == undefined){
				return _arr_targets;
			}

			for (
				var _it_target = 0;
				_it_target < ds_list_size(_list_targets);
				_it_target++
			){

				var _ref_target =
					ds_list_find_value(
						_list_targets,
						_it_target
					);

				if (!instance_exists(_ref_target)){
					continue;
				}

				if (
					_ref_target._str_list != "ALIVE" ||
					_ref_target._val_cur_hp <= 0
				){
					continue;
				}

				array_push(
					_arr_targets,
					_ref_target
				);
			}

		break;
	}

	return _arr_targets;
}