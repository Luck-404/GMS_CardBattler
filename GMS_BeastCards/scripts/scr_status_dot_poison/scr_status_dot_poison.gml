//===============================================================================//
//
// SCRIPT: SCR_STATUS_DOT_POISON
// FUNCTION: Handles the Poison damage-over-time Status.
//           Stackable Timed.
//           Damage increases as Poison ages through its maximum duration.
//           Reapplications add one stack and refresh to the stored maximum life.
//
// ARGUMENTS: _str_tag selects the Status action, _ref_status references an
//            existing Status, _val_lifetime optionally sets duration, and
//            _flag_trigger_plague_garden controls Plague Garden reactions.
// RETURNS: The active Poison Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_dot_poison(_str_tag,_ref_status,_val_lifetime=undefined,_flag_trigger_plague_garden=true){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

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
				_val_lifetime = 5;
			}

			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("POISON",_ref_target);
			var _ref_applied_status = undefined;

			//================//
			//STACK EXISTING//
			//================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._ct_status_stacks++;

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
				scr_status_init_lifetime(
					_ref_new_status,
					_val_lifetime,
					true,
					false
				);

				//-------------//
				//STATUS DATA//
				//-------------//
				_ref_new_status._scr_status = scr_status_dot_poison;

				_ref_new_status._ref_host = _ref_target;

				_ref_new_status._str_status_type = "DOT";
				_ref_new_status._str_status_name = "POISON";
				_ref_new_status._str_status_desc = "DAMAGE INCREASES AS POISON AGES";

				_ref_new_status._spr_status = spr_status_dot_poison;

				_ref_new_status._ct_status_stacks = 1;
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

				_ref_applied_status = _ref_new_status;
			}

			//=================//
			//PLAGUE GARDEN//
			//=================//
			if (_flag_trigger_plague_garden){

				scr_status_trigger_plague_garden(
					_ref_target,
					"POISON"
				);
			}

			//========================//
			//APPLICATION PRESENTATION//
			//========================//
			scr_battle_vfx(
				_ref_target,
				spr_battle_vfx_poison,
				undefined,
				undefined,
				16,
				16,
				1,
				0,
				snd_battle_poison
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

				scr_status_dot_poison(
					"DEATH",
					_ref_status
				);

				return undefined;
			}

			//================//
			//ADVANCE POISON//
			//================//
			/*
				Poison ages before calculating damage for the current
				trigger. A 5-round Poison therefore progresses through
				20%, 40%, 60%, 80%, and 100% damage.
			*/

			scr_status_tick_lifetime(_ref_status);

			//=================//
			//POISON DAMAGE//
			//=================//
			var _ct_poison_stacks = max(0,_ref_status._ct_status_stacks);
			var _val_poison_max = max(1,_ref_status._val_status_lifetime_max);
			var _val_poison_age = _val_poison_max - _ref_status._val_status_lifetime;

			//----------------------//
			//POISON BUILDUP SPEED//
			//----------------------//
			var _val_poison_buildup = 5;

			if (_ct_poison_stacks >= 15){
				_val_poison_buildup = 1;
			}
			else if (_ct_poison_stacks >= 10){
				_val_poison_buildup = 2;
			}
			else if (_ct_poison_stacks >= 6){
				_val_poison_buildup = 3;
			}
			else if (_ct_poison_stacks >= 4){
				_val_poison_buildup = 4;
			}

			var _val_poison_progress = clamp(
				_val_poison_age / _val_poison_buildup,
				0,
				1
			);

			var _val_damage = ceil(_ct_poison_stacks * _val_poison_progress);

			//==========//
			//TICK VFX//
			//==========//
			scr_battle_vfx(
				_ref_host,
				spr_battle_vfx_poison_tick,
				undefined,
				undefined,
				16,
				16,
				1,
				0,
				snd_battle_poison
			);

			//============//
			//OVERHEALTH//
			//============//
			if (
				_val_damage > 0 &&
				_ref_host._val_overhealth > 0
			){

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
			if (
				_val_damage > 0 &&
				_ref_host._val_cur_hp > 0
			){

				var _val_actual_damage = min(_val_damage,_ref_host._val_cur_hp);

				scr_gui_spawn_popup_scrolling(
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