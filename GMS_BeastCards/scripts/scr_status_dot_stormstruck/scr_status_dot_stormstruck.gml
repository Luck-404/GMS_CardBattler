//===============================================================================//
//
// SCRIPT: SCR_STATUS_DOT_STORMSTRUCK
// FUNCTION: Creates and manages the Stormstruck status.
//           Stormstruck is stackable and lasts 3 rounds.
//           Its normal round trigger only decrements lifetime.
//           Action damage is resolved through scr_trigger_stormstruck_action.
//
//===============================================================================//

function scr_status_dot_stormstruck(_str_command,_ref_status=undefined,_val_lifetime=undefined){

	switch(_str_command){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			//-----------------------//
			//CHECK EXISTING STATUS//
			//-----------------------//
			var _ref_existing_status = scr_check_for_status("STORMSTRUCK",_ref_target);

			if (_ref_existing_status != -1){

				_ref_existing_status._ct_status_stacks++;
				
				scr_battle_vfx(
					_ref_target,
					spr_battle_vfx_stormstruck,
					undefined,
					undefined,
					32,
					32,
					1,
					0,
					snd_battle_sfx_stormstruck
				);

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				scr_reposition_statuses(_ref_target);

				//----------------//
				//CHECK DISCHARGE//
				//----------------//
				scr_trigger_discharge(_ref_target);

				return _ref_existing_status;
			}

			//----------------//
			//CREATE STATUS//
			//----------------//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_fx",
				obj_battle_status
			);

			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				true,
				false
			);

			_ref_new_status._scr_status = scr_status_dot_stormstruck;

			_ref_new_status._ref_host = _ref_target;
			_ref_new_status._ref_status_target = _ref_target;

			_ref_new_status._str_status_type = "DOT";
			_ref_new_status._str_status_name = "STORMSTRUCK";

			_ref_new_status._str_status_desc =
				"WHEN HOST ACTS: DEAL 2 NEU DMG PER STACK, REMOVE 1 STACK, REFRESH LIFETIME.";

			_ref_new_status._spr_status =
				spr_status_dot_stormstruck;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = 2;

			_ref_new_status._str_trigger_region = "START";

			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_reposition_statuses(_ref_target);

				scr_battle_vfx(
					_ref_target,
					spr_battle_vfx_stormstruck,
					undefined,
					undefined,
					32,
					32,
					1,
					0,
					snd_battle_sfx_stormstruck
				);
			
			return _ref_new_status;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return;
			}

			// Stormstruck does not deal its damage during
			// the normal status phase. It only loses duration.
			scr_status_tick_lifetime(_ref_status);

		break;


		//------//
		//DEATH//
		//------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return;
			}

			scr_destroy_status(_ref_status);

		break;
	}

	return _ref_status;
}