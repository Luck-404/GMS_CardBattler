//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_PAIN_RESPONSE
// FUNCTION: Handles Pain Response.
//           Unstackable timed Buff lasting 2 rounds.
//           First HP damage received each battle round grants 1 Rage.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_magnitude=undefined, _val_lifetime=undefined, _val_hp_damage=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_pain_response(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_val_hp_damage=undefined,_ref_target=undefined){

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

			if (_val_lifetime == undefined){
				_val_lifetime = 2;
			}

			_val_magnitude = max(1,floor(_val_magnitude));
			_val_lifetime = max(1,floor(_val_lifetime));

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"PAIN_RESPONSE",
				_ref_target
			);

			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				//------------------//
				//REFRESH DURATION//
				//------------------//
				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				// Preserve _ct_pain_response_last_round.
				// Reapplication cannot grant another Rage
				// during the same round.

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
				false,
				false
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_pain_response;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "PAIN_RESPONSE";

			_ref_new_status._str_status_desc =
				"FIRST HP DAMAGE EACH ROUND: GAIN 1 RAGE";

			_ref_new_status._spr_status = spr_status_buff_pain_response;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._val_status_magnitude = _val_magnitude;

			_ref_new_status._str_trigger_region = "START";

			//======================//
			//TRACK LAST TRIGGER//
			//======================//
			_ref_new_status._ct_pain_response_last_round = -1;

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

		//=========//
		//TRIGGER//
		//=========//
		case "TRIGGER":

			//----------------//
			//VALIDATE STATUS//
			//----------------//
			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			//----------------//
			//VALIDATE DAMAGE//
			//----------------//
			if (
				_val_hp_damage == undefined ||
				_val_hp_damage <= 0
			){
				return false;
			}

			//------------------//
			//VALIDATE SURVIVAL//
			//------------------//
			if (_ref_host._val_cur_hp <= 0){
				return false;
			}

			//------------------//
			//VALIDATE LIFETIME//
			//------------------//
			if (
				_ref_status._val_status_lifetime <= 0 ||
				_ref_status._str_status_command == "DEATH"
			){
				return false;
			}

			//---------------------//
			//VALIDATE CONTROLLER//
			//---------------------//
			if (!instance_exists(obj_battle_turn_controller)){
				return false;
			}

			//================//
			//GET ROUND//
			//================//
			var _ct_current_round = obj_battle_turn_controller._ct_round;

			//======================//
			//CHECK PREVIOUS TRIGGER//
			//======================//
			if (
				_ref_status._ct_pain_response_last_round ==
				_ct_current_round
			){
				return false;
			}

			//================//
			//MARK TRIGGER//
			//================//
			_ref_status._ct_pain_response_last_round = _ct_current_round;

			//==========//
			//FEEDBACK//
			//==========//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"PAIN RESPONSE",
				undefined,
				c_red,
				_ref_host.x,
				_ref_host.y - 48
			);

			//================//
			//GAIN RAGE//
			//================//
			scr_status_gain_rage(
				_ref_host,
				_ref_status._val_status_magnitude
			);

			return true;

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
