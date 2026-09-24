
//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_LEECH
// FUNCTION: Handles Leech.
//           Unstackable Timed Buff.
//           Heals the host for a percentage of actual HP damage dealt
//           by its Attacks.
//
//           Excludes damage absorbed by Minions, Armor, and Overhealth.
//           Supports multi-hit, AoE, percentage, and Armor-piercing Attacks.
//           Reapplication refreshes duration without changing magnitude.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/TRIGGER/DEATH.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged:
//            _val_magnitude=undefined, _val_lifetime=undefined,
//            _ref_attacker=undefined, _stct_card=undefined.
//            _ref_target is the explicit host ONLY for APPLY.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_leech(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_attacker=undefined,_stct_card=undefined,_ref_target=undefined){

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

			//==========//
			//DEFAULTS//
			//==========//
			if (_val_magnitude == undefined){
				_val_magnitude = 0.25;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_magnitude = clamp(_val_magnitude,0,1);
			_val_lifetime = max(1,_val_lifetime);

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"LEECH",
				_ref_target
			);

			var _ref_applied_status = undefined;

			//================//
			//REFRESH EXISTING//
			//================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				//==========================//
				//PRESERVE ORIGINAL MAGNITUDE//
				//==========================//
				// Reapplication does not overwrite or accumulate
				// the existing healing percentage.

				_ref_existing_status._str_status_desc =
					"HEAL " +
					string(round(_ref_existing_status._val_status_magnitude * 100)) +
					"% OF HP DAMAGE DEALT BY ATTACKS.";

				//================//
				//REFRESH LIFETIME//
				//================//
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

				//================//
				//INIT LIFETIME//
				//================//
				scr_status_init_lifetime(
					_ref_new_status,
					_val_lifetime,
					false,
					false
				);

				//=============//
				//STATUS DATA//
				//=============//
				_ref_new_status._scr_status = scr_status_buff_leech;

				_ref_new_status._ref_host = _ref_target;

				_ref_new_status._str_status_type = "BUFF";
				_ref_new_status._str_status_name = "LEECH";

				_ref_new_status._str_status_desc =
					"HEAL " +
					string(round(_val_magnitude * 100)) +
					"% OF HP DAMAGE DEALT BY ATTACKS.";

				_ref_new_status._spr_status = spr_status_buff_leech;

				_ref_new_status._ct_status_stacks = 1;
				_ref_new_status._flag_status_stackable = false;

				_ref_new_status._val_status_magnitude = _val_magnitude;

				_ref_new_status._str_trigger_region = "END";

				//================//
				//REGISTER STATUS//
				//================//
				ds_list_add(
					_ref_target._list_statuses,
					_ref_new_status
				);

				scr_status_reposition(_ref_target);

				_ref_applied_status = _ref_new_status;
			}

			//================//
			//BUFF FEEDBACK//
			//================//
			if (instance_exists(_ref_applied_status)){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"LEECH",
					undefined,
					c_red,
					_ref_target.x,
					_ref_target.y - 48
				);

				var _snd_sfx = snd_battle_buff;

				if (instance_exists(global.ref_cast_card)){

					if (global.ref_cast_card._flag_buff_sfx_played){
						_snd_sfx = undefined;
					}
					else{
						global.ref_cast_card._flag_buff_sfx_played = true;
					}
				}

				scr_battle_vfx(
					_ref_target,
					spr_battle_vfx_buff,
					undefined,
					undefined,
					0,
					0,
					1,
					0,
					_snd_sfx
				);
			}

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

				scr_status_destroy(_ref_status);

				return undefined;
			}

			//================//
			//TICK LIFETIME//
			//================//
			scr_status_tick_lifetime(_ref_status);

			scr_status_reposition(_ref_host);

		break;

		//=========//
		//TRIGGER//
		//=========//
		case "TRIGGER":

			//================//
			//VALIDATE ATTACKER//
			//================//
			if (!instance_exists(_ref_attacker)){
				return false;
			}

			if (!is_struct(_stct_card)){
				return false;
			}

			if (_stct_card._str_card_type != "ATTACK"){
				return false;
			}

			//================//
			//GET CAST CARD//
			//================//
			var _ref_cast_card = global.ref_cast_card;

			if (!instance_exists(_ref_cast_card)){
				return false;
			}

			if (!variable_instance_exists(_ref_cast_card,"_arr_damage_results")){
				return false;
			}

			if (!is_array(_ref_cast_card._arr_damage_results)){
				return false;
			}

			//================//
			//GET DAMAGE RESULTS//
			//================//
			var _arr_results = _ref_cast_card._arr_damage_results;
			var _ct_results = array_length(_arr_results);

			if (_ct_results <= 0){
				return false;
			}

			//=======================//
			//FIND UNPROCESSED HITS//
			//=======================//
			var _it_start = 0;

			if (
				variable_instance_exists(
					_ref_cast_card,
					"_stct_leech_last_processed_result"
				)
			){

				var _stct_previous =
					_ref_cast_card._stct_leech_last_processed_result;

				if (is_struct(_stct_previous)){

					for (var _it_result = _ct_results - 1;_it_result >= 0;_it_result--){

						if (_arr_results[_it_result] == _stct_previous){

							_it_start = _it_result + 1;

							break;
						}
					}
				}
			}

			//=====================//
			//MARK RESULTS HANDLED//
			//=====================//
			/*
				Always advance the cursor, even when Leech is inactive.

				This prevents an Attack performed before gaining Leech
				from contributing damage to a later Attack.

				Tracking the result struct also handles cards that
				reset their damage-result array.
			*/

			_ref_cast_card._stct_leech_last_processed_result =
				_arr_results[_ct_results - 1];

			if (_it_start >= _ct_results){
				return false;
			}

			//================//
			//CHECK LEECH//
			//================//
			if (
				_ref_status == -1 ||
				!instance_exists(_ref_status)
			){
				return false;
			}

			if (_ref_status._ref_host != _ref_attacker){
				return false;
			}

			if (_ref_attacker._val_cur_hp <= 0){
				return false;
			}

			//================//
			//TOTAL HP DAMAGE//
			//================//
			var _val_hp_damage = 0;

			for (var _it_result = _it_start;_it_result < _ct_results;_it_result++){

				var _stct_result = _arr_results[_it_result];

				if (!is_struct(_stct_result)){
					continue;
				}

				//================//
				//MATCH ATTACKER//
				//================//
				if (_stct_result._ref_caster != _ref_attacker){
					continue;
				}

				//====================//
				//EXCLUDE SELF/ALLIES//
				//====================//
				var _ref_hit_target = _stct_result._ref_target;

				if (_ref_hit_target == _ref_attacker){
					continue;
				}

				if (
					instance_exists(_ref_hit_target) &&
					_ref_hit_target._str_team == _ref_attacker._str_team
				){
					continue;
				}

				//================//
				//COUNT HP DAMAGE//
				//================//
				if (!is_real(_stct_result._val_hp_damage)){
					continue;
				}

				_val_hp_damage += max(
					0,
					_stct_result._val_hp_damage
				);
			}

			if (_val_hp_damage <= 0){
				return false;
			}

			//================//
			//CALCULATE HEAL//
			//================//
			var _val_healing = floor(
				_val_hp_damage * _ref_status._val_status_magnitude
			);

			if (_val_healing <= 0){
				return false;
			}

			//================//
			//HEAL HOST//
			//================//
			scr_battle_heal_target(
				"FIXED",
				_val_healing,
				_ref_attacker
			);


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