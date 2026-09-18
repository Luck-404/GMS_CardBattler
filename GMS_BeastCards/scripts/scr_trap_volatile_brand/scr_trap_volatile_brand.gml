//===============================================================================//
//
// SCRIPT: SCR_TRAP_VOLATILE_BRAND
// FUNCTION: Handles Volatile Brand activation.
//           Triggers when its marked Beast dies.
//           Deals Linear MAG damage to the original adjacent enemies.
//           Applies 2 Burn to each surviving adjacent enemy.
//           Excludes the marked Beast itself.
//           Consumes the Trap before resolving its explosion.
//
// ARGUMENTS: _str_tag selects the Trap action.
//            _ref_trap is the Volatile Brand Trap instance.
//            _ref_attacker is unused.
//            _ref_target is the dying Beast.
//            _stct_card is unused.
// RETURNS: True when the Trap activates; otherwise false.
//
//===============================================================================//

function scr_trap_volatile_brand(_str_tag,_ref_trap,_ref_attacker,_ref_target,_stct_card){

	switch (_str_tag){

		//=========//
		//TRIGGER//
		//=========//
		case "TRIGGER":

			//================//
			//VALIDATE TRAP//
			//================//
			if (!instance_exists(_ref_trap)){
				return false;
			}

			if (_ref_trap._flag_triggered){
				return false;
			}

			//================//
			//VALIDATE HOST//
			//================//
			var _ref_host = _ref_trap._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			if (_ref_host != _ref_target){
				return false;
			}

			//=====================//
			//VALIDATE TRAP SOURCE//
			//=====================//
			if (
				!instance_exists(_ref_trap._ref_owner) ||
				!instance_exists(_ref_trap._ref_source_card) ||
				!is_struct(_ref_trap._ref_source_card._ref_card)
			){

				scr_trap_destroy(_ref_trap);

				return false;
			}

			//================//
			//STORE TRAP DATA//
			//================//
			var _ref_trap_owner = _ref_trap._ref_owner;
			var _ref_source_card = _ref_trap._ref_source_card;
			var _stct_source_card = _ref_source_card._ref_card;

			var _val_magnitude = _ref_trap._val_magnitude;

			//=====================//
			//SNAPSHOT ADJACENCY//
			//=====================//
			// Death Traps execute before formation removal.
			// Capture both adjacent Beasts before dealing damage,
			// as the first explosion hit may cause another death.

			var _arr_targets = [
				scr_battle_get_left_target(_ref_host),
				scr_battle_get_right_target(_ref_host)
			];

			//================//
			//MARK TRIGGERED//
			//================//
			_ref_trap._flag_triggered = true;

			//==================//
			//TRAP TRIGGER VFX//
			//==================//
			scr_battle_vfx_trap_trigger(_ref_trap);

			//================//
			//REVEAL TRAP//
			//================//
			scr_gui_spawn_popup_trigger_banner(
				"TRAP TRIGGERED: VOLATILE BRAND"
			);

			//======================//
			//STORE GLOBAL CONTEXT//
			//======================//
			var _ref_original_caster = global.ref_caster_beast;
			var _ref_original_target = global.ref_target_beast;
			var _ref_original_card = global.ref_cast_card;

			var _str_original_stat = _stct_source_card._str_card_stat;

			//================//
			//CONSUME TRAP//
			//================//
			// Destroy before damage so chained death effects cannot
			// activate this exact Trap a second time.

			scr_trap_destroy(_ref_trap);

			//================//
			//SET TRAP CONTEXT//
			//================//
			global.ref_caster_beast = _ref_trap_owner;
			global.ref_cast_card = _ref_source_card;

			//-----------------------//
			//FORCE MAGICAL DAMAGE//
			//-----------------------//
			// Card metadata remains NEU; triggered damage is MAG.

			_stct_source_card._str_card_stat = "MAG";

			//================//
			//RESOLVE EXPLOSION//
			//================//
			for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

				var _ref_adjacent = _arr_targets[_it_target];

				//================//
				//VALIDATE ENEMY//
				//================//
				if (!instance_exists(_ref_adjacent)){
					continue;
				}

				if (
					_ref_adjacent._str_team != _ref_host._str_team ||
					_ref_adjacent._str_team == _ref_trap_owner._str_team ||
					_ref_adjacent._str_list != "ALIVE" ||
					_ref_adjacent._val_cur_hp <= 0
				){
					continue;
				}

				//================//
				//DEAL MAG DAMAGE//
				//================//
				global.ref_target_beast = _ref_adjacent;

				scr_battle_damage_target(
					_val_magnitude,
					_ref_adjacent
				);

				//================//
				//CHECK SURVIVAL//
				//================//
				if (
					!instance_exists(_ref_adjacent) ||
					_ref_adjacent._str_list != "ALIVE" ||
					_ref_adjacent._val_cur_hp <= 0
				){
					continue;
				}

				//================//
				//APPLY 2 BURN//
				//================//
				global.ref_target_beast = _ref_adjacent;

				repeat (2){
					scr_status_apply_dot("BURN");
				}
			}

			//====================//
			//RESTORE CARD STAT//
			//====================//
			_stct_source_card._str_card_stat = _str_original_stat;

			//========================//
			//RESTORE GLOBAL CONTEXT//
			//========================//
			global.ref_caster_beast = _ref_original_caster;
			global.ref_target_beast = _ref_original_target;
			global.ref_cast_card = _ref_original_card;

			return true;

		break;
	}

	return false;
}