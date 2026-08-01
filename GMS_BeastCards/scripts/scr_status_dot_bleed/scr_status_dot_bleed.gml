//===============================================================================//
//
// SCRIPT: SCR_STATUS_DOT_BLEED
// FUNCTION: Handles the Bleed damage-over-time status.
//           Deals one hit equal to the current Bleed stack count.
//           Lasts 4 turns and refreshes to 4 turns when another stack is added.
//
//===============================================================================//
function scr_status_dot_bleed(_str_tag,_ref_status){

	switch(_str_tag){

		//-------//
		// APPLY //
		//-------//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			//--------------------//
			//STACK EXISTING BLEED//
			//--------------------//
			var _ref_existing_status = scr_check_for_status(
				"BLEED",
				_ref_target
			);

			if (_ref_existing_status != -1){

				_ref_existing_status._val_status_lifetime = 4;
				_ref_existing_status._ct_status_stacks++;

				return _ref_existing_status;
			}

			//----------------//
			//CREATE NEW BLEED//
			//----------------//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			_ref_new_status._val_status_lifetime = 4;
			_ref_new_status._scr_status = scr_status_dot_bleed;
			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "DOT";
			_ref_new_status._str_status_name = "BLEED";
			_ref_new_status._str_status_desc = "DEALS DAMAGE EQUAL TO BLEED STACKS";

			_ref_new_status._spr_status = spr_status_dot_bleed;

			_ref_new_status._ct_status_stacks = 1;

			_ref_new_status._str_trigger_region = "START";

			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_reposition_statuses(_ref_target);

			return _ref_new_status;

		break;


		//--------//
		// REPEAT //
		//--------//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				_ref_status._str_status_command = "DEATH";
				return undefined;
			}

			//--------------------------//
			//DAMAGE = CURRENT STACKS//
			//--------------------------//
			var _val_damage = _ref_status._ct_status_stacks;

			audio_play_sound(snd_attack,0,false);

			//------------//
			// OVERHEALTH //
			//------------//
			if (
				_val_damage > 0 &&
				_ref_host._val_overhealth > 0
			){

				var _val_blocked = min(
					_ref_host._val_overhealth,
					_val_damage
				);

				scr_spawn_popup_scrolling(
					"TEXT",
					"-" + string(_val_blocked),
					undefined,
					c_green,
					_ref_host.x + irandom_range(-32,32),
					_ref_host.y - 24 + irandom_range(-32,32)
				);

				_ref_host._val_overhealth -= _val_blocked;
				_val_damage -= _val_blocked;
			}

			//---------//
			// HOST HP //
			//---------//
			if (_val_damage > 0){

				var _val_actual_damage = min(
					_val_damage,
					_ref_host._val_cur_hp
				);

				scr_spawn_popup_scrolling(
					"TEXT",
					"-" + string(_val_actual_damage),
					undefined,
					c_maroon,
					_ref_host.x + irandom_range(-32,32),
					_ref_host.y - 24 + irandom_range(-32,32)
				);

				_ref_host._val_cur_hp = max(
					0,
					_ref_host._val_cur_hp - _val_actual_damage
				);
			}

			//----------//
			// LIFETIME //
			//----------//
			_ref_status._val_status_lifetime--;

			if (_ref_status._val_status_lifetime <= 0){
				_ref_status._str_status_command = "DEATH";
			}
			else{
				_ref_status._str_status_command = "WAIT";
			}

			scr_reposition_statuses(_ref_host);

		break;


		//-------//
		// DEATH //
		//-------//
		case "DEATH":

			if (instance_exists(_ref_status)){
				scr_destroy_status(_ref_status);
			}

		break;
	}

	return undefined;
}