//===============================================================================//
//
// SCRIPT: SCR_STATUS_DOT_BLEED
// FUNCTION: Handles the Bleed damage-over-time Status.
//           Stackable Timed.
//           Deals one hit equal to the current Bleed stack count.
//           Reapplications add Bleed and refresh to the stored maximum life.
//           Bloodlet doubles the amount of Bleed added per application.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_lifetime=undefined, _flag_trigger_plague_garden=true.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_dot_bleed(_str_tag,_ref_status,_val_lifetime=undefined,_flag_trigger_plague_garden=true,_ref_target=undefined){

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
			if (_val_lifetime == undefined){
				_val_lifetime = 4;
			}

			_val_lifetime = max(1,_val_lifetime);

			//================//
			//BLEED AMOUNT//
			//================//
			var _ct_bleed_added = 1;
			var _ref_bloodlet = scr_status_check("BLOODLET",_ref_target);

			if (_ref_bloodlet != -1 && instance_exists(_ref_bloodlet)){
				_ct_bleed_added *= 2;
			}

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("BLEED",_ref_target);
			var _ref_applied_status = undefined;

			//================//
			//STACK EXISTING//
			//================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._ct_status_stacks += _ct_bleed_added;

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				_ref_applied_status = _ref_existing_status;
			}

			//================//
			//CREATE STATUS//
			//================//
			else{

				var _ref_new_status = instance_create_layer(
					_ref_target.x,
					_ref_target.y,
					"ily_status",
					obj_battle_status
				);

				//---------------------//
				//INITIALIZE LIFETIME//
				//---------------------//
				scr_status_init_lifetime(_ref_new_status,_val_lifetime,true,false);

				//-------------//
				//STATUS DATA//
				//-------------//
				_ref_new_status._scr_status = scr_status_dot_bleed;

				_ref_new_status._ref_host = _ref_target;

				_ref_new_status._str_status_type = "DOT";
				_ref_new_status._str_status_name = "BLEED";
				_ref_new_status._str_status_desc = "DEALS DAMAGE EQUAL TO BLEED STACKS";

				_ref_new_status._spr_status = spr_status_dot_bleed;

				_ref_new_status._ct_status_stacks = _ct_bleed_added;
				_ref_new_status._flag_status_stackable = true;

				_ref_new_status._str_trigger_region = "START";

				//----------------//
				//REGISTER STATUS//
				//----------------//
				ds_list_add(_ref_target._list_statuses,_ref_new_status);

				scr_status_reposition(_ref_target);

				_ref_applied_status = _ref_new_status;
			}

			//=================//
			//PLAGUE GARDEN//
			//=================//
			if (_flag_trigger_plague_garden){
				scr_status_trigger_plague_garden(_ref_target,"BLEED");
			}

			//========================//
			//APPLICATION PRESENTATION//
			//========================//
			scr_battle_vfx(
				_ref_target,
				spr_battle_vfx_bleed,
				undefined,
				undefined,
				16,
				16,
				1,
				0,
				snd_battle_bleed
			);

			return _ref_applied_status;

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

				scr_status_dot_bleed("DEATH",_ref_status);

				return undefined;
			}

			//=========================//
			//DAMAGE = CURRENT STACKS//
			//=========================//
			var _val_damage = max(0,_ref_status._ct_status_stacks);

			//============//
			//OVERHEALTH//
			//============//
			if (_val_damage > 0 && _ref_host._val_overhealth > 0){

				var _val_blocked = min(_ref_host._val_overhealth,_val_damage);

				scr_gui_spawn_popup_scrolling(
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

			//=========//
			//HOST HP//
			//=========//
			if (_val_damage > 0){

				var _val_actual_damage = min(_val_damage,_ref_host._val_cur_hp);

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"-" + string(_val_actual_damage),
					undefined,
					c_maroon,
					_ref_host.x + irandom_range(-32,32),
					_ref_host.y - 24 + irandom_range(-32,32)
				);

				_ref_host._val_cur_hp = max(0,_ref_host._val_cur_hp - _val_actual_damage);
			}

			//==========//
			//TICK VFX//
			//==========//
			scr_battle_vfx(
				_ref_host,
				spr_battle_vfx_bleed_tick,
				undefined,
				undefined,
				16,
				16,
				1,
				0,
				snd_battle_bleed
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
