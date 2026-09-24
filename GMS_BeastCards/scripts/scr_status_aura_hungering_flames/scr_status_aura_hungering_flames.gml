//===============================================================================//
//
// SCRIPT: SCR_STATUS_AURA_HUNGERING_FLAMES
// FUNCTION: Infinite, unstackable Aura.
//           Reduces the host's Maximum HP by 20% while active.
//           At round end, heals the host for 2 HP per living Burning enemy.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_magnitude=undefined, _ct_burning_enemies=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_aura_hungering_flames(_str_tag,_ref_status,_val_magnitude=undefined,_ct_burning_enemies=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":


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
				_val_magnitude = 2;
			}

			_val_magnitude = max(0,floor(_val_magnitude));

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"HUNGERING_FLAMES",
				_ref_target
			);

			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){
				return _ref_existing_status;
			}

			//===============//
			//CREATE STATUS//
			//===============//
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
				false,
				true
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_aura_hungering_flames;

			_ref_new_status._ref_host = _ref_target;
			_ref_new_status._str_team = _ref_target._str_team;

			_ref_new_status._str_status_type = "AURA";
			_ref_new_status._str_status_name = "HUNGERING_FLAMES";

			_ref_new_status._str_status_desc =
				"ROUND END: HEAL " +
				string(_val_magnitude) +
				" HP PER BURNING ENEMY; MAX HP -20%";

			_ref_new_status._spr_status = spr_status_aura_hungering_flames;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._val_status_magnitude = _val_magnitude;

			//-----------------------//
			//ROUND-END TRIGGER ONLY//
			//-----------------------//
			_ref_new_status._str_trigger_region = undefined;

			_ref_new_status._str_aura_scope = "TEAM";
			_ref_new_status._str_aura_trigger = "ROUND_END";

			//======================//
			//CALCULATE HP PENALTY//
			//======================//
			var _val_hp_reduction = 0;

			if (_ref_target._val_max_hp > 1){

				_val_hp_reduction = round(
					_ref_target._val_max_hp * 0.20
				);

				_val_hp_reduction = clamp(
					_val_hp_reduction,
					1,
					_ref_target._val_max_hp - 1
				);
			}

			//--------------------------//
			//TRACK OWNED HP REDUCTION//
			//--------------------------//
			_ref_new_status._val_hungering_max_hp_reduction = _val_hp_reduction;

			//================//
			//REDUCE MAX HP//
			//================//
			_ref_target._val_max_hp = max(
				1,
				_ref_target._val_max_hp - _val_hp_reduction
			);

			//----------------//
			//CLAMP CURRENT HP//
			//----------------//
			_ref_target._val_cur_hp = min(
				_ref_target._val_cur_hp,
				_ref_target._val_max_hp
			);

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

			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			if (_ref_host._val_cur_hp <= 0){
				return false;
			}

			if (
				_ct_burning_enemies == undefined ||
				_ct_burning_enemies <= 0
			){
				return false;
			}

			//================//
			//CALCULATE HEAL//
			//================//
			var _val_healing =
				_ct_burning_enemies *
				_ref_status._val_status_magnitude;

			if (_val_healing <= 0){
				return false;
			}

			//================//
			//HEAL HOST//
			//================//
			return scr_battle_heal_target(
				"FIXED",
				_val_healing,
				_ref_host
			);

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			// Infinite Aura. Healing is handled by the
			// central round-end trigger, not team turn-end.

			if (
				instance_exists(_ref_status) &&
				instance_exists(_ref_status._ref_host)
			){
				scr_status_reposition(_ref_status._ref_host);
			}

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			//================//
			//RESTORE MAX HP//
			//================//
			if (instance_exists(_ref_host)){

				_ref_host._val_max_hp +=
					_ref_status._val_hungering_max_hp_reduction;
			}

			//================//
			//DESTROY STATUS//
			//================//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}
