//===============================================================================//
//
// DRAW GUI: OBJ_GUI_SCROLLING_TEXTBOX
// FUNCTION: Draws a centered scrolling textbox.
//           Displays the currently revealed text.
//           Shows a click hint once the text is complete.
//
//===============================================================================//

draw_set_font(fnt_medium_gui);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

//------//
//LAYOUT//
//------//
var _val_box_x1 = x - (_val_box_w * 0.5);
var _val_box_y1 = y - (_val_box_h * 0.5);
var _val_box_x2 = x + (_val_box_w * 0.5);
var _val_box_y2 = y + (_val_box_h * 0.5);

//----//
//PANE//
//----//
draw_set_colour(c_black);
draw_rectangle(_val_box_x1,_val_box_y1,_val_box_x2,_val_box_y2,false);

draw_set_colour(c_dkgray);
draw_rectangle(_val_box_x1 + 4,_val_box_y1 + 4,_val_box_x2 - 4,_val_box_y2 - 4,false);

//----//
//TEXT//
//----//
draw_set_colour(c_white);
draw_text_ext(_val_box_x1 + 24,_val_box_y1 + 24,_str_visible_text,24,_val_box_w - 48);

//----//
//HINT//
//----//
if (_ct_char >= string_length(_str_text)){
	draw_set_font(fnt_small_gui);
	draw_set_colour(c_ltgray);
	draw_text(_val_box_x2 - 150,_val_box_y2 - 30,"LEFT CLICK");
}