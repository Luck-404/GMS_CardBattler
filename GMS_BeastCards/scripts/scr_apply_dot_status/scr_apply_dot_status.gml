//===============================================================================//
//
// SCR_APPLY_DOT_STATUS
// FUNCTION: Attempts to apply a damage-over-time status to the current target.
//           Checks target resistance from CON before applying.
//           Spawns feedback popup text for resisted or successful applications.
//
//===============================================================================//
function scr_apply_dot_status(_str_status_name){

	//
	// RESIST CHECK
	//
	var _val_res_stat = global.ref_target_beast._ref_unit._val_beast_con_stat;
	var _val_res_mod = scr_get_beast_grade_modifier(_val_res_stat);
	var _val_resist_chance = floor(5 * _val_res_mod);

	var _val_roll = irandom_range(0,100);

	if (_val_roll < _val_resist_chance){

		scr_spawn_popup_scrolling(
			"TEXT",
			"RESISTED",
			undefined,
			c_black,
			global.ref_target_beast.x + irandom_range(-32,32),
			global.ref_target_beast.y - 24 + irandom_range(-32,32)
		);

		exit;
	}

	//
	// APPLY STATUS
	//
	switch(_str_status_name){

		case "BLEED":

			scr_status_dot_bleed("APPLY",undefined);

			scr_spawn_popup_scrolling(
				"TEXT",
				"+1 BLEED",
				undefined,
				c_maroon,
				global.ref_target_beast.x + irandom_range(-32,32),
				global.ref_target_beast.y - 24 + irandom_range(-32,32)
			);

		break;
		
		case "BURN":

			scr_status_dot_burn("APPLY",undefined);

			scr_spawn_popup_scrolling(
				"TEXT",
				"+1 BURN",
				undefined,
				c_red,
				global.ref_target_beast.x + irandom_range(-32,32),
				global.ref_target_beast.y - 24 + irandom_range(-32,32)
			);

		break;		
		
		case "POISON":

			scr_status_dot_poison("APPLY",undefined);

			scr_spawn_popup_scrolling(
				"TEXT",
				"+1 POISON",
				undefined,
				c_lime,
				global.ref_target_beast.x + irandom_range(-32,32),
				global.ref_target_beast.y - 24 + irandom_range(-32,32)
			);

		break;		
		
		case "VENOM":

			scr_status_dot_venom("APPLY",undefined);

			scr_spawn_popup_scrolling(
				"TEXT",
				"+1 VENOM",
				undefined,
				c_purple,
				global.ref_target_beast.x + irandom_range(-32,32),
				global.ref_target_beast.y - 24 + irandom_range(-32,32)
			);

		break;				
	}
	
	//------------------//
	//CHECK DOT TRAPS//
	//------------------//
	scr_trigger_dot_traps(
		global.ref_target_beast
	);	
}