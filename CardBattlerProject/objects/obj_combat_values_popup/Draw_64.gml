//////////////////////////////////////////////////////////////////////
//						OBJ_ERROR_POPUP DRAW						//
//																	//
// > REDUCE LIFE PER TICK											//
//////////////////////////////////////////////////////////////////////
if (_life > 0){
	_life--;	
	y-=2;
	if (_type == "Death"){
		draw_sprite(spr_skull,0,x,y);
	}
	else if (_type == "Mana"){
		draw_sprite(spr_mana,0,x,y);
	}	
	else {
	switch(_type){
		case "Damage":
			draw_set_color(c_red);
		break;
		
		case "Healing":
			draw_set_color(c_lime);
		break;
		
		case "Shields":
			draw_set_color(c_blue);
		break;
		
		case "Poison":
			draw_set_color(c_olive);
		break;
		
		case "Venom":
			draw_set_color(c_purple);
		break;
		
		case "Default":
			draw_set_color(c_white);
		break;
	}

	draw_set_font(fnt_standout);
	draw_text(x,y,_text);
}
}
else {		
	instance_destroy();
}