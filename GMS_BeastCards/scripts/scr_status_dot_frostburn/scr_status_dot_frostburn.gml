//===============================================================================//
//
// SCRIPT: SCR_STATUS_DOT_FROSTBURN
// FUNCTION: Handles the Frostburn damage-over-time status.
//           Stackable Infinite.
//           Each application destroys 3 Armor immediately.
//           Each round, deals 2 NEU damage per Frostburn stack.
//           Each round, removes 1 positive Buff from the host.
//
//===============================================================================//

function scr_status_dot_frostburn(
	_str_tag,
	_ref_status,
	_val_lifetime=undefined
){

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

			//----------------//
			//DESTROY 3 ARMOR//
			//----------------//
			var _val_armor_destroyed =
				min(
					3,
					_ref_target._val_armor
				);

			if (_val_armor_destroyed > 0){

				_ref_target._val_armor -=
					_val_armor_destroyed;

				scr_spawn_popup_scrolling(
					"TEXT",
					"-" +
					string(_val_armor_destroyed) +
					" ARMOR",
					undefined,
					c_aqua,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_check_for_status(
					"FROSTBURN",
					_ref_target
				);

			//----------------//
			//STACK EXISTING//
			//----------------//
			if (_ref_existing_status != -1){

				_ref_existing_status._ct_status_stacks++;

				_ref_existing_status._str_status_desc =
					"DEALS " +
					string(
						_ref_existing_status._ct_status_stacks *
						2
					) +
					" NEU DMG EACH ROUND; REMOVES 1 BUFF";

				scr_reposition_statuses(
					_ref_target
				);

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

			//--------------------//
			//INFINITE + STACKABLE//
			//--------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				true,
				true
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status =
				scr_status_dot_frostburn;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"DOT";

			_ref_new_status._str_status_name =
				"FROSTBURN";

			_ref_new_status._str_status_desc =
				"DEALS 2 NEU DMG EACH ROUND; REMOVES 1 BUFF";

			_ref_new_status._spr_status =
				spr_status_dot_frostburn;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._val_status_magnitude =
				2;

			_ref_new_status._str_trigger_region =
				"START";

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

				_ref_status._str_status_command =
					"DEATH";

				return undefined;
			}

			//----------------//
			//CALCULATE DAMAGE//
			//----------------//
			var _val_damage =
				_ref_status._ct_status_stacks *
				_ref_status._val_status_magnitude;

			//------------//
			//OVERHEALTH//
			//------------//
			if (
				_val_damage > 0 &&
				_ref_host._val_overhealth > 0
			){

				var _val_blocked =
					min(
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

				_ref_host._val_overhealth -=
					_val_blocked;

				_val_damage -=
					_val_blocked;
			}

			//---------//
			//HOST HP//
			//---------//
			if (
				_val_damage > 0 &&
				_ref_host._val_cur_hp > 0
			){

				var _val_actual_damage =
					min(
						_val_damage,
						_ref_host._val_cur_hp
					);

				scr_spawn_popup_scrolling(
					"TEXT",
					"-" + string(_val_actual_damage),
					undefined,
					c_aqua,
					_ref_host.x + irandom_range(-32,32),
					_ref_host.y - 24 + irandom_range(-32,32)
				);

				_ref_host._val_cur_hp =
					max(
						0,
						_ref_host._val_cur_hp -
						_val_actual_damage
					);
			}

			//------------------------//
			//REMOVE 1 POSITIVE BUFF//
			//------------------------//
			if (
				instance_exists(_ref_host) &&
				_ref_host._val_cur_hp > 0
			){

				scr_cleanse_buff(
					_ref_host,
					1
				);
			}

			//----------------//
			//PLAY ANIMATION//
			//----------------//

			//-----------//
			//PLAY SOUND//
			//-----------//
			audio_play_sound(
				snd_attack,
				0,
				false
			);

			//----------------//
			//TICK LIFETIME//
			//----------------//
			scr_status_tick_lifetime(
				_ref_status
			);

			scr_reposition_statuses(
				_ref_host
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