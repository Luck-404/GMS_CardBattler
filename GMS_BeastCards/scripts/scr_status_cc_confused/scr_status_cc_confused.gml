
//===============================================================================//
//
// SCRIPT: SCR_STATUS_CC_CONFUSED
// FUNCTION: Handles Confused.
//           Unstackable Timed CC.
//           Hostile single-Beast cards have a 66% chance to retarget to a
//           DIFFERENT random living Beast from either team.
//           The caster and allies may be selected.
//           Self, Teamwide, Global, Card, and Corpse targets are exempt.
//           Reapplication refreshes duration.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY.
// RETURNS: Status reference or undefined.
//
//===============================================================================//

function scr_status_cc_confused(_str_tag,_ref_status,_val_lifetime=undefined,_ref_target=undefined){

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

			//================//
			//GET CC LIFETIME//
			//================//
			_val_lifetime = scr_cc_get_lifetime(
				_val_lifetime,
				1
			);

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"CONFUSED",
				_ref_target
			);

			//================//
			//REFRESH EXISTING//
			//================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				//------------------//
				//REFRESH DURATION//
				//------------------//
				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				//--------------------//
				//UPDATE DESCRIPTION//
				//--------------------//
				_ref_existing_status._str_status_desc =
					"66% CHANCE: HOSTILE SINGLE-BEAST CARDS " +
					"RETARGET TO A DIFFERENT LIVING BEAST ON EITHER TEAM, " +
					"INCLUDING SELF. SELF, TEAMWIDE, GLOBAL, CARD, AND " +
					"CORPSE TARGETS ARE UNAFFECTED.";

				//-----------------------//
				//ENSURE PERSISTENT VFX//
				//-----------------------//
				if (!instance_exists(_ref_existing_status._ref_persistent_vfx)){

					_ref_existing_status._ref_persistent_vfx = scr_battle_vfx_persistent(
						_ref_target,
						spr_battle_vfx_confused,
						0,
						-20,
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

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_cc_confused;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "CC";
			_ref_new_status._str_status_name = "CONFUSED";

			_ref_new_status._str_status_desc =
				"66% CHANCE: HOSTILE SINGLE-BEAST CARDS " +
				"RETARGET TO A DIFFERENT LIVING BEAST ON EITHER TEAM, " +
				"INCLUDING SELF. SELF, TEAMWIDE, GLOBAL, CARD, AND " +
				"CORPSE TARGETS ARE UNAFFECTED.";

			_ref_new_status._spr_status = spr_status_cc_confused;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = 66;

			_ref_new_status._flag_status_stackable = false;
			_ref_new_status._str_trigger_region = "END";

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
				spr_battle_vfx_confused,
				0,
				-20,
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