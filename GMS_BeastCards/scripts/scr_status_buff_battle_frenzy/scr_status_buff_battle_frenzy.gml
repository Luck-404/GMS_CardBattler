//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_BATTLE_FRENZY
// FUNCTION: Handles Battle Frenzy.
//           Stackable Buff lasting until the host's next resolved Attack.
//           Each stack repeats recorded Attack damage at 25% as fixed NEU.
//           Does not repeat the original Card script or secondary effects.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _ct_stacks_added=1, _ref_card=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_battle_frenzy(_str_tag,_ref_status,_ct_stacks_added=1,_ref_card=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":


			//================//
			//VALIDATE TARGET//
			//================//
			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			_ct_stacks_added = max(0,floor(_ct_stacks_added));

			if (_ct_stacks_added <= 0){
				return undefined;
			}

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"BATTLE_FRENZY",
				_ref_target
			);

			//================//
			//STACK EXISTING//
			//================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._ct_status_stacks += _ct_stacks_added;

				_ref_existing_status._str_status_desc =
					"NEXT ATTACK: " +
					string(_ref_existing_status._ct_status_stacks) +
					" DAMAGE-ONLY NEU REPEAT(S) AT 25% EACH.";

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

			//===================//
			//INFINITE LIFETIME//
			//===================//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				true,
				true
			);

			//================//
			//STATUS DATA//
			//================//
			_ref_new_status._scr_status = scr_status_buff_battle_frenzy;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "BATTLE_FRENZY";

			_ref_new_status._spr_status = spr_status_buff_battle_frenzy;

			_ref_new_status._ct_status_stacks = _ct_stacks_added;
			_ref_new_status._flag_status_stackable = true;

			_ref_new_status._str_trigger_region = undefined;

			_ref_new_status._str_status_desc =
				"NEXT ATTACK: " +
				string(_ct_stacks_added) +
				" DAMAGE-ONLY NEU REPEAT(S) AT 25% EACH.";

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

			return _ref_new_status;

		break;

		//=========//
		//TRIGGER//
		//=========//
		case "TRIGGER":

			//================//
			//VALIDATE STATUS//
			//================//
			if (!instance_exists(_ref_status)){
				return false;
			}

			if (!instance_exists(_ref_card)){
				return false;
			}

			if (!is_array(_ref_card._arr_battle_frenzy_hits)){
				return false;
			}

			//================//
			//SNAPSHOT EFFECT//
			//================//
			var _ref_host = _ref_status._ref_host;

			var _ct_repeats = _ref_status._ct_status_stacks;

			var _arr_hits = _ref_card._arr_battle_frenzy_hits;

			//================//
			//CLEAR RECORDING//
			//================//
			_ref_card._flag_battle_frenzy_recording = false;
			_ref_card._arr_battle_frenzy_hits = [];

			//================//
			//CONSUME BUFF//
			//================//
			scr_status_buff_battle_frenzy(
				"DEATH",
				_ref_status
			);

			//----------------//
			//VALIDATE CASTER//
			//----------------//
			if (!instance_exists(_ref_host)){
				return true;
			}

			if (_ref_host._val_cur_hp <= 0){
				return true;
			}

			//================//
			//TRIGGER FEEDBACK//
			//================//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"BATTLE FRENZY",
				undefined,
				c_red,
				_ref_host.x,
				_ref_host.y - 48
			);

			//================//
			//REPEAT DAMAGE//
			//================//
			for (var _it_repeat = 0;_it_repeat < _ct_repeats;_it_repeat++){

				for (var _it_hit = 0;_it_hit < array_length(_arr_hits);_it_hit++){

					var _stct_hit = _arr_hits[_it_hit];

					var _ref_hit_target = _stct_hit._ref_target;

					//----------------//
					//VALIDATE TARGET//
					//----------------//
					if (!instance_exists(_ref_hit_target)){
						continue;
					}

					if (
						_ref_hit_target._str_list != "ALIVE" ||
						_ref_hit_target._val_cur_hp <= 0
					){
						continue;
					}

					//================//
					//25% NEU DAMAGE//
					//================//
					var _val_repeat_damage = ceil(
						_stct_hit._val_damage * 0.25
					);

					if (_val_repeat_damage <= 0){
						continue;
					}

					//====================//
					//RESOLVE FIXED DAMAGE//
					//====================//
					scr_battle_damage_target(
						"FIXED",
						undefined,
						_ref_hit_target,
						_val_repeat_damage
					);
				}
			}

			return true;

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}
