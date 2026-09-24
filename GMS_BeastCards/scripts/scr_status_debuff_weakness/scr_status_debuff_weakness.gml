//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_WEAKNESS
// FUNCTION: Handles the Weakness Debuff.
//           Stackable Timed.
//           Each stack reduces outgoing linear damage by 2.
//           Reapplications add a stack and refresh to the stored maximum life.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_debuff_weakness(_str_tag,_ref_status,_val_lifetime=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":


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

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("WEAKNESS",_ref_target);

			//================//
			//STACK EXISTING//
			//================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._ct_status_stacks++;

				_ref_target._val_dmg_linear_reduction += _ref_existing_status._val_status_magnitude;

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

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
				true,
				false
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_debuff_weakness;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "DEBUFF";
			_ref_new_status._str_status_name = "WEAKNESS";

			_ref_new_status._spr_status = spr_status_debuff_weakness;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = true;

			_ref_new_status._val_status_magnitude = 2;

			_ref_new_status._str_status_desc =
				"-" +
				string(_ref_new_status._val_status_magnitude) +
				" OUTGOING DAMAGE PER STACK";

			_ref_new_status._str_trigger_region = "END";

			//=========================//
			//APPLY DAMAGE REDUCTION//
			//=========================//
			_ref_target._val_dmg_linear_reduction += _ref_new_status._val_status_magnitude;

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
