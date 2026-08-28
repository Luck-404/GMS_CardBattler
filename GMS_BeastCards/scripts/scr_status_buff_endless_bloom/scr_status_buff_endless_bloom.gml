//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_ENDLESS_BLOOM
// FUNCTION: Handles the Endless Bloom global team Buff.
//           Unstackable Timed.
//           Records which team is protected by Endless Bloom.
//           Minion death handling queries this status separately.
//
//===============================================================================//

function scr_status_buff_endless_bloom(
	_str_tag,
	_ref_status,
	_val_magnitude=undefined,
	_val_lifetime=undefined
){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			if (_val_lifetime == undefined){
				_val_lifetime = 6;
			}

			_val_lifetime =
				max(
					1,
					_val_lifetime
				);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_check_for_status(
					"ENDLESS_BLOOM",
					global.list_statuses
				);

			//------------------//
			//REFRESH EXISTING//
			//------------------//
			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status =
				instance_create_layer(
					room_width * 0.5,
					room_height * 0.5,
					"ily_status",
					obj_battle_status
				);

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			_ref_new_status._scr_status =
				scr_status_buff_endless_bloom;

			_ref_new_status._ref_host =
				undefined;

			_ref_new_status._str_status_type =
				"GLOBAL";

			_ref_new_status._str_status_name =
				"ENDLESS_BLOOM";

			_ref_new_status._str_status_desc =
				"ALLIED MINION DEATHS CREATE INHERITED DORMANT SEEDS";

			_ref_new_status._spr_status =
				spr_status_buff_endless_bloom;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._str_trigger_region =
				"END";

			//----------------//
			//STORE BUFF TEAM//
			//----------------//
			if (instance_exists(global.ref_caster_beast)){

				_ref_new_status._str_status_team =
					global.ref_caster_beast._str_team;
			}
			else{

				_ref_new_status._str_status_team =
					"PLAYER";
			}

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				global.list_statuses,
				_ref_new_status
			);

			scr_reposition_statuses(
				global.list_statuses
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

			scr_status_tick_lifetime(
				_ref_status
			);

			scr_reposition_statuses(
				global.list_statuses
			);

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