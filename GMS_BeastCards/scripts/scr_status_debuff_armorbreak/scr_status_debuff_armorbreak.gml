//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_ARMORBREAK
// FUNCTION: Applies or refreshes the unstackable timed Armorbreak Debuff.
//           Destroys floor(20% current Armor) on application and halves
//           subsequent Armor gains; preserves status lifetime and feedback.
//
// ARGUMENTS: _str_tag - APPLY, REPEAT or DEATH.
//            _ref_status - stored status for non-APPLY commands.
//            _val_lifetime - optional existing lifetime; _ref_target - APPLY host.
// RETURNS: APPLY returns status reference or undefined; other tags no value.
//
//===============================================================================//

function scr_status_debuff_armorbreak(_str_tag,_ref_status,_val_lifetime=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":


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
				_val_lifetime = 2;
			}

			_val_lifetime = max(1,_val_lifetime);

			//================//
			//BREAK 20% ARMOR//
			//================//
			var _val_armor_break = floor(_ref_target._val_armor * 0.20);
			var _stct_armor_result = scr_battle_destroy_armor(_ref_target,_val_armor_break);
			_val_armor_break = _stct_armor_result._val_armor_removed;

			if (_val_armor_break > 0){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"-" + string(_val_armor_break) + " ARMOR",
					undefined,
					c_blue,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("ARMORBREAK",_ref_target);

			//------------------//
			//REFRESH EXISTING//
			//------------------//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				return _ref_existing_status;
			}

			//===============//
			//CREATE STATUS//
			//===============//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_debuff_armorbreak;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "DEBUFF";
			_ref_new_status._str_status_name = "ARMORBREAK";

			_ref_new_status._spr_status = spr_status_debuff_armorbreak;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._val_status_magnitude = 50;

			_ref_new_status._str_status_desc =
				"BREAKS 20% ARMOR ON APPLY; ARMOR GAIN -" +
				string(_ref_new_status._val_status_magnitude) +
				"%";

			_ref_new_status._str_trigger_region = "END";

			//----------------//
			//REGISTER STATUS//
			//----------------//
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

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(_ref_status);
			scr_status_reposition(_ref_host);

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
