//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_BRITTLE_CONSTITUTION
// FUNCTION: Handles Brittle Constitution.
//           Reduces CON by 30 for 3 rounds.
//           Gives hosted DoTs a 25% chance to preserve duration.
//
//===============================================================================//

function scr_status_debuff_brittle_constitution(_str_tag,_ref_status,_val_lifetime=undefined){

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

			if (_ref_target._ref_unit == undefined){
				return undefined;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_lifetime =
				max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_status_check(
					"BRITTLE_CONSTITUTION",
					_ref_target
				);

			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				return _ref_existing_status;
			}

			//---------------------//
			//REDUCE CONSTITUTION//
			//---------------------//
			var _val_con_before =
				_ref_target._ref_unit._val_beast_con_stat;

			_ref_target._ref_unit._val_beast_con_stat =
				max(
					0,
					_val_con_before - 30
				);

			var _val_con_reduction =
				_val_con_before -
				_ref_target._ref_unit._val_beast_con_stat;

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

			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			_ref_new_status._scr_status =
				scr_status_debuff_brittle_constitution;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"DEBUFF";

			_ref_new_status._str_status_name =
				"BRITTLE_CONSTITUTION";

			_ref_new_status._str_status_desc =
				"CON -30; DOTS HAVE 25% CHANCE TO PRESERVE DURATION";

			_ref_new_status._spr_status =
				spr_status_debuff_brittle_constitution;

			_ref_new_status._ct_status_stacks =
				1;

			// STORES EXACT CON ACTUALLY REMOVED
			_ref_new_status._val_status_magnitude =
				_val_con_reduction;

			_ref_new_status._val_dot_lifetime_hold_chance =
				25;

			_ref_new_status._str_trigger_region =
				"END";

			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

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

				scr_status_destroy(_ref_status);

				return undefined;
			}

			scr_status_tick_lifetime(_ref_status);
			scr_status_reposition(_ref_host);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host =
				_ref_status._ref_host;

			//-------------//
			//RESTORE CON//
			//-------------//
			if (
				instance_exists(_ref_host) &&
				_ref_host._ref_unit != undefined
			){

				_ref_host._ref_unit._val_beast_con_stat +=
					_ref_status._val_status_magnitude;
			}

			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}