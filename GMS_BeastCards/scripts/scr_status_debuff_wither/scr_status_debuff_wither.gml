
//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_WITHER
// FUNCTION: Handles the Wither Debuff.
//           Unstackable Timed Debuff.
//           Reduces Current HP and Maximum HP by 25% when first applied.
//           Reapplication refreshes duration without applying HP loss again.
//           Restores the exact Maximum HP and Current HP reductions on removal.
//           Does not restore damage taken from other sources.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY.
// RETURNS: Status reference or undefined.
//
//===============================================================================//

function scr_status_debuff_wither(_str_tag,_ref_status,_val_lifetime=undefined,_ref_target=undefined){

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

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"WITHER",
				_ref_target
			);

			//==================//
			//REFRESH EXISTING//
			//==================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				return _ref_existing_status;
			}

			//==========================//
			//CALCULATE HP REDUCTIONS//
			//==========================//
			var _val_max_hp_reduction = 0;
			var _val_cur_hp_reduction = 0;

			if (_ref_target._val_max_hp > 1){

				_val_max_hp_reduction = round(
					_ref_target._val_max_hp * 0.25
				);

				_val_max_hp_reduction = clamp(
					_val_max_hp_reduction,
					1,
					_ref_target._val_max_hp - 1
				);
			}

			if (_ref_target._val_cur_hp > 1){

				_val_cur_hp_reduction = round(
					_ref_target._val_cur_hp * 0.25
				);

				_val_cur_hp_reduction = clamp(
					_val_cur_hp_reduction,
					0,
					_ref_target._val_cur_hp - 1
				);
			}

			//======================//
			//STORE ORIGINAL HP//
			//======================//
			var _val_cur_hp_before = _ref_target._val_cur_hp;

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
			_ref_new_status._scr_status = scr_status_debuff_wither;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "DEBUFF";
			_ref_new_status._str_status_name = "WITHER";

			_ref_new_status._spr_status = spr_status_debuff_wither;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._val_status_magnitude = 0.25;

			//================//
			//STORE MAX HP LOSS//
			//================//
			_ref_new_status._val_wither_max_hp_reduction =
				_val_max_hp_reduction;

			// Actual Current HP loss is recorded after applying
			// the reductions and clamping the resulting HP.
			_ref_new_status._val_wither_cur_hp_reduction = 0;

			//================//
			//DESCRIPTION//
			//================//
			_ref_new_status._str_status_desc =
				"CURRENT AND MAXIMUM HP -" +
				string(round(_ref_new_status._val_status_magnitude * 100)) +
				"%; RESTORES LOST HP WHEN REMOVED";

			_ref_new_status._str_trigger_region = "END";

			//==================//
			//REDUCE MAXIMUM HP//
			//==================//
			_ref_target._val_max_hp -= _val_max_hp_reduction;

			_ref_target._val_max_hp = max(
				1,
				_ref_target._val_max_hp
			);

			//================//
			//REDUCE CURRENT HP//
			//================//
			_ref_target._val_cur_hp -= _val_cur_hp_reduction;

			_ref_target._val_cur_hp = clamp(
				_ref_target._val_cur_hp,
				1,
				_ref_target._val_max_hp
			);

			//========================//
			//STORE ACTUAL HP LOSS//
			//========================//
			// Includes any additional HP removed by the Max HP clamp.
			// This exact amount will be returned on removal.

			_ref_new_status._val_wither_cur_hp_reduction =
				max(
					0,
					_val_cur_hp_before - _ref_target._val_cur_hp
				);

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

			//================//
			//UPDATE LIFETIME//
			//================//
			scr_status_tick_lifetime(_ref_status);

			scr_status_reposition(_ref_host);

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (instance_exists(_ref_host)){

				//==================//
				//RESTORE MAXIMUM HP//
				//==================//
				_ref_host._val_max_hp +=
					_ref_status._val_wither_max_hp_reduction;

				_ref_host._val_max_hp = max(
					1,
					_ref_host._val_max_hp
				);

				//==================//
				//RESTORE CURRENT HP//
				//==================//
				// Restore only the HP removed by Wither.
				// Do not revive a Beast that has already died.

				if (_ref_host._val_cur_hp > 0){

					_ref_host._val_cur_hp +=
						_ref_status._val_wither_cur_hp_reduction;

					_ref_host._val_cur_hp = min(
						_ref_host._val_cur_hp,
						_ref_host._val_max_hp
					);
				}
			}

			//----------------//
			//DESTROY STATUS//
			//----------------//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}