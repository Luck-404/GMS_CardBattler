//===============================================================================//
//
// SCRIPT: SCR_STATUS_DOT_RAGE
// FUNCTION: Handles the Rage DoT.
//           Stackable Timed with a default lifetime of 5.
//           Maximum 5 stacks.
//           Each stack grants +1 outgoing Linear damage.
//           At the start of the host's turn, Rage deals 1 NEU damage per stack.
//           Rage stacks may also be consumed as a resource by other effects.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_dot_rage(_str_tag,_ref_status,_val_lifetime=undefined,_ref_target=undefined){

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
				_val_lifetime = 5;
			}

			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("RAGE",_ref_target);

			//================//
			//STACK EXISTING//
			//================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				//================//
				//GAIN RAGE STACK//
				//================//
				if (_ref_existing_status._ct_status_stacks < 5){

					_ref_existing_status._ct_status_stacks++;

					//===================//
					//ADD DAMAGE BONUS//
					//===================//
					_ref_target._val_dmg_linear_bonus += _ref_existing_status._val_status_magnitude;
				}

				//==================//
				//REFRESH LIFETIME//
				//==================//
				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				//------------------//
				//UPDATE DESCRIPTION//
				//------------------//
				_ref_existing_status._str_status_desc =
					"+" +
					string(_ref_existing_status._ct_status_stacks) +
					" OUTGOING DAMAGE; TAKE " +
					string(_ref_existing_status._ct_status_stacks) +
					" NEU DAMAGE EACH ROUND. MAX 5 STACKS.";

				//================//
				//APPLY VFX / SFX//
				//================//
				scr_battle_vfx(
					_ref_target,
					spr_battle_vfx_rage,
					undefined,
					undefined,
					0,
					0,
					1,
					0,
					snd_battle_rage
				);

				scr_status_reposition(_ref_target);

				return _ref_existing_status;
			}

			//================//
			//CREATE STATUS//
			//================//
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
			_ref_new_status._scr_status = scr_status_dot_rage;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "DOT";
			_ref_new_status._str_status_name = "RAGE";
			_ref_new_status._str_status_desc = "+1 OUTGOING DAMAGE; TAKE 1 NEU DAMAGE EACH ROUND. MAX 5 STACKS.";

			_ref_new_status._spr_status = spr_status_dot_rage;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = true;

			_ref_new_status._val_status_magnitude = 1;

			_ref_new_status._str_trigger_region = "START";

			//===================//
			//ADD DAMAGE BONUS//
			//===================//
			_ref_target._val_dmg_linear_bonus += _ref_new_status._val_status_magnitude;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

			//================//
			//APPLY VFX / SFX//
			//================//
			scr_battle_vfx(
				_ref_target,
				spr_battle_vfx_rage,
				undefined,
				undefined,
				0,
				0,
				1,
				0,
				snd_battle_rage
			);

			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			//----------------//
			//VALIDATE HOST//
			//----------------//
			if (!instance_exists(_ref_host)){

				scr_status_dot_rage(
					"DEATH",
					_ref_status
				);

				return undefined;
			}

			if (_ref_host._val_cur_hp <= 0){

				scr_status_tick_lifetime(_ref_status);

				return undefined;
			}

			//================//
			//BASE RAGE DAMAGE//
			//================//
			var _val_damage = max(
				0,
				_ref_status._ct_status_stacks
			);

			//================//
			//CHECK ENDLESS RAGE//
			//================//
			var _ref_endless_rage = scr_status_check(
				"ENDLESS_RAGE",
				_ref_host
			);

			//================//
			//DOUBLE SELF-DAMAGE//
			//================//
			if (
				_ref_endless_rage != -1 &&
				instance_exists(_ref_endless_rage)
			){

				_val_damage *= 2;
			}

			//================//
			//TICK VFX / SFX//
			//================//
			scr_battle_vfx(
				_ref_host,
				spr_battle_vfx_rage_tick,
				undefined,
				undefined,
				0,
				0,
				1,
				0,
				snd_battle_rage
			);

			//============//
			//OVERHEALTH//
			//============//
			if (
				_val_damage > 0 &&
				_ref_host._val_overhealth > 0
			){

				var _val_overhealth_damage = min(
					_ref_host._val_overhealth,
					_val_damage
				);

				_ref_host._val_overhealth -= _val_overhealth_damage;
				_val_damage -= _val_overhealth_damage;

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"-" + string(_val_overhealth_damage),
					undefined,
					c_green,
					_ref_host.x + irandom_range(-32,32),
					_ref_host.y - 24 + irandom_range(-32,32)
				);
			}

			//=========//
			//HOST HP//
			//=========//
			if (
				_val_damage > 0 &&
				_ref_host._val_cur_hp > 0
			){

				var _val_hp_damage = min(
					_val_damage,
					_ref_host._val_cur_hp
				);

				_ref_host._val_cur_hp = max(
					0,
					_ref_host._val_cur_hp - _val_hp_damage
				);

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"-" + string(_val_hp_damage),
					undefined,
					c_maroon,
					_ref_host.x + irandom_range(-32,32),
					_ref_host.y - 24 + irandom_range(-32,32)
				);
			}

			//================//
			//UPDATE LIFETIME//
			//================//
			if (
				_ref_endless_rage != -1 &&
				instance_exists(_ref_endless_rage)
			){

				// Rage cannot expire while Endless Rage is active.
				_ref_status._str_status_command = "WAIT";
			}
			else{

				scr_status_tick_lifetime(_ref_status);
			}

			scr_status_reposition(_ref_host);

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			//=====================//
			//REMOVE DAMAGE BONUS//
			//=====================//
			if (instance_exists(_ref_host)){

				var _val_owned_bonus =
					_ref_status._ct_status_stacks *
					_ref_status._val_status_magnitude;

				_ref_host._val_dmg_linear_bonus = max(
					0,
					_ref_host._val_dmg_linear_bonus - _val_owned_bonus
				);
			}

			//================//
			//DESTROY STATUS//
			//================//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}
