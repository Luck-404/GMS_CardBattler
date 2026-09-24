
//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_VULNERABLE
// FUNCTION: Handles the Vulnerable Debuff.
//           Stackable Timed Debuff.
//           Each stack increases incoming damage by 25%.
//           Reapplication adds 1 stack and refreshes duration without
//           shortening the current effect.
//           Removes the entire accumulated damage bonus on DEATH.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY.
// RETURNS: Status reference or undefined.
//
//===============================================================================//

function scr_status_debuff_vulnerable(_str_tag,_ref_status,_val_lifetime=undefined,_ref_target=undefined){

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
				"VULNERABLE",
				_ref_target
			);

			//================//
			//STACK EXISTING//
			//================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				//================//
				//ADD 1 STACK//
				//================//
				_ref_existing_status._ct_status_stacks++;
				_ref_existing_status._flag_status_stackable = true;

				//=========================//
				//INCREASE DAMAGE TAKEN//
				//=========================//
				// Apply only the NEW stack's bonus.
				// Previous stacks are already included in the host scalar.

				_ref_target._val_dmg_taken_scalar_bonus +=
					_ref_existing_status._val_status_magnitude;

				//================//
				//REFRESH LIFETIME//
				//================//
				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				//================//
				//UPDATE DESCRIPTION//
				//================//
				var _val_total_bonus =
					_ref_existing_status._val_status_magnitude *
					_ref_existing_status._ct_status_stacks;

				_ref_existing_status._str_status_desc =
					"TAKES " +
					string(_val_total_bonus) +
					"% ADDITIONAL DAMAGE";

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
			_ref_new_status._scr_status = scr_status_debuff_vulnerable;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "DEBUFF";
			_ref_new_status._str_status_name = "VULNERABLE";

			_ref_new_status._spr_status = spr_status_debuff_vulnerable;

			//================//
			//STACK DATA//
			//================//
			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = true;

			// Magnitude is the damage bonus PER STACK.
			_ref_new_status._val_status_magnitude = 25;

			//================//
			//DESCRIPTION//
			//================//
			_ref_new_status._str_status_desc =
				"TAKES " +
				string(_ref_new_status._val_status_magnitude) +
				"% ADDITIONAL DAMAGE";

			//================//
			//TRIGGER TIMING//
			//================//
			_ref_new_status._str_trigger_region = "END";

			//=========================//
			//INCREASE DAMAGE TAKEN//
			//=========================//
			_ref_target._val_dmg_taken_scalar_bonus +=
				_ref_new_status._val_status_magnitude;

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

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			//=======================//
			//REMOVE DAMAGE PENALTY//
			//=======================//
			if (instance_exists(_ref_host)){

				var _val_total_bonus =
					_ref_status._val_status_magnitude *
					_ref_status._ct_status_stacks;

				_ref_host._val_dmg_taken_scalar_bonus -=
					_val_total_bonus;
			}

			//================//
			//DESTROY STATUS//
			//================//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}