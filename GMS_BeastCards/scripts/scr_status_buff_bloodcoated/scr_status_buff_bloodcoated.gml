
//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_BLOODCOATED
// FUNCTION: Handles Bloodcoated.
//
//           Unstackable timed Buff.
//           For 3 rounds, Attacks apply exactly 1 base Bleed
//           application to each eligible enemy target.
//
//           Reapplication refreshes lifetime.
//           Magnitude is fixed at 1.
//
//===============================================================================//

function scr_status_buff_bloodcoated(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_primary_target=undefined,_stct_card=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//================//
			//VALIDATE TARGET//
			//================//
			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//==========//
			//DEFAULTS//
			//==========//
			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_lifetime = max(1,_val_lifetime);

			//====================//
			//FIXED BLEED MAGNITUDE//
			//====================//
			_val_magnitude = 1;

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"BLOODCOATED",
				_ref_target
			);

			//================//
			//REFRESH EXISTING//
			//================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				_ref_existing_status._val_status_magnitude = 1;

				_ref_existing_status._str_status_desc =
					"ATTACKS APPLY 1 BLEED";

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				return _ref_existing_status;
			}

			//================//
			//CREATE STATUS//
			//================//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			//================//
			//INIT LIFETIME//
			//================//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//================//
			//STATUS DATA//
			//================//
			_ref_new_status._scr_status = scr_status_buff_bloodcoated;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "BLOODCOATED";

			_ref_new_status._str_status_desc =
				"ATTACKS APPLY 1 BLEED";

			_ref_new_status._spr_status = spr_status_buff_bloodcoated;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._val_status_magnitude = 1;

			//================//
			//END DECREMENT//
			//================//
			_ref_new_status._str_trigger_region = "END";

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_status_destroy(_ref_status);

				return undefined;
			}

			//================//
			//TICK LIFETIME//
			//================//
			scr_status_tick_lifetime(_ref_status);

			scr_status_reposition(_ref_host);

		break;

		//=========//
		//TRIGGER//
		//=========//
		case "TRIGGER":

			//================//
			//VALIDATE STATUS//
			//================//
			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			//================//
			//VALIDATE CARD//
			//================//
			if (!is_struct(_stct_card)){
				return false;
			}

			if (_stct_card._str_card_type != "ATTACK"){
				return false;
			}

			//====================//
			//GET ATTACK TARGETS//
			//====================//
			var _arr_targets = scr_battle_get_card_preview_targets(
				_stct_card,
				_ref_primary_target
			);

			//================//
			//FALLBACK TARGET//
			//================//
			if (
				array_length(_arr_targets) <= 0 &&
				instance_exists(_ref_primary_target)
			){

				array_push(_arr_targets,_ref_primary_target);
			}

			if (array_length(_arr_targets) <= 0){
				return false;
			}

			var _flag_triggered = false;

			//================//
			//APPLY BLEED//
			//================//
			for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

				var _ref_effect_target = _arr_targets[_it_target];

				//================//
				//VALIDATE TARGET//
				//================//
				if (!instance_exists(_ref_effect_target)){
					continue;
				}

				if (
					_ref_effect_target._str_list != "ALIVE" ||
					_ref_effect_target._val_cur_hp <= 0
				){
					continue;
				}

				if (_ref_effect_target._str_team == _ref_host._str_team){
					continue;
				}

				//=========================//
				//APPLY EXACTLY ONE BASE BLEED//
				//=========================//
				var _ref_applied_bleed = scr_status_apply_dot(
					"BLEED",
					_ref_effect_target
				);

				if (instance_exists(_ref_applied_bleed)){
					_flag_triggered = true;
				}
			}

			//==========//
			//FEEDBACK//
			//==========//
			if (_flag_triggered){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"BLOODCOATED",
					undefined,
					c_red,
					_ref_host.x,
					_ref_host.y - 48
				);
			}

			return _flag_triggered;

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (instance_exists(_ref_status)){
				scr_status_destroy(_ref_status);
			}

		break;
	}

	return undefined;
}