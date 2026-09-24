
//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_FROZEN_CURSE
// FUNCTION: Handles Frozen Curse.
//           Stackable Timed Debuff.
//           Each stack adds 5 bonus NEU damage when triggered.
//           Reapplication adds 1 stack and refreshes duration.
//           Magnitude stores damage PER STACK.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY.
// RETURNS: Status reference or undefined.
//
//===============================================================================//

function scr_status_debuff_frozen_curse(_str_tag,_ref_status,_val_lifetime=undefined,_ref_target=undefined){

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
				"FROZEN_CURSE",
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
				_ref_existing_status._flag_status_stackable = true;

				//----------------//
				//REFRESH LIFETIME//
				//----------------//
				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				//----------------------//
				//CALCULATE TOTAL BONUS//
				//----------------------//
				var _val_total_bonus =
					_ref_existing_status._val_status_magnitude *
					_ref_existing_status._ct_status_stacks;

				//--------------------//
				//UPDATE DESCRIPTION//
				//--------------------//
				_ref_existing_status._str_status_desc =
					"ATTACKED WHILE FROST-AFFECTED: TAKE " +
					string(_val_total_bonus) +
					" ADDITIONAL NEU DAMAGE (" +
					string(_ref_existing_status._val_status_magnitude) +
					" PER STACK)";

				scr_status_reposition(_ref_target);

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

			//================//
			//INIT LIFETIME//
			//================//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				true,
				false
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_debuff_frozen_curse;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "DEBUFF";
			_ref_new_status._str_status_name = "FROZEN_CURSE";

			_ref_new_status._spr_status = spr_status_debuff_frozen_curse;

			//================//
			//STACK DATA//
			//================//
			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = true;

			// Damage per stack, NOT total damage.
			_ref_new_status._val_status_magnitude = 5;

			//================//
			//DESCRIPTION//
			//================//
			_ref_new_status._str_status_desc =
				"ATTACKED WHILE FROST-AFFECTED: TAKE " +
				string(_ref_new_status._val_status_magnitude) +
				" ADDITIONAL NEU DAMAGE (" +
				string(_ref_new_status._val_status_magnitude) +
				" PER STACK)";

			//================//
			//TRIGGER TIMING//
			//================//
			_ref_new_status._str_trigger_region = "END";

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

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
			//UPDATE LIFETIME//
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