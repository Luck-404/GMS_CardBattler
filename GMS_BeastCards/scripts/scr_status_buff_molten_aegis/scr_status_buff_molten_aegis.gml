//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_MOLTEN_AEGIS
// FUNCTION: Handles Molten Aegis.
//           Infinite unstackable Buff.
//           The host's next successfully resolved Attack applies 1 Burn to
//           each living Beast affected by that Attack, then consumes the Buff.
//
// ARGUMENTS: _str_tag selects the Status action.
//            _ref_status references an existing Molten Aegis Status.
//            _val_magnitude is the Burn applied when triggered.
//            _val_lifetime is unused because Molten Aegis is infinite.
// RETURNS: Active Molten Aegis Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_buff_molten_aegis(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined){

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

			_val_magnitude = max(1,floor(_val_magnitude));

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check("MOLTEN_AEGIS",_ref_target);

			//------------------//
			//UNSTACKABLE BUFF//
			//------------------//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				_ref_existing_status._val_status_magnitude = _val_magnitude;

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

			//===================//
			//INFINITE LIFETIME//
			//===================//
			scr_status_init_lifetime(_ref_new_status,-1,false,true);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_molten_aegis;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "MOLTEN_AEGIS";
			_ref_new_status._str_status_desc = "NEXT ATTACK APPLIES 1 BURN";

			_ref_new_status._spr_status = spr_status_buff_molten_aegis;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;
			_ref_new_status._flag_status_permanent = false;

			_ref_new_status._val_status_magnitude = _val_magnitude;

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

			if (
				instance_exists(_ref_status) &&
				instance_exists(_ref_status._ref_host)
			){
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