//===============================================================================//
//
// SCRIPT: SCR_BATTLE_DAMAGE_TARGET
// FUNCTION: Resolves direct Card damage using LINEAR or target-Max-HP PERCENT
//           bases, or card-independent FIXED damage.
//           FIXED preserves the former dedicated fixed-damage pipeline.
//           Armor piercing applies only to Card damage.
//
// ARGUMENTS: _str_mode - LINEAR, PERCENT, or FIXED.
//            _ref_caster - attacking Beast for LINEAR/PERCENT; optional source
//            Minion for FIXED.
//            _ref_target - selected battle Beast.
//            _val_amount - base amount or PERCENT value.
//            _stct_options - Card/options struct for LINEAR/PERCENT.
// RETURNS: True when the damage instance resolves; otherwise false.
//
//===============================================================================//

function scr_battle_damage_target(_str_mode,_ref_caster,_ref_target,_val_amount,_stct_options=undefined){

	#region VALIDATION

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (_ref_target == -1 || !instance_exists(_ref_target)){
		return false;
	}

	if (!is_struct(_ref_target._ref_unit)){
		return false;
	}

	//=======================//
	//VALIDATE DAMAGE MODE//
	//=======================//
	if (
		_str_mode != "LINEAR" &&
		_str_mode != "PERCENT" &&
		_str_mode != "FIXED"
	){
		return false;
	}

	if (!is_real(_val_amount) || _val_amount <= 0){
		return false;
	}

	#region FIXED DAMAGE

	//==================//
	//FIXED DAMAGE MODE//
	//==================//
	if (_str_mode == "FIXED"){

		/*
			FIXED preserves the former dedicated fixed-damage pipeline.

			It does not require a Card struct or battle Beast caster and does not
			resolve Dodge, Critical Hits, Power scaling, Defense mitigation,
			Weather/Card damage bonuses, or direct-Attack triggers.

			When _ref_caster is an obj_battle_minion, it is retained as the
			killing Minion for Minion-death mechanics such as Cinderling.
		*/

		//================//
		//SOURCE MINION//
		//================//
		var _ref_fixed_source_minion = undefined;

		if (
			instance_exists(_ref_caster) &&
			_ref_caster.object_index == obj_battle_minion
		){
			_ref_fixed_source_minion = _ref_caster;
		}

		//================//
		//BASE DAMAGE//
		//================//
		var _val_fixed_damage_left = max(
			0,
			_val_amount
		);

		if (_val_fixed_damage_left <= 0){
			return false;
		}

		var _val_fixed_final_damage =
			_val_fixed_damage_left;

		//================//
		//DAMAGE REDIRECT//
		//================//
		_ref_target = scr_status_resolve_damage_redirect(
			_ref_target
		);

		if (!instance_exists(_ref_target)){
			return false;
		}

		//===================//
		//MINION ABSORPTION//
		//===================//
		var _val_fixed_minion_damage = 0;

		if (ds_exists(_ref_target._list_minions,ds_type_list)){

			var _list_fixed_minions =
				_ref_target._list_minions;

			//-----------------------//
			//REMOVE INVALID MINIONS//
			//-----------------------//
			for (
				var _it_fixed_minion =
					ds_list_size(_list_fixed_minions) - 1;
				_it_fixed_minion >= 0;
				_it_fixed_minion--
			){

				var _ref_fixed_minion = ds_list_find_value(
					_list_fixed_minions,
					_it_fixed_minion
				);

				if (!instance_exists(_ref_fixed_minion)){

					ds_list_delete(
						_list_fixed_minions,
						_it_fixed_minion
					);
				}
			}

			var _ct_fixed_minions =
				ds_list_size(_list_fixed_minions);

			if (
				_ct_fixed_minions > 0 &&
				_val_fixed_damage_left > 0
			){

				var _val_fixed_damage_per_minion =
					_val_fixed_damage_left div
					_ct_fixed_minions;

				var _val_fixed_remainder =
					_val_fixed_damage_left mod
					_ct_fixed_minions;

				//-----------------------//
				//DISTRIBUTE MINION HIT//
				//-----------------------//
				for (
					var _it_fixed_minion =
						_ct_fixed_minions - 1;
					_it_fixed_minion >= 0;
					_it_fixed_minion--
				){

					var _ref_fixed_minion =
						ds_list_find_value(
							_list_fixed_minions,
							_it_fixed_minion
						);

					if (!instance_exists(_ref_fixed_minion)){
						continue;
					}

					var _val_fixed_take =
						_val_fixed_damage_per_minion;

					if (_val_fixed_remainder > 0){

						_val_fixed_take++;
						_val_fixed_remainder--;
					}

					var _val_fixed_actual = min(
						_val_fixed_take,
						_ref_fixed_minion._val_cur_hp
					);

					if (_val_fixed_actual <= 0){
						continue;
					}

					_ref_fixed_minion._val_cur_hp -=
						_val_fixed_actual;

					_val_fixed_minion_damage +=
						_val_fixed_actual;

					scr_gui_spawn_popup_scrolling(
						"TEXT",
						"-" + string(_val_fixed_actual),
						undefined,
						c_maroon,
						_ref_fixed_minion.x +
							irandom_range(-16,16),
						_ref_fixed_minion.y -
							16 +
							irandom_range(-16,16)
					);

					//===============//
					//DESTROY MINION//
					//===============//
					if (_ref_fixed_minion._val_cur_hp <= 0){

						_ref_fixed_minion._val_cur_hp = 0;

						scr_minion_destroy(
							_ref_fixed_minion,
							"DEATH",
							_ref_fixed_source_minion
						);
					}
				}

				_val_fixed_damage_left -=
					_val_fixed_minion_damage;
			}
		}

		//================//
		//BEAST DAMAGE//
		//================//
		var _val_fixed_beast_damage = 0;

		var _val_fixed_armor_damage = 0;
		var _val_fixed_overhealth_damage = 0;
		var _val_fixed_hp_damage = 0;

		//-------//
		//ARMOR//
		//-------//
		if (
			_val_fixed_damage_left > 0 &&
			_ref_target._val_armor > 0
		){

			_val_fixed_armor_damage = min(
				_ref_target._val_armor,
				_val_fixed_damage_left
			);

			var _stct_fixed_armor_result =
				scr_battle_destroy_armor(
					_ref_target,
					_val_fixed_armor_damage
				);

			_val_fixed_armor_damage =
				_stct_fixed_armor_result._val_armor_removed;

			_val_fixed_damage_left -=
				_val_fixed_armor_damage;

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"-" + string(_val_fixed_armor_damage),
				undefined,
				c_blue,
				_ref_target.x +
					irandom_range(-32,32),
				_ref_target.y -
					24 +
					irandom_range(-32,32)
			);
		}

		//------------//
		//OVERHEALTH//
		//------------//
		if (
			_val_fixed_damage_left > 0 &&
			_ref_target._val_overhealth > 0
		){

			_val_fixed_overhealth_damage = min(
				_ref_target._val_overhealth,
				_val_fixed_damage_left
			);

			_ref_target._val_overhealth -=
				_val_fixed_overhealth_damage;

			_val_fixed_damage_left -=
				_val_fixed_overhealth_damage;

			_val_fixed_beast_damage +=
				_val_fixed_overhealth_damage;

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"-" +
					string(_val_fixed_overhealth_damage),
				undefined,
				c_green,
				_ref_target.x +
					irandom_range(-32,32),
				_ref_target.y -
					24 +
					irandom_range(-32,32)
			);
		}

		//---------//
		//BEAST HP//
		//---------//
		if (_val_fixed_damage_left > 0){

			_val_fixed_hp_damage = min(
				_val_fixed_damage_left,
				_ref_target._val_cur_hp
			);

			if (_val_fixed_hp_damage > 0){

				_ref_target._val_cur_hp = max(
					0,
					_ref_target._val_cur_hp -
						_val_fixed_hp_damage
				);

				_val_fixed_beast_damage +=
					_val_fixed_hp_damage;

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"-" + string(_val_fixed_hp_damage),
					undefined,
					c_maroon,
					_ref_target.x +
						irandom_range(-32,32),
					_ref_target.y -
						24 +
						irandom_range(-32,32)
				);
			}
		}

		//================//
		//DEBUG DAMAGE//
		//================//
		if (instance_exists(_ref_fixed_source_minion)){

			scr_debug_log(
				"BATTLE",
				"DAMAGE",
				_ref_fixed_source_minion,
				string_upper(
					_ref_fixed_source_minion._str_team
				) + " " +
				string_upper(
					_ref_fixed_source_minion._str_name
				) +
				" DEALT " +
				string(_val_fixed_final_damage) +
				" FIXED DAMAGE TO " +
				string_upper(_ref_target._str_team) +
				" " +
				string_upper(
					_ref_target._ref_unit._str_beast_name
				) +
				" | MINIONS: " +
				string(_val_fixed_minion_damage) +
				" | ARMOR: " +
				string(_val_fixed_armor_damage) +
				" | OVERHEALTH: " +
				string(_val_fixed_overhealth_damage) +
				" | HP: " +
				string(_val_fixed_hp_damage) +
				" | TARGET HP: " +
				string(_ref_target._val_cur_hp) +
				"/" +
				string(_ref_target._val_max_hp),
				"BATTLE",
				"SCR_BATTLE_DAMAGE_TARGET"
			);
		}

		//================//
		//DAMAGE TRAPS//
		//================//
		if (
			_val_fixed_armor_damage +
			_val_fixed_beast_damage >
			0
		){

			scr_battle_trigger_damage_traps(
				_ref_target,
				_val_fixed_armor_damage +
					_val_fixed_beast_damage
			);
		}

		//============//
		//WAKE SLEEP//
		//============//
		if (_val_fixed_beast_damage > 0){

			scr_status_wake_sleep_on_damage(
				_ref_target
			);
		}

		return true;
	}

	#endregion

	//=========================//
	//VALIDATE CASTER AND CARD//
	//=========================//
	if (_ref_caster == -1 || !instance_exists(_ref_caster) || !variable_instance_exists(_ref_caster,"_ref_unit") || !is_struct(_ref_caster._ref_unit)){
		return false;
	}

	if (!is_struct(_stct_options) || !variable_struct_exists(_stct_options,"card") || !is_struct(_stct_options.card)){
		return false;
	}

	var _stct_caster_unit = _ref_caster._ref_unit;
	var _stct_card = _stct_options.card;
	var _str_card_stat = _stct_card._str_card_stat;

	//============================//
	//RESOLVE EXPLICIT OPTIONS//
	//============================//
	var _flag_pierce_armor = false;
	var _stct_presentation = undefined;
	var _ref_source_card = undefined;

	if (variable_struct_exists(_stct_options,"pierce_armor")){
		_flag_pierce_armor = (_stct_options.pierce_armor == true);
	}

	if (variable_struct_exists(_stct_options,"presentation")){
		_stct_presentation = _stct_options.presentation;
	}

	if (variable_struct_exists(_stct_options,"card_instance")){
		_ref_source_card = _stct_options.card_instance;
	}

	//===========================//
	//CALCULATE MODE BASE DAMAGE//
	//===========================//
	var _val_damage_left = max(0,_val_amount);

	if (_str_mode == "PERCENT"){
		_val_damage_left = _ref_target._val_max_hp * (_val_amount / 100);
	}

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


	//=================================//
	//PREVIEW FINAL DAMAGE RECIPIENT//
	//=================================//
	// Do not consume Redirect yet.
	// The damage floor is checked later in this function.

	var _ref_damage_recipient = scr_status_resolve_damage_redirect(
		_ref_target,
		false
	);

	if (!instance_exists(_ref_damage_recipient)){
		return false;
	}

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
		_ref_damage_recipient._val_dmg_taken_linear_bonus -
		_ref_damage_recipient._val_dmg_taken_linear_reduction;

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

//============================//
//SECOND WIND DIRECT DAMAGE//
//============================//
var _val_second_wind_bonus = scr_status_get_second_wind_direct_bonus(
	_ref_caster,
	_stct_card
);

if (_val_second_wind_bonus > 0){

	_val_damage_left *= 1 + (_val_second_wind_bonus / 100);
}

	//--------------------------//
	//INCOMING SCALAR MODIFIERS//
	//--------------------------//
	var _val_incoming_scalar_modifier =
		_ref_damage_recipient._val_dmg_taken_scalar_bonus -
		_ref_damage_recipient._val_dmg_taken_scalar_reduction;

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

	//============================//
	//MOLTEN BRAND DAMAGE BONUS//
	//============================//
	var _val_molten_brand_bonus = scr_status_get_molten_brand_damage_bonus(
		_ref_target,
		_stct_card
	);

	if (_val_molten_brand_bonus > 0){

		_val_damage_left *= 1 + (_val_molten_brand_bonus / 100);
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

	//===========================//
	//MELTING ARMAMENTS: PRE-HIT//
	//===========================//
	scr_status_trigger_melting_armaments(
		_ref_caster,
		_ref_target,
		_stct_card
	);

	#endregion

	#region HIT PRESENTATION

	//------------//
	//PLAY HIT VFX//
	//------------//
	var _ref_hit_vfx = scr_battle_vfx_damage_hit(
		_ref_target,
		_str_card_stat,
		_val_damage_left,
		_stct_presentation,
		_ref_source_card
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
	if (!_flag_pierce_armor && _val_damage_left > 0 && _ref_target._val_armor > 0){

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
		var _stct_armor_result = scr_battle_destroy_armor(_ref_target,_val_armor_blocked);
		_val_armor_blocked = _stct_armor_result._val_armor_removed;
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
		if (_stct_armor_result._flag_armor_broken){

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

	//--------------------//
	//MODE-SPECIFIC LABEL//
	//--------------------//
	var _str_damage_label = "STANDARD";

	if (_str_mode == "PERCENT"){
		_str_damage_label = "MAX HP " + string(_val_amount) + "%";
	}

	if (_flag_pierce_armor){
		_str_damage_label = (_str_mode == "PERCENT") ? _str_damage_label + " | ARMOR PIERCE" : "ARMOR PIERCE";
	}

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
		_str_damage_label,
		"SCR_BATTLE_DAMAGE_TARGET",
		_ref_source_card
	);

	#endregion

	//=======================//
	//RECORD BATTLE FRENZY//
	//=======================//
	scr_battle_record_battle_frenzy_hit(
		_ref_caster,
		_ref_target,
		_val_minion_damage_applied +
		_val_armor_blocked +
		_val_overhealth_blocked +
		_val_hp_damage,
		_ref_source_card
	);

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

	//================//
	//PAIN RESPONSE//
	//================//
	if (_val_hp_damage > 0){

		scr_status_trigger_pain_response(
			_ref_target,
			_val_hp_damage
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

	#endregion

	return true;
}