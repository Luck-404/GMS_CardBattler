//===============================================================================//
//
// SCR_APPLY_BUFF_STATUS
// FUNCTION: Applies a buff status or immediate buff effect.
//           Handles mana gain, overhealth, and card draw modifiers.
//           Spawns feedback popup text for successful applications.
//
//===============================================================================//
function scr_apply_buff_status(_str_status_name,_val_magnitude,_val_lifetime){

	switch(_str_status_name){

		case "THORNS":

			var _ref_thorns_status =
				scr_status_buff_thorns(
					"APPLY",
					undefined,
					_val_magnitude,
					_val_lifetime
				);

			if (_ref_thorns_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"THORNS",
					undefined,
					c_green,
					global.ref_target_beast.x +
						irandom_range(-32,32),
					global.ref_target_beast.y -
						24 +
						irandom_range(-32,32)
				);
			}

		break;

		case "ARMOR_OVER_TIME":

			var _ref_status =
				scr_status_buff_armor_over_time(
					"APPLY",
					undefined,
					_val_magnitude,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"ARMOR OVER TIME",
					undefined,
					c_green,
					global.ref_target_beast.x +
						irandom_range(-32,32),
					global.ref_target_beast.y -
						24 +
						irandom_range(-32,32)
				);
			}

		break;

		case "REDIRECT":

			var _ref_redirect_status =
				scr_status_buff_redirect(
					"APPLY",
					undefined
				);

			if (_ref_redirect_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"REDIRECT",
					undefined,
					c_green,
					global.ref_target_beast.x +
						irandom_range(-32,32),
					global.ref_target_beast.y -
						24 +
						irandom_range(-32,32)
				);
			}

		break;

		case "SECOND_LIFE":

			var _ref_second_life_status =
				scr_status_buff_second_life(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_second_life_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"SECOND LIFE",
					undefined,
					c_green,
					global.ref_target_beast.x +
						irandom_range(-32,32),
					global.ref_target_beast.y -
						24 +
						irandom_range(-32,32)
				);
			}

		break;

		case "INSPIRATION":

			scr_status_buff_inspiration("APPLY",undefined);

			scr_spawn_popup_scrolling(
				"TEXT",
				"+2 MANA",
				undefined,
				c_black,
				global.ref_caster_beast.x + irandom_range(-32,32),
				global.ref_caster_beast.y - 24 + irandom_range(-32,32)
			);

		break;

		case "OVERHEALTH":

			scr_status_buff_overhealth("APPLY",undefined);

			scr_spawn_popup_scrolling(
				"TEXT",
				"+5 OVERHEALTH",
				undefined,
				c_green,
				global.ref_target_beast.x + irandom_range(-32,32),
				global.ref_target_beast.y - 24 + irandom_range(-32,32)
			);

		break;

		case "DRAW_2":

			scr_status_buff_draw_2("APPLY",undefined);

			scr_spawn_popup_scrolling(
				"TEXT",
				"+2 CARD DRAW",
				undefined,
				c_green,
				global.ref_caster_beast.x + irandom_range(-32,32),
				global.ref_caster_beast.y - 24 + irandom_range(-32,32)
			);

		break;
		
		case "MALLEABILITY":

			scr_status_buff_malleability(
				"APPLY",
				undefined
			);

			scr_spawn_popup_scrolling(
				"TEXT",
				"MALLEABILITY",
				undefined,
				c_white,
				global.ref_target_beast.x + irandom_range(-32,32),
				global.ref_target_beast.y - 24 + irandom_range(-32,32)
			);

		break;
	}
}