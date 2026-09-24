
//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_THORNS
// FUNCTION: Handles Thorns.
//           Stackable Timed Buff with START decrement.
//           Melee attackers receive stored neutral damage.
//           Each reapplication adds 1 stack and adds its magnitude to
//           the existing total damage, then refreshes duration.
//           Retaliation is resolved by scr_status_trigger_thorns().
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged:
//            _val_magnitude=undefined, _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_thorns(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_target=undefined){

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

			//----------//
			//DEFAULTS//
			//----------//
			if (_val_magnitude == undefined){
				_val_magnitude = 3;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_magnitude = max(0,_val_magnitude);
			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check(
				"THORNS",
				_ref_target
			);

			//================//
			//STACK EXISTING//
			//================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				//----------------//
				//ADD 1 STACK//
				//----------------//
				_ref_existing_status._ct_status_stacks++;

				//----------------------//
				//ADD DAMAGE MAGNITUDE//
				//----------------------//
				// Magnitudes are additive, not replaced or multiplied
				// by the stack count.

				_ref_existing_status._val_status_magnitude +=
					_val_magnitude;

				//----------------//
				//REFRESH LIFE//
				//----------------//
				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				//--------------------//
				//UPDATE DESCRIPTION//
				//--------------------//
				_ref_existing_status._str_status_desc =
					"MELEE ATTACKERS TAKE " +
					string(_ref_existing_status._val_status_magnitude) +
					" NEUTRAL DAMAGE";

				//-----------------------//
				//ENSURE PERSISTENT VFX//
				//-----------------------//
				if (!instance_exists(_ref_existing_status._ref_persistent_vfx)){

					_ref_existing_status._ref_persistent_vfx = scr_battle_vfx_persistent(
						_ref_target,
						spr_battle_vfx_thorns,
						0,
						-65,
						1
					);
				}

				scr_status_reposition(_ref_target);

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
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				true,
				false
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_buff_thorns;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "THORNS";

			_ref_new_status._str_status_desc =
				"MELEE ATTACKERS TAKE " +
				string(_val_magnitude) +
				" NEUTRAL DAMAGE";

			_ref_new_status._spr_status = spr_status_buff_thorns;

			//----------------//
			//STACK DATA//
			//----------------//
			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = true;

			// Total retaliation damage across all applications.
			_ref_new_status._val_status_magnitude = _val_magnitude;

			//------------------//
			//START DECREMENT//
			//------------------//
			_ref_new_status._str_trigger_region = "START";

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

			//----------------//
			//PERSISTENT VFX//
			//----------------//
			_ref_new_status._ref_persistent_vfx = scr_battle_vfx_persistent(
				_ref_target,
				spr_battle_vfx_thorns,
				0,
				-65,
				1
			);

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