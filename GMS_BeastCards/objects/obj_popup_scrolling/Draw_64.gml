//===============================================================================//
//
// DRAW GUI: OBJ_POPUP_SCROLLING
// FUNCTION: Moves and draws a scrolling popup.
//           Displays text, icon, or both depending on popup type.
//           Counts down lifespan and destroys itself when expired.
//
//===============================================================================//

//--------------//
//SCROLL MOVEMENT//
//--------------//
if (!instance_exists(obj_gui_end_battle_pane)){
	y -= _val_y_speed;

	//------------//
	//POPUP ACTION//
	//------------//
	if (_str_text != "DEFAULT"){
		switch(_str_type){

			case "TEXT":
				draw_set_colour(_c_popup);
				draw_set_font(fnt_medium_gui);
				draw_text(x - (string_width(_str_text) / 2),y,_str_text);
			break;

			case "ICON":
				draw_sprite(_spr_icon,0,x,y);
			break;

			case "DUAL":
				draw_set_colour(_c_popup);
				draw_set_font(fnt_medium_gui);
				draw_text(x - (string_width(_str_text) / 2),y,_str_text);
				draw_sprite(_spr_icon,0,x,y - 15);
			break;
		}
	}
}

//---------//
//LIFESPAN//
//---------//
if (_ct_life > 0){
	_ct_life--;

	if (_ct_life <= 0){
		instance_destroy();
	}
}