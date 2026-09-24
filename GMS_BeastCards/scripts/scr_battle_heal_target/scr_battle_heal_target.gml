//===============================================================================//
//
// SCRIPT: SCR_BATTLE_HEAL_TARGET
// FUNCTION: Authoritative healing resolver.
//           LINEAR applies Card Power scaling before normal healing resolution.
//           FIXED is the raw source-independent path for Minions, Statuses,
//           Weather, Events, and other fixed effects.
//           Both modes still resolve Antiheal, Blood Moon, healing-received
//           modifiers, Bloomtide, healing Traps, VFX and heal triggers.
//
// ARGUMENTS: _str_mode - LINEAR or FIXED.
//            _val_amount - base healing amount.
//            _ref_target - living battle Beast receiving healing.
//            _flag_trigger_auras - whether healing Aura triggers resolve.
// RETURNS: True when healing resolves; otherwise false.
//
//===============================================================================//

function scr_battle_heal_target(_str_mode,_val_amount,_ref_target,_flag_trigger_auras=true){

	#region VALIDATION

	//-----------------//
	//VALIDATE TARGET//
	//-----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (!is_struct(_ref_target._ref_unit)){
		return false;
	}

	if (_ref_target._val_cur_hp <= 0){
		return false;
	}

	//-----------------//
	//VALIDATE AMOUNT//
	//-----------------//
	if (!is_real(_val_amount) || _val_amount <= 0){
		return false;
	}

	//======================//
	//VALIDATE HEALING MODE//
	//======================//
	if (
		_str_mode != "LINEAR" &&
		_str_mode != "FIXED"
	){
		return false;
	}

	//======================//
	//RESOLVE BASE HEALING//
	//======================//
	var _val_mode_healing = _val_amount;

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

			var _stct_card = _ref_cast_card._ref_card;

			//=====================================//
			//LINEAR HEALING MUST USE PHY OR MAG//
			//=====================================//
			if (
				_stct_card._str_card_stat != "PHY" &&
				_stct_card._str_card_stat != "MAG"
			){
				return false;
			}

			//========================//
			//POWER-SCALE BASE HEALING//
			//========================//
			_val_mode_healing = scr_battle_get_heal_linear_amount(
				_val_amount,
				_ref_caster,
				_stct_card
			);

		break;

		//=======//
		//FIXED//
		//=======//
		case "FIXED":

			/*
				FIXED uses the supplied amount directly.
				It still resolves Antiheal, Blood Moon,
				healing-received modifiers, Bloomtide,
				Traps, and heal triggers.
			*/

		break;
	}

	if (_val_mode_healing <= 0){
		return false;
	}

	#endregion

	#region ANTIHEAL

	//================//
	//CHECK ANTIHEAL//
	//================//
	var _ref_antiheal = scr_status_check(
		"ANTIHEAL",
		_ref_target
	);

	if (
		_ref_antiheal != -1 &&
		instance_exists(_ref_antiheal)
	){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"+0 (ANTIHEAL)",
			undefined,
			c_maroon,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);

		return false;
	}

	#endregion

	#region PRE-HEAL EFFECTS

	//==================//
	//CHECK BLOOD MOON//
	//==================//
	var _ref_blood_moon = scr_status_check(
		"EVENT: BLOOD_MOON",
		global.list_statuses
	);

	if (
		_ref_blood_moon != -1 &&
		instance_exists(_ref_blood_moon)
	){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"+0 (BLOOD MOON)",
			undefined,
			c_red,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);

		scr_debug_log(
			"BATTLE",
			"HEAL",
			_ref_target,
			string_upper(_ref_target._str_team) + " " +
			string_upper(_ref_target._ref_unit._str_beast_name) +
			" HEALED 0 HP | BLOOD MOON PREVENTED HEALING",
			"BATTLE",
			"SCR_BATTLE_HEAL_TARGET"
		);

		return false;
	}

	//================//
	//CHECK BLOOMTIDE//
	//================//
	var _ref_bloomtide = scr_status_check(
		"EVENT: BLOOMTIDE",
		global.list_statuses
	);

	var _flag_bloomtide =
		_ref_bloomtide != -1 &&
		instance_exists(_ref_bloomtide);

	//===========================//
	//CHECK BEFORE HEALING TRAPS//
	//===========================//
	if (
		scr_battle_trigger_heal_traps(
			_ref_target,
			"BEFORE"
		)
	){
		return false;
	}

	//========================//
	//MODIFY HEALING RECEIVED//
	//========================//
	var _val_healing_requested = _val_mode_healing;

	var _val_healing = scr_battle_get_healing_received_amount(
		_val_mode_healing,
		_ref_target
	);

	#endregion

	#region HEALING

	//================//
	//STORE OLD STATE//
	//================//
	var _val_hp_before = _ref_target._val_cur_hp;
	var _val_overhealth_before = _ref_target._val_overhealth;

	//=====================//
	//CALCULATE HP RESTORED//
	//=====================//
	var _val_missing_hp = max(
		0,
		_ref_target._val_max_hp -
		_ref_target._val_cur_hp
	);

	var _val_healed = min(
		_val_healing,
		_val_missing_hp
	);

	//====================//
	//CALCULATE OVERHEAL//
	//====================//
	var _val_overheal = 0;

	if (_flag_bloomtide){

		_val_overheal = max(
			0,
			_val_healing -
			_val_healed
		);
	}

	//========//
	//HEAL HP//
	//========//
	_ref_target._val_cur_hp = min(
		_ref_target._val_cur_hp +
			_val_healed,
		_ref_target._val_max_hp
	);

	//=============//
	//HEAL POPUP//
	//=============//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"+" + string(_val_healed),
		undefined,
		c_green,
		_ref_target.x + irandom_range(-32,32),
		_ref_target.y - 24 + irandom_range(-32,32)
	);

	//==================//
	//HEAL PRESENTATION//
	//==================//
	scr_battle_play_heal_vfx(
		_ref_target
	);

	#endregion

	#region PERSISTENT OVERHEALTH

	//================================//
	//CONVERT BLOOMTIDE EXCESS HEALING//
	//================================//
	var _val_persistent_overhealth_added = 0;

	if (_val_overheal > 0){

		var _ref_persistent_overhealth = scr_status_apply_buff(
			"PERSISTENT_OVERHEALTH",
			_ref_target,
			_val_overheal
		);

		if (instance_exists(_ref_persistent_overhealth)){

			_val_persistent_overhealth_added = max(
				0,
				_ref_target._val_overhealth -
				_val_overhealth_before
			);
		}
	}

	#endregion

	#region DEBUG

	//================//
	//GET HEAL SOURCE//
	//================//
	var _str_source = "SYSTEM";

	if (
		instance_exists(global.ref_cast_card) &&
		is_struct(global.ref_cast_card._ref_card)
	){
		_str_source = string_upper(
			global.ref_cast_card._ref_card._str_card_name
		);
	}

	//================//
	//BUILD MESSAGE//
	//================//
	var _str_message =
		string_upper(_ref_target._str_team) + " " +
		string_upper(_ref_target._ref_unit._str_beast_name) +
		" HEALED " + string(_val_healed) +
		" HP | " +
		string(_val_hp_before) +
		"/" + string(_ref_target._val_max_hp) +
		" -> " +
		string(_ref_target._val_cur_hp) +
		"/" + string(_ref_target._val_max_hp) +
		" | MODE: " + _str_mode +
		" | SOURCE: " + _str_source;

	//================//
	//HEAL MODIFIERS//
	//================//
	if (_val_healing != _val_healing_requested){

		_str_message +=
			" | HEALING: " +
			string(_val_healing_requested) +
			" -> " +
			string(_val_healing);
	}

	//==========================//
	//BLOOMTIDE PERSISTENT HP//
	//==========================//
	if (_val_persistent_overhealth_added > 0){

		_str_message +=
			" | PERSISTENT OVERHEALTH: +" +
			string(_val_persistent_overhealth_added) +
			" | TOTAL OVERHEALTH: " +
			string(_val_overhealth_before) +
			" -> " +
			string(_ref_target._val_overhealth);
	}

	//================//
	//LOG HEAL RESULT//
	//================//
	scr_debug_log(
		"BATTLE",
		"HEAL",
		_ref_target,
		_str_message,
		"BATTLE",
		"SCR_BATTLE_HEAL_TARGET"
	);

	#endregion

	#region HEAL TRIGGERS

	//==========================//
	//HEART OF THE FOREST//
	//==========================//
	if (_val_healed > 0){

		scr_status_trigger_heart_of_the_forest(
			_ref_target,
			_val_healed
		);
	}

	//======================//
	//TRIGGER HEALING AURAS//
	//======================//
	if (_flag_trigger_auras){

		scr_status_trigger_heal_auras(
			_ref_target,
			_val_healing
		);
	}

	//=====================//
	//TRIGGER HEALING BUFFS//
	//=====================//
	scr_status_trigger_heal_buffs(
		_ref_target,
		_val_healing
	);

	#endregion

	#region POST-HEAL TRAPS

	//==========================//
	//CHECK AFTER HEALING TRAPS//
	//==========================//
	scr_battle_trigger_heal_traps(
		_ref_target,
		"AFTER"
	);

	#endregion

	return true;
}