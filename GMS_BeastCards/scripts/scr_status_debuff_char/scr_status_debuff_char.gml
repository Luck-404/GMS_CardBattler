//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_CHAR
// FUNCTION: Handles the Char Debuff.
//           Stackable Infinite and uncleansable.
//           Each stack reduces outgoing linear damage by 1.
//           Owns the persistent Char VFX.
//
// ARGUMENTS: _str_tag selects the Status action.
//            _ref_status references an existing Char Status.
//            _val_lifetime is retained for dispatcher compatibility.
// RETURNS: The active Char Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_debuff_char(_str_tag,_ref_status,_val_lifetime=undefined){

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
			var _ref_existing_status = scr_status_check("CHAR",_ref_target);

			//================//
			//STACK EXISTING//
			//================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._ct_status_stacks++;

				_ref_target._val_dmg_linear_reduction += _ref_existing_status._val_status_magnitude;

				_ref_existing_status._str_status_desc =
					"-" +
					string(_ref_existing_status._ct_status_stacks * _ref_existing_status._val_status_magnitude) +
					" OUTGOING DAMAGE. PERMANENT.";

				//-----------------------//
				//ENSURE PERSISTENT VFX//
				//-----------------------//
				if (!instance_exists(_ref_existing_status._ref_persistent_vfx)){
					_ref_existing_status._ref_persistent_vfx = scr_battle_vfx_persistent(_ref_target,spr_battle_vfx_char,0,0,1);
				}

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
			scr_status_init_lifetime(_ref_new_status,-1,true,true);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_debuff_char;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "DEBUFF";
			_ref_new_status._str_status_name = "CHAR";
			_ref_new_status._str_status_desc = "-1 OUTGOING DAMAGE PER STACK. PERMANENT.";

			_ref_new_status._spr_status = spr_battle_vfx_char;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = true;
			_ref_new_status._flag_status_uncleansable = true;

			_ref_new_status._val_status_magnitude = 1;

			_ref_new_status._str_trigger_region = undefined;

			//=========================//
			//APPLY DAMAGE REDUCTION//
			//=========================//
			_ref_target._val_dmg_linear_reduction += _ref_new_status._val_status_magnitude;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(_ref_target._list_statuses,_ref_new_status);

			scr_status_reposition(_ref_target);

			//================//
			//PERSISTENT VFX//
			//================//
			_ref_new_status._ref_persistent_vfx = scr_battle_vfx_persistent(_ref_target,spr_battle_vfx_char,0,0,1);

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

			//=========================//
			//REMOVE DAMAGE REDUCTION//
			//=========================//
			if (instance_exists(_ref_host)){

				var _val_total_reduction =
					_ref_status._val_status_magnitude *
					_ref_status._ct_status_stacks;

				_ref_host._val_dmg_linear_reduction -= _val_total_reduction;
			}

			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}