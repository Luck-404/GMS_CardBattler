//===============================================================================//
//
// SCRIPT: SCR_STATUS_DOT_BURN
// FUNCTION: Handles the Burn damage-over-time status.
//           Applies or stacks Burn on the target battle beast.
//           Deals 1 damage per stack at turn start and expires over time.
//
//===============================================================================//
function scr_status_dot_burn(_str_tag,_ref_status){

	switch(_str_tag){

		case "APPLY":

			var _ref_target = global.ref_target_beast;

			var _ref_existing_status = scr_check_for_status("BURN",_ref_target);

			if (_ref_existing_status != -1){
				_ref_existing_status._val_status_lifetime = 5;
				_ref_existing_status._ct_status_stacks++;
				return _ref_existing_status;
			}

			var _ref_new_status = instance_create_layer(_ref_target.x,_ref_target.y,"ily_status",obj_battle_status);

			_ref_new_status._val_status_lifetime = 3;
			_ref_new_status._scr_status = scr_status_dot_burn;
			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "DOT";
			_ref_new_status._str_status_name = "BURN";
			_ref_new_status._str_status_desc = "BURNED";
			_ref_new_status._spr_status = spr_status_dot_burn;
			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._str_trigger_region = "START";

			ds_list_add(_ref_target._list_statuses,_ref_new_status);

			scr_reposition_statuses(_ref_target);

		break;

		case "REPEAT":

			var _ct_burn = _ref_status._ct_status_stacks;
			var _ref_host = _ref_status._ref_host;

			repeat (_ct_burn){
				
				audio_play_sound(snd_attack,0,false);
				
				var _val_damage = 1;
				if (_val_damage > 0 && _ref_host._val_overhealth > 0){

					var _val_blocked = min(_ref_host._val_overhealth,_val_damage);

					scr_spawn_popup_scrolling("TEXT","-" + string(_val_blocked),undefined,c_green,_ref_host.x + irandom_range(-32,32),_ref_host.y - 24 + irandom_range(-32,32));

					_ref_host._val_overhealth -= _val_blocked;
					_val_damage -= _val_blocked;
				}

				if (_val_damage > 0){

					scr_spawn_popup_scrolling("TEXT","-" + string(_val_damage),undefined,c_maroon,_ref_host.x + irandom_range(-32,32),_ref_host.y - 24 + irandom_range(-32,32));

					_ref_host._val_cur_hp -= _val_damage;
				}
			}
			
			_ref_status._val_status_lifetime--;

			if (_ref_status._val_status_lifetime <= 0){
				_ref_status._str_status_command = "DEATH";
			}
			else{
				_ref_status._str_status_command = "WAIT";
			}

			scr_reposition_statuses(_ref_host);

		break;

		case "DEATH":

			scr_destroy_status(_ref_status);

		break;
	}
}