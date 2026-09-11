//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_CARD_PREVIEW_TARGETS
// FUNCTION: Returns every living Beast affected if the hovered Beast were
//           selected as the Card's primary target.
//           Supports ST, FRONT2, ADJACENT, and TEAMWIDE target patterns.
//
// INPUTS:   _stct_card - Card struct being previewed.
//           _ref_primary_target - Beast treated as the selected primary target.
// USES:     Card target-count metadata and shared battle targeting helpers.
//
//===============================================================================//

function scr_battle_get_card_preview_targets(_stct_card,_ref_primary_target){

	#region VALIDATION

	//----------------//
	//VALIDATE CARD//
	//----------------//
	var _arr_targets = [];

	if (!is_struct(_stct_card)){
		return _arr_targets;
	}

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_primary_target)){
		return _arr_targets;
	}

	#endregion

	#region TARGET PREVIEW

	switch(_stct_card._str_card_target_count){

		//---------------//
		//SINGLE TARGET//
		//---------------//
		case "ST":

			array_push(_arr_targets,_ref_primary_target);

		break;

		//----------//
		//FRONT TWO//
		//----------//
		case "FRONT2":

			var _list_targets = scr_battle_get_target_team_list(_ref_primary_target);

			if (_list_targets == undefined){
				return _arr_targets;
			}

			var _ct_targets = min(2,ds_list_size(_list_targets));

			for (var _it_target = 0; _it_target < _ct_targets; _it_target++){

				var _ref_target = ds_list_find_value(_list_targets,_it_target);

				if (!instance_exists(_ref_target)){
					continue;
				}

				if (_ref_target._str_list != "ALIVE" || _ref_target._val_cur_hp <= 0){
					continue;
				}

				array_push(_arr_targets,_ref_target);
			}

		break;

		//----------------//
		//TARGET + SIDES//
		//----------------//
		case "ADJACENT":

			var _ref_left_target = scr_battle_get_left_target(_ref_primary_target);
			var _ref_right_target = scr_battle_get_right_target(_ref_primary_target);

			if (instance_exists(_ref_left_target)){
				array_push(_arr_targets,_ref_left_target);
			}

			array_push(_arr_targets,_ref_primary_target);

			if (instance_exists(_ref_right_target)){
				array_push(_arr_targets,_ref_right_target);
			}

		break;

		//------------//
		//ENTIRE TEAM//
		//------------//
		case "TEAMWIDE":

			var _list_targets = scr_battle_get_target_team_list(_ref_primary_target);

			if (_list_targets == undefined){
				return _arr_targets;
			}

			for (var _it_target = 0; _it_target < ds_list_size(_list_targets); _it_target++){

				var _ref_target = ds_list_find_value(_list_targets,_it_target);

				if (!instance_exists(_ref_target)){
					continue;
				}

				if (_ref_target._str_list != "ALIVE" || _ref_target._val_cur_hp <= 0){
					continue;
				}

				array_push(_arr_targets,_ref_target);
			}

		break;
	}

	#endregion

	return _arr_targets;
}