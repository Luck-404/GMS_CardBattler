//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_REDIRECT
// FUNCTION: Handles Redirect.
//           Unstackable Infinite Buff.
//           Stores a linked Beast that receives the host's next incoming
//           damage instance.
//           Redirect is consumed when successfully triggered.
//
//===============================================================================//

function scr_status_buff_redirect(_str_tag,_ref_status){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			var _ref_target = global.ref_target_beast;
			var _ref_redirect_target = global.ref_caster_beast;

			//------------------//
			//VALIDATE TARGETS//
			//------------------//
			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!instance_exists(_ref_redirect_target)){
				return undefined;
			}

			if (_ref_target == _ref_redirect_target){
				return undefined;
			}

			if (
				_ref_target._str_list != "ALIVE" ||
				_ref_target._val_cur_hp <= 0
			){
				return undefined;
			}

			if (
				_ref_redirect_target._str_list != "ALIVE" ||
				_ref_redirect_target._val_cur_hp <= 0
			){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("REDIRECT",_ref_target);

			//------------------//
			//UPDATE EXISTING//
			//------------------//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._ref_status_target = _ref_redirect_target;

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

			//-------------------//
			//INFINITE LIFETIME//
			//-------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_buff_redirect;

			_ref_new_status._ref_host = _ref_target;
			_ref_new_status._ref_status_target = _ref_redirect_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "REDIRECT";
			_ref_new_status._str_status_desc = "NEXT DAMAGE INSTANCE IS REDIRECTED";

			_ref_new_status._spr_status = spr_status_buff_redirect;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

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

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			// Infinite event-bound Buff.
			// Does not process each turn.

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