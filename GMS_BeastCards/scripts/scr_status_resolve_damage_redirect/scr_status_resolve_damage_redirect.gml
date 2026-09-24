
//===============================================================================//
//
// SCRIPT: SCR_STATUS_RESOLVE_DAMAGE_REDIRECT
// FUNCTION: Resolves an entire chain of Redirect relationships.
//           Always selects the newest VALID Redirect on each Beast.
//           Consumes each traversed link and its paired Guard.
//           Grants each triggered link's stored Rage payoff.
//           Skips cyclic links and removes invalid links when consuming.
//
// ARGUMENTS: _ref_target is the original damage target.
//            _flag_consume=true executes and consumes Redirects.
//            false previews the final recipient without side effects.
// RETURNS: Final damage recipient, or the original target if none apply.
//
//===============================================================================//

function scr_status_resolve_damage_redirect(_ref_target,_flag_consume=true){

	//================//
	//VALIDATE TARGET//
	//================//
	if (!instance_exists(_ref_target)){
		return _ref_target;
	}

	var _ref_current = _ref_target;

	//================//
	//TRACK VISITED//
	//================//
	var _arr_visited = [_ref_current];

	//================//
	//FOLLOW THE CHAIN//
	//================//
	while (instance_exists(_ref_current)){

		if (!ds_exists(_ref_current._list_statuses,ds_type_list)){
			break;
		}

		var _ref_selected_redirect = undefined;
		var _ref_next = undefined;

		//===========================//
		//FIND NEWEST VALID REDIRECT//
		//===========================//
		for (
			var _it_status = ds_list_size(_ref_current._list_statuses) - 1;
			_it_status >= 0;
			_it_status--
		){

			var _ref_check = ds_list_find_value(
				_ref_current._list_statuses,
				_it_status
			);

			if (!instance_exists(_ref_check)){
				continue;
			}

			if (_ref_check._str_status_name != "REDIRECT"){
				continue;
			}

			//===================//
			//VALIDATE LINK DATA//
			//===================//
			var _flag_valid = true;
			var _ref_candidate = undefined;
			var _ref_guard_status = undefined;

			if (
				!variable_instance_exists(
					_ref_check,
					"_ref_status_target"
				) ||
				!variable_instance_exists(
					_ref_check,
					"_ref_redirect_guard_status"
				)
			){
				_flag_valid = false;
			}
			else{

				_ref_candidate = _ref_check._ref_status_target;
				_ref_guard_status = _ref_check._ref_redirect_guard_status;
			}

			//================//
			//VALIDATE GUARD//
			//================//
			if (_flag_valid){

				if (
					!instance_exists(_ref_candidate) ||
					!instance_exists(_ref_guard_status)
				){
					_flag_valid = false;
				}
			}

			if (_flag_valid){

				if (
					_ref_candidate == _ref_current ||
					_ref_candidate._str_team != _ref_current._str_team ||
					_ref_candidate._str_list != "ALIVE" ||
					_ref_candidate._val_cur_hp <= 0
				){
					_flag_valid = false;
				}
			}

			//======================//
			//VALIDATE MATCHING PAIR//
			//======================//
			if (_flag_valid){

				if (
					!variable_instance_exists(
						_ref_guard_status,
						"_ref_redirect_status"
					) ||
					!variable_instance_exists(
						_ref_guard_status,
						"_ref_status_target"
					)
				){
					_flag_valid = false;
				}
			}

			if (_flag_valid){

				if (
					_ref_guard_status._str_status_name != "REDIRECT_GUARD" ||
					_ref_guard_status._ref_host != _ref_candidate ||
					_ref_guard_status._ref_status_target != _ref_current ||
					_ref_guard_status._ref_redirect_status != _ref_check
				){
					_flag_valid = false;
				}
			}

			if (_flag_valid){

				if (
					!ds_exists(_ref_candidate._list_statuses,ds_type_list) ||
					ds_list_find_index(
						_ref_candidate._list_statuses,
						_ref_guard_status
					) == -1
				){
					_flag_valid = false;
				}
			}

			//================//
			//REMOVE STALE LINK//
			//================//
			if (!_flag_valid){

				if (_flag_consume){

					scr_status_buff_redirect(
						"DEATH",
						_ref_check
					);
				}

				continue;
			}

			//================//
			//PREVENT CYCLES//
			//================//
			if (array_contains(_arr_visited,_ref_candidate)){
				continue;
			}

			//================//
			//SELECT NEWEST//
			//================//
			_ref_selected_redirect = _ref_check;
			_ref_next = _ref_candidate;

			break;
		}

		//================//
		//END OF CHAIN//
		//================//
		if (!instance_exists(_ref_selected_redirect)){
			break;
		}

		//================//
		//EXECUTE LINK//
		//================//
		if (_flag_consume){

			var _ct_rage_gain = 0;

			if (
				variable_instance_exists(
					_ref_selected_redirect,
					"_ct_redirect_rage_gain"
				)
			){

				_ct_rage_gain = max(
					0,
					floor(_ref_selected_redirect._ct_redirect_rage_gain)
				);
			}

			var _str_link_label = "?";

			if (
				variable_instance_exists(
					_ref_selected_redirect,
					"_str_redirect_link_label"
				)
			){

				_str_link_label =
					_ref_selected_redirect._str_redirect_link_label;
			}

			//==========//
			//FEEDBACK//
			//==========//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"REDIRECT [" + _str_link_label + "]",
				undefined,
				c_green,
				_ref_current.x + irandom_range(-32,32),
				_ref_current.y - 24 + irandom_range(-32,32)
			);

			scr_battle_vfx_blocked(_ref_current);

			//================//
			//CONSUME THIS PAIR//
			//================//
			scr_status_buff_redirect(
				"DEATH",
				_ref_selected_redirect
			);

			//================//
			//GRANT RAGE//
			//================//
			if (
				_ct_rage_gain > 0 &&
				instance_exists(_ref_next)
			){

				scr_status_gain_rage(
					_ref_next,
					_ct_rage_gain
				);
			}
		}

		//================//
		//ADVANCE CHAIN//
		//================//
		_ref_current = _ref_next;

		array_push(
			_arr_visited,
			_ref_current
		);
	}

	return _ref_current;
}