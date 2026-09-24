//===============================================================================//
//
// SCRIPT: SCR_STATUS_AURA_3RD_DEGREE
// FUNCTION: Handles 3rd Degree.
//           Infinite, nonstacking Aura applied to an individual Beast.
//           Increases outgoing damage by 25%.
//           Increases incoming damage by 15%.
//           Reverses its exact contributions when removed.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_magnitude=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_aura_3rd_degree(_str_tag,_ref_status,_val_magnitude=undefined,_ref_target=undefined){

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
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"3RD_DEGREE",
				_ref_target
			);

			//==================//
			//PREVENT DUPLICATES//
			//==================//
			if (_ref_existing_status != -1){

				if (instance_exists(_ref_existing_status)){
					return _ref_existing_status;
				}

				return undefined;
			}

			//================//
			//CREATE STATUS//
			//================//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			//===================//
			//INFINITE LIFETIME//
			//===================//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			//================//
			//STATUS DATA//
			//================//
			_ref_new_status._scr_status = scr_status_aura_3rd_degree;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "AURA";
			_ref_new_status._str_status_name = "3RD_DEGREE";

			_ref_new_status._str_status_desc =
				"OUTGOING DAMAGE +25%. " +
				"INCOMING DAMAGE +15%. " +
				"PERMANENT UNTIL CLEANSED.";

			//================//
			//STATUS SPRITE//
			//================//
			// Uses the dedicated icon when available.
			// Falls back to the existing Boost icon otherwise.

			var _spr_status = asset_get_index(
				"spr_status_aura_3rd_degree"
			);

			if (_spr_status == -1){
				_spr_status = spr_status_buff_boost;
			}

			_ref_new_status._spr_status = _spr_status;

			//================//
			//STATUS RULES//
			//================//
			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._val_status_magnitude = 0;

			//================//
			//AURA RULES//
			//================//
			_ref_new_status._str_aura_scope = "SELF";
			_ref_new_status._str_aura_trigger = undefined;

			_ref_new_status._str_trigger_region = undefined;

			//================//
			//OWNED MODIFIERS//
			//================//
			_ref_new_status._val_damage_bonus = 25;
			_ref_new_status._val_damage_taken_bonus = 15;

			//========================//
			//INCREASE OUTGOING DAMAGE//
			//========================//
			_ref_target._val_dmg_scalar_bonus +=
				_ref_new_status._val_damage_bonus;

			//========================//
			//INCREASE INCOMING DAMAGE//
			//========================//
			_ref_target._val_dmg_taken_scalar_bonus +=
				_ref_new_status._val_damage_taken_bonus;

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			//================//
			//REPOSITION STATUS//
			//================//
			scr_status_reposition(_ref_target);

			return _ref_new_status;

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			//================//
			//VALIDATE STATUS//
			//================//
			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			//================//
			//REMOVE MODIFIERS//
			//================//
			if (instance_exists(_ref_host)){

				//------------------------//
				//REMOVE OUTGOING BONUS//
				//------------------------//
				_ref_host._val_dmg_scalar_bonus -=
					_ref_status._val_damage_bonus;

				//------------------------//
				//REMOVE INCOMING PENALTY//
				//------------------------//
				_ref_host._val_dmg_taken_scalar_bonus -=
					_ref_status._val_damage_taken_bonus;
			}

			//================//
			//DESTROY STATUS//
			//================//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}
