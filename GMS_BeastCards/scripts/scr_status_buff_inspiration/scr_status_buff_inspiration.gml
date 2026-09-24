
//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_INSPIRATION
// FUNCTION: Handles Inspiration.
//           Unstackable Timed Global Buff.
//           Grants +2 temporary Maximum Mana on first application.
//           Grants up to +2 Current Mana on every application.
//           Reapplication refreshes duration without stacking Maximum Mana.
//           Expiration removes only its temporary Maximum Mana bonus.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_lifetime=undefined.
//            _ref_target is retained for APPLY caller compatibility.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_inspiration(_str_tag,_ref_status,_val_lifetime=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//================//
			//VALIDATE SYSTEM//
			//================//
			if (!instance_exists(obj_battle_player_controller)){
				return undefined;
			}

			if (!variable_global_exists("list_statuses")){
				return undefined;
			}

			if (!ds_exists(global.list_statuses,ds_type_list)){
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
				"INSPIRATION",
				global.list_statuses
			);

			//==================//
			//REFRESH EXISTING//
			//==================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				//==================//
				//REFRESH LIFETIME//
				//==================//
				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				//===================//
				//GAIN CURRENT MANA//
				//===================//
				// Do not increase Maximum Mana again.
				// Shared helper clamps Current Mana to Maximum Mana.

				scr_battle_gain_mana(
					_ref_existing_status._val_status_magnitude
				);

				//====================//
				//UPDATE DESCRIPTION//
				//====================//
				_ref_existing_status._str_status_desc =
					"+2 MAXIMUM MANA. GAIN 2 CURRENT MANA ON APPLY. " +
					string(_ref_existing_status._val_status_lifetime) +
					" ROUNDS REMAINING.";

				scr_status_reposition(global.list_statuses);

				return _ref_existing_status;
			}

			//===============//
			//CREATE STATUS//
			//===============//
			var _ref_new_status = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_status",
				obj_battle_status
			);

			//================================//
			//UNSTACKABLE TIMED INITIALIZATION//
			//================================//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_inspiration;

			_ref_new_status._ref_host = undefined;

			_ref_new_status._str_status_type = "GLOBAL";
			_ref_new_status._str_status_name = "INSPIRATION";

			_ref_new_status._str_status_desc =
				"+2 MAXIMUM MANA. GAIN 2 CURRENT MANA ON APPLY. " +
				string(_val_lifetime) +
				" ROUNDS REMAINING.";

			_ref_new_status._spr_status = spr_status_buff_inspiration;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = 2;

			_ref_new_status._str_trigger_region = "END";

			//======================//
			//INCREASE MAXIMUM MANA//
			//======================//
			// This executes only on the first application.

			scr_battle_change_max_mana(
				_ref_new_status._val_status_magnitude
			);

			//===================//
			//GAIN CURRENT MANA//
			//===================//
			scr_battle_gain_mana(
				_ref_new_status._val_status_magnitude
			);

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				global.list_statuses,
				_ref_new_status
			);

			scr_status_reposition(global.list_statuses);

			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			if (
				!variable_global_exists("list_statuses") ||
				!ds_exists(global.list_statuses,ds_type_list)
			){

				scr_status_destroy(_ref_status);

				return undefined;
			}

			//================//
			//UPDATE LIFETIME//
			//================//
			scr_status_tick_lifetime(_ref_status);

			scr_status_reposition(global.list_statuses);

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _val_mana_bonus = max(
				0,
				_ref_status._val_status_magnitude
			);

			//=====================//
			//REMOVE MAXIMUM MANA//
			//=====================//
			scr_battle_change_max_mana(
				-_val_mana_bonus
			);

			//================//
			//DESTROY STATUS//
			//================//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}