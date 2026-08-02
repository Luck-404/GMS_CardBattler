//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_SECOND_LIFE
// FUNCTION: Handles the Second Life buff.
//           Prevents the host's next defeat while active.
//           Restores the host to 25% maximum HP and consumes the status.
//
//===============================================================================//

function scr_status_buff_second_life(_str_tag,_ref_status,_val_lifetime){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			var _ref_target =
				global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 4;
			}

			_val_lifetime =
				max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_check_for_status(
					"SECOND_LIFE",
					_ref_target
				);

			//----------------//
			//REFRESH STATUS//
			//----------------//
			if (_ref_existing_status != -1){

				_ref_existing_status._val_status_lifetime =
					_val_lifetime;

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status =
				instance_create_layer(
					_ref_target.x,
					_ref_target.y,
					"ily_status",
					obj_battle_status
				);

			_ref_new_status._val_status_lifetime =
				_val_lifetime;

			_ref_new_status._scr_status =
				scr_status_buff_second_life;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"SECOND_LIFE";

			_ref_new_status._str_status_desc =
				"NEXT DEFEAT RESTORES 25% MAXIMUM HP";

			_ref_new_status._spr_status =
				spr_status_buff_second_life;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._str_trigger_region =
				"END";

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_reposition_statuses(
				_ref_target
			);

			return _ref_new_status;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host =
				_ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_destroy_status(
					_ref_status
				);

				return undefined;
			}

			//----------------//
			//REDUCE LIFETIME//
			//----------------//
			_ref_status._val_status_lifetime--;

			if (
				_ref_status._val_status_lifetime <= 0
			){

				_ref_status._str_status_command =
					"DEATH";
			}
			else{

				_ref_status._str_status_command =
					"WAIT";
			}

			scr_reposition_statuses(
				_ref_host
			);

		break;


		//--------//
		//TRIGGER//
		//--------//
		case "TRIGGER":

			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_host =
				_ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			//----------------//
			//RESTORE 25% HP//
			//----------------//
			_ref_host._val_cur_hp =
				max(
					1,
					ceil(
						_ref_host._val_max_hp *
						0.25
					)
				);

			//-------------//
			//SPAWN POPUP//
			//-------------//
			scr_spawn_popup_scrolling(
				"TEXT",
				"SECOND LIFE",
				undefined,
				c_green,
				_ref_host.x,
				_ref_host.y - 48
			);

			audio_play_sound(
				snd_heal,
				0,
				false
			);

			//----------------//
			//CONSUME STATUS//
			//----------------//
			scr_destroy_status(
				_ref_status
			);

			return true;

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (instance_exists(_ref_status)){
				scr_destroy_status(
					_ref_status
				);
			}

		break;
	}

	return undefined;
}