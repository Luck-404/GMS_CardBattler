//===============================================================================//
//
// SCRIPT: SCR_STATUS_AURA_BURGEONING_BLOOM
// FUNCTION: Handles Burgeoning Bloom.
//           Unstackable Infinite Self Aura.
//           Reduces the host's Maximum HP by 15% while active.
//           Healing effects splash 25% of their attempted healing amount
//           to adjacent allied Beasts without retriggering healing Auras.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_magnitude=undefined, _val_trigger_amount=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_aura_burgeoning_bloom(_str_tag,_ref_status,_val_magnitude=undefined,_val_trigger_amount=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":


			if (!instance_exists(_ref_target)){
				return undefined;
			}

			//------------------//
			//DEFAULT MAGNITUDE//
			//------------------//
			if (
				_val_magnitude == undefined ||
				_val_magnitude <= 0
			){
				_val_magnitude = 0.25;
			}

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("BURGEONING_BLOOM",_ref_target);

			if (_ref_existing_status != -1){
				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
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
				-1,
				false,
				true
			);

			_ref_new_status._scr_status = scr_status_aura_burgeoning_bloom;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "AURA";
			_ref_new_status._str_status_name = "BURGEONING_BLOOM";
			_ref_new_status._str_status_desc = "HEALING EFFECTS SPLASH 25% TO ADJACENT ALLIES; MAX HP -15%";

			_ref_new_status._spr_status = spr_status_aura_burgeoning_bloom;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = _val_magnitude;

			_ref_new_status._str_trigger_region = undefined;

			_ref_new_status._str_aura_scope = "SELF";
			_ref_new_status._str_aura_trigger = "HEALED";

			//--------------------//
			//CALCULATE HP PENALTY//
			//--------------------//
			var _val_hp_reduction = 0;

			if (_ref_target._val_max_hp > 1){

				_val_hp_reduction = round(_ref_target._val_max_hp * 0.15);

				_val_hp_reduction = clamp(
					_val_hp_reduction,
					1,
					_ref_target._val_max_hp - 1
				);
			}

			_ref_new_status._val_aura_hp_max_reduction = _val_hp_reduction;

			//------------------//
			//REDUCE MAXIMUM HP//
			//------------------//
			_ref_target._val_max_hp -= _val_hp_reduction;
			_ref_target._val_max_hp = max(1,_ref_target._val_max_hp);

			//----------------//
			//CLAMP CURRENT HP//
			//----------------//
			_ref_target._val_cur_hp = min(_ref_target._val_cur_hp,_ref_target._val_max_hp);

			//----------------//
			//REGISTER STATUS//
			//----------------//
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

			if (
				_val_trigger_amount == undefined ||
				_val_trigger_amount <= 0
			){
				return false;
			}

			//--------------------------//
			//CALCULATE SPLASH HEALING//
			//--------------------------//
			var _val_splash_heal = round(_val_trigger_amount * _ref_status._val_status_magnitude);

			if (_val_splash_heal <= 0){
				return false;
			}

			//----------------------//
			//GET ADJACENT BEASTS//
			//----------------------//
			var _ref_left_target = scr_battle_get_left_target(_ref_host);
			var _ref_right_target = scr_battle_get_right_target(_ref_host);

			var _flag_healed = false;

			//--------------------//
			//HEAL LEFT ADJACENT//
			//--------------------//
			if (
				instance_exists(_ref_left_target) &&
				_ref_left_target._str_team == _ref_host._str_team &&
				_ref_left_target._val_cur_hp > 0
			){

				if (
					scr_battle_heal_target(
						"FIXED",
						_val_splash_heal,
						_ref_left_target,
						false
					)
				){
					_flag_healed = true;
				}
			}

			//---------------------//
			//HEAL RIGHT ADJACENT//
			//---------------------//
			if (
				instance_exists(_ref_right_target) &&
				_ref_right_target._str_team == _ref_host._str_team &&
				_ref_right_target._val_cur_hp > 0
			){

				if (
					scr_battle_heal_target(
						"FIXED",
						_val_splash_heal,
						_ref_right_target,
						false
					)
				){
					_flag_healed = true;
				}
			}

			return _flag_healed;

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			//-------------------//
			//RESTORE MAXIMUM HP//
			//-------------------//
			if (instance_exists(_ref_host)){
				_ref_host._val_max_hp += _ref_status._val_aura_hp_max_reduction;
			}

			//----------------//
			//DESTROY STATUS//
			//----------------//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}
