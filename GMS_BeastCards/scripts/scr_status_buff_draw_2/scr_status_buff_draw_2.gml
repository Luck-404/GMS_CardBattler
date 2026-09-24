
//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_DRAW_2
// FUNCTION: Handles Draw 2.
//           Stackable Infinite Global Buff with consumable charges.
//           Each charge adds 2 cards to one draw event.
//           Default application grants 3 charges.
//           Reapplication adds charges.
//           The Buff ends when all charges are consumed.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/CONSUME/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_lifetime is retained for caller compatibility but now
//            specifies the number of charges added (default 3).
//            _ref_target is retained for caller compatibility.
// RETURNS: Command-specific Status reference or result.
//
//===============================================================================//

function scr_status_buff_draw_2(_str_tag,_ref_status,_val_lifetime=undefined,_ref_target=undefined){

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

			var _ct_charges_added = max(1,floor(_val_lifetime));

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"DRAW_2",
				global.list_statuses
			);

			//================//
			//ADD CHARGES//
			//================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._ct_status_stacks += _ct_charges_added;

				_ref_existing_status._str_status_desc =
					"NEXT " +
					string(_ref_existing_status._ct_status_stacks) +
					" DRAW EVENTS: +2 CARDS EACH";

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

			//============================//
			//STACKABLE INFINITE LIFETIME//
			//============================//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				true,
				true
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_draw_2;

			_ref_new_status._ref_host = undefined;

			_ref_new_status._str_status_type = "GLOBAL";
			_ref_new_status._str_status_name = "DRAW_2";

			_ref_new_status._str_status_desc =
				"NEXT " +
				string(_ct_charges_added) +
				" DRAW EVENTS: +2 CARDS EACH";

			_ref_new_status._spr_status = spr_status_buff_draw_2;

			_ref_new_status._ct_status_stacks = _ct_charges_added;
			_ref_new_status._val_status_magnitude = 2;

			// No turn-based trigger: charges are spent by draw events.
			_ref_new_status._str_trigger_region = undefined;

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

			// Safely clear a queued REPEAT without spending charges.
			// Infinite statuses never lose lifetime.
			scr_status_tick_lifetime(_ref_status);

		break;

		//=========//
		//CONSUME//
		//=========//
		case "CONSUME":

			if (!instance_exists(_ref_status)){
				return false;
			}

			if (_ref_status._ct_status_stacks <= 0){
				return false;
			}

			//================//
			//SPEND ONE CHARGE//
			//================//
			_ref_status._ct_status_stacks--;

			//==================//
			//REMOVE LAST CHARGE//
			//==================//
			if (_ref_status._ct_status_stacks <= 0){

				scr_status_buff_draw_2(
					"DEATH",
					_ref_status
				);

				return true;
			}

			//================//
			//UPDATE DESCRIPTION//
			//================//
			_ref_status._str_status_desc =
				"NEXT " +
				string(_ref_status._ct_status_stacks) +
				" DRAW EVENTS: +2 CARDS EACH";

			//================//
			//REFRESH STATUS//
			//================//
			if (
				variable_global_exists("list_statuses") &&
				ds_exists(global.list_statuses,ds_type_list)
			){
				scr_status_reposition(global.list_statuses);
			}

			return true;

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			// No permanent draw-stat modifier needs to be reversed.
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}