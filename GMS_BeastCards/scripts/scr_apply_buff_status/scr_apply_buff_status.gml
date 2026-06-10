// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_apply_buff_status(_name){
	
	switch(_name){
		case "INSPIRATION":
			scr_status_buff_inspiration("APPLY",undefined);
			//POPUP
			scr_spawn_popup_scrolling("TEXT","+2 MANA",undefined,c_black,global.caster_beast.x+irandom_range(-32,32),global.caster_beast.y-24+irandom_range(-32,32));					
		break;
		
		case "OVERHEALTH":
			scr_status_buff_overhealth("APPLY",undefined);
			//POPUP
			scr_spawn_popup_scrolling("TEXT","+5 OVERHEALTH",undefined,c_green,global.target_beast.x+irandom_range(-32,32),global.target_beast.y-24+irandom_range(-32,32));					
		break;
		
		case "DRAW_2":
			scr_status_buff_draw_2("APPLY",undefined);
			//POPUP
			scr_spawn_popup_scrolling("TEXT","+2 CARD DRAW",undefined,c_green,global.caster_beast.x+irandom_range(-32,32),global.caster_beast.y-24+irandom_range(-32,32));					
		break;		
	}
}