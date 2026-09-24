//===============================================================================//
//
// SCRIPT: SCR_STATUS_DOT_STORMSTRUCK
// FUNCTION: Handles the Stormstruck damage-over-time Status.
//           Stackable Timed.
//           Lasts 3 rounds by default.
//           Normal Status ticks only decrement lifetime.
//           Action damage is resolved through scr_status_trigger_stormstruck_action.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_dot_stormstruck(_str_tag,_ref_status=undefined,_val_lifetime=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":


			//----------------//
			//VALIDATE TARGET//
			//----------------//
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

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("STORMSTRUCK",_ref_target);
			var _ref_applied_status = undefined;

			//================//
			//STACK EXISTING//
			//================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._ct_status_stacks++;

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				scr_status_reposition(_ref_target);

				//------------------//
				//CHECK DISCHARGE//
				//------------------//
				scr_battle_trigger_discharge(_ref_target);

				_ref_applied_status = _ref_existing_status;
			}

			//================//
			//CREATE STATUS//
			//================//
			else{

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
					true,
					false
				);

				//-------------//
				//STATUS DATA//
				//-------------//
				_ref_new_status._scr_status = scr_status_dot_stormstruck;

				_ref_new_status._ref_host = _ref_target;
				_ref_new_status._ref_status_target = _ref_target;

				_ref_new_status._str_status_type = "DOT";
				_ref_new_status._str_status_name = "STORMSTRUCK";
				_ref_new_status._str_status_desc = "WHEN HOST ACTS: DEAL 2 NEU DMG PER STACK, REMOVE 1 STACK, REFRESH LIFETIME";

				_ref_new_status._spr_status = spr_status_dot_stormstruck;

				_ref_new_status._ct_status_stacks = 1;
				_ref_new_status._flag_status_stackable = true;

				_ref_new_status._val_status_magnitude = 2;

				_ref_new_status._str_trigger_region = "END";

				//----------------//
				//REGISTER STATUS//
				//----------------//
				ds_list_add(
					_ref_target._list_statuses,
					_ref_new_status
				);

				scr_status_reposition(_ref_target);

				_ref_applied_status = _ref_new_status;
			}

			//========================//
			//APPLICATION PRESENTATION//
			//========================//
			scr_battle_vfx(
				_ref_target,
				spr_battle_vfx_stormstruck,
				undefined,
				undefined,
				32,
				32,
				1,
				0,
				snd_battle_stormstruck
			);

			return _ref_applied_status;

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

				scr_status_dot_stormstruck(
					"DEATH",
					_ref_status
				);

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
