
//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_MOLTEN_AEGIS
// FUNCTION: Handles Molten Aegis.
//           Infinite Stackable Buff with no charge cap.
//           Each application adds charges to the existing Status.
//           Each successfully resolved Attack applies 1 Burn to every
//           living Beast affected by that Attack and consumes 1 charge.
//           The Status is destroyed when its final charge is consumed.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/CONSUME/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_magnitude is the number of charges granted on APPLY.
//            _val_lifetime is retained for caller compatibility.
//            _ref_target is the explicit host ONLY for APPLY.
// RETURNS: Status reference, consumption result, or undefined.
//
//===============================================================================//

function scr_status_buff_molten_aegis(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_target=undefined){

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
			if (_val_magnitude == undefined){
				_val_magnitude = 1;
			}

			var _ct_charges_added = max(1,floor(_val_magnitude));

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"MOLTEN_AEGIS",
				_ref_target
			);

			//================//
			//ADD CHARGES//
			//================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				_ref_existing_status._ct_status_stacks += _ct_charges_added;

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

			//===================//
			//INFINITE LIFETIME//
			//===================//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				true,
				true
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_molten_aegis;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "MOLTEN_AEGIS";

			_ref_new_status._str_status_desc =
				"EACH ATTACK APPLIES 1 BURN AND CONSUMES 1 CHARGE";

			_ref_new_status._spr_status = spr_status_buff_molten_aegis;

			//================//
			//CHARGE DATA//
			//================//
			_ref_new_status._ct_status_stacks = _ct_charges_added;

			// Burn magnitude is fixed at 1.
			// The stack count represents charges, not Burn intensity.
			_ref_new_status._val_status_magnitude = 1;

			_ref_new_status._flag_status_permanent = false;

			_ref_new_status._str_trigger_region = undefined;

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

			if (
				instance_exists(_ref_status) &&
				instance_exists(_ref_status._ref_host)
			){
				scr_status_reposition(_ref_status._ref_host);
			}

		break;

		//=========//
		//CONSUME//
		//=========//
		case "CONSUME":

			//-----------------//
			//VALIDATE STATUS//
			//-----------------//
			if (!instance_exists(_ref_status)){
				return false;
			}

			if (_ref_status._ct_status_stacks <= 0){
				return false;
			}

			//================//
			//CONSUME 1 CHARGE//
			//================//
			_ref_status._ct_status_stacks--;

			//================//
			//REMOVE LAST CHARGE//
			//================//
			if (_ref_status._ct_status_stacks <= 0){

				scr_status_buff_molten_aegis(
					"DEATH",
					_ref_status
				);

				return true;
			}

			//================//
			//REFRESH STATUS ICONS//
			//================//
			var _ref_host = _ref_status._ref_host;

			if (instance_exists(_ref_host)){
				scr_status_reposition(_ref_host);
			}

			return true;

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