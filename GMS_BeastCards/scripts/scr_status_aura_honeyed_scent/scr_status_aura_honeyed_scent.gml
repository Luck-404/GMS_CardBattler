//===============================================================================//
//
// SCRIPT: SCR_STATUS_AURA_HONEYED_SCENT
// FUNCTION: Handles the Honeyed Scent Aura.
//           Unstackable Infinite Team Aura.
//           Allied Attack casts summon a Wasp Drone on the casting Beast.
//           Disables the host's Dodge and increases incoming damage by 10%.
//
//===============================================================================//
function scr_status_aura_honeyed_scent(_str_tag,_ref_status,_val_magnitude=undefined,_ref_trigger_caster=undefined){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			//------------------//
			//DEFAULT MAGNITUDE//
			//------------------//
			if (_val_magnitude == undefined){
				_val_magnitude = 10;
			}

			_val_magnitude = max(0,_val_magnitude);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_check_for_status("HONEYED_SCENT",_ref_target);

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
			scr_status_init_lifetime(_ref_new_status,-1,false,true);

			_ref_new_status._scr_status =
				scr_status_aura_honeyed_scent;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"AURA";

			_ref_new_status._str_status_name =
				"HONEYED_SCENT";

			_ref_new_status._str_status_desc =
				"ALLIED ATTACK CASTS SUMMON WASP DRONES; HOST DODGE 0; DAMAGE TAKEN +10%";

			_ref_new_status._spr_status =
				spr_status_aura_honeyed_scent;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._val_status_magnitude =
				_val_magnitude;

			_ref_new_status._str_trigger_region =
				undefined;

			_ref_new_status._str_aura_scope =
				"TEAM";

			_ref_new_status._str_aura_trigger =
				"ATTACK_CAST";

			//----------------------//
			//DISABLE HOST DODGE//
			//----------------------//
			_ref_target._ct_dodge_disabled++;

			//-------------------------//
			//INCREASE DAMAGE RECEIVED//
			//-------------------------//
			_ref_target._val_dmg_taken_scalar_bonus +=
				_val_magnitude;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(_ref_target._list_statuses,_ref_new_status);

			scr_reposition_statuses(_ref_target);

			return _ref_new_status;

		break;


		//---------//
		//TRIGGER//
		//---------//
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

			if (_ref_trigger_caster._str_team != _ref_host._str_team){
				return false;
			}

			//------------------//
			//SUMMON WASP DRONE//
			//------------------//
			var _ref_wasp = scr_init_minion(
				"WASP_DRONE",
				undefined,
				_ref_trigger_caster,
				_ref_trigger_caster
			);

			return instance_exists(_ref_wasp);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (instance_exists(_ref_host)){

				//--------------------//
				//RESTORE HOST DODGE//
				//--------------------//
				_ref_host._ct_dodge_disabled =
					max(
						0,
						_ref_host._ct_dodge_disabled - 1
					);

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

			//---------------//
			//DESTROY STATUS//
			//---------------//
			scr_destroy_status(_ref_status);

		break;
	}

	return undefined;
}