//===============================================================================//
//
// SCR_APPLY_CC_STATUS
// FUNCTION: Attempts to apply a crowd-control status to the current target.
//           Checks target resistance from CON before applying.
//           Spawns feedback popup text for resisted or successful applications.
//
//===============================================================================//
function scr_apply_cc_status(_str_status_name){

	//
	// RESIST CHECK
	//
	var _val_res_stat = global.target_beast._stct_unit.beast_con_stat;
	var _val_res_mod = scr_get_beast_grade_modifier(_val_res_stat);
	var _val_resist_chance = floor(5 * _val_res_mod);

	var _val_roll = irandom_range(0,100);

	if (_val_roll < _val_resist_chance){

		scr_spawn_popup_scrolling(
			"TEXT",
			"RESISTED",
			undefined,
			c_black,
			global.target_beast.x + irandom_range(-32,32),
			global.target_beast.y - 24 + irandom_range(-32,32)
		);

		exit;
	}

	//
	// APPLY STATUS
	//
	switch(_str_status_name){

		case "STUN":

			scr_status_cc_stun("APPLY",undefined);

			scr_spawn_popup_scrolling(
				"TEXT",
				"STUNNED",
				undefined,
				c_black,
				global.target_beast.x + irandom_range(-32,32),
				global.target_beast.y - 24 + irandom_range(-32,32)
			);

		break;
	}
}