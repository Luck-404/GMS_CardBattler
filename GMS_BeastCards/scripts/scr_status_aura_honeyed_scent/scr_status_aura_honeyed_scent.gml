//===============================================================================//
//
// SCRIPT: SCR_STATUS_AURA_HONEYED_SCENT
// FUNCTION: Handles Honeyed Scent.
//           Unstackable Infinite Team Aura.
//           Allied Attack casts summon a Wasp Drone on the casting Beast.
//           Disables the host's Dodge and increases incoming damage by 10%.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_magnitude=undefined, _ref_trigger_caster=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_aura_honeyed_scent(_str_tag,_ref_status,_val_magnitude=undefined,_ref_trigger_caster=undefined,_ref_target=undefined){

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
				_val_magnitude = 10;
			}

			//--------------//
			//GET TEAM LIST//
			//--------------//
			var _list_team = (_ref_target._str_team == "PLAYER") ? obj_battle_player_controller._list_beasts : obj_battle_enemy_controller._list_beasts;

			if (!ds_exists(_list_team,ds_type_list)){
				return undefined;
			}

			//----------------//
			//CHECK EXISTING//
			//----------------//
			for (var _it_beast = 0;_it_beast < ds_list_size(_list_team);_it_beast++){

				var _ref_beast = ds_list_find_value(_list_team,_it_beast);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				var _ref_existing_status = scr_status_check("HONEYED_SCENT",_ref_beast);

				if (_ref_existing_status != -1){
					return _ref_existing_status;
				}
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

			_ref_new_status._scr_status = scr_status_aura_honeyed_scent;

			_ref_new_status._ref_host = _ref_target;
			_ref_new_status._str_team = _ref_target._str_team;

			_ref_new_status._str_status_type = "AURA";
			_ref_new_status._str_status_name = "HONEYED_SCENT";
			_ref_new_status._str_status_desc = "ALLIED ATTACK CASTS SUMMON WASP DRONES; HOST DODGE 0; DAMAGE TAKEN +10%";

			_ref_new_status._spr_status = spr_status_aura_honeyed_scent;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = _val_magnitude;

			_ref_new_status._str_trigger_region = undefined;

			_ref_new_status._str_aura_scope = "TEAM";
			_ref_new_status._str_aura_trigger = "ATTACK_CAST";

			//--------------------//
			//DISABLE HOST DODGE//
			//--------------------//
			_ref_target._ct_dodge_disabled++;

			//-------------------------//
			//INCREASE DAMAGE RECEIVED//
			//-------------------------//
			_ref_target._val_dmg_taken_scalar_bonus += _val_magnitude;

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

			if (!instance_exists(_ref_trigger_caster)){
				return false;
			}

			if (_ref_trigger_caster._str_team != _ref_status._str_team){
				return false;
			}

			if (_ref_trigger_caster._val_cur_hp <= 0){
				return false;
			}

			//------------------//
			//SUMMON WASP DRONE//
			//------------------//
			var _ref_wasp = scr_minion_init(
				"WASP_DRONE",
				undefined,
				_ref_trigger_caster,
				_ref_trigger_caster
			);

			return instance_exists(_ref_wasp);

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (instance_exists(_ref_host)){

				//--------------------//
				//RESTORE HOST DODGE//
				//--------------------//
				_ref_host._ct_dodge_disabled = max(0,_ref_host._ct_dodge_disabled - 1);

				//------------------------//
				//RESTORE DAMAGE RECEIVED//
				//------------------------//
				_ref_host._val_dmg_taken_scalar_bonus =
					max(
						0,
						_ref_host._val_dmg_taken_scalar_bonus -
						_ref_status._val_status_magnitude
					);
			}

			//----------------//
			//DESTROY STATUS//
			//----------------//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}
