//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_WITHER
// FUNCTION: Handles the Wither Debuff.
//           Unstackable Timed.
//           Reduces current HP and Maximum HP by 25% when first applied.
//           Reapplication refreshes duration without applying the HP loss again.
//           Restores Maximum HP when removed, but does not restore lost current HP.
//
//===============================================================================//
function scr_status_debuff_wither(_str_tag,_ref_status,_val_lifetime=undefined){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			//----------------//
			//DEFAULT LENGTH//
			//----------------//
			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_check_for_status("WITHER",_ref_target);

			//------------------//
			//REFRESH EXISTING//
			//------------------//
			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(_ref_existing_status,_val_lifetime);

				return _ref_existing_status;
			}

			//-------------------------//
			//CALCULATE MAX HP REDUCTION//
			//-------------------------//
			var _val_max_hp_reduction = 0;

			if (_ref_target._val_max_hp > 1){

				_val_max_hp_reduction =
					round(
						_ref_target._val_max_hp *
						0.25
					);

				_val_max_hp_reduction =
					clamp(
						_val_max_hp_reduction,
						1,
						_ref_target._val_max_hp - 1
					);
			}

			//-----------------------------//
			//CALCULATE CURRENT HP REDUCTION//
			//-----------------------------//
			var _val_cur_hp_reduction = 0;

			if (_ref_target._val_cur_hp > 1){

				_val_cur_hp_reduction =
					round(
						_ref_target._val_cur_hp *
						0.25
					);

				_val_cur_hp_reduction =
					clamp(
						_val_cur_hp_reduction,
						0,
						_ref_target._val_cur_hp - 1
					);
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

			_ref_new_status._scr_status =
				scr_status_debuff_wither;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"DEBUFF";

			_ref_new_status._str_status_name =
				"WITHER";

			_ref_new_status._str_status_desc =
				"CURRENT HP -25%; MAXIMUM HP -25%";

			_ref_new_status._spr_status =
				spr_status_debuff_wither;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._val_status_magnitude =
				0.25;

			_ref_new_status._val_wither_max_hp_reduction =
				_val_max_hp_reduction;

			_ref_new_status._val_wither_cur_hp_reduction =
				_val_cur_hp_reduction;

			_ref_new_status._str_trigger_region =
				"END";

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(_ref_new_status,_val_lifetime,false,false);

			//------------------//
			//REDUCE MAXIMUM HP//
			//------------------//
			_ref_target._val_max_hp -=
				_val_max_hp_reduction;

			_ref_target._val_max_hp =
				max(
					1,
					_ref_target._val_max_hp
				);

			//----------------//
			//REDUCE CURRENT HP//
			//----------------//
			_ref_target._val_cur_hp -=
				_val_cur_hp_reduction;

			_ref_target._val_cur_hp =
				clamp(
					_ref_target._val_cur_hp,
					1,
					_ref_target._val_max_hp
				);

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(_ref_target._list_statuses,_ref_new_status);

			scr_reposition_statuses(_ref_target);

			return _ref_new_status;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_destroy_status(_ref_status);

				return undefined;
			}

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(_ref_status);

			scr_reposition_statuses(_ref_host);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			//------------------//
			//RESTORE MAXIMUM HP//
			//------------------//
			if (instance_exists(_ref_host)){

				_ref_host._val_max_hp +=
					_ref_status._val_wither_max_hp_reduction;

				_ref_host._val_max_hp =
					max(
						1,
						_ref_host._val_max_hp
					);

				_ref_host._val_cur_hp =
					min(
						_ref_host._val_cur_hp,
						_ref_host._val_max_hp
					);
			}

			//---------------//
			//DESTROY STATUS//
			//---------------//
			scr_destroy_status(_ref_status);

		break;
	}

	return undefined;
}