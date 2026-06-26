//===============================================================================//
//
// SCR_APPLY_BUFF_STATUS
// FUNCTION: Applies a buff status or immediate buff effect.
//           Handles mana gain, overhealth, and card draw modifiers.
//           Spawns feedback popup text for successful applications.
//
//===============================================================================//
function scr_apply_buff_status(_str_status_name){

	switch(_str_status_name){

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
	}
}