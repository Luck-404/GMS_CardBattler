//===============================================================================//
//
// SCRIPT: SCR_DAMAGE_TARGET_ARMOR_PIERCE
// FUNCTION: Deals armor-piercing damage to a target battle Beast.
//           Applies dodge, color bonuses, critical damage, outgoing and incoming
//           damage modifiers, Power scaling, Defense mitigation, and minions.
//           Bypasses Armor and Overhealth before damaging HP.
//
//===============================================================================//

function scr_damage_target_armor_pierce(_val_damage,_ref_target){

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
	var _ref_caster =
		global.ref_caster_beast;

	if (!instance_exists(_ref_caster)){
		return false;
	}

	if (!is_struct(_ref_caster._ref_unit)){
		return false;
	}

	//--------------//
	//VALIDATE CARD//
	//--------------//
	var _ref_cast_card =
		global.ref_cast_card;

	if (!instance_exists(_ref_cast_card)){
		return false;
	}

	if (!is_struct(_ref_cast_card._ref_card)){
		return false;
	}

	var _stct_card =
		_ref_cast_card._ref_card;

	var _str_card_stat =
		_stct_card._str_card_stat;

	//-------------//
	//BASE DAMAGE//
	//-------------//
	var _val_damage_left =
		max(0,_val_damage);

	if (_val_damage_left <= 0){
		return false;
	}

//-------------//
//TARGET DODGE//
//-------------//
var _val_dodge = 0;

if (_ref_target._ct_dodge_disabled <= 0){

	_val_dodge = clamp(
		_ref_target._ref_unit._val_beast_dod_stat +
		_ref_target._val_dodge_bonus,
		0,
		100
	);
}

	var _val_dodge_roll =
		irandom_range(1,100);

	if (_val_dodge_roll <= _val_dodge){

		scr_spawn_popup_scrolling(
			"TEXT",
			"DODGED",
			undefined,
			c_white,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);

		return false;
	}

	//--------------------------//
	//SEEDFALL COLOR BONUS//
	//--------------------------//
	var _ref_status = scr_check_for_status(
		"WEATHER: SEEDFALL",
		global.list_statuses
	);

	if (_ref_status != -1){

		var _arr_card_colors =
			_stct_card._arr_card_colors;

		var _flag_viridian_card =
			false;

		if (is_array(_arr_card_colors)){

			for (
				var _it_color = 0;
				_it_color < array_length(_arr_card_colors);
				_it_color++
			){

				if (_arr_card_colors[_it_color] == "VIRIDIAN"){

					_flag_viridian_card =
						true;

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
	var _val_crit_chance = clamp(
		_ref_caster._val_crit_chance,
		0,
		100
	);

	var _val_crit_damage = max(
		0,
		_ref_caster._val_crit_damage
	);

	var _val_crit_roll =
		irandom_range(1,100);

	if (_val_crit_roll <= _val_crit_chance){

		_val_damage_left *=
			1 +
			(_val_crit_damage / 100);

		scr_spawn_popup_scrolling(
			"TEXT",
			"CRIT",
			undefined,
			c_maroon,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

	//----------------------------//
	//OUTGOING LINEAR MODIFIERS//
	//----------------------------//
	var _val_outgoing_linear_modifier =
		_ref_caster._val_dmg_linear_bonus -
		_ref_caster._val_dmg_linear_reduction;

	_val_damage_left +=
		_val_outgoing_linear_modifier;

	//----------------------------//
	//INCOMING LINEAR MODIFIERS//
	//----------------------------//
	var _val_incoming_linear_modifier =
		_ref_target._val_dmg_taken_linear_bonus -
		_ref_target._val_dmg_taken_linear_reduction;

	_val_damage_left +=
		_val_incoming_linear_modifier;

	//----------------------------//
	//OUTGOING SCALAR MODIFIERS//
	//----------------------------//
	var _val_outgoing_scalar_modifier =
		_ref_caster._val_dmg_scalar_bonus -
		_ref_caster._val_dmg_scalar_reduction;

	var _val_outgoing_scalar_multiplier = max(
		0,
		1 +
		(_val_outgoing_scalar_modifier / 100)
	);

	_val_damage_left *=
		_val_outgoing_scalar_multiplier;

	//----------------------------//
	//INCOMING SCALAR MODIFIERS//
	//----------------------------//
	var _val_incoming_scalar_modifier =
		_ref_target._val_dmg_taken_scalar_bonus -
		_ref_target._val_dmg_taken_scalar_reduction;

	var _val_incoming_scalar_multiplier = max(
		0,
		1 +
		(_val_incoming_scalar_modifier / 100)
	);

	_val_damage_left *=
		_val_incoming_scalar_multiplier;

	//------------------//
	//CHECK DAMAGE FLOOR//
	//------------------//
	if (_val_damage_left <= 0){

		scr_spawn_popup_scrolling(
			"TEXT",
			"TOO WEAK",
			undefined,
			c_white,
			_ref_caster.x + irandom_range(-32,32),
			_ref_caster.y - 24 + irandom_range(-32,32)
		);

		return false;
	}

	//----------------------//
	//ATTACKER POWER SCALING//
	//----------------------//
	if (_str_card_stat == "PHY"){

		var _val_ppow_stat =
			_ref_caster._ref_unit._val_beast_ppow_stat;

		var _val_ppow_modifier = max(
			0.1,
			scr_get_beast_grade_modifier(_val_ppow_stat)
		);

		_val_damage_left *=
			_val_ppow_modifier;
	}
	else if (_str_card_stat == "MAG"){

		var _val_mpow_stat =
			_ref_caster._ref_unit._val_beast_mpow_stat;

		var _val_mpow_modifier = max(
			0.1,
			scr_get_beast_grade_modifier(_val_mpow_stat)
		);

		_val_damage_left *=
			_val_mpow_modifier;
	}

	//----------------//
	//DAMAGE REDIRECT//
	//----------------//
	_ref_target =
		scr_resolve_damage_redirect(
			_ref_target
		);

	if (!instance_exists(_ref_target)){
		return false;
	}

	//--------------------//
	//DEFENDER MITIGATION//
	//--------------------//
	if (_str_card_stat == "PHY"){

		var _val_pdef_stat =
			_ref_target._ref_unit._val_beast_pdef_stat;

		var _val_pdef_modifier = max(
			0.1,
			scr_get_beast_grade_modifier(_val_pdef_stat)
		);

		_val_damage_left /=
			_val_pdef_modifier;
	}
	else if (_str_card_stat == "MAG"){

		var _val_mdef_stat =
			_ref_target._ref_unit._val_beast_mdef_stat;

		var _val_mdef_modifier = max(
			0.1,
			scr_get_beast_grade_modifier(_val_mdef_stat)
		);

		_val_damage_left /=
			_val_mdef_modifier;
	}

	//----------------//
	//FINALIZE DAMAGE//
	//----------------//
	_val_damage_left = max(
		0,
		ceil(_val_damage_left)
	);

	if (_val_damage_left <= 0){
		return false;
	}

	//-------------------//
	//MINION ABSORPTION//
	//-------------------//
	var _list_minions =
		_ref_target._list_minions;

	for (
		var _it_minion = ds_list_size(_list_minions) - 1;
		_it_minion >= 0;
		_it_minion--
	){

		var _ref_minion =
			ds_list_find_value(
				_list_minions,
				_it_minion
			);

		if (!instance_exists(_ref_minion)){

			ds_list_delete(
				_list_minions,
				_it_minion
			);
		}
	}

	var _ct_minions =
		ds_list_size(_list_minions);

	if (
		_ct_minions > 0 &&
		_val_damage_left > 0
	){

		var _val_damage_per_minion =
			_val_damage_left div _ct_minions;

		var _val_remainder =
			_val_damage_left mod _ct_minions;

		var _val_total_applied =
			0;

		for (
			var _it_minion = _ct_minions - 1;
			_it_minion >= 0;
			_it_minion--
		){

			var _ref_minion =
				ds_list_find_value(
					_list_minions,
					_it_minion
				);

			if (!instance_exists(_ref_minion)){
				continue;
			}

			var _val_take =
				_val_damage_per_minion;

			if (_val_remainder > 0){

				_val_take++;

				_val_remainder--;
			}

			var _val_actual = min(
				_val_take,
				_ref_minion._val_cur_hp
			);

			if (_val_actual <= 0){
				continue;
			}

			_ref_minion._val_cur_hp -=
				_val_actual;

			_val_total_applied +=
				_val_actual;

			scr_spawn_popup_scrolling(
				"TEXT",
				"-" + string(_val_actual),
				undefined,
				c_maroon,
				_ref_minion.x + irandom_range(-16,16),
				_ref_minion.y - 16 + irandom_range(-16,16)
			);

			if (_ref_minion._val_cur_hp <= 0){

				_ref_minion._val_cur_hp = 0;

				scr_destroy_minion(_ref_minion,"DEATH");
			}
		}

		_val_damage_left -=
			_val_total_applied;

		scr_reposition_minions(
			_ref_target
		);

		scr_reposition_statuses(
			_ref_target
		);
	}

	//--------//
	//HOST HP//
	//--------//
	var _val_hp_damage = 0;

	if (_val_damage_left > 0){

		_val_hp_damage = min(
			_val_damage_left,
			_ref_target._val_cur_hp
		);

		if (_val_hp_damage > 0){

			scr_spawn_popup_scrolling(
				"TEXT",
				"-" + string(_val_hp_damage),
				undefined,
				c_maroon,
				_ref_target.x + irandom_range(-32,32),
				_ref_target.y - 24 + irandom_range(-32,32)
			);

			_ref_target._val_cur_hp = max(
				0,
				_ref_target._val_cur_hp -
				_val_hp_damage
			);
		}
	}

	//------------//
	//WAKE SLEEP//
	//------------//
	if (_val_hp_damage > 0){
		scr_wake_sleep_on_damage(_ref_target);
	}

	//--------------------//
	//ON TARGET HELD ITEM//
	//--------------------//
	if (_val_hp_damage > 0){

		var _stct_target_item =
			_ref_target._stct_held_item;

		if (
			_stct_target_item != undefined &&
			_stct_target_item != "EMPTY" &&
			_stct_target_item._str_item_trigger_type == "ON_TARGET" &&
			_stct_target_item._scr_item != undefined
		){

			var _flag_triggered = script_execute(
				_stct_target_item._scr_item,
				"TRIGGER",
				_stct_target_item,
				_ref_target
			);

			if (_flag_triggered){

				_ref_target._stct_held_item =
					"EMPTY";
			}
		}
	}

	//-----------------//
	//ON HIT HELD ITEM//
	//-----------------//
	var _stct_caster_item =
		_ref_caster._stct_held_item;

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

	//----------------------//
	//MELEE DEFENSE TRIGGERS//
	//----------------------//
	if (
		!global.flag_thorns_retaliating &&
		_stct_card._str_card_type == "ATTACK" &&
		_stct_card._str_card_range == "MELEE"
	){
		scr_trigger_melee_defense_buffs(
			_ref_target,
			_ref_caster
		);
	}

	return true;
}