
//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_REDIRECT
// FUNCTION: Creates one independently linked Redirect per protector.
//           Up to 4 distinct allies may protect the same Beast.
//           A protector casting again replaces their previous relationship.
//           Each pair has an A-Z label shared with its Redirect Guard.
//           Infinite lifetime; consumed by a successful damage redirect.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH.
//            _ref_status is the Status for non-APPLY commands.
//            _ref_target is the protected Beast ONLY for APPLY.
//            global.ref_caster_beast is the protector.
// RETURNS: Created Redirect Status or undefined.
//
//===============================================================================//

function scr_status_buff_redirect(_str_tag,_ref_status,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			var _ref_guard = global.ref_caster_beast;

			//================//
			//VALIDATE BEASTS//
			//================//
			if (
				!instance_exists(_ref_target) ||
				!instance_exists(_ref_guard)
			){
				return undefined;
			}

			if (_ref_target == _ref_guard){
				return undefined;
			}

			if (_ref_target._str_team != _ref_guard._str_team){
				return undefined;
			}

			if (
				_ref_target._str_list != "ALIVE" ||
				_ref_target._val_cur_hp <= 0 ||
				_ref_guard._str_list != "ALIVE" ||
				_ref_guard._val_cur_hp <= 0
			){
				return undefined;
			}

			if (
				!ds_exists(_ref_target._list_statuses,ds_type_list) ||
				!ds_exists(_ref_guard._list_statuses,ds_type_list)
			){
				return undefined;
			}

			//==========================//
			//CHECK PROTECTED UNIT CAP//
			//==========================//
			// Count other protectors only.
			// The current guard's old link can be replaced.

			var _ct_other_guards = 0;

			for (
				var _it_status = 0;
				_it_status < ds_list_size(_ref_target._list_statuses);
				_it_status++
			){

				var _ref_check = ds_list_find_value(
					_ref_target._list_statuses,
					_it_status
				);

				if (!instance_exists(_ref_check)){
					continue;
				}

				if (_ref_check._str_status_name != "REDIRECT"){
					continue;
				}

				if (
					!variable_instance_exists(_ref_check,"_ref_status_target")
				){
					continue;
				}

				if (_ref_check._ref_status_target == _ref_guard){
					continue;
				}

				_ct_other_guards++;
			}

			if (_ct_other_guards >= 4){
				return undefined;
			}

			//===========================//
			//ALLOCATE UNIQUE LINK LABEL//
			//===========================//
			// A-Z labels identify relationships, not Beast instances.
			// Reuse a letter only when its previous link no longer exists.

			var _str_alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			var _str_link_label = "";

			for (var _it_letter = 1;_it_letter <= 26;_it_letter++){

				var _str_candidate = string_char_at(
					_str_alphabet,
					_it_letter
				);

				var _flag_used = false;

				for (
					var _it_instance = 0;
					_it_instance < instance_number(obj_battle_status);
					_it_instance++
				){

					var _ref_check = instance_find(
						obj_battle_status,
						_it_instance
					);

					if (!instance_exists(_ref_check)){
						continue;
					}

					if (_ref_check._str_status_name != "REDIRECT"){
						continue;
					}

					if (
						!variable_instance_exists(
							_ref_check,
							"_str_redirect_link_label"
						)
					){
						continue;
					}

					if (_ref_check._str_redirect_link_label == _str_candidate){

						_flag_used = true;

						break;
					}
				}

				if (!_flag_used){

					_str_link_label = _str_candidate;

					break;
				}
			}

			if (_str_link_label == ""){
				return undefined;
			}

			//================//
			//GET BEAST NAMES//
			//================//
			var _str_protected_name = string_upper(
				_ref_target._ref_unit._str_beast_name
			);

			var _str_guard_name = string_upper(
				_ref_guard._ref_unit._str_beast_name
			);

			//================//
			//CREATE REDIRECT//
			//================//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			if (!instance_exists(_ref_new_status)){
				return undefined;
			}

			//===================//
			//INFINITE LIFETIME//
			//===================//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_redirect;

			_ref_new_status._ref_host = _ref_target;
			_ref_new_status._ref_status_target = _ref_guard;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "REDIRECT";

			_ref_new_status._str_status_desc =
				"LINK [" + _str_link_label + "] | " +
				_str_protected_name + " -> " +
				_str_guard_name +
				" | NEXT DAMAGE IS REDIRECTED";

			_ref_new_status._spr_status = spr_status_buff_redirect;

			// Each relationship is unique.
			// Multiple protectors produce separate Status instances.
			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._str_redirect_link_label = _str_link_label;

			_ref_new_status._ct_redirect_rage_gain = 0;
			_ref_new_status._ref_redirect_guard_status = undefined;

			_ref_new_status._str_trigger_region = undefined;

			//================//
			//REGISTER REDIRECT//
			//================//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			//=====================//
			//CREATE MATCHING GUARD//
			//=====================//
			var _ref_guard_status = scr_status_buff_redirect_guard(
				"APPLY",
				undefined,
				_ref_new_status
			);

			//================//
			//ROLL BACK FAILURE//
			//================//
			if (!instance_exists(_ref_guard_status)){

				scr_status_buff_redirect(
					"DEATH",
					_ref_new_status
				);

				return undefined;
			}

			_ref_new_status._ref_redirect_guard_status = _ref_guard_status;

			//=====================================//
			//REPLACE THIS PROTECTOR'S OLDER LINKS//
			//=====================================//
			// The new pair now exists successfully.
			// Remove any previous relationship belonging to this guard,
			// including one protecting a different ally.

			for (
				var _it_status = ds_list_size(_ref_guard._list_statuses) - 1;
				_it_status >= 0;
				_it_status--
			){

				var _ref_old_guard_status = ds_list_find_value(
					_ref_guard._list_statuses,
					_it_status
				);

				if (!instance_exists(_ref_old_guard_status)){
					continue;
				}

				if (_ref_old_guard_status == _ref_guard_status){
					continue;
				}

				if (_ref_old_guard_status._str_status_name != "REDIRECT_GUARD"){
					continue;
				}

				scr_status_buff_redirect_guard(
					"DEATH",
					_ref_old_guard_status
				);
			}

			//================//
			//REFRESH ICONS//
			//================//
			scr_status_reposition(_ref_target);
			scr_status_reposition(_ref_guard);

			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			// Infinite, event-bound Buff.
			// No turn-based decrement.

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//=====================//
			//REMOVE MATCHING GUARD//
			//=====================//
			if (
				variable_instance_exists(
					_ref_status,
					"_ref_redirect_guard_status"
				) &&
				instance_exists(_ref_status._ref_redirect_guard_status)
			){

				var _ref_linked_guard =
					_ref_status._ref_redirect_guard_status;

				_ref_status._ref_redirect_guard_status = undefined;
				_ref_linked_guard._ref_redirect_status = undefined;

				scr_status_buff_redirect_guard(
					"DEATH",
					_ref_linked_guard
				);
			}

			//================//
			//REMOVE REDIRECT//
			//================//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}