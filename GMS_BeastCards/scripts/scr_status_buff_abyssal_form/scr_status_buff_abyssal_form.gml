//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_ABYSSAL_FORM
// FUNCTION: Handles Abyssal Form.
//           Unstackable Timed Buff.
//           Increases CON, PPOW, MPOW, PDEF, and MDEF by 40.
//           Whenever the host Attacks, randomly applies Stun,
//           Banish, or Stormstruck to the Attack target.
//           Generic form drawing handles the Abyssal Form transformation.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_magnitude=undefined, _val_lifetime=undefined, _ref_attack_target=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_abyssal_form(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_attack_target=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":


			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!is_struct(_ref_target._ref_unit)){
				return undefined;
			}

			//----------//
			//DEFAULTS//
			//----------//
			if (_val_magnitude == undefined){
				_val_magnitude = 40;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 5;
			}

			_val_magnitude = max(0,_val_magnitude);
			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("ABYSSAL_FORM",_ref_target);

			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				return _ref_existing_status;
			}

			//======================//
			//INCREASE COMBAT STATS//
			//======================//
			_ref_target._ref_unit._val_beast_con_stat += _val_magnitude;
			_ref_target._ref_unit._val_beast_ppow_stat += _val_magnitude;
			_ref_target._ref_unit._val_beast_mpow_stat += _val_magnitude;
			_ref_target._ref_unit._val_beast_pdef_stat += _val_magnitude;
			_ref_target._ref_unit._val_beast_mdef_stat += _val_magnitude;

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			_ref_new_status._scr_status = scr_status_buff_abyssal_form;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "ABYSSAL_FORM";
			_ref_new_status._str_status_desc = "ALL COMBAT STATS +40; ATTACKS APPLY A RANDOM ABYSSAL EFFECT";

			_ref_new_status._spr_status = spr_status_buff_abyssal_form;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;
			_ref_new_status._val_status_magnitude = _val_magnitude;

			_ref_new_status._str_trigger_region = "END";

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			//------------------//
			//REFRESH FORM DRAW//
			//------------------//
			scr_battle_refresh_beast_form_draw(_ref_target);

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

			if (!instance_exists(_ref_attack_target)){
				return false;
			}

			if (_ref_attack_target._val_cur_hp <= 0){
				return false;
			}

			if (_ref_attack_target._str_team == _ref_host._str_team){
				return false;
			}

			//--------------------//
			//ROLL ABYSSAL EFFECT//
			//--------------------//
			var _val_roll = irandom_range(0,2);

			switch (_val_roll){

				//------//
				//STUN//
				//------//
				case 0:

					scr_status_apply_cc("STUN", _ref_attack_target, 1);

				break;

				//--------//
				//BANISH//
				//--------//
				case 1:

					scr_status_apply_cc("BANISH", _ref_attack_target, 1);

				break;

				//-------------//
				//STORMSTRUCK//
				//-------------//
				case 2:

					scr_status_apply_dot("STORMSTRUCK", _ref_attack_target);

				break;
			}


			return true;

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

			scr_status_tick_lifetime(_ref_status);
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

			if (
				instance_exists(_ref_host) &&
				is_struct(_ref_host._ref_unit)
			){

				var _val_bonus = _ref_status._val_status_magnitude;

				//====================//
				//REMOVE STAT BONUSES//
				//====================//
				_ref_host._ref_unit._val_beast_con_stat = max(0,_ref_host._ref_unit._val_beast_con_stat - _val_bonus);
				_ref_host._ref_unit._val_beast_ppow_stat = max(0,_ref_host._ref_unit._val_beast_ppow_stat - _val_bonus);
				_ref_host._ref_unit._val_beast_mpow_stat = max(0,_ref_host._ref_unit._val_beast_mpow_stat - _val_bonus);
				_ref_host._ref_unit._val_beast_pdef_stat = max(0,_ref_host._ref_unit._val_beast_pdef_stat - _val_bonus);
				_ref_host._ref_unit._val_beast_mdef_stat = max(0,_ref_host._ref_unit._val_beast_mdef_stat - _val_bonus);

				//------------------//
				//REFRESH FORM DRAW//
				//------------------//
				scr_battle_refresh_beast_form_draw(_ref_host);
			}

			//----------------//
			//DESTROY STATUS//
			//----------------//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}
