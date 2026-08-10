//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_ARMORBREAK
// FUNCTION: Handles the Armorbreak Debuff.
//           Unstackable Timed.
//           Breaks 20% of current Armor whenever applied or refreshed.
//           Reduces all Armor gained by the host by 50% while active.
//
//===============================================================================//
function scr_status_debuff_armorbreak(_str_tag,_ref_status,_val_lifetime=undefined){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			var _ref_target =
				global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			//----------------//
			//DEFAULT LENGTH//
			//----------------//
			if (_val_lifetime == undefined){
				_val_lifetime = 2;
			}

			_val_lifetime =
				max(
					1,
					_val_lifetime
				);

			//----------------//
			//BREAK 20% ARMOR//
			//----------------//
			var _val_armor_break =
				floor(
					_ref_target._val_armor *
					0.20
				);

			if (_val_armor_break > 0){

				_ref_target._val_armor =
					max(
						0,
						_ref_target._val_armor -
						_val_armor_break
					);

				scr_spawn_popup_scrolling(
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
			var _ref_existing_status =
				scr_check_for_status(
					"ARMORBREAK",
					_ref_target
				);

			//------------------//
			//REFRESH EXISTING//
			//------------------//
			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status =
				instance_create_layer(
					_ref_target.x,
					_ref_target.y,
					"ily_status",
					obj_battle_status
				);

			_ref_new_status._scr_status =
				scr_status_debuff_armorbreak;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"DEBUFF";

			_ref_new_status._str_status_name =
				"ARMORBREAK";

			_ref_new_status._str_status_desc =
				"BREAKS 20% ARMOR ON APPLY; ARMOR GAIN -50%";

			_ref_new_status._spr_status =
				spr_status_debuff_armorbreak;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._val_status_magnitude =
				50;

			_ref_new_status._str_trigger_region =
				"END";

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_reposition_statuses(
				_ref_target
			);

			return _ref_new_status;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host =
				_ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_destroy_status(
					_ref_status
				);

				return undefined;
			}

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(
				_ref_status
			);

			scr_reposition_statuses(
				_ref_host
			);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (instance_exists(_ref_status)){
				scr_destroy_status(_ref_status);
			}

		break;
	}

	return undefined;
}