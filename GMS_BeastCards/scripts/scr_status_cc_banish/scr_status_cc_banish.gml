//===============================================================================//
//
// SCRIPT: SCR_STATUS_CC_BANISH
// FUNCTION: Handles Banish.
//           Unstackable Crowd Control Status.
//           Removes the host from active battle.
//           The host cannot act, be targeted, or trigger effects while Banished.
//           Hosted effect durations remain paused until the Beast returns.
//           Banish duration is advanced externally by the Banish controller.
//
//===============================================================================//

function scr_status_cc_banish(_str_tag,_ref_status,_val_lifetime=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//----------//
			//DEFAULTS//
			//----------//
			if (_val_lifetime == undefined){
				_val_lifetime = 1;
			}

			//---------------//
			//CC LIFETIME//
			//---------------//
			_val_lifetime = scr_cc_get_lifetime(
				_val_lifetime,
				1
			);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("BANISH",_ref_target);

			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			/*
				The standard lifetime values are retained for Status
				display/state data, but do not tick while Banished.

				scr_cc_update_banished_beasts() advances the separate
				Banish countdown instead.
			*/
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_cc_banish;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "CC";
			_ref_new_status._str_status_name = "BANISH";
			_ref_new_status._str_status_desc = "REMOVED FROM BATTLE; CANNOT ACT, BE TARGETED, OR TRIGGER EFFECTS; HOSTED EFFECTS ARE PAUSED";

			_ref_new_status._spr_status = spr_status_cc_banish;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._str_trigger_region = undefined;

			//==========================//
			//STORE BANISH STATE//
			//==========================//
			_ref_new_status._val_banish_return_pos = _ref_target._val_pos;

			/*
				One Banish round represents one complete
				Player/Enemy battle cycle.

				The Banish controller updates once per side-turn,
				so each round requires two countdown steps.
			*/
			_ref_new_status._ct_banish_turns_remaining = _val_lifetime * 2;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			//================//
			//BANISH BEAST//
			//================//
			if (!scr_cc_banish_beast(_ref_target)){

				scr_status_destroy(_ref_new_status);

				return undefined;
			}

			return _ref_new_status;

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;
			var _val_return_pos = _ref_status._val_banish_return_pos;

			//================//
			//REMOVE BANISH//
			//================//
			scr_status_destroy(_ref_status);

			//================//
			//RETURN BEAST//
			//================//
			if (
				instance_exists(_ref_host) &&
				_ref_host._str_list == "BANISHED" &&
				_ref_host._val_cur_hp > 0
			){

				if (
					scr_cc_return_banished_beast(
						_ref_host,
						_val_return_pos
					)
				){

					scr_gui_spawn_popup_scrolling(
						"TEXT",
						"RETURNED",
						undefined,
						c_aqua,
						_ref_host.x,
						_ref_host.y - 48
					);
				}
			}

		break;
	}

	return undefined;
}