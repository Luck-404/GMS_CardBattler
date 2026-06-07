//
//
//
//
//
function scr_apply_dot_status(_name){
	//resist check
	var _res_stat = global._target._ref_unit[?"beast_con_stat"];
	var _res_mod = scr_get_beast_grade_modifier(_res_stat);
	var _resist_chance = floor(5*_res_mod);
	var _roll = irandom_range(0,100);
	if (_roll < _res_mod){
		scr_spawn_scrolling_popup("TEXT","RESISTED",undefined,c_black,global._target.x+irandom_range(-32,32),global.caster_beast.y-24+irandom_range(-32,32));		
		exit;	
	}
	
	//play spell	
	switch(_name){
		case "BLEED":
			scr_status_dot_bleed("APPLY",undefined);
			//POPUP
			scr_spawn_scrolling_popup("TEXT","+1 BLEED",undefined,c_maroon,global.target_beast.x+irandom_range(-32,32),global.target_beast.y-24+irandom_range(-32,32));					
		break;
	}
}