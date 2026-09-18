//===============================================================================//
//
// SCRIPT: SCR_BATTLE_DAMAGE_TARGET
// FUNCTION: Deals standard direct damage to a target battle Beast.
//           Resolves Dodge, protection, color/critical bonuses, damage modifiers,
//           Power scaling, Defense mitigation, Minions, Armor, Overhealth, HP,
//           held items, reactive statuses, and post-damage triggers.
//
// ARGUMENTS: _val_damage is base damage before combat modifiers.
//            _ref_target is the initially targeted battle Beast.
//            _stct_presentation is an optional hit-presentation override.
// RETURNS: True when the damage instance resolves, otherwise false.
//
//===============================================================================//

function scr_battle_damage_target(_val_damage,_ref_target,_stct_presentation=undefined){

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

	var _stct_caster_unit = _ref_caster._ref_unit;

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
	var _str_card_stat = _stct_card._str_card_stat;

	//-------------//
	//BASE DAMAGE//
	//-------------//
	var _val_damage_left = max(0,_val_damage);

	if (_val_damage_left <= 0){
		return false;
	}

	#endregion

	#region PRE-DAMAGE EFFECTS

	//--------------------------//
	//CALL THE DEEP DAMAGE BONUS//
	//--------------------------//
	_val_damage_left += scr_status_consume_call_the_deep_damage(_ref_caster);

	//-------------//
	//TARGET DODGE//
	//-------------//
	var _val_dodge = scr_battle_get_effective_dodge(_ref_caster,_ref_target);
	var _val_dodge_roll = irandom_range(1,100);

	if (_val_dodge_roll <= _val_dodge){

		//---------------//
		//DODGE ANIMATION//
		//---------------//
		scr_battle_vfx_dodge(_ref_target);

		//----------//
		//FEEDBACK//
		//----------//
		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"DODGED",
			undefined,
			c_white,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);

		//----------------//
		//DEBUG DODGE//
		//----------------//
		scr_debug_log(
			"BATTLE",
			"DODGE",
			_ref_target,
			string_upper(_ref_target._str_team) + " " +
			string_upper(_ref_target._ref_unit._str_beast_name) +
			" DODGED " +
			string_upper(_ref_caster._str_team) + " " +
			string_upper(_ref_caster._ref_unit._str_beast_name) +
			"'S " +
			string_upper(_stct_card._str_card_name) +
			" | ROLL: " + string(_val_dodge_roll) +
			"/" + string(_val_dodge),
			"BATTLE",
			"SCR_BATTLE_DAMAGE_TARGET"
		);

		return false;
	}

	//-------------------//
	//DIVINE PROTECTION//
	//-------------------//
	if (scr_status_trigger_divine_protection(_ref_target)){

		//----------------//
		//DEBUG BLOCK//
		//----------------//
		scr_debug_log(
			"BATTLE",
			"BLOCK",
			_ref_target,
			string_upper(_ref_target._str_team) + " " +
			string_upper(_ref_target._ref_unit._str_beast_name) +
			" BLOCKED " +
			string_upper(_ref_caster._str_team) + " " +
			string_upper(_ref_caster._ref_unit._str_beast_name) +
			"'S " +
			string_upper(_stct_card._str_card_name) +
			" | DIVINE PROTECTION",
			"BATTLE",
			"SCR_BATTLE_DAMAGE_TARGET"
		);

		return false;
	}

	#endregion

	#region DAMAGE BONUSES

	//========================//
	//HEATWAVE DAMAGE BONUS//
	//========================//
	_val_damage_left *= scr_status_get_heatwave_damage_multiplier(
		_stct_card
	);

	//================//
	//RAIN DAMAGE BONUS//
	//================//
	if (
		scr_status_check("WEATHER: RAIN",global.list_statuses) != -1 &&
		array_contains(_stct_card._arr_card_colors,"CERULEAN")
	){
		_val_damage_left *= 1.25;
	}

	//----------------------//
	//SEEDFALL COLOR BONUS//
	//----------------------//
	var _ref_seedfall = scr_status_check("WEATHER: SEEDFALL",global.list_statuses);

	if (_ref_seedfall != -1){

		var _arr_card_colors = _stct_card._arr_card_colors;
		var _flag_viridian_card = false;

		if (is_array(_arr_card_colors)){

			for (var _it_color = 0; _it_color < array_length(_arr_card_colors); _it_color++){

				if (_arr_card_colors[_it_color] == "VIRIDIAN"){
					_flag_viridian_card = true;
					break;
				}
			}
		}

		if (_flag_viridian_card){
			_val_damage_left *= 1.25;
		}
	}

	//------//
	//CRIT//
	//------//
	var _flag_critical = false;

	var _val_crit_chance = clamp(_ref_caster._val_crit_chance,0,100);
	var _val_crit_damage = max(0,_ref_caster._val_crit_damage);
	var _val_crit_roll = irandom_range(1,100);

	if (_val_crit_roll <= _val_crit_chance){

		_flag_critical = true;
		_val_damage_left *= 1 + (_val_crit_damage / 100);

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"CRIT",
			undefined,
			c_maroon,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

	#endregion

	#region DAMAGE MODIFIERS

	//--------------------------//
	//OUTGOING LINEAR MODIFIERS//
	//--------------------------//
	var _val_outgoing_linear_modifier =
		_ref_caster._val_dmg_linear_bonus -
		_ref_caster._val_dmg_linear_reduction;

	_val_damage_left += _val_outgoing_linear_modifier;

	//--------------------------//
	//INCOMING LINEAR MODIFIERS//
	//--------------------------//
	var _val_incoming_linear_modifier =
		_ref_target._val_dmg_taken_linear_bonus -
		_ref_target._val_dmg_taken_linear_reduction;

	_val_damage_left += _val_incoming_linear_modifier;

	//--------------------------//
	//OUTGOING SCALAR MODIFIERS//
	//--------------------------//
	var _val_outgoing_scalar_modifier =
		_ref_caster._val_dmg_scalar_bonus -
		_ref_caster._val_dmg_scalar_reduction;

	var _val_outgoing_scalar_multiplier = max(
		0,
		1 + (_val_outgoing_scalar_modifier / 100)
	);

	_val_damage_left *= _val_outgoing_scalar_multiplier;

	//--------------------------//
	//INCOMING SCALAR MODIFIERS//
	//--------------------------//
	var _val_incoming_scalar_modifier =
		_ref_target._val_dmg_taken_scalar_bonus -
		_ref_target._val_dmg_taken_scalar_reduction;

	var _val_incoming_scalar_multiplier = max(
		0,
		1 + (_val_incoming_scalar_modifier / 100)
	);

	_val_damage_left *= _val_incoming_scalar_multiplier;

	//------------------//
	//CHECK DAMAGE FLOOR//
	//------------------//
	if (_val_damage_left <= 0){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"TOO WEAK",
			undefined,
			c_white,
			_ref_caster.x + irandom_range(-32,32),
			_ref_caster.y - 24 + irandom_range(-32,32)
		);

		return false;
	}

	#endregion

	#region POWER SCALING

	//----------------------//
	//ATTACKER POWER SCALING//
	//----------------------//
	if (_str_card_stat == "PHY"){

		var _val_ppow_modifier = max(
			0.1,
			scr_beast_get_grade_modifier(_stct_caster_unit._val_beast_ppow_stat)
		);

		_val_damage_left *= _val_ppow_modifier;
	}
	else if (_str_card_stat == "MAG"){

		var _val_mpow_modifier = max(
			0.1,
			scr_beast_get_grade_modifier(_stct_caster_unit._val_beast_mpow_stat)
		);

		_val_damage_left *= _val_mpow_modifier;
	}

	#endregion

	#region DAMAGE REDIRECT

	//----------------//
	//DAMAGE REDIRECT//
	//----------------//
	_ref_target = scr_status_resolve_damage_redirect(_ref_target);

	if (!instance_exists(_ref_target)){
		return false;
	}

	if (!is_struct(_ref_target._ref_unit)){
		return false;
	}

	var _stct_target_unit = _ref_target._ref_unit;

	#endregion

	#region DEFENSE MITIGATION

	//--------------------//
	//DEFENDER MITIGATION//
	//--------------------//
	if (_str_card_stat == "PHY"){

		var _val_pdef_modifier = max(
			0.1,
			scr_beast_get_grade_modifier(_stct_target_unit._val_beast_pdef_stat)
		);

		_val_damage_left /= _val_pdef_modifier;
	}
	else if (_str_card_stat == "MAG"){

		var _val_mdef_modifier = max(
			0.1,
			scr_beast_get_grade_modifier(_stct_target_unit._val_beast_mdef_stat)
		);

		_val_damage_left /= _val_mdef_modifier;
	}

	//----------------//
	//FINALIZE DAMAGE//
	//----------------//
	_val_damage_left = max(0,ceil(_val_damage_left));

	if (_val_damage_left <= 0){
		return false;
	}

	//================//
	//FURNACE HEART//
	//================//
	if (
		scr_status_trigger_furnace_heart(
			_ref_target,
			_val_damage_left
		)
	){
		return false;
	}
	//===================//
	//TRIGGER BACKDRAFT//
	//===================//
	_val_damage_left = scr_status_trigger_backdraft(
		_ref_target,
		_ref_caster,
		_val_damage_left
	);

	if (_val_damage_left <= 0){
		return true;
	}


	//--------------------//
	//STORE FINAL DAMAGE//
	//--------------------//
	var _val_final_damage = _val_damage_left;

	#endregion

	#region HIT PRESENTATION

	//------------//
	//PLAY HIT VFX//
	//------------//
	var _ref_hit_vfx = scr_battle_vfx_damage_hit(
		_ref_target,
		_str_card_stat,
		_val_damage_left,
		_stct_presentation
	);

	var _ct_hit_vfx_delay = 0;

	if (instance_exists(_ref_hit_vfx)){
		_ct_hit_vfx_delay = _ref_hit_vfx._ct_start_delay;
	}

	//--------//
	//CRIT VFX//
	//--------//
	if (_flag_critical){

		scr_battle_vfx(
			_ref_target,
			spr_battle_vfx_crit,
			undefined,
			undefined,
			6,
			6,
			1,
			_ct_hit_vfx_delay,
			snd_battle_crit
		);
	}

	#endregion

	#region MINION ABSORPTION

	//-----------------//
	//GET HOST MINIONS//
	//-----------------//
	var _list_minions = _ref_target._list_minions;

	//-----------------------//
	//REMOVE INVALID MINIONS//
	//-----------------------//
	for (var _it_minion = ds_list_size(_list_minions) - 1; _it_minion >= 0; _it_minion--){

		var _ref_minion = ds_list_find_value(_list_minions,_it_minion);

		if (!instance_exists(_ref_minion)){
			ds_list_delete(_list_minions,_it_minion);
		}
	}

	//-------------------//
	//MINION ABSORPTION//
	//-------------------//
	var _ct_minions = ds_list_size(_list_minions);
	var _val_minion_damage_applied = 0;

	if (_ct_minions > 0 && _val_damage_left > 0){

		var _val_damage_per_minion = _val_damage_left div _ct_minions;
		var _val_minion_damage_remainder = _val_damage_left mod _ct_minions;

		for (var _it_minion = _ct_minions - 1; _it_minion >= 0; _it_minion--){

			var _ref_minion = ds_list_find_value(_list_minions,_it_minion);

			if (!instance_exists(_ref_minion)){
				continue;
			}

			//-----------------------//
			//CALCULATE MINION DAMAGE//
			//-----------------------//
			var _val_minion_damage = _val_damage_per_minion;

			if (_val_minion_damage_remainder > 0){
				_val_minion_damage++;
				_val_minion_damage_remainder--;
			}

			var _val_actual_minion_damage = min(_val_minion_damage,_ref_minion._val_cur_hp);

			if (_val_actual_minion_damage <= 0){
				continue;
			}

			//--------------//
			//DAMAGE MINION//
			//--------------//
			_ref_minion._val_cur_hp -= _val_actual_minion_damage;
			_val_minion_damage_applied += _val_actual_minion_damage;

			//----------//
			//FEEDBACK//
			//----------//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"-" + string(_val_actual_minion_damage),
				undefined,
				c_maroon,
				_ref_minion.x + irandom_range(-16,16),
				_ref_minion.y - 16 + irandom_range(-16,16)
			);

			//--------------//
			//MINION DEATH//
			//--------------//
			if (_ref_minion._val_cur_hp <= 0){
				_ref_minion._val_cur_hp = 0;
				scr_minion_destroy(_ref_minion,"DEATH");
			}
		}

		//-----------------------//
		//REMOVE ABSORBED DAMAGE//
		//-----------------------//
		_val_damage_left -= _val_minion_damage_applied;

		scr_minion_reposition(_ref_target);
		scr_status_reposition(_ref_target);
	}

	#endregion

	#region BEAST DAMAGE

	//-------------------//
	//TRACK BEAST DAMAGE//
	//-------------------//
	var _val_beast_damage = 0;
	var _val_armor_blocked = 0;
	var _val_overhealth_blocked = 0;

	//-------//
	//ARMOR//
	//-------//
	if (_val_damage_left > 0 && _ref_target._val_armor > 0){

		//------------------//
		//STORE ARMOR BEFORE//
		//------------------//
		var _val_armor_before = _ref_target._val_armor;

		//-----------------------//
		//CALCULATE ARMOR BLOCKED//
		//-----------------------//
		_val_armor_blocked = min(_ref_target._val_armor,_val_damage_left);

		//----------//
		//FEEDBACK//
		//----------//
		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_val_armor_blocked),
			undefined,
			c_blue,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);

		//-------------//
		//DAMAGE ARMOR//
		//-------------//
		_ref_target._val_armor -= _val_armor_blocked;
		_val_damage_left -= _val_armor_blocked;

		//----------------//
		//FULL ARMOR BLOCK//
		//----------------//
		if (_val_damage_left <= 0 && _stct_card._str_card_type == "ATTACK"){
			scr_battle_vfx_blocked(_ref_target,_ct_hit_vfx_delay);
		}

		//----------------//
		//ARMOR BREAK VFX//
		//----------------//
		if (_val_armor_before > 0 && _ref_target._val_armor <= 0){

			scr_battle_vfx(
				_ref_target,
				spr_battle_vfx_armor_break,
				undefined,
				undefined,
				4,
				4,
				1,
				_ct_hit_vfx_delay,
				snd_battle_armor_break
			);
		}
	}

	//------------//
	//OVERHEALTH//
	//------------//
	if (_val_damage_left > 0 && _ref_target._val_overhealth > 0){

		_val_overhealth_blocked = min(_ref_target._val_overhealth,_val_damage_left);

		//----------//
		//FEEDBACK//
		//----------//
		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_val_overhealth_blocked),
			undefined,
			c_green,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);

		//-----------------//
		//DAMAGE OVERHEALTH//
		//-----------------//
		_ref_target._val_overhealth -= _val_overhealth_blocked;
		_val_damage_left -= _val_overhealth_blocked;
		_val_beast_damage += _val_overhealth_blocked;
	}

	//--------//
	//HOST HP//
	//--------//
	var _val_hp_damage = 0;

	if (_val_damage_left > 0){

		_val_hp_damage = min(_val_damage_left,_ref_target._val_cur_hp);

		if (_val_hp_damage > 0){

			//----------//
			//FEEDBACK//
			//----------//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"-" + string(_val_hp_damage),
				undefined,
				c_maroon,
				_ref_target.x + irandom_range(-32,32),
				_ref_target.y - 24 + irandom_range(-32,32)
			);

			//----------//
			//DAMAGE HP//
			//----------//
			_ref_target._val_cur_hp = max(0,_ref_target._val_cur_hp - _val_hp_damage);
			_val_beast_damage += _val_hp_damage;
		}
	}

	#endregion

	#region DEBUG DAMAGE

	//------------------//
	//LOG DAMAGE RESULT//
	//------------------//
	scr_debug_log_damage_result(
		_ref_caster,
		_ref_target,
		_stct_card,
		_val_final_damage,
		_val_minion_damage_applied,
		_val_armor_blocked,
		_val_overhealth_blocked,
		_val_hp_damage,
		_flag_critical,
		"STANDARD",
		"SCR_BATTLE_DAMAGE_TARGET"
	);

	#endregion

	#region DAMAGE TRIGGERS

	//================//
	//DAMAGE TRAPS//
	//================//
	if (_val_armor_blocked + _val_beast_damage > 0){
		scr_battle_trigger_damage_traps(
			_ref_target,
			_val_armor_blocked + _val_beast_damage
		);
	}

	//------------//
	//WAKE SLEEP//
	//------------//
	if (_val_beast_damage > 0){
		scr_status_wake_sleep_on_damage(_ref_target);
	}

	//--------------------//
	//TRIGGER DAMAGE AURAS//
	//--------------------//
	if (_val_beast_damage > 0){
		scr_status_trigger_damage_auras(_ref_target,_val_beast_damage);
	}

	//--------------------//
	//ON TARGET HELD ITEM//
	//--------------------//
	if (_val_hp_damage > 0){

		var _stct_target_item = _ref_target._stct_held_item;

		if (
			_stct_target_item != undefined &&
			_stct_target_item != "EMPTY" &&
			_stct_target_item._str_item_trigger_type == "ON_TARGET" &&
			_stct_target_item._scr_item != undefined
		){

			var _flag_target_item_triggered = script_execute(
				_stct_target_item._scr_item,
				"TRIGGER",
				_stct_target_item,
				_ref_target
			);

			if (_flag_target_item_triggered){
				_ref_target._stct_held_item = "EMPTY";
			}
		}
	}

	//-----------------//
	//ON HIT HELD ITEM//
	//-----------------//
	var _stct_caster_item = _ref_caster._stct_held_item;

	if (
		_stct_caster_item != undefined &&
		_stct_caster_item != "EMPTY" &&
		_stct_caster_item._str_item_trigger_type == "ON_HIT" &&
		_stct_caster_item._scr_item != undefined
	){

		script_execute(
			_stct_caster_item._scr_item,
			"TRIGGER",
			_stct_caster_item,
			_ref_caster,
			_ref_target,
			_str_card_stat
		);
	}

	//------------------//
	//ON DEFENSE BUFFS//
	//------------------//
	if (instance_exists(_ref_caster) && instance_exists(_ref_target)){
		scr_status_trigger_defense_buffs(_ref_target,_ref_caster,_stct_card);
	}

	//---------------------//
	//FROZEN CURSE TRIGGER//
	//---------------------//
	if (
		!global.flag_frozen_curse_triggering &&
		!global.flag_thorns_retaliating &&
		_stct_card._str_card_type == "ATTACK" &&
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){
		scr_status_trigger_frozen_curse(_ref_target,_ref_caster);
	}

	//----------------------//
	//MELEE DEFENSE TRIGGERS//
	//----------------------//
	if (
		!global.flag_thorns_retaliating &&
		_stct_card._str_card_type == "ATTACK" &&
		_stct_card._str_card_range == "MELEE"
	){
		scr_status_trigger_melee_defense_buffs(_ref_target,_ref_caster);
	}

	#endregion

	return true;
}