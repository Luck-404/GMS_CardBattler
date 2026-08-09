//===============================================================================//
//
// SCRIPT: SCR_APPLY_BUFF_STATUS
// FUNCTION: Applies Buff statuses through their shared status callbacks.
//           Passes configurable magnitude and lifetime where supported.
//           Infinite Buffs ignore supplied lifetime.
//
//===============================================================================//
function scr_apply_buff_status(_str_status_name,_val_magnitude=0,_val_lifetime=undefined){

	switch(_str_status_name){

		case "MANAVINE":

			var _ref_manavine_status =
				scr_status_buff_manavine(
					"APPLY",
					undefined,
					_val_magnitude,
					_val_lifetime
				);

			if (_ref_manavine_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"+" + string(_ref_manavine_status._val_status_magnitude) + " MANA",
					undefined,
					c_green,
					global.ref_caster_beast.x + irandom_range(-32,32),
					global.ref_caster_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


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
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		case "BLOOM":

			var _ref_bloom_status =
				scr_status_buff_bloom(
					"APPLY",
					undefined,
					_val_magnitude,
					_val_lifetime
				);

			if (_ref_bloom_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"BLOOM +" + string(_val_magnitude) + " OVERHEALTH",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		case "TAUNT":

			var _ref_taunt_status =
				scr_status_buff_taunt(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_taunt_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"TAUNT",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		case "ARMOR_OVER_TIME":

			var _ref_armor_status =
				scr_status_buff_armor_over_time(
					"APPLY",
					undefined,
					_val_magnitude,
					_val_lifetime
				);

			if (_ref_armor_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"ARMOR OVER TIME",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
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
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
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
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		case "INSPIRATION":

			var _ref_inspiration_status =
				scr_status_buff_inspiration(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_inspiration_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"+2 MANA",
					undefined,
					c_black,
					global.ref_caster_beast.x + irandom_range(-32,32),
					global.ref_caster_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		case "OVERHEALTH":

			var _ref_overhealth_status =
				scr_status_buff_overhealth(
					"APPLY",
					undefined,
					_val_magnitude,
					_val_lifetime
				);

			if (_ref_overhealth_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"+" + string(_val_magnitude) + " OVERHEALTH",
					undefined,
					c_green,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		case "DRAW_2":

			var _ref_draw_status =
				scr_status_buff_draw_2(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_draw_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"+2 CARD DRAW",
					undefined,
					c_green,
					global.ref_caster_beast.x + irandom_range(-32,32),
					global.ref_caster_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		case "MALLEABILITY":

			var _ref_malleability_status =
				scr_status_buff_malleability(
					"APPLY",
					undefined
				);

			if (_ref_malleability_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"MALLEABILITY",
					undefined,
					c_white,
					global.ref_target_beast.x + irandom_range(-32,32),
					global.ref_target_beast.y - 24 + irandom_range(-32,32)
				);
			}

		break;
	}
}