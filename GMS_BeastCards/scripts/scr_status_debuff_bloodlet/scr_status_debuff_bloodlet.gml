//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_BLOODLET
// FUNCTION: Handles the Bloodlet Debuff.
//           Stackable Infinite and cleansable.
//           While Bloodlet is present, Bleed applications are doubled.
//           Healing received is reduced by 2 HP per Bloodlet stack.
//
// ARGUMENTS: _str_tag selects the Status action.
//            _ref_status references an existing Bloodlet Status.
//            _val_lifetime is retained for dispatcher compatibility.
// RETURNS: The active Bloodlet Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_debuff_bloodlet(_str_tag,_ref_status,_val_lifetime=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			//----------------//
			//VALIDATE TARGET//
			//----------------//
			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("BLOODLET",_ref_target);

			//================//
			//STACK EXISTING//
			//================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._ct_status_stacks++;

				_ref_existing_status._str_status_desc =
					"BLEED APPLICATIONS ARE DOUBLED; HEALING RECEIVED -" +
					string(_ref_existing_status._ct_status_stacks * 2) +
					". PERMANENT.";

				scr_status_reposition(_ref_target);

				return _ref_existing_status;
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

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				true,
				true
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_debuff_bloodlet;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "DEBUFF";
			_ref_new_status._str_status_name = "BLOODLET";
			_ref_new_status._str_status_desc = "BLEED APPLICATIONS ARE DOUBLED; HEALING RECEIVED -2. PERMANENT.";

			_ref_new_status._spr_status = spr_status_debuff_bloodlet;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = true;
			_ref_new_status._flag_status_uncleansable = false;

			_ref_new_status._val_status_magnitude = 2;

			_ref_new_status._str_trigger_region = undefined;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

			return _ref_new_status;

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