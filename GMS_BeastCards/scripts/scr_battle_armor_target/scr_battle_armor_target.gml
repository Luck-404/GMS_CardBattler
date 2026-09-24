//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ARMOR_TARGET
// FUNCTION: Authoritative Armor-gain resolver.
//           LINEAR applies Card Power scaling before Armor resolution.
//           FIXED is the raw source-independent path for Minions, Statuses,
//           Items, and other fixed effects.
//           Both modes still resolve Armorbreak, presentation, debug logging,
//           and hosted-Minion Armor-gain triggers.
//
// ARGUMENTS: _str_mode - LINEAR or FIXED.
//            _val_amount - base Armor amount.
//            _ref_target - battle Beast receiving Armor.
// RETURNS: True when Armor is successfully gained; otherwise false.
//
//===============================================================================//

function scr_battle_armor_target(_str_mode,_val_amount,_ref_target){

	#region VALIDATION

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (!is_struct(_ref_target._ref_unit)){
		return false;
	}

	//-----------------//
	//VALIDATE AMOUNT//
	//-----------------//
	if (!is_real(_val_amount) || _val_amount <= 0){
		return false;
	}

	//====================//
	//VALIDATE ARMOR MODE//
	//====================//
	if (
		_str_mode != "LINEAR" &&
		_str_mode != "FIXED"
	){
		return false;
	}

	#endregion

	#region ARMOR SCALING

	//===================//
	//RESOLVE BASE ARMOR//
	//===================//
	var _val_armor_gain = _val_amount;

	switch (_str_mode){

		//========//
		//LINEAR//
		//========//
		case "LINEAR":

			//----------------//
			//VALIDATE CASTER//
			//----------------//
			var _ref_caster = global.ref_caster_beast;

			if (!instance_exists(_ref_caster)){
				return false;
			}

			if (!is_struct(_ref_caster._ref_unit)){
				return false;
			}

			//--------------//
			//VALIDATE CARD//
			//--------------//
			var _ref_cast_card = global.ref_cast_card;

			if (!instance_exists(_ref_cast_card)){
				return false;
			}

			if (!is_struct(_ref_cast_card._ref_card)){
				return false;
			}

			//================//
			//GET CAST DATA//
			//================//
			var _stct_caster_unit = _ref_caster._ref_unit;
			var _stct_card = _ref_cast_card._ref_card;
			var _str_card_stat = _stct_card._str_card_stat;

			//=====================================//
			//LINEAR ARMOR MUST USE PHY OR MAG//
			//=====================================//
			if (
				_str_card_stat != "PHY" &&
				_str_card_stat != "MAG"
			){
				return false;
			}

			//===============//
			//PHYPOW SCALING//
			//===============//
			if (_str_card_stat == "PHY"){

				var _val_ppow_modifier = scr_beast_get_grade_modifier(
					_stct_caster_unit._val_beast_ppow_stat
				);

				_val_armor_gain = ceil(
					_val_armor_gain *
					_val_ppow_modifier
				);
			}

			//===============//
			//MAGPOW SCALING//
			//===============//
			else if (_str_card_stat == "MAG"){

				var _val_mpow_modifier = scr_beast_get_grade_modifier(
					_stct_caster_unit._val_beast_mpow_stat
				);

				_val_armor_gain = ceil(
					_val_armor_gain *
					_val_mpow_modifier
				);
			}

		break;

		//=======//
		//FIXED//
		//=======//
		case "FIXED":

			/*
				FIXED uses the supplied amount directly.
				It still resolves Armorbreak, Armor VFX/SFX,
				debug logging, and hosted-Minion Armor-gain triggers.
			*/

		break;
	}

	if (_val_armor_gain <= 0){
		return false;
	}

	#endregion

	#region ARMOR GAIN

	//----------------//
	//BASE ARMOR GAIN//
	//----------------//
	var _val_armor_requested = _val_armor_gain;
	var _val_armor_before = _ref_target._val_armor;

	//----------------//
	//CHECK ARMORBREAK//
	//----------------//
	var _ref_armorbreak = scr_status_check(
		"ARMORBREAK",
		_ref_target
	);

	var _flag_armorbreak = (_ref_armorbreak != -1);

	if (_flag_armorbreak){

		_val_armor_gain = floor(
			_val_armor_gain * 0.50
		);
	}

	//------------------//
	//CHECK FINAL AMOUNT//
	//------------------//
	if (_val_armor_gain <= 0){
		return false;
	}

	//-------------//
	//GRANT ARMOR//
	//-------------//
	_ref_target._val_armor += _val_armor_gain;

	#endregion

	#region FEEDBACK

	//---------------//
	//ARMOR VFX / SFX//
	//---------------//
	scr_battle_vfx(
		_ref_target,
		spr_battle_vfx_armor,
		undefined,
		undefined,
		0,
		0,
		1,
		0,
		snd_battle_armor
	);

	//-------------//
	//SPAWN POPUP//
	//-------------//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"+" + string(_val_armor_gain),
		undefined,
		c_blue,
		_ref_target.x + irandom_range(-32,32),
		_ref_target.y - 24 + irandom_range(-32,32)
	);

	#endregion

	#region DEBUG

	//----------------//
	//GET SOURCE CARD//
	//----------------//
	var _str_source = "SYSTEM";

	if (
		instance_exists(global.ref_cast_card) &&
		is_struct(global.ref_cast_card._ref_card)
	){
		_str_source = string_upper(
			global.ref_cast_card._ref_card._str_card_name
		);
	}

	//----------------//
	//BUILD MESSAGE//
	//----------------//
	var _str_message =
		string_upper(_ref_target._str_team) + " " +
		string_upper(_ref_target._ref_unit._str_beast_name) +
		" GAINED " + string(_val_armor_gain) +
		" ARMOR | " +
		string(_val_armor_before) +
		" -> " +
		string(_ref_target._val_armor) +
		" | MODE: " + _str_mode +
		" | SOURCE: " + _str_source;

	if (_flag_armorbreak){

		_str_message +=
			" | ARMORBREAK: " +
			string(_val_armor_requested) +
			" -> " +
			string(_val_armor_gain);
	}

	//----------------//
	//LOG ARMOR GAIN//
	//----------------//
	scr_debug_log(
		"BATTLE",
		"ARMOR",
		_ref_target,
		_str_message,
		"BATTLE",
		"SCR_BATTLE_ARMOR_TARGET"
	);

	#endregion

	#region MINION TRIGGERS

	//----------------------//
	//TRIGGER HOSTED MINIONS//
	//----------------------//
	scr_minion_trigger_host_armor_gain(
		_ref_target,
		_val_armor_gain
	);

	#endregion

	return true;
}