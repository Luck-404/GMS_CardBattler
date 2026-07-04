//===============================================================================//
//
// DRAW GUI: OBJ_GUI_PROMPT
// FUNCTION: Draws a centered yes/no prompt.
//           Displays prompt text and hover states for both buttons.
//
//===============================================================================//

draw_set_font(fnt_medium_gui);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

//------//
//LAYOUT//
//------//
var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

var _val_box_x1 = x - (_val_box_w * 0.5);
var _val_box_y1 = y - (_val_box_h * 0.5);
var _val_box_x2 = x + (_val_box_w * 0.5);
var _val_box_y2 = y + (_val_box_h * 0.5);

var _val_yes_x1 = x - _val_button_w - 20;
var _val_yes_y1 = y + 35;
var _val_yes_x2 = _val_yes_x1 + _val_button_w;
var _val_yes_y2 = _val_yes_y1 + _val_button_h;

var _val_no_x1 = x + 20;
var _val_no_y1 = y + 35;
var _val_no_x2 = _val_no_x1 + _val_button_w;
var _val_no_y2 = _val_no_y1 + _val_button_h;

var _flag_yes_hover = _val_mouse_x > _val_yes_x1 && _val_mouse_x < _val_yes_x2 && _val_mouse_y > _val_yes_y1 && _val_mouse_y < _val_yes_y2;
var _flag_no_hover = _val_mouse_x > _val_no_x1 && _val_mouse_x < _val_no_x2 && _val_mouse_y > _val_no_y1 && _val_mouse_y < _val_no_y2;

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
draw_text(x,y - 45,_str_prompt_text);

//-----//
//YES//
//-----//
draw_set_colour(_flag_yes_hover ? c_white : c_gray);
draw_rectangle(_val_yes_x1,_val_yes_y1,_val_yes_x2,_val_yes_y2,false);

draw_set_colour(c_black);
draw_text((_val_yes_x1 + _val_yes_x2) * 0.5,(_val_yes_y1 + _val_yes_y2) * 0.5,_str_yes_text);

//----//
//NO//
//----//
draw_set_colour(_flag_no_hover ? c_white : c_gray);
draw_rectangle(_val_no_x1,_val_no_y1,_val_no_x2,_val_no_y2,false);

draw_set_colour(c_black);
draw_text((_val_no_x1 + _val_no_x2) * 0.5,(_val_no_y1 + _val_no_y2) * 0.5,_str_no_text);

//-------//
//RESET//
//-------//
draw_set_halign(fa_left);
draw_set_valign(fa_top);