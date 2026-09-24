//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_REGENERATION
// FUNCTION: Handles Regeneration.
//           Stackable Timed Buff.
//           Each application adds its healing amount to the stored total.
//           At the start of each round, heals for the combined Magnitude.
//           Reapplication adds one stack and refreshes duration.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_magnitude=undefined, _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_regeneration(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_target=undefined){

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

			//----------//
			//DEFAULTS//
			//----------//
			if (_val_magnitude == undefined){
				_val_magnitude = 1;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_magnitude = max(1,_val_magnitude);
			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("REGENERATION",_ref_target);

			//----------------//
			//STACK EXISTING//
			//----------------//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._ct_status_stacks++;
				_ref_existing_status._val_status_magnitude += _val_magnitude;

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				_ref_existing_status._str_status_desc =
					"HEAL " +
					string(_ref_existing_status._val_status_magnitude) +
					" HP AT ROUND START";

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
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
			_ref_new_status._scr_status = scr_status_buff_regeneration;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "REGENERATION";
			_ref_new_status._str_status_desc = "HEAL " + string(_val_magnitude) + " HP AT ROUND START";

			_ref_new_status._spr_status = spr_status_buff_regeneration;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = _val_magnitude;

			_ref_new_status._flag_status_stackable = true;

			_ref_new_status._str_trigger_region = "START";

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

			//-----------//
			//HEAL HOST//
			//-----------//
			scr_battle_heal_target(
				"FIXED",
				_ref_status._val_status_magnitude,
				_ref_host
			);

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
