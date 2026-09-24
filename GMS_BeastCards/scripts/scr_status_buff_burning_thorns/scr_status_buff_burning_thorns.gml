
//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_BURNING_THORNS
// FUNCTION: Handles Burning Thorns.
//           Unstackable timed Buff lasting 3 rounds by default.
//           The next enemy Attack that directly damages the host
//           applies 1 Burn to the attacker.
//           The Buff is consumed after triggering.
//           Reapplication refreshes its lifetime.
//           Lifetime decrements at START.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged:
//            _val_magnitude=undefined, _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY.
//            Other commands use the stored Status host.
// RETURNS: Command-specific Status reference or undefined.
//
//===============================================================================//

function scr_status_buff_burning_thorns(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_target=undefined){

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

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"BURNING_THORNS",
				_ref_target
			);

			//==================//
			//REFRESH EXISTING//
			//==================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				//=======================//
				//ENSURE PERSISTENT VFX//
				//=======================//
				if (!instance_exists(_ref_existing_status._ref_persistent_vfx)){

					_ref_existing_status._ref_persistent_vfx =
						scr_battle_vfx_persistent(
							_ref_target,
							spr_battle_vfx_thorns,
							0,
							-65,
							1
						);
				}

				return _ref_existing_status;
			}

			//===============//
			//CREATE STATUS//
			//===============//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			//=====================//
			//INITIALIZE LIFETIME//
			//=====================//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status =
				scr_status_buff_burning_thorns;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "BURNING_THORNS";
			_ref_new_status._str_status_desc =
				"THE NEXT ENEMY THAT DIRECTLY DAMAGES THIS BEAST GAINS 1 BURN";

			_ref_new_status._spr_status =
				spr_status_buff_thorns;

			_ref_new_status._ct_status_stacks = 1;

			_ref_new_status._str_trigger_region = "START";

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

			//================//
			//PERSISTENT VFX//
			//================//
			_ref_new_status._ref_persistent_vfx =
				scr_battle_vfx_persistent(
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

			//================//
			//TICK LIFETIME//
			//================//
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