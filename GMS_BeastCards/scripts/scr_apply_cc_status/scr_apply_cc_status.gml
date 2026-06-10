//
//
//
//
//
function scr_apply_cc_status(_name){
	//resist check
	var _res_stat = global.target_beast._ref_unit[?"beast_con_stat"];
	var _res_mod = scr_get_beast_grade_modifier(_res_stat);
	var _resist_chance = floor(5*_res_mod);
	var _roll = irandom_range(0,100);
	if (_roll < _res_mod){
		scr_spawn_popup_scrolling("TEXT","RESISTED",undefined,c_black,global.target_beast.x+irandom_range(-32,32),global.target_beast.y-24+irandom_range(-32,32));		
		exit;	
	}
	
	//play spell
	switch(_name){
		case "STUN":
			scr_status_cc_stun("APPLY",undefined);
			//POPUP
			scr_spawn_popup_scrolling("TEXT","STUNNED",undefined,c_black,global.target_beast.x+irandom_range(-32,32),global.target_beast.y-24+irandom_range(-32,32));					
		break;
	}
}