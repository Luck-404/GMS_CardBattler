//===============================================================================//
//
// DRAW GUI: OBJ_GUI_POPUP_TRIGGER_BANNER
// FUNCTION: Draws a dynamically sized trigger banner.
//           Anchors the right edge to the GUI boundary.
//           Expands leftward to accommodate text and padding.
//           Draws black backing, grey interior, and centered white text.
//
//===============================================================================//

//----------------//
//VALIDATE TEXT//
//----------------//
if (_str_text == "DEFAULT" || _str_text == ""){
    exit;
}

#region LAYOUT

//----------------//
//GET GUI SIZE//
//----------------//
var _val_gui_width = display_get_gui_width();
var _val_gui_height = display_get_gui_height();

//----------------//
//SET FONT//
//----------------//
draw_set_font(_font_banner);

//-----------------------//
//CALCULATE TEXT WIDTH//
//-----------------------//
var _val_available_text_w = max(
    1,
    _val_gui_width - ((_val_border + _val_padding_x) * 2)
);

var _val_text_w = min(
    string_width(_str_text),
    _val_available_text_w
);

//------------------------//
//CALCULATE TEXT BOUNDS//
//------------------------//
var _val_text_actual_w = string_width_ext(
    _str_text,
    -1,
    _val_text_w
);

var _val_text_h = string_height_ext(
    _str_text,
    -1,
    _val_text_w
);

//------------------------//
//CALCULATE BANNER SIZE//
//------------------------//
var _val_banner_w = ceil(
    _val_text_actual_w +
    (_val_padding_x * 2) +
    (_val_border * 2)
);

var _val_banner_h = ceil(
    _val_text_h +
    (_val_padding_y * 2) +
    (_val_border * 2)
);

//--------------------//
//ANCHOR RIGHT EDGE//
//--------------------//
var _val_right = _val_gui_width;
var _val_bottom = min(_val_anchor_y,_val_gui_height);

var _val_left = _val_right - _val_banner_w;
var _val_top = _val_bottom - _val_banner_h;

//------------------//
//TEXT CENTER POINT//
//------------------//
var _val_center_x = (_val_left + _val_right) * 0.5;
var _val_center_y = (_val_top + _val_bottom) * 0.5;

#endregion

#region BACKGROUND

//================//
//BLACK OUTER PANE//
//================//
draw_set_alpha(1);
draw_set_colour(c_black);

draw_rectangle(
    _val_left,
    _val_top,
    _val_right,
    _val_bottom,
    false
);

//================//
//GREY INNER PANE//
//================//
draw_set_colour(global.c_dk_gray);

draw_rectangle(
    _val_left + _val_border,
    _val_top + _val_border,
    _val_right - _val_border,
    _val_bottom - _val_border,
    false
);

#endregion

#region TEXT

//================//
//DRAW CENTERED TEXT//
//================//
draw_set_colour(c_white);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_ext(
    _val_center_x,
    _val_center_y,
    _str_text,
    -1,
    _val_text_w
);

#endregion

#region RESET

//----------------//
//RESET DRAW STATE//
//----------------//
draw_set_colour(c_white);
draw_set_alpha(1);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

#endregion