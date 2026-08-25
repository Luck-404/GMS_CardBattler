//===============================================================================//
//
// SCRIPT: SCR_APPLY_DEBUFF_STATUS
// FUNCTION: Attempts to apply a Debuff status to the current target.
//           Checks target resistance from CON before applying.
//           Accepts an optional lifetime override.
//           Spawns feedback popup text for successful applications.
//
//===============================================================================//
function scr_apply_debuff_status(_str_status_name,_val_lifetime=undefined){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	var _ref_target =
		global.ref_target_beast;

	if (!instance_exists(_ref_target)){
		return undefined;
	}

	if (_ref_target._ref_unit == undefined){
		return undefined;
	}

	//--------------//
	//RESIST CHECK//
	//--------------//
	var _val_res_stat =
		_ref_target._ref_unit._val_beast_con_stat;

	var _val_res_mod =
		scr_get_beast_grade_modifier(
			_val_res_stat
		);

	var _val_resist_chance =
		floor(
			5 *
			_val_res_mod
		);

	var _val_roll =
		irandom_range(
			0,
			100
		);

	if (_val_roll < _val_resist_chance){

		scr_spawn_popup_scrolling(
			"TEXT",
			"RESISTED",
			undefined,
			c_black,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);

		return undefined;
	}

	//--------------//
	//APPLY STATUS//
	//--------------//
	var _ref_status =
		undefined;

	switch(_str_status_name){

		//--------//
		//DRAINED//
		//--------//
		case "DRAINED":

			_ref_status = scr_status_debuff_drained("APPLY",undefined,_val_lifetime);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"DRAINED",
					undefined,
					c_maroon,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//------------//
		//ARMORBREAK//
		//------------//
		case "ARMORBREAK":

			_ref_status =
				scr_status_debuff_armorbreak(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"ARMORBREAK",
					undefined,
					c_maroon,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//------------------//
		//CRIPPLING VINES//
		//------------------//
		case "CRIPPLING_VINES":

			_ref_status =
				scr_status_debuff_crippling_vines(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"CRIPPLING VINES",
					undefined,
					c_maroon,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//----------//
		//WEAKNESS//
		//----------//
		case "WEAKNESS":

			_ref_status =
				scr_status_debuff_weakness(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"WEAKNESS",
					undefined,
					c_black,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//--------//
		//WITHER//
		//--------//
		case "WITHER":

			_ref_status = scr_status_debuff_wither("APPLY",undefined,_val_lifetime);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"WITHER",
					undefined,
					c_maroon,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//------------//
		//VULNERABLE//
		//------------//
		case "VULNERABLE":

			_ref_status =
				scr_status_debuff_vulnerable(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"VULNERABLE",
					undefined,
					c_maroon,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;
	}

	return _ref_status;
}