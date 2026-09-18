//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_CINDERGUARD
// FUNCTION: Handles Cinderguard.
//           Stackable Infinite Buff.
//           Each stack represents one reactive charge.
//           The next enemy that directly damages the host gains 1 Burn and
//           consumes one Cinderguard stack.
//
// ARGUMENTS: _str_tag selects the Status action.
//            _ref_status references an existing Cinderguard Status.
//            _val_magnitude is the number of charges added.
//            _val_lifetime is unused because Cinderguard is infinite.
// RETURNS: Active Cinderguard Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_buff_cinderguard(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined){

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

			//==========//
			//DEFAULTS//
			//==========//
			if (_val_magnitude == undefined){
				_val_magnitude = 1;
			}

			var _ct_charges = max(1,floor(_val_magnitude));

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check("CINDERGUARD",_ref_target);

			//================//
			//ADD CHARGES//
			//================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._ct_status_stacks += _ct_charges;

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

			//=====================//
			//INFINITE LIFETIME//
			//=====================//
			scr_status_init_lifetime(_ref_new_status,-1,false,true);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_cinderguard;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "CINDERGUARD";
			_ref_new_status._str_status_desc = "NEXT ENEMY THAT DIRECTLY DAMAGES THIS BEAST GAINS 1 BURN PER CHARGE";

			_ref_new_status._spr_status = spr_status_buff_thorns;

			_ref_new_status._ct_status_stacks = _ct_charges;
			_ref_new_status._flag_status_stackable = true;

			_ref_new_status._str_trigger_region = undefined;

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(_ref_target._list_statuses,_ref_new_status);

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

			if (instance_exists(_ref_status._ref_host)){
				scr_status_reposition(_ref_status._ref_host);
			}

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