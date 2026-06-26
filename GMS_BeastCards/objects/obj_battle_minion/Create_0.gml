//
// DRAW: OBJ_MINION
//
if (!instance_exists(obj_gui_end_battle_pane)){

if (_host == undefined) exit;



//----------------------------------------------------
// BASIC SETUP
//----------------------------------------------------
draw_set_font(fnt_small_party_draw);

var _scale = 0.125;

// direction flip for enemy side
var _flip = (_team == "ENEMY") ? -1 : 1;

//----------------------------------------------------
// DRAW SPRITE (SCALED)
//----------------------------------------------------
draw_sprite_ext(
    _minion_sprite,
    0,
    x,
    y,
    _scale * _flip,
    _scale,
    0,
    c_white,
    1
);

//----------------------------------------------------
// HP TEXT
//----------------------------------------------------
draw_set_colour(c_white);

var _hp_text = string(_cur_hp) + "/" + string(_max_hp);

draw_text(
    x - string_width(_hp_text) * 0.5,
    y + 20,
    _hp_text
);

//----------------------------------------------------
// TOOLTIP (CTRL HOVER) - CENTER TOP PANEL
//----------------------------------------------------
if (keyboard_check(vk_lcontrol) && position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), self))
{
    var _host_name = (_host != undefined) ? string(_host._ref_unit[?"beast_name"]) : "UNKNOWN";

    var _title = string(_name) + "  |  " + _host_name;

    var _panel_w = string_width(_title) + 40;
    var _panel_h = 40;

    var _px = room_width * 0.5 - _panel_w * 0.5;
    var _py = 20;

    // background
    draw_set_colour(c_dkgray);
    draw_rectangle(_px, _py, _px + _panel_w, _py + _panel_h, false);

    draw_set_colour(c_black);
    draw_rectangle(_px, _py, _px + _panel_w, _py + _panel_h, true);

    // text
    draw_set_colour(c_white);
    draw_text(
        _px + _panel_w * 0.5 - string_width(_title) * 0.5,
        _py + 12,
        _title
    );
}
}