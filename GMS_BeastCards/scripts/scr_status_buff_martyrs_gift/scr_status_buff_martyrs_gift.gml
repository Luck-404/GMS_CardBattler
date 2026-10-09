//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_MARTYRS_GIFT
// FUNCTION: Represents the permanent primary-stat gift granted to a living ally
//           when a MARTYR Elite dies.
//
//           Each application:
//           - permanently grants +25% to all seven primary stats through the
//             existing Elite primary-stat bonus helper;
//           - adds one visible MARTYRS_GIFT stack;
//           - is Infinite, permanent, uncleansable, and untransferable;
//           - survives host death so a resurrected Beast still visibly owns the
//             permanent gift for the remainder of battle.
//
//           The Status intentionally uses the generic Boost Status sprite so this
//           gameplay update does not require a new sprite resource. It is NOT the
//           MARTYR Elite icon and can be swapped to a dedicated sprite later.
//
// ARGUMENTS: _str_tag selects APPLY/REMOVE_STACK/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_percent is the permanent primary-stat percent granted per stack.
//            _ref_target is the living Beast receiving the gift.
// RETURNS: MARTYRS_GIFT Status instance, or undefined on failure.
//
//===============================================================================//

function scr_status_buff_martyrs_gift(_str_tag,_ref_status,_val_percent=25,_ref_target=undefined){

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

			if (
				_ref_target._val_cur_hp <= 0 ||
				_ref_target._str_list != "ALIVE" ||
				!is_struct(_ref_target._ref_unit) ||
				!ds_exists(_ref_target._list_statuses,ds_type_list)
			){
				return undefined;
			}

			if (!is_real(_val_percent)){
				return undefined;
			}

			_val_percent = max(0,_val_percent);

			if (_val_percent <= 0){
				return undefined;
			}

			//================//
			//EXISTING STATUS//
			//================//
			var _ref_existing =
				scr_status_check(
					"MARTYRS_GIFT",
					_ref_target
				);

			//========================//
			//APPLY PERMANENT STAT GIFT//
			//========================//
			var _stct_bonus =
				scr_battle_elite_apply_primary_stat_percent_bonus(
					_ref_target,
					_val_percent,
					undefined,
					"MARTYRS_GIFT"
				);

			if (!is_struct(_stct_bonus)){
				return undefined;
			}

			//================//
			//STACK EXISTING//
			//================//
			if (
				_ref_existing != -1 &&
				instance_exists(_ref_existing)
			){
				if (
					!variable_instance_exists(
						_ref_existing,
						"_arr_martyrs_gift_bonus_records"
					) ||
					!is_array(
						_ref_existing._arr_martyrs_gift_bonus_records
					)
				){
					_ref_existing._arr_martyrs_gift_bonus_records = [];
				}

				array_push(
					_ref_existing._arr_martyrs_gift_bonus_records,
					_stct_bonus
				);

				_ref_existing._ct_status_stacks++;
				_ref_existing._val_status_magnitude = _val_percent;

				_ref_existing._str_status_desc =
					"PERMANENT. UNCLEANSABLE. +" +
					string(_val_percent) +
					"% PRIMARY STATS PER MARTYR'S GIFT STACK.";

				scr_status_reposition(_ref_target);

				return _ref_existing;
			}

			//===============//
			//CREATE STATUS//
			//===============//
			var _ref_new_status =
				instance_create_layer(
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
				true,
				true
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status =
				scr_status_buff_martyrs_gift;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"MARTYRS_GIFT";

			_ref_new_status._str_status_desc =
				"PERMANENT. UNCLEANSABLE. +" +
				string(_val_percent) +
				"% PRIMARY STATS PER MARTYR'S GIFT STACK.";

			_ref_new_status._spr_status =
				spr_status_buff_boost;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = _val_percent;

			// Exact applied deltas are retained so the Cheats Status stack editor can
			// remove one permanent gift without approximating compounded/rounded stats.
			_ref_new_status._arr_martyrs_gift_bonus_records = [
				_stct_bonus
			];

			_ref_new_status._flag_status_stackable = true;
			_ref_new_status._flag_status_uncleansable = true;
			_ref_new_status._flag_status_untransferable = true;
			_ref_new_status._flag_status_permanent = true;

			_ref_new_status._str_trigger_region =
				undefined;

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

		//============//
		//REMOVE STACK//
		//============//
		case "REMOVE_STACK":

			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_remove_host = _ref_status._ref_host;

			if (
				!instance_exists(_ref_remove_host) ||
				!is_struct(_ref_remove_host._ref_unit) ||
				!variable_instance_exists(
					_ref_status,
					"_arr_martyrs_gift_bonus_records"
				) ||
				!is_array(_ref_status._arr_martyrs_gift_bonus_records) ||
				array_length(_ref_status._arr_martyrs_gift_bonus_records) <= 0
			){
				return false;
			}

			var _it_bonus =
				array_length(
					_ref_status._arr_martyrs_gift_bonus_records
				) - 1;

			var _stct_remove_bonus =
				_ref_status._arr_martyrs_gift_bonus_records[
					_it_bonus
				];

			if (!is_struct(_stct_remove_bonus)){
				return false;
			}

			var _stct_remove_unit = _ref_remove_host._ref_unit;

			_stct_remove_unit._val_beast_hp_stat =
				max(0,_stct_remove_unit._val_beast_hp_stat - _stct_remove_bonus._val_hp_stat_bonus);

			_stct_remove_unit._val_beast_con_stat =
				max(0,_stct_remove_unit._val_beast_con_stat - _stct_remove_bonus._val_con_bonus);

			_stct_remove_unit._val_beast_ppow_stat =
				max(0,_stct_remove_unit._val_beast_ppow_stat - _stct_remove_bonus._val_ppow_bonus);

			_stct_remove_unit._val_beast_mpow_stat =
				max(0,_stct_remove_unit._val_beast_mpow_stat - _stct_remove_bonus._val_mpow_bonus);

			_stct_remove_unit._val_beast_pdef_stat =
				max(0,_stct_remove_unit._val_beast_pdef_stat - _stct_remove_bonus._val_pdef_bonus);

			_stct_remove_unit._val_beast_mdef_stat =
				max(0,_stct_remove_unit._val_beast_mdef_stat - _stct_remove_bonus._val_mdef_bonus);

			_stct_remove_unit._val_beast_speed_stat =
				max(0,_stct_remove_unit._val_beast_speed_stat - _stct_remove_bonus._val_speed_bonus);

			_ref_remove_host._val_speed_base =
				max(0,_ref_remove_host._val_speed_base - _stct_remove_bonus._val_speed_bonus);

			_ref_remove_host._val_max_hp =
				max(1,_ref_remove_host._val_max_hp - _stct_remove_bonus._val_max_hp_bonus);

			_stct_remove_unit._val_beast_hp_max =
				max(1,_stct_remove_unit._val_beast_hp_max - _stct_remove_bonus._val_max_hp_bonus);

			_ref_remove_host._val_cur_hp =
				min(_ref_remove_host._val_cur_hp,_ref_remove_host._val_max_hp);

			_stct_remove_unit._val_beast_hp_cur =
				min(_stct_remove_unit._val_beast_hp_cur,_stct_remove_unit._val_beast_hp_max);

			array_delete(
				_ref_status._arr_martyrs_gift_bonus_records,
				_it_bonus,
				1
			);

			_ref_status._ct_status_stacks =
				max(0,_ref_status._ct_status_stacks - 1);

			if (_ref_status._ct_status_stacks <= 0){
				scr_status_destroy(_ref_status);
				return true;
			}

			_ref_status._str_status_desc =
				"PERMANENT. UNCLEANSABLE. +" +
				string(_ref_status._val_status_magnitude) +
				"% PRIMARY STATS PER MARTYR'S GIFT STACK.";

			scr_status_reposition(_ref_remove_host);

			return true;

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			/*
				MARTYRS_GIFT is permanent for the battle and its stat changes are
				intentionally not rolled back when the host dies. Leaving the Status
				alive mirrors other permanent battle Buffs such as OUTLEVELED and
				keeps the icon available if the Beast is resurrected.
			*/
			return _ref_status;

		break;
	}

	return undefined;
}
